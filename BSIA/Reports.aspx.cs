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
using System.Data.Odbc;


namespace BSIA
{
    public partial class Reports : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {/*
            if (!IsPostBack)
            {
                //ReportViewer1.Reset();
                ReportViewer1.ProcessingMode = ProcessingMode.Local;
                ReportViewer1.LocalReport.ReportPath = Server.MapPath("~/Report4.rdlc");
                BSIA_Rpts ds_busPass = new BSIA_Rpts();
                //ds_busPass = GetData(77);
                ds_busPass = GetData();
                ReportDataSource datasource_busPass = new ReportDataSource("rpt_Buses_Passing_Inspection", ds_busPass.Tables[0]);
                ReportViewer1.LocalReport.DataSources.Clear();
                ReportViewer1.LocalReport.DataSources.Add(datasource_busPass);
                ReportViewer1.LocalReport.Refresh();

                //ReportViewer2.Reset();
                //ReportViewer2.ProcessingMode = ProcessingMode.Local;
                //ReportViewer2.LocalReport.ReportPath = Server.MapPath("~/Inspection Summary.rdlc");
                //BSIA_Rpts ds_failures = new BSIA_Rpts();
                //ds_failures = GetData(77);
                //ReportDataSource datasource_failures = new ReportDataSource("Failures", ds_failures.Tables[0]);
                //ReportViewer2.LocalReport.DataSources.Clear();
                //ReportViewer2.LocalReport.DataSources.Add(datasource_failures);
            }
         */
        }

        /*

        OdbcConnection cn;
        OdbcCommand cmd;
        BSIA_Rpts ds_busPass = new BSIA_Rpts();
        //public BSIA_Rpts GetData(
        //    BSIA_Rpts ds_busPass, string conString, string queryString)
        public BSIA_Rpts GetData()
        {
            string conString = ConfigurationManager.ConnectionStrings["BSIAConnectionString2"].ConnectionString;
            cmd = new OdbcCommand("{? = call dbo.rpt_Buses_Passing_Inspection (?, ?)}", cn);
            cn = new OdbcConnection(conString);
            

            using (OdbcConnection connection = new OdbcConnection(conString))
            {
                //using (OdbcDataAdapter adapter = new OdbcDataAdapter(cmd, connection))
                using (OdbcDataAdapter adapter = new OdbcDataAdapter())
                {
                    // Open the connection and fill the DataSet.
                    try
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.CommandText = "rpt_Buses_Passing_Inspection"; //your store procedure name;
                        cmd.Parameters.Add("@StartDate", OdbcType.Date).Value = DateTime.Parse("07/01/2015");
                        cmd.Parameters.Add("@EndDate", OdbcType.Date).Value = DateTime.Parse("7/10/2015");
                        using (BSIA_Rpts ds_busPass = new BSIA_Rpts())
                        {
                            connection.Open();
                            adapter.Fill(ds_busPass);
                        }
                    }
                    catch (Exception ex)
                    {
                        Console.WriteLine(ex.Message);
                    }
                    // The connection is automatically closed when the
                    // code exits the using block.
                }
            }
            return ds_busPass;
        }

        */
    }


}


