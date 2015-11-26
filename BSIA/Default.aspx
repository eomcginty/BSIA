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
            <p>
                ASP.NET Web Forms lets you build dynamic websites using a familiar drag-and-drop, event-driven model.
            A design surface and hundreds of controls and components let you rapidly build sophisticated, powerful UI-driven sites with data access.
            </p>
            <p>
                <a class="btn btn-default" href="Create.aspx">Learn more &raquo;</a>
            </p>
        </div>
        <div class="col-md-3">
            <h2>Edit Inspection</h2>
            <p>
                NuGet is a free Visual Studio extension that makes it easy to add, remove, and update libraries and tools in Visual Studio projects.
            </p>
            <p>
                <a class="btn btn-default" href="Edit.aspx">Learn more &raquo;</a>
            </p>
        </div>
        <div class="col-md-3">
            <h2>Reports</h2>
            <p>
                You can easily find a web hosting company that offers the right mix of features and price for your applications.
            </p>
            <p>
                <a class="btn btn-default" href="Reports.aspx">Learn more &raquo;</a>
            </p>
        </div>
    </div>

</asp:Content>
