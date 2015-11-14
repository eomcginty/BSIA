<%@ Page Title="Create" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Create.aspx.cs" Inherits="BSIA.Create" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    
    <%--Begin Bus Information Panel--%>
    <div class="panel panel-default">
        <div class="panel-heading" style="font-size: 18px; font-weight: bold; background-color: cornflowerblue">Bus Information</div>
        <div class="panel-body">

            <div class="row">

                <div class="col-sm-4">
                    <div class="form-group">
                        <label for="sel_bus">Bus:</label>
                        <select class="form-control" id="sel_bus" style="max-width: 300px">
                            <option>1</option>
                            <option>2</option>
                            <option>3</option>
                            <option>4</option>
                            <option>45</option>
                            <option>456</option>
                        </select>
                    </div>
                </div>

                <div class="col-sm-8">
                    <div class="form-group" style="grid-flow: columns">

                        <table class="table">
                            <thead>
                                <tr>
                                    <th>Contractor</th>
                                    <th>VIN</th>
                                    <th>Model</th>
                                    <th>Chassis</th>
                                    <th>Body</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>Contractor Name</td>
                                    <td>4DRBUAAN09B06282948</td>
                                    <td>2009</td>
                                    <td>INTERNATIONAL</td>
                                    <td>INTERNATIONAL</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>

            </div><%--End Bus Info Row--%>     
        </div><%--End Bus Panel Body--%>
    </div><%--End Bus Panel--%>
    

    <%--Begin Create Inspection Panel--%>
    <div class="panel panel-default">
        <div class="panel-heading" style="font-size: 18px; font-weight: bold; background-color: cornflowerblue">Create Inspection</div>
        <div class="panel-body">

            <div class="row">
                <div class="col-sm-3">
                    <div class="form-group" style="grid-flow: columns">
                        <label for="sel_season">Season:</label>
                        <select class="form-control" id="sel_season" style="max-width: 300px">
                            <option>Spring</option>
                            <option>Summer</option>
                            <option>Fall</option>
                            <option>Winter</option>
                        </select>
                    </div>
                </div>

                <div class="col-sm-3">
                    <div class="form-group" style="grid-flow: columns">
                        <label for="lbl_inspectionDate">Inspection Date:</label>
                        <input type="text" class="form-control" id="txt_inspectionDate">
                    </div>
                </div>

                <div class="col-sm-3">
                    <div class="form-group" style="grid-flow: columns">
                        <label for="lbl_odometer">Odometer:</label>
                        <input type="text" class="form-control" id="txt_odometer">
                    </div>
                </div>

                <div class="col-sm-3">
                <div class="form-group" style="grid-flow: columns">
                    <label for="lbl_enteredBy">Entered By:</label>
                    <input type="text" class="form-control" id="txt_enteredBy">
                </div>




                </div>
            </div> <%--End Row Div--%>


            <div class="container">
                <div class="panel-group">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" href="#collapse1">Group I - Suspension & Frame <span class="badge" style="float: right">5</span></a>
                            </h4>
                        </div>
                        <div id="collapse1" class="panel-collapse collapse">
                            <ul class="list-group">
                                <li class="list-group-item">One</li>
                                <li class="list-group-item">Two</li>
                                <li class="list-group-item">Three</li>
                            </ul>
                            <div class="panel-footer">Footer</div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="container">
                <div class="panel-group">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" href="#collapse2">Group II - Brakes & Wheels <span class="badge" style="float: right">5</span></a>
                            </h4>
                        </div>
                        <div id="collapse2" class="panel-collapse collapse">
                            <ul class="list-group">
                                <li class="list-group-item">One</li>
                                <li class="list-group-item">Two</li>
                                <li class="list-group-item">Three</li>
                            </ul>
                            <div class="panel-footer">Footer</div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="container">
                <div class="panel-group">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" href="#collapse3">Group III - Engine & Exhaust <span class="badge" style="float: right">5</span></a>
                            </h4>
                        </div>
                        <div id="collapse3" class="panel-collapse collapse">
                            <ul class="list-group">
                                <li class="list-group-item">One</li>
                                <li class="list-group-item">Two</li>
                                <li class="list-group-item">Three</li>
                            </ul>
                            <div class="panel-footer">Footer</div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="container">
                <div class="panel-group">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" href="#collapse4">Group IV - Lighting & Glazing <span class="badge" style="float: right">5</span></a>
                            </h4>
                        </div>
                        <div id="collapse4" class="panel-collapse collapse">
                            <ul class="list-group">
                                <li class="list-group-item">One</li>
                                <li class="list-group-item">Two</li>
                                <li class="list-group-item">Three</li>
                            </ul>
                            <div class="panel-footer">Footer</div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="container">
                <div class="panel-group">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" href="#collapse5">Group V - Emergency Equipment <span class="badge" style="float: right">5</span></a>
                            </h4>
                        </div>
                        <div id="collapse5" class="panel-collapse collapse">
                            <ul class="list-group">
                                <li class="list-group-item">One</li>
                                <li class="list-group-item">Two</li>
                                <li class="list-group-item">Three</li>
                            </ul>
                            <div class="panel-footer">Footer</div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="container">
                <div class="panel-group">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" href="#collapse6">Group VI - General <span class="badge" style="float: right">5</span></a>
                            </h4>
                        </div>
                        <div id="collapse6" class="panel-collapse collapse">
                            <ul class="list-group">
                                <li class="list-group-item">One</li>
                                <li class="list-group-item">Two</li>
                                <li class="list-group-item">Three</li>
                            </ul>
                            <div class="panel-footer">Footer</div>
                        </div>
                    </div>
                </div>
            </div>
            <br />
            <div class="container">
                <form role="form">
                    <div class="form-group">
                        <label for="notes">Notes:</label>
                        <textarea class="form-control" rows="5" id="notes"></textarea>
                    </div>
                </form>
            </div>

        </div>
    </div>
</asp:Content>
