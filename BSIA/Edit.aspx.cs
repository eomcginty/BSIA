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
        }

        protected void btn_getBusEdit_Click(object sender, EventArgs e)
        {
            pnl_bus.Visible = true;
            pnl_inspection.Visible = true;
        }

        protected void btn_getBusDelete_Click(object sender, EventArgs e)
        {
            pnl_bus.Visible = true;
            pnl_inspection.Visible = true;
        }

        protected void btn_editInspection_Click(object sender, EventArgs e)
        {
            //SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["BSIAConnectionString"].ConnectionString);
            //conn.Open();
            //SqlCommand cmd = new SqlCommand("Insert into season (season_name, created_by, updated_by, date_created, date_updated) values(@season_name, @created_by, @updated_by, @date_created, @date_updated)", conn);
            //try
            //{
            //    cmd.Parameters.AddWithValue("@season_name", "Test Season2");
            //    cmd.Parameters.AddWithValue("@created_by", "1");
            //    cmd.Parameters.AddWithValue("@updated_by", "1");
            //    cmd.Parameters.AddWithValue("@date_created", "11/25/2015 12:00:00 AM");
            //    cmd.Parameters.AddWithValue("@date_updated", "11/25/2015 12:00:00 AM");
            //    cmd.ExecuteNonQuery();
            //    lbl_message.Visible = true;
            //    lbl_message.Text = "Saved...";
            //}
            //catch (Exception)
            //{
            //    lbl_message.Visible = true;
            //    lbl_message.Text = "Not Saved.";
            //}
            //finally
            //{
            //    conn.Close();
            //}
        }

        protected void btn_deleteInspection_Click(object sender, EventArgs e)
        {

        }
    }
}