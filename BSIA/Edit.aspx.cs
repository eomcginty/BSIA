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

            //if (txt_createdby.Text == "")
            //    txt_createdby.Text = Context.User.Identity.Name;
        }

        protected void btn_calendar_Click(object sender, EventArgs e)
        {

            //calendar.Visible = true;
        }

        protected void calendar_SelectionChanged(object sender, EventArgs e)
        {
            //txt_inspectionDate.Text = DateTime.Parse(calendar.SelectedDate.ToShortDateString()).ToString("M/d/yyyy");
            //calendar.Visible = false;
        }

        protected void btn_getBus_Click(object sender, EventArgs e)
        {
            pnl_bus.Visible = true;
            upd_pnl_repairs.Visible = true;
            // pnl_inspection.Visible = true;
        }

        protected void btn_saveInspection_Click(object sender, EventArgs e)
        {

        }

        protected void btn_getBusEdit_Click(object sender, EventArgs e)
        {
            //pnl_bus.Visible = true;
            //pnl_inspection.Visible = true;
        }

        protected void btn_getBusDelete_Click(object sender, EventArgs e)
        {
            //pnl_bus.Visible = true;
            //pnl_inspection.Visible = true;
        }

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
                    //protected void btn_deleteInspection_Click(object sender, EventArgs e)
                    //{

                    //}
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

                    //notify user inspection passed
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal_success_repair();", true);
                    pnl_success.Visible = true;
                }
                else
                {
                    //notify user that there are still repairs
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal_error_repair();", true);
                    pnl_error.Visible = true;
                }

                conn.Close();
            }

            Repeater_repairs.DataBind();
            upd_pnl_repairs.Update();
        }

        protected void btn_delete_inspection_Click(object sender, EventArgs e)
        {

            //get inspection id from dbo.Inspections based on bus_id and season_id
            //delete all failures associated with inspection_id
            //delete inspection
            //<asp:ControlParameter ControlID = "ddl_bus" Name = "bus_id" Type = "Int32" DefaultValue = "0" />
            //<asp:ControlParameter ControlID = "ddl_season"  PropertyName = "SelectedIndex" Name = "season_id" Type = "Int32" DefaultValue = "0" />

        }

        protected void btn_edit_inspection_Click(object sender, EventArgs e)
        {

        }
    }
}