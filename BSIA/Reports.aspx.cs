using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;
using Microsoft.Reporting.WebForms;
using Microsoft.Owin.Security;


namespace BSIA
{
    public partial class Reports : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ReportViewer1.Reset();
                ReportViewer1.ProcessingMode = ProcessingMode.Local;
                ReportViewer1.LocalReport.ReportPath = Server.MapPath("~/Inspection Summary.rdlc");
                BSIA_Rpts ds_busDetails = new BSIA_Rpts();
                ds_busDetails = GetData(77);
                ReportDataSource datasource_busDetails = new ReportDataSource("BusDetails", ds_busDetails.Tables[0]);
                ReportViewer1.LocalReport.DataSources.Clear();
                ReportViewer1.LocalReport.DataSources.Add(datasource_busDetails);

                ReportViewer2.Reset();
                ReportViewer2.ProcessingMode = ProcessingMode.Local;
                ReportViewer2.LocalReport.ReportPath = Server.MapPath("~/Inspection Summary.rdlc");
                BSIA_Rpts ds_failures = new BSIA_Rpts();
                ds_failures = GetData(77);
                ReportDataSource datasource_failures = new ReportDataSource("Failures", ds_failures.Tables[0]);
                ReportViewer2.LocalReport.DataSources.Clear();
                ReportViewer2.LocalReport.DataSources.Add(datasource_failures);
            }
        }

        private BSIA_Rpts GetData(int id)
        {
            string conString = ConfigurationManager.ConnectionStrings["BSIAConnectionString"].ConnectionString;
            SqlCommand cmd = new SqlCommand("dbo.rpt_Bus_Inspection_Summary");
            using (SqlConnection con = new SqlConnection(conString))
            {
                using (SqlDataAdapter sda = new SqlDataAdapter())
                {
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.StoredProcedure;
                    //cmd.Parameters.Add("@StartDate", SqlDbType.DateTime).Value = "1/1/2013";
                    //cmd.Parameters.Add("@EndDate", SqlDbType.DateTime).Value = "11/20/2015";
                    cmd.Parameters.Add("@InspectionID", SqlDbType.Int).Value = id;
                    sda.SelectCommand = cmd;
                    using (BSIA_Rpts ds = new BSIA_Rpts())
                    {
                       // ds.EnforceConstraints = false;
                        //sda.Fill(dsViolations, "DataTable1");
                        sda.Fill(ds, "rpt_Bus_Inspection_Summary");
                        return ds;
                    }
                }
            }
        }


    }


}