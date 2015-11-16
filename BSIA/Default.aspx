<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="BSIA._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron" style="height: 400px">
        <!--<h1>BSIA</h1>
        <p class="lead">The Bus Safety Inspection Application (BSIA) is a web application used to perform inspections and view inspection data on school buses for a public school system transportation department.</p>
        <p><a href="http://www.asp.net" class="btn btn-primary btn-lg">Learn more &raquo;</a></p>--><br /><br /><br /><br /><br /><br />
    </div>
    <div class="row">
        <div class="col-md-3">
            <h2>Login</h2>
            <div class="form-group">
                <label for="usr">Name:</label>
                <input type="text" class="form-control" id="usr">
            </div>
            <div class="form-group">
                <label for="pwd">Password:</label>
                <input type="password" class="form-control" id="pwd">
            </div>
            <button type="button" class="btn btn-primary">Login</button>
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
