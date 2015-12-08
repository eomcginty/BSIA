using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data.Sql;
using System.Data;

namespace BSIA
{
    class RepairItem
    {
        public int inspection_id { get; set; }
        public int element_id { get; set; }
        public String notes { get; set; }
        public int severity_id { get; set; }
        public int odometer { get; set; }
        public String tag { get; set; }
        public int updated_by_id { get; set; }
        public List<string> items;

        public RepairItem()
        {
            items = new List<string>();
        }

    }

    public partial class Edit : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!User.Identity.IsAuthenticated)
            {
                //If not authenticated, redirect to login page.
                Response.Redirect("/Account/Login");
            }

            //if (txt_inspectionDate.Text == "")
            //    txt_inspectionDate.Text = DateTime.Now.ToString("M/d/yyyy");
        }


        /*************************************************************************
        *   Calendar - TODO
        *   Pop up calendar for easy Repair Date input.  Date field currently 
        *      takes in most date formats.
        *      Date should be the date of the repair or if a repair date is not 
        *      available it should be the data the repair notice was received in 
        *      the office.  This data should not be the date it is entered in the system.
        **************************************************************************/
        protected void btn_calendar_Click(object sender, EventArgs e)
        {

            //calendar.Visible = true;
        }

        protected void calendar_SelectionChanged(object sender, EventArgs e)
        {
            //txt_inspectionDate.Text = DateTime.Parse(calendar.SelectedDate.ToShortDateString()).ToString("M/d/yyyy");
            //calendar.Visible = false;
        }


        /*************************************************************************
        *   Get Bus Information 
        *   Display bus information for the bus number selected in a table:
        *     Contractor Name, Odometer, TAG, VIN, Model, Chassis, Body
        *   Display Edit or Delete options
        *   Display Repair panel
        **************************************************************************/
        protected void btn_getBus_Click(object sender, EventArgs e)
        {
            //pnl_bus.Visible = true;
            //upd_pnl_repairs.Visible = true;

            if (ddl_bus.SelectedIndex != 0)
            {
                int inspectionId = 0;
                string pass_date = null;
                DropDownList ddl = (DropDownList)sender;
                SqlDataAdapter adapter = new SqlDataAdapter();
                SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["BSIAConnectionString"].ConnectionString);
                conn.Open();

                System.Data.DataSet ds = new System.Data.DataSet();
                SqlCommand cmd = new SqlCommand("Select * FROM BSIA.dbo.Inspections " +
                 "WHERE bus_id = (SELECT bus_id from BusContractorNumber bcn WHERE bus_number = @bus_num " +
                 "AND bcn.effective_date <= GETDATE() AND ( bcn.termination_date IS NULL OR bcn.termination_date > GETDATE()))", conn);

                try
                {
                   // string pass_date = null;
                    cmd.Parameters.AddWithValue("@bus_num", int.Parse(ddl_bus.SelectedItem.Text));
                    //cmd.Parameters.AddWithValue(pass_date.ToString(), "@pass_date");
                    adapter.SelectCommand = cmd;
                    adapter.Fill(ds);
                    cmd.ExecuteNonQuery();
                    repeater_busInfo.DataBind();
                    Repeater_repairs.DataBind();
                    upd_pnl_repairs.Update();
                }
                catch (Exception err)
                {
                    System.Console.Write("somthing went wrong");
                }

                if (ds.Tables[0].Rows.Count == 0) //if there is no inspection for this bus, display alert
                {
                    cmd.ExecuteNonQuery();
                    repeater_busInfo.DataBind();
                    Repeater_repairs.DataBind();
                    upd_pnl_repairs.Update();

                    pnl_bus.Visible = false;
                    upd_pnl_repairs.Visible = false;
                    pnl_editInspection.Visible = false;
                    pnl_alert_noInspection.Visible = true;
                }
                else
                {
                    pnl_bus.Visible = true;  //if there is an inspection with failures, display repairs section
                    pnl_alert_noInspection.Visible = false;

                    //if (pass_date == null)
                    //    upd_pnl_repairs.Visible = true;
                    if (ds.Tables[0].Rows[0].ItemArray[11].ToString() != null)
                    {
                        upd_pnl_repairs.Update();
                        upd_pnl_repairs.Visible = true;
                    }

                }

            }
        } //End Get Bus Click


        /*************************************************************************
        *   Repairs to Inspection failures
        *   Displays all failures and associated notes. Allows users to select an 
        *     inspection view its failures, and choose to modify the content or 
        *     mark the failures as repaired.  If all failures have been submitted 
        *     as completed, the inspection automatically updates the status to PASS.  
        *     Otherwise, an alert is generated to confirm that Repairs are still 
        *     pending for the inspection and will remain in FAIL status. 
        **************************************************************************/
        protected void btn_repair_update_Click(object sender, EventArgs e)
        {
            SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["BSIAConnectionString"].ConnectionString);
            conn.Open();

            int inspection_id = 0;
            int count = Repeater_repairs.Items.Count;

            if (count != 0)
            {
                foreach (RepeaterItem item in Repeater_repairs.Items)
                {
                    int element_id = 0;
                    string repair_date;

                    TextBox tb1 = (TextBox)item.FindControl("txt_inspection_id");
                    inspection_id = int.Parse(tb1.Text);

                    TextBox tb2 = (TextBox)item.FindControl("txt_element_id");
                    element_id = int.Parse(tb2.Text);

                    TextBox tb3 = (TextBox)item.FindControl("txt_repairDate");

                    try
                    {
                        DateTime d = DateTime.Parse(tb3.Text);
                        repair_date = d.ToString("M/d/yyyy");
                    }
                    catch (Exception err)
                    {
                        continue;
                    }

                    SqlCommand cmd = new SqlCommand("UPDATE BSIA.dbo.InspectionFailures SET repaired_date=@repair_date " +
                        "WHERE inspection_id=@inspection_id AND element_id=@element_id", conn);

                    try
                    {
                        cmd.Parameters.AddWithValue("@inspection_id", inspection_id);
                        cmd.Parameters.AddWithValue("@element_id", element_id);
                        cmd.Parameters.AddWithValue("@repair_date", repair_date);

                        cmd.ExecuteNonQuery();
                        count--;
                    }
                    catch (Exception err)
                    {
                        continue;
                    }
                }

                if (count == 0) //all repairs have been made - mark inspection as passed
                {
                    SqlCommand cmd = new SqlCommand("UPDATE BSIA.dbo.Inspections SET pass_date=GETDATE(), date_updated=GETDATE() " +
                        "WHERE inspection_id=@inspection_id", conn);

                    try
                    {
                        cmd.Parameters.AddWithValue("@inspection_id", inspection_id);
                        cmd.ExecuteNonQuery();
                    }
                    catch (Exception err)
                    {

                    }
                    btn_repair_update.Visible = false;
                    Repeater_repairs.DataBind();
                    upd_pnl_repairs.Update();

                    //notify user inspection passed
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal_success_repair();", true);
                    pnl_success_repair.Visible = true;
                }
                else
                {
                    Repeater_repairs.DataBind();
                    upd_pnl_repairs.Update();

                    //notify user that there are still repairs and remains in FAIL status
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal_error_repair();", true);
                    pnl_error_repair.Visible = true;
                }

                conn.Close();
            }

        }  //End Update Repair


        /*************************************************************************
        *   Delete Inspection - Button Selection
        *   Allows a user in a role such as an Administrator the option to delete.  
        *     Pop up/modal asks user to confirm their choice to delete.  
        *     If yes, go to 'btn_verifyDeleteYes_Click' functionality.
        *     TODO - Although the database provides the Admin role, it is not implemented at this time
        **************************************************************************/
        protected void btn_delete_inspection_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;

            //Get the odemeter for the item selected. This is ugly.
            Repeater r = (Repeater)btn.Parent.Parent;
            foreach (RepeaterItem item in r.Items)
            {
                Label lbl_odometer = (Label)item.FindControl("lbl_odometer");
                btn_verifyDeleteYes.CommandArgument = lbl_odometer.Text;
            }

            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal_verify_delete();", true);
            pnl_verify_delete.Visible = true;
        }  //End Delete selection


        /*************************************************************************
        *   Delete Inspection - Select Yes for Delete confirmation
        *   Modified the dbo.sp_Delete_Inspection stored procedure for delete to be 
        *     based on bus number and odometer parameters.  
        *     This function is kicked off when the user selects Yes from the Pop up/modal.
        *     Calls the dbo.sp_Delete_Inspection stored procedure to delete inspections/failures.
        **************************************************************************/
        protected void btn_verifyDeleteYes_Click(object sender, EventArgs e)
        {
            Button btn_vrfy = (Button)sender;
            int odometer = int.Parse(btn_vrfy.CommandArgument);
            int season_id = ddl_season.SelectedIndex;

            SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["BSIAConnectionString"].ConnectionString);
            conn.Open();

            try
            {
                SqlCommand cmd = new SqlCommand("dbo.sp_Delete_Inspection", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add(new SqlParameter("@BusNum", ddl_bus.SelectedItem.Text));
                cmd.Parameters.Add(new SqlParameter("@Odometer", odometer));

                cmd.ExecuteNonQuery();

                repeater_busInfo.DataBind();
                Repeater_repairs.DataBind();
                upd_pnl_repairs.Update();

                //notify user delete was a success
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal_success_delete();", true);
                pnl_success_delete.Visible = true;

            }
            catch (Exception err)
            {
                //notify user delete did not happen and offer a chance to retry
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal_error_delete();", true);
                pnl_error_delete.Visible = true;
                System.Console.Write(err);
            }
            finally
            {
                conn.Close();
            }
        }  //End Delete Inspection


        /*************************************************************************
        *   Edit Inspection
        *   Opens the Edit Inspection section.  Populates Odometer, TAG, UpdatedBy, and notes.
        *   The form is dynamically populated which invokes the Item and Element Databound
        *   functions to populate the form.
        **************************************************************************/
        protected void btn_edit_inspection_Click(object sender, EventArgs e)
        {
            pnl_editInspection.Visible = true;

            Button btn = (Button)sender;
            int inspection_id = 0;

            //Get the odemeter for the item selected. This is ugly.
            Repeater r = (Repeater)btn.Parent.Parent;
            foreach (RepeaterItem item in r.Items)
            {
                Label lbl_odometer = (Label)item.FindControl("lbl_odometer");
                txt_odometer.Text = lbl_odometer.Text;

                Label lbl_tag = (Label)item.FindControl("lbl_tag");
                txt_tag.Text = lbl_tag.Text;

                TextBox txt_id = (TextBox)item.FindControl("txt_inspection_id");
                inspection_id = int.Parse(txt_id.Text);
                //also, lets save it for later
                btn_saveInspection.CommandArgument = inspection_id.ToString();

                Button btn2 = (Button)item.FindControl("btn_edit_inspection");

                if (btn2 == btn)
                    break;
            }

            if (txt_updatedBy.Text == "")
                txt_updatedBy.Text = Context.User.Identity.Name;

            string notes = null;
            SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["BSIAConnectionString"].ConnectionString);
            conn.Open();

            SqlCommand cmd = new SqlCommand("SELECT notes from Inspections where inspection_id = @inspection_id", conn);

            try
            {
                cmd.Parameters.AddWithValue("@inspection_id", inspection_id);

                notes = (string)cmd.ExecuteScalar();
            }
            catch (Exception err)
            {

            }

            if (notes != null)
            {
                ta_notes.Value = notes;
            }
        }


        /*************************************************************************
        *   Save changes to Inspection
        *   Takes input and inserts into the Inspection table of the BSIA database. 
        **************************************************************************/
        protected void btn_saveInspection_Click(object sender, EventArgs e)
        {
            //retrieve the saved inspection_id from command arguemnets
            Button btn= (Button)sender;
            int inspectionId = int.Parse(btn.CommandArgument);

            //delete all previously saved failures
            /*
            DELETE FROM dbo.InspectionFailures
            WHERE inspection_id=@inspection_id;
            */

            SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["BSIAConnectionString"].ConnectionString);
            conn.Open();

            try
            {
                SqlCommand cmd = new SqlCommand("DELETE FROM dbo.InspectionFailures " +
                    "WHERE inspection_id=@inspection_id AND repaired_date IS NULL", conn);

                cmd.Parameters.Add(new SqlParameter("@inspection_id", inspectionId));

                cmd.ExecuteNonQuery();
            }
            catch (Exception err)
            {

            }

            //updated failure information

            Boolean passed = false;

            List<InspectionItem> failedItems = new List<InspectionItem>();

            //iterate through and add failures to list
            foreach (RepeaterItem group in Repeater_groups.Items)
            {
                Repeater rep = (Repeater)group.FindControl("Repeater_items");
                foreach (RepeaterItem item in rep.Items)
                {
                    CheckBox cb = (CheckBox)item.FindControl("cb_fail");
                    if (cb.Checked)
                    {
                        InspectionItem failedItem = new InspectionItem();

                        DropDownList severity = (DropDownList)item.FindControl("ddl_severity");
                        failedItem.severity_id = severity.SelectedIndex;
                        Label id = (Label)item.FindControl("lbl_elementsId");
                        failedItem.element_id = int.Parse(id.Text);

                        TextBox tb = (TextBox)item.FindControl("txt_comments");
                        string comments = tb.Text;

                        Repeater rep2 = (Repeater)item.FindControl("Repeater_elements");
                        foreach (RepeaterItem note in rep2.Items)
                        {
                            CheckBox cb_note = (CheckBox)note.FindControl("cb_elements");
                            if (cb_note.Checked)
                                failedItem.notes += cb_note.Text + " / ";
                        }

                        //TextBox tb = (TextBox)item.FindControl("txt_comments");
                        failedItem.notes += comments;

                        failedItems.Add(failedItem);
                    }
                }

            }

            if (failedItems.Count == 0)
            {
                passed = true;
            }
            else
            {
                foreach (InspectionItem item in failedItems)
                {
                    item.inspection_id = inspectionId;
                    try
                    {
                        SqlCommand cmd_fails = new SqlCommand("INSERT INTO BSIA.dbo.InspectionFailures(inspection_id, element_id, notes, severity_id, created_by, updated_by, date_created, date_updated) " +
                            " VALUES (@inspection_id, @element_id, @notes, @severity_id," +
                            " @created_by, @updated_by, GETDATE(), GETDATE())", conn);

                        cmd_fails.Parameters.AddWithValue("@inspection_id", item.inspection_id);
                        cmd_fails.Parameters.AddWithValue("@element_id", item.element_id);
                        cmd_fails.Parameters.AddWithValue("@notes", (item.notes == null) ? "" : item.notes);
                        cmd_fails.Parameters.AddWithValue("@severity_id", item.severity_id);
                        //TODO: get user id
                        //bogus user id for now
                        cmd_fails.Parameters.AddWithValue("@created_by", 1);
                        cmd_fails.Parameters.AddWithValue("@updated_by", 1);

                        cmd_fails.ExecuteNonQuery();
                    }
                    catch (Exception err)
                    { }

                }
            }

            //update inspection
            string today = DateTime.Now.ToString("M/d/yyyy");

            SqlCommand cmd_update = new SqlCommand("UPDATE BSIA.dbo.Inspections " +
                "SET odometer=@odometer, " +
                "notes=@notes, " +
                "date_updated=GETDATE(), " +
                "pass_date=@pass_date " +
                 "WHERE inspection_id=@inspection_id", conn);

            try
            {
                cmd_update.Parameters.AddWithValue("@inspection_id", inspectionId);
                cmd_update.Parameters.AddWithValue("@odometer", txt_odometer.Text);
                cmd_update.Parameters.AddWithValue("@notes", ta_notes.Value);
                if (passed)
                    cmd_update.Parameters.AddWithValue("@pass_date", today);
                else
                    cmd_update.Parameters.AddWithValue("@pass_date", DBNull.Value);

                cmd_update.ExecuteNonQuery();

                //notify user Creation was successful
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal_success_edit();", true);
                pnl_success_edit.Visible = true;
                
            }
            catch (Exception err)
            {
                //notify user Edit resulted in an error
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal_error_edit();", true);
                pnl_error_edit.Visible = true;
                System.Console.Write(err);
            }
            finally
            {
                conn.Close();
            }
        }  //End Save Inspection


        /*************************************************************************
        *   Repeater Items 
        *   DataBound functionality for the Edit Inspection Section. 
        *   Invoked everytime the page reloads and the dataset is loaded into the table.
        *     Gets repair information, traverses through the dynamically populated form, 
        *     to set the values. 
        *     Marks the failures, severity, and comments.   
        **************************************************************************/
        protected void Repeater_items_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            RepeaterItem element = e.Item;

            List<RepairItem> Repairs = new List<RepairItem>();

            Label lbl_element_id = (Label)element.FindControl("lbl_elementsId");

            if (lbl_element_id != null)
            {
                int id = int.Parse(lbl_element_id.Text);

                foreach (RepeaterItem item in Repeater_repairs.Items)
                {
                    RepairItem repair = new RepairItem();

                    TextBox tb1 = (TextBox)item.FindControl("txt_inspection_id");
                    repair.inspection_id = int.Parse(tb1.Text);

                    TextBox tb2 = (TextBox)item.FindControl("txt_element_id");
                    repair.element_id = int.Parse(tb2.Text);

                    TextBox tb3 = (TextBox)item.FindControl("txt_notes");
                    repair.notes = tb3.Text;
                    string[] noteArr = repair.notes.Split('/');
                    foreach (string s in noteArr)
                    {
                        repair.items.Add(s.Trim());
                    }

                    Label lbl_s = (Label)item.FindControl("lbl_severity_id");
                    repair.severity_id = int.Parse(lbl_s.Text);

                    Repairs.Add(repair);
                }

                foreach (RepairItem r in Repairs)
                {
                    if (r.element_id == id)
                    {
                        //mark the failure
                        CheckBox cb = (CheckBox)element.FindControl("cb_fail");
                        cb.Checked = true;

                        //mark the severity
                        DropDownList ddl_s = (DropDownList)element.FindControl("ddl_severity");
                        ddl_s.SelectedIndex = r.severity_id;

                        Repeater rep = (Repeater)element.FindControl("Repeater_elements");
                        foreach (RepeaterItem ri in rep.Items)
                        {
                            CheckBox cb_e = (CheckBox)ri.FindControl("cb_elements");
                            if (cb_e != null)
                            {
                                if (r.items.Contains(cb_e.Text))
                                {
                                    cb_e.Checked = true;
                                    r.items.Remove(cb_e.Text);
                                }
                            }
                        }

                        //mark the severity
                        TextBox txt_comments = (TextBox)element.FindControl("txt_comments");
                        txt_comments.Text = r.items.Last();
                    }
                }
            }
        }  //End Repeater Items


        /*************************************************************************
        *   Repeater Elements
        *   DataBound functionality for the Edit Inspection Section.  
        *   Invoked everytime the page reloads and the dataset is loaded into the table.
        *     Gets repair information, traverses through the dynamically populated form, 
        *     to set the values. 
        *     Marks the checkboxes.   
        *   TODO: Flaw - Currently, last checkbox does not show up as checked
        *                after modification and page reload if 
        *         no comments were initially provided in the original inspection.
        **************************************************************************/
        protected void Repeater_elements_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            RepeaterItem element = e.Item;

            CheckBox cb_e = (CheckBox)element.FindControl("cb_elements");
            if (cb_e != null)
            {
                RepeaterItem row = (RepeaterItem)cb_e.Parent.Parent.Parent;
                Label lbl_element_id = (Label)row.FindControl("lbl_elementsId");
                int element_id = int.Parse(lbl_element_id.Text);

                foreach (RepeaterItem item in Repeater_repairs.Items)
                {
                    RepairItem repair = new RepairItem();

                    TextBox tb1 = (TextBox)item.FindControl("txt_inspection_id");
                    repair.inspection_id = int.Parse(tb1.Text);

                    TextBox tb2 = (TextBox)item.FindControl("txt_element_id");
                    repair.element_id = int.Parse(tb2.Text);

                    if (repair.element_id == element_id)
                    {
                        TextBox tb3 = (TextBox)item.FindControl("txt_notes");
                        repair.notes = tb3.Text;
                        string[] noteArr = repair.notes.Split('/');
                        foreach (string s in noteArr)
                        {
                            repair.items.Add(s.Trim());
                        }

                        if (repair.items.Contains(cb_e.Text))
                            cb_e.Checked = true;
                    }
                }
            }
        }  //End Repeater Elements




    }
}