﻿using System;
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


    }
}