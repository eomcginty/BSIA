<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="BSIA._Default" %>
<%@ Register Src="~/Account/OpenAuthProviders.ascx" TagPrefix="uc" TagName="OpenAuthProviders" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron" style="height: 300px">
        <!--<h1>BSIA</h1>
        <p class="lead">The Bus Safety Inspection Application (BSIA) is a web application used to perform inspections and view inspection data on school buses for a public school system transportation department.</p>
        <p><a href="http://www.asp.net" class="btn btn-primary btn-lg">Learn more &raquo;</a></p>--><br /><br /><br /><br /><br /><br />
    </div>
    <div class="row">
        <div class="col-md-3">
            <h2>Login</h2>
                <asp:PlaceHolder runat="server" ID="d_ErrorMessage" Visible="false">
                    <p class="text-danger"><asp:Literal runat="server" ID="d_FailureText" /></p>
                </asp:PlaceHolder>
                <asp:PlaceHolder runat="server" ID="d_LoginMessageSuccess" Visible="false">
                    <p class="text-success"><asp:Literal runat="server" ID="d_SuccessText" /></p>
                </asp:PlaceHolder>
                <asp:Panel ID="d_pnl_login" runat="server" Visible="true">
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="d_UserName" CssClass="control-label">Username:</asp:Label>
                        <div><asp:TextBox runat="server" ID="d_UserName" CssClass="form-control" /></div>
                    </div>
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="d_Password" CssClass="control-label">Password:</asp:Label>
                        <div><asp:TextBox runat="server" ID="d_Password" TextMode="Password" CssClass="form-control" /></div>
                    </div>
                    <div class="form-group">
                        <div>
                            <div class="checkbox">
                                <asp:CheckBox runat="server" ID="d_RememberMe" />
                                <asp:Label runat="server" AssociatedControlID="d_RememberMe">Remember me?</asp:Label>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div><asp:Button runat="server" OnClick="d_LogIn" Text="Login" CssClass="btn btn-primary" /></div>
                    </div>
                </asp:Panel>
        </div>
        <div class="col-md-3">
            <h2>Create Inspection</h2>
            <p>The BSIA eliminates the need for paper inspection forms. Inspectors can create a new bus inspection and 
                use the BSIA to complete and submit the inspection entirely online.</p>
            <p><a class="btn btn-default" href="Create.aspx">Create Inspections &raquo;</a></p>
        </div>
        <div class="col-md-3">
            <h2>Edit Inspection</h2>
            <p>Allows transportation staff to edit a completed inspection to fix errors or update the inspection based 
                on changes, such as repairs. Administrators can also delete completed inspections.</p>
            <p><a class="btn btn-default" href="Edit.aspx">Edit or Delete Inspections &raquo;</a></p>
        </div>
        <div class="col-md-3">
            <h2>Reports</h2>
            View up-to-date inspection data: 
                <ul>
                    <li>Inspection Summary</li>
                    <li>Redline Violations</li>
                    <li>30 Day Violations</li>
                    <li>Passed Initial Inspection</li>
                    <li>Outstanding Violations</li>
                    <li>Inspection Due</li>
                    <li>View Inspection Reports</li>
                </ul>
            
            <p><a class="btn btn-default" href="Reports.aspx">View Reports &raquo;</a></p>
        </div>
    </div>

</asp:Content>
