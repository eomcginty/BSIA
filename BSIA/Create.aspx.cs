using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BSIA
{
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

        }

    }
}