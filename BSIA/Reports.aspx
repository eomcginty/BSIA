﻿<%@ Page Title="Reports" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Reports.aspx.cs" Inherits="BSIA.Reports" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=12.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Inspection Data Reporting and Analysis</h2>

    <%--Begin Tabbed List--%>
    <div>
        <!-- Nav tabs -->
        <ul class="nav nav-tabs" role="tablist">
            <li role="presentation" class="active"><a href="#divRptSummary" aria-controls="divRptSummary" role="tab" data-toggle="tab">Inspection Summary</a></li>
            <li role="presentation"><a href="#divRpt1" aria-controls="divRpt1" role="tab" data-toggle="tab">Redline</a></li>
            <li role="presentation"><a href="#divRpt2" aria-controls="divRpt2" role="tab" data-toggle="tab">30 Day Violation</a></li>
            <li role="presentation"><a href="#divRpt3" aria-controls="divRpt3" role="tab" data-toggle="tab">Passed</a></li>
            <li role="presentation"><a href="#divRpt4" aria-controls="divRpt4" role="tab" data-toggle="tab">Outstanding Violations</a></li>
            <li role="presentation"><a href="#divRpt5" aria-controls="divRpt5" role="tab" data-toggle="tab">Inspections Due</a></li>
            <li role="presentation"><a href="#divRpt6" aria-controls="divRpt6" role="tab" data-toggle="tab">View Inspection Report</a></li>
        </ul> <%--End new tabs--%>

        <!-- Begin Tab panes -->
        <div class="tab-content">
            <div role="tabpanel" class="tab-pane active" id="divRptSummary">
                <h3>Summary of the Latest Inspection</h3>
                <p>Summary of the latest inspection results including the number of buses inspected, the number of minor failures, the number of major failures, the number of outstanding repairs (any failure that has not been corrected is considered an outstanding failure regardless of the time passed.</p><br />

                <rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana" Font-Size="8pt" WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt" Width="751px">
                    <LocalReport ReportPath="Report4.rdlc">
                                                <DataSources>
                            <rsweb:ReportDataSource Name="rpt_Buses_Passing_Inspection" DataSourceId="ObjectDataSource1"></rsweb:ReportDataSource>
                        </DataSources>
                    </LocalReport>
                </rsweb:ReportViewer>
                <asp:ObjectDataSource runat="server" SelectMethod="GetData" TypeName="BSIA.BSIA_RptsTableAdapters.rpt_Buses_Passing_InspectionTableAdapter" ID="ObjectDataSource1" OldValuesParameterFormatString="original_{0}">
                    <SelectParameters>
                        <asp:Parameter DefaultValue="7/1/2015" Name="StartDate" Type="DateTime"></asp:Parameter>
                        <asp:Parameter DefaultValue="7/10/2015" Name="EndDate" Type="DateTime"></asp:Parameter>
                    </SelectParameters>
                </asp:ObjectDataSource>
            
           
            </div>
            <div role="tabpanel" class="tab-pane" id="divRpt1">
                <h3>Buses with Redline</h3>

            
            </div>
            <div role="tabpanel" class="tab-pane" id="divRpt2">
                <h3>Buses with 30 Day Violation</h3>

            </div>
            <div role="tabpanel" class="tab-pane" id="divRpt3">
                <h3>Buses that passed initial inspection</h3>
            </div>
            <div role="tabpanel" class="tab-pane" id="divRpt4">
                <h3>Buses with outstanding violations (pending repairs)</h3>
            </div>
            <div role="tabpanel" class="tab-pane" id="divRpt5">
                <h3>Buses that have an inspection due</h3>
            </div>
            <div role="tabpanel" class="tab-pane" id="divRpt6">
                <h3>Inspection Report</h3>
                (this is the report transmitted or printed following an inspection and can be run as needed)
            </div>
        </div><!-- End Tab panes -->
    </div> <%--End Tabbed List--%>


</asp:Content>
