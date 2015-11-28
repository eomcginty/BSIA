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
        }

        protected void btn_calendar_Click(object sender, EventArgs e)
        {
            calendar.Visible = true;
        }

        protected void calendar_SelectionChanged(object sender, EventArgs e)
        {
            txt_inspectionDate.Text = calendar.SelectedDate.ToShortDateString();
            calendar.Visible = false;
        }

        protected void btn_getBus_Click(object sender, EventArgs e)
        {
            pnl_bus.Visible = true;
            pnl_inspection.Visible = true;
        }



        protected void btn_createInspection_Click(object sender, EventArgs e)
        {

            int inspectionId = 0;
            Boolean passed = false;
            string today = DateTime.Now.ToString("M/d/yyyy");

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

                        Repeater rep2 = (Repeater)item.FindControl("Repeater_elements");
                        foreach(RepeaterItem note in rep2.Items)
                        {
                            CheckBox cb_note = (CheckBox)note.FindControl("cb_elements");
                            if (cb_note.Checked)
                                failedItem.notes += cb_note.Text + "\n";
                        }

                        //TextBox tb = (TextBox)item.FindControl("txt_comments");
                        //failedItem.notes += tb.Text;

                        failedItems.Add(failedItem);
                    }
                }

            }

            
            if (failedItems.Count == 0)
                passed = true;

            SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["BSIAConnectionString"].ConnectionString);
            conn.Open();
            SqlCommand cmd = new SqlCommand("INSERT INTO BSIA.dbo.Inspections(inspection_date, season_id, bus_id, contractor_id, user_id, odometer, inspector_esignature, notes, contractor_ename, contractor_esignature, pass_date, tag_number, created_by, updated_by, date_created, date_updated) " +
                "output INSERTED.inspection_id" + " VALUES (@insp_date, @seaon_id, @bus_id, @contractor_id, @user_id," +
                " @odometer, @inspector_esignature, @notes, NULL, NULL, @pass_date, @tag_number," +
                " @created_by, @updated_by, GETDATE(), GETDATE())", conn);
            try
            {
                cmd.Parameters.AddWithValue("@insp_date", today);
                cmd.Parameters.AddWithValue("@seaon_id", ddl_season.SelectedIndex);
                cmd.Parameters.AddWithValue("@bus_id", int.Parse(ddl_bus.SelectedItem.Text));
                //TODO: get contractor id
                //bogus contractor id for now
                cmd.Parameters.AddWithValue("@contractor_id", 23);
                //TODO: get user id
                //bogus user id for now
                cmd.Parameters.AddWithValue("@user_id", 1);
                cmd.Parameters.AddWithValue("@odometer", int.Parse(txt_odometer.Text));
                //TODO: get inspector sig
                //bogus sig for now
                cmd.Parameters.AddWithValue("@inspector_esignature", "1");
                cmd.Parameters.AddWithValue("@notes", ta_notes.Value);
                // null               cmd.Parameters.AddWithValue("@contractor_ename", "Bogus name"   );
                // NULL               cmd.Parameters.AddWithValue("@contractor_esignature", "Bogus Signature"   );
                if (passed)
                    cmd.Parameters.AddWithValue("@pass_date", today);
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
                lbl_message.Visible = true;
                lbl_message.Text = "Saved...";
            }
            catch (Exception)
            {
                lbl_message.Visible = true;
                lbl_message.Text = "Not Saved.";
            }
            finally
            {
                conn.Close();
            }

        }

    }
}