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

        protected void btn_getBusEdit_Click(object sender, EventArgs e)
        {
            pnl_bus.Visible = true;
            pnl_repairs.Visible = true;
           // pnl_inspection.Visible = true;
        }

        protected void btn_editInspection_Click(object sender, EventArgs e)
        {

        }

        protected void btn_getBusDelete_Click(object sender, EventArgs e)
        {
            pnl_bus.Visible = true;
            //pnl_inspection.Visible = true;
        }

        //protected void btn_deleteInspection_Click(object sender, EventArgs e)
        //{

        //}
    }
}