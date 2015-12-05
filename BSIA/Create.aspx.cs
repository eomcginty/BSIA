using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data.Sql;

namespace BSIA
{
    class InspectionItem
    {
        public int inspection_id { get; set; }
        public int element_id { get; set; }
        public String notes { get; set; }
        public int severity_id { get; set; }
        public int created_by_id { get; set; }
        public int updated_by_id { get; set; }
        public string date_created { get; set; }
        public string date_updated { get; set; }
        public string inspector_esignature { get; set; }
        public string contractor_esignature { get; set; }
        public string contractor_ename { get; set; }
    }

    public partial class Create : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!User.Identity.IsAuthenticated)
            {
                //If not authenticated, redirect to login page.
                Response.Redirect("/Account/Login");
            }
            if (txt_inspectionDate.Text == "")
                txt_inspectionDate.Text = DateTime.Now.ToString("M/d/yyyy");

            if (txt_createdby.Text == "")
                txt_createdby.Text = Context.User.Identity.Name;

            if (txt_sig_inspector.Text == "")
                txt_sig_inspector.Text = Context.User.Identity.Name;
        } 

        protected void btn_calendar_Click(object sender, EventArgs e)
        {
            calendar.Visible = true;
        }

        protected void calendar_SelectionChanged(object sender, EventArgs e)
        {
            txt_inspectionDate.Text = DateTime.Parse(calendar.SelectedDate.ToShortDateString()).ToString("M/d/yyyy");
            calendar.Visible = false;
        }

        protected void btn_getBus_Click(object sender, EventArgs e)
        {

            if (ddl_bus.SelectedIndex != 0)
            {
                int inspectionId = 0;
                SqlDataAdapter adapter = new SqlDataAdapter();
                SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["BSIAConnectionString"].ConnectionString);
                conn.Open();

                System.Data.DataSet ds = new System.Data.DataSet();

                SqlCommand cmd = new SqlCommand("Select * FROM BSIA.dbo.Inspections " +
                    "WHERE season_id = @season_id AND bus_id = (SELECT bus_id from BusContractorNumber bcn WHERE bus_number = @bus_num " +
                    "AND bcn.effective_date <= GETDATE() AND ( bcn.termination_date IS NULL OR bcn.termination_date > GETDATE()))", conn);
                try
                {
                    cmd.Parameters.AddWithValue("@season_id", ddl_season.SelectedIndex);
                    cmd.Parameters.AddWithValue("@bus_num", int.Parse(ddl_bus.SelectedItem.Text));
                    adapter.SelectCommand = cmd;
                    adapter.Fill(ds);
                }
                catch(Exception err)
                {
                    System.Console.Write("somthing went wrong");
                }

                if (ds.Tables[0].Rows.Count == 0)
                {
                    pnl_bus.Visible = true;
                    pnl_inspection.Visible = true;
                    pnl_error_exists.Visible = false;
                    btn_getBus.CssClass = "btn btn-primary";
                    btn_getBus.Enabled = false;
                }
                else
                {
                    pnl_error_exists.Visible = true;
                }
            }
        }

        protected void btn_createInspection_Click(object sender, EventArgs e)
        {

            int inspectionId = 0;
            Boolean passed = false;

            string creationDate;
            if (txt_inspectionDate.Text != "")
                creationDate = txt_inspectionDate.Text;
            else creationDate = DateTime.Now.ToString("M/d/yyyy");

            List<InspectionItem> failedItems = new List<InspectionItem>();
            int contractorId = 0;

            foreach (RepeaterItem i in repeater_busInfo.Items)
            {
                Label contractor = (Label)i.FindControl("lbl_contractor_id");
                contractorId = int.Parse(contractor.Text);
            }

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
                        foreach(RepeaterItem note in rep2.Items)
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
                passed = true;

            SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["BSIAConnectionString"].ConnectionString);
            conn.Open();

            int bus_id = 0;
            SqlCommand cmd1 = new SqlCommand("SELECT bus_id from BusContractorNumber WHERE bus_number = @bus_num", conn);
            cmd1.Parameters.AddWithValue("@bus_num", ddl_bus.SelectedValue);
            bus_id = (int)cmd1.ExecuteScalar();

            SqlCommand cmd = new SqlCommand("INSERT INTO BSIA.dbo.Inspections(inspection_date, season_id, bus_id, contractor_id, user_id, odometer, inspector_esignature, notes, contractor_ename, contractor_esignature, pass_date, tag_number, created_by, updated_by, date_created, date_updated) " +
                "output INSERTED.inspection_id" + " VALUES (@insp_date, @season_id, @bus_id, @contractor_id, @user_id," +
                " @odometer, @inspector_esignature, @notes, @contractor_ename, @contractor_esignature, @pass_date, @tag_number," +
                " @created_by, @updated_by, GETDATE(), GETDATE())", conn);

            try
            {
                cmd.Parameters.AddWithValue("@insp_date", creationDate);
                cmd.Parameters.AddWithValue("@season_id", ddl_season.SelectedIndex);
                cmd.Parameters.AddWithValue("@bus_id", bus_id);
                cmd.Parameters.AddWithValue("@contractor_id", contractorId);
                //TODO: get user id
                //bogus user id for now 
                cmd.Parameters.AddWithValue("@user_id", 1);
                cmd.Parameters.AddWithValue("@odometer", int.Parse(txt_odometer.Text));
                cmd.Parameters.AddWithValue("@inspector_esignature", "1");
                cmd.Parameters.AddWithValue("@contractor_esignature", "1");
                string contractor_ename = txt_sig_contractor_first.Text + " " + txt_sig_contractor_last.Text;
                cmd.Parameters.AddWithValue("@contractor_ename", contractor_ename);
                cmd.Parameters.AddWithValue("@notes", ta_notes.Value);

                if (passed)
                    cmd.Parameters.AddWithValue("@pass_date", creationDate);
                else
                    cmd.Parameters.AddWithValue("@pass_date", DBNull.Value);

                cmd.Parameters.AddWithValue("@tag_number", txt_tag.Text);
                //TODO: get user id
                //bogus user id for now
                cmd.Parameters.AddWithValue("@created_by", 1);
                cmd.Parameters.AddWithValue("@updated_by", 1);

                inspectionId = (int)cmd.ExecuteScalar();

                if (failedItems.Count != 0)
                {
                    foreach (InspectionItem item in failedItems)
                    {
                        item.inspection_id = inspectionId;
                        SqlCommand cmd_fails = new SqlCommand("INSERT INTO BSIA.dbo.InspectionFailures(inspection_id, element_id, notes, severity_id, created_by, updated_by, date_created, date_updated) " +
                            " VALUES (@inspection_id, @element_id, @notes, @severity_id," +
                            " @created_by, @updated_by, GETDATE(), GETDATE())", conn);

                        cmd_fails.Parameters.AddWithValue("@inspection_id", item.inspection_id);
                        cmd_fails.Parameters.AddWithValue("@element_id", item.element_id);
                        cmd_fails.Parameters.AddWithValue("@notes", (item.notes == null)? "":item.notes);
                        cmd_fails.Parameters.AddWithValue("@severity_id", item.severity_id);
                        //TODO: get user id
                        //bogus user id for now
                        cmd_fails.Parameters.AddWithValue("@created_by", 1);
                        cmd_fails.Parameters.AddWithValue("@updated_by", 1);

                        cmd_fails.ExecuteNonQuery();
                    }
                }

                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal_success_create();", true);
                pnl_success.Visible = true;
                btn_createInspection.Enabled = false;
            }
            catch (Exception err)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal_error_create();", true);
                pnl_error.Visible = true;
                System.Console.Write(err);
            }
            finally
            {
                conn.Close();
            }

        }

    }
}