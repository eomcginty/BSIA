<%@ Page Title="Create" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Create.aspx.cs" Inherits="BSIA.Create" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Create Inspection</h2>

    <%--Begin Bus Information Panel--%>
    <div class="panel panel-default">
        <div class="panel-heading" style="font-size: 18px; font-weight: bold; background-color: cornflowerblue">Bus Information</div>
        <div class="panel-body">

            <%--Begin Bus Selection Row--%>
            <div class="row">
                <div class="alert alert-info fade in">
                    <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                    <i>Select Bus, Season, and Inspection Date.</i>
                </div>
                <div class="alert alert-warning fade in">
                    <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                    <i>Bus already has an inspection completed for this season.</i>
                </div>
                <div class="alert alert-warning fade in">
                    <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                    <i>Bus is currently locked for editing by another inspector.</i>
                </div>
                <div class="col-sm-3">
                    <div class="form-group">
                        <label for="lbl_bus">Bus:</label>
                        <asp:DropDownList class="form-control" ID="ddl_bus" Style="max-width: 300px" runat="server">
                            <asp:ListItem Text="Select Bus Number" Value="ddlli_prompt_bus" Selected="True" />
                            <asp:ListItem Text="1" Value="ddlli_bus1" />
                            <asp:ListItem Text="2" Value="ddlli_bus2" />
                            <asp:ListItem Text="3" Value="ddlli_bus3" />
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="col-sm-3">
                    <div class="form-group" style="grid-flow: columns">
                        <label for="lbl_season">Season:</label>
                        <asp:DropDownList class="form-control" ID="ddl_season" Style="max-width: 300px" runat="server">
                            <asp:ListItem Text="Select Season" Value="ddlli_prompt_season" Selected="True" />
                            <asp:ListItem Text="Spring" Value="ddlli_Spring" />
                            <asp:ListItem Text="Summer" Value="ddlli_Summer" />
                            <asp:ListItem Text="Fall" Value="ddlli_Fall" />
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="col-sm-3">
                    <div class="form-group" style="grid-flow: columns">
                        <label for="lbl_inspectionDate">Inspection Date:</label>
                        <table><tr><td>
                            <asp:TextBox ID="txt_inspectionDate" Width="200px" class="form-control" runat="server" /></td><td>
                            <asp:LinkButton ID="btn_calendar" runat="server" class="btn btn-primary btn-calendar" OnClick="btn_calendar_Click"><span aria-hidden="true" class="glyphicon glyphicon-calendar"></span></asp:LinkButton>
                        </td></tr></table>
                        <asp:Calendar ID="calendar" runat="server" BackColor="White" BorderColor="#999999" CellPadding="4" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" ForeColor="Black" Height="180px" Width="200px" OnSelectionChanged="calendar_SelectionChanged" Visible="False">
                            <DayHeaderStyle BackColor="#CCCCCC" Font-Bold="True" Font-Size="7pt" />
                            <NextPrevStyle VerticalAlign="Bottom" />
                            <OtherMonthDayStyle ForeColor="#808080" />
                            <SelectedDayStyle BackColor="#666666" Font-Bold="True" ForeColor="White" />
                            <SelectorStyle BackColor="#CCCCCC" />
                            <TitleStyle BackColor="#999999" BorderColor="Black" Font-Bold="True" />
                            <TodayDayStyle BackColor="#CCCCCC" ForeColor="Black" />
                            <WeekendDayStyle BackColor="#FFFFCC" />
                        </asp:Calendar>
                    </div>
                </div>
                <div class="col-sm-3" style="margin-top: 25px">
                    <asp:Button ID="btn_createInspection" class="btn btn-primary" runat="server" Text="Create Inspection" />
                </div>

            </div><%--End Bus Selection Row--%>   
            
            <%--Begin Display, Populate, and Verify Row--%>
            <div id="rowDisplay_busInfo" class="row" style="display: block">
                <div class="alert alert-info fade in">
                    <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                    <i>Verify Bus Information.</i>
                </div>
                <div class="col-sm-12">
                    <div class="form-group" style="grid-flow: columns">
                        <asp:Table class="table" id="tbl_busInfo" runat="server">
                            <asp:TableHeaderRow id="Table1HeaderRow" runat="server">
                                <asp:TableHeaderCell Scope="Column" Text="Contractor">Contractor</asp:TableHeaderCell>
                                <asp:TableHeaderCell Scope="Column" Text="VIN">VIN</asp:TableHeaderCell>
                                <asp:TableHeaderCell Scope="Column" Text="Model">Model</asp:TableHeaderCell>
                                <asp:TableHeaderCell Scope="Column" Text="Chassis">Chassis</asp:TableHeaderCell>
                                <asp:TableHeaderCell Scope="Column" Text="Body">Body</asp:TableHeaderCell>
                            </asp:TableHeaderRow>
                            <asp:TableRow>
                                <asp:TableCell Text="Contractor Name" />
                                <asp:TableCell Text="4DRBUAAN09B06282948" />
                                <asp:TableCell Text="2009" />
                                <asp:TableCell Text="INTERNATIONAL" />
                                <asp:TableCell Text="INTERNATIONAL" />
                            </asp:TableRow>
                        </asp:Table>
                    </div>
                </div>
            </div><%--End Display, Populate, and Verify Row--%>   
             
        </div><%--End Bus Panel Body--%>
    </div><%--End Bus Panel--%>
    

    <%--Begin Create Inspection Panel--%>
    <div class="panel panel-default">
        <div class="panel-heading" style="font-size: 18px; font-weight: bold; background-color: cornflowerblue">Create Inspection</div>
        <div class="panel-body">

            <%--Additional input fields - Odometer, TAG--%>
            <div class="row">

                <div class="col-sm-4">
                    <div class="form-group" style="grid-flow: columns">
                        <label for="lbl_odometer">Odometer:</label>
                        <asp:TextBox class="form-control" id="txt_odometer" placeholder="Numerical Data Only..." runat="server"></asp:TextBox>
                    </div>
                </div>

                <div class="col-sm-4">
                    <div class="form-group" style="grid-flow: columns">
                        <label for="lbl_tag">Vehicle License Plate (TAG):</label>
                        <asp:TextBox class="form-control" id="txt_tag" placeholder="Letters/Numbers, No Spaces..." runat="server"></asp:TextBox>
                    </div>
                </div>

                <div class="col-sm-4">
                    <div class="form-group" style="grid-flow: columns">
                        <label for="lbl_enteredBy">Entered By:</label> Do we still need this?
                        <asp:TextBox class="form-control" id="txt_enteredBy" runat="server"></asp:TextBox>
                    </div>
                </div>
            </div>  <%-- End Additional input fields - Odometer, TAG--%>

            <%--Begin Group I Panel--%>
            <div class="container">
                <div class="panel-group">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" href="#collapse1"><strong>Group I - Suspension & Frame</strong> <span class="badge badge-danger" style="float: right">5</span></a>
                            </h4>
                        </div>
                        <div id="collapse1" class="panel-collapse collapse">
                            <ul class="list-group">
                                <li class="list-group-item"><p><strong>Ball Joints</strong></p>
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-1"><asp:CheckBox id="cb_fail_ballJoints" Text="&nbsp;Fail" runat="server" /></div>
                                        <div class="col-xs-6 col-sm-3">
                                            <asp:DropDownList class="form-control" ID="ddl_ballJoints" Width="200px" runat="server">
                                                <asp:ListItem Text="Select Major or Minor..." Value="ddlli_prompt_majmin_ballJoints" Selected="True" />
                                                <asp:ListItem Text="Minor" Value="ddlli_Minor_ballJoints" />
                                                <asp:ListItem Text="Major" Value="ddlli_Major_ballJoints" />
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-xs-6 col-sm-4">
                                            <label class="checkbox-inline"><input type="checkbox" value="">Right</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Left</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Tighten</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Replace</label>
                                        </div>
                                        <div class="col-xs-6 col-sm-4"><asp:TextBox class="form-control" id="txt_comments_ballJoints" placeholder="Additional Comments..." runat="server"></asp:TextBox></div>
                                    </div>
                                </li>
                                <li class="list-group-item"><p><strong>Drag Link</strong></p>
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-1"><asp:CheckBox id="cb_fail_dragLink" Text="&nbsp;Fail" runat="server" /></div>
                                        <div class="col-xs-6 col-sm-3">
                                            <asp:DropDownList class="form-control" ID="ddl_dragLink" Width="200px" runat="server">
                                                <asp:ListItem Text="Select Major or Minor..." Value="ddlli_prompt_majmin_dragLink" Selected="True" />
                                                <asp:ListItem Text="Minor" Value="ddlli_Minor_dragLink" />
                                                <asp:ListItem Text="Major" Value="ddlli_Major_dragLink" />
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-xs-6 col-sm-4">
                                            <label class="checkbox-inline"><input type="checkbox" value="">Adjust</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Tighten</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Replace</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">+1/8"</label>
                                        </div>
                                        <div class="col-xs-6 col-sm-4"><asp:TextBox class="form-control" id="txt_comments_dragLink" placeholder="Additional Comments..." runat="server"></asp:TextBox></div>
                                    </div>
                                </li>
                                <li class="list-group-item"><p><strong>Tie Rods</strong></p>
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-1"><asp:CheckBox id="cb_fail_tieRods" Text="&nbsp;Fail" runat="server" /></div>
                                        <div class="col-xs-6 col-sm-3">
                                            <asp:DropDownList class="form-control" ID="ddl_tieRods" Width="200px" runat="server">
                                                <asp:ListItem Text="Select Major or Minor..." Value="ddlli_prompt_majmin_tieRods" Selected="True" />
                                                <asp:ListItem Text="Minor" Value="ddlli_Minor_tieRods" />
                                                <asp:ListItem Text="Major" Value="ddlli_Major_tieRods" />
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-xs-6 col-sm-4">
                                            <label class="checkbox-inline"><input type="checkbox" value="">End</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Right</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Left</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Adjust</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Tighten</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Replace</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">+1/8"</label>
                                        </div>
                                        <div class="col-xs-6 col-sm-4"><asp:TextBox class="form-control" id="txt_comments_tieRods" placeholder="Additional Comments..." runat="server"></asp:TextBox></div>
                                    </div>
                                </li>
                                <li class="list-group-item"><p><strong>Springs</strong></p>
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-1"><asp:CheckBox id="cb_fail_springs" Text="&nbsp;Fail" runat="server" /></div>
                                        <div class="col-xs-6 col-sm-3">
                                            <asp:DropDownList class="form-control" ID="ddl_springs" Width="200px" runat="server">
                                                <asp:ListItem Text="Select Major or Minor..." Value="ddlli_prompt_majmin_springs" Selected="True" />
                                                <asp:ListItem Text="Minor" Value="ddlli_Minor_springs" />
                                                <asp:ListItem Text="Major" Value="ddlli_Major_springs" />
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-xs-6 col-sm-4">
                                            <label class="checkbox-inline"><input type="checkbox" value="">Front</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Rear</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Right</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Left</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Refer to Manual</label>
                                        </div>
                                        <div class="col-xs-6 col-sm-4"><asp:TextBox class="form-control" id="txt_comments_springs" placeholder="Additional Comments..." runat="server"></asp:TextBox></div>
                                    </div>
                                </li>
                                <li class="list-group-item"><p><strong>Shackles (Bolts)</strong></p>
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-1"><asp:CheckBox id="cb_fail_shackles" Text="&nbsp;Fail" runat="server" /></div>
                                        <div class="col-xs-6 col-sm-3">
                                            <asp:DropDownList class="form-control" ID="ddl_shackles" Width="200px" runat="server">
                                                <asp:ListItem Text="Select Major or Minor..." Value="ddlli_prompt_majmin_shackles" Selected="True" />
                                                <asp:ListItem Text="Minor" Value="ddlli_Minor_shackles" />
                                                <asp:ListItem Text="Major" Value="ddlli_Major_shackles" />
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-xs-6 col-sm-4">
                                            <label class="checkbox-inline"><input type="checkbox" value="">Front</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Rear</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Right</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Left</label>
                                        </div>
                                        <div class="col-xs-6 col-sm-4"><asp:TextBox class="form-control" id="txt_comments_shackles" placeholder="Additional Comments..." runat="server"></asp:TextBox></div>
                                    </div>
                                </li>
                                <li class="list-group-item"><p><strong>Shock Absorbers</strong></p>
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-1"><asp:CheckBox id="cb_fail_shockAbsorbers" Text="&nbsp;Fail" runat="server" /></div>
                                        <div class="col-xs-6 col-sm-3">
                                            <asp:DropDownList class="form-control" ID="ddl_shockAbsorbers" Width="200px" runat="server">
                                                <asp:ListItem Text="Select Major or Minor..." Value="ddlli_prompt_majmin_shockAbsorbers" Selected="True" />
                                                <asp:ListItem Text="Minor" Value="ddlli_Minor_shockAbsorbers" />
                                                <asp:ListItem Text="Major" Value="ddlli_Major_shockAbsorbers" />
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-xs-6 col-sm-4">
  
                                        </div>
                                        <div class="col-xs-6 col-sm-4"><asp:TextBox class="form-control" id="txt_comments_shockAbsorbers" placeholder="Additional Comments..." runat="server"></asp:TextBox></div>
                                    </div>
                                </li>
                                <li class="list-group-item"><p><strong>Front End Alignment</strong></p>
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-1"><asp:CheckBox id="cb_fail_frontendAlignment" Text="&nbsp;Fail" runat="server" /></div>
                                        <div class="col-xs-6 col-sm-3">
                                            <asp:DropDownList class="form-control" ID="ddl_frontendAlignment" Width="200px" runat="server">
                                                <asp:ListItem Text="Select Major or Minor..." Value="ddlli_prompt_majmin_frontendAlighnment" Selected="True" />
                                                <asp:ListItem Text="Minor" Value="ddlli_Minor_frontendAlignment" />
                                                <asp:ListItem Text="Major" Value="ddlli_Major_frontendAlignment" />
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-xs-6 col-sm-4">

                                        </div>
                                        <div class="col-xs-6 col-sm-4"><asp:TextBox class="form-control" id="txt_comments_frontendAlignment" placeholder="Additional Comments..." runat="server"></asp:TextBox></div>
                                    </div>
                                </li>
                                <li class="list-group-item"><p><strong>King Pins and Bushings</strong></p>
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-1"><asp:CheckBox id="cb_fail_kingPins" Text="&nbsp;Fail" runat="server" /></div>
                                        <div class="col-xs-6 col-sm-3">
                                            <asp:DropDownList class="form-control" ID="ddl_kingPin" Width="200px" runat="server">
                                                <asp:ListItem Text="Select Major or Minor..." Value="ddlli_prompt_majmin_kingPin" Selected="True" />
                                                <asp:ListItem Text="Minor" Value="ddlli_Minor_kingPin" />
                                                <asp:ListItem Text="Major" Value="ddlli_Major_kingPin" />
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-xs-6 col-sm-4">
                                            <label class="checkbox-inline"><input type="checkbox" value="">Right</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Left</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Replace</label>
                                        </div>
                                        <div class="col-xs-6 col-sm-4"><asp:TextBox class="form-control" id="txt_comments_kingPins" placeholder="Additional Comments..." runat="server"></asp:TextBox></div>
                                    </div>
                                </li>
                                <li class="list-group-item"><p><strong>Steering Column</strong></p>
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-1"><asp:CheckBox id="cb_fail_steeringColumn" Text="&nbsp;Fail" runat="server" /></div>
                                        <div class="col-xs-6 col-sm-3">
                                            <asp:DropDownList class="form-control" ID="ddl_steeringColumn" Width="200px" runat="server">
                                                <asp:ListItem Text="Select Major or Minor..." Value="ddlli_prompt_majmin_steeringColumn" Selected="True" />
                                                <asp:ListItem Text="Minor" Value="ddlli_Minor_steeringColumn" />
                                                <asp:ListItem Text="Major" Value="ddlli_Major_steeringColumn" />
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-xs-6 col-sm-4">
                                            <label class="checkbox-inline"><input type="checkbox" value="">"U" Joint</label>
                                        </div>
                                        <div class="col-xs-6 col-sm-4"><asp:TextBox class="form-control" id="txt_comments_steeringColumn" placeholder="Additional Comments..." runat="server"></asp:TextBox></div>
                                    </div>
                                </li>
                                <li class="list-group-item"><p><strong>Steering Gear Box</strong></p>
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-1"><asp:CheckBox id="cb_fail_steeringGearBox" Text="&nbsp;Fail" runat="server" /></div>
                                        <div class="col-xs-6 col-sm-3">
                                            <asp:DropDownList class="form-control" ID="ddl_steeringGearBox" Width="200px" runat="server">
                                                <asp:ListItem Text="Select Major or Minor..." Value="ddlli_prompt_majmin_steeringGearBox" Selected="True" />
                                                <asp:ListItem Text="Minor" Value="ddlli_Minor_steeringGearBox" />
                                                <asp:ListItem Text="Major" Value="ddlli_Major_steeringGearBox" />
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-xs-6 col-sm-4">
                                            <label class="checkbox-inline"><input type="checkbox" value="">Adjust</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Tighten</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Replace</label>
                                        </div>
                                        <div class="col-xs-6 col-sm-4"><asp:TextBox class="form-control" id="txt_comments_steeringGearBox" placeholder="Additional Comments..." runat="server"></asp:TextBox></div>
                                    </div>
                                </li>
                                <li class="list-group-item"><p><strong>Steering Leakage</strong></p>
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-1"><asp:CheckBox id="cb_fail_steeringLeakage" Text="&nbsp;Fail" runat="server" /></div>
                                        <div class="col-xs-6 col-sm-3">
                                            <asp:DropDownList class="form-control" ID="ddl_steeringLeakage" Width="200px" runat="server">
                                                <asp:ListItem Text="Select Major or Minor..." Value="ddlli_prompt_majmin_steeringLeakage" Selected="True" />
                                                <asp:ListItem Text="Minor" Value="ddlli_Minor_steeringLeakage" />
                                                <asp:ListItem Text="Major" Value="ddlli_Major_steeringLeakage" />
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-xs-6 col-sm-4">
 
                                        </div>
                                        <div class="col-xs-6 col-sm-4"><asp:TextBox class="form-control" id="txt_comments_steeringLeakage" placeholder="Additional Comments..." runat="server"></asp:TextBox></div>
                                    </div>
                                </li>
                                <li class="list-group-item"><p><strong>Power Steering Mechanism and Hoses</strong></p>
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-1"><asp:CheckBox id="cb_fail_powerSteering" Text="&nbsp;Fail" runat="server" /></div>
                                        <div class="col-xs-6 col-sm-3">
                                            <asp:DropDownList class="form-control" ID="ddl_powerSteering" Width="200px" runat="server">
                                                <asp:ListItem Text="Select Major or Minor..." Value="ddlli_prompt_majmin_powerSteering" Selected="True" />
                                                <asp:ListItem Text="Minor" Value="ddlli_Minor_powerSteering" />
                                                <asp:ListItem Text="Major" Value="ddlli_Major_powerSteering" />
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-xs-6 col-sm-4">
                                            <label class="checkbox-inline"><input type="checkbox" value="">Adjust</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Replace</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Exposed Cord Body</label>
                                        </div>
                                        <div class="col-xs-6 col-sm-4"><asp:TextBox class="form-control" id="txt_comments_powerSteering" placeholder="Additional Comments..." runat="server"></asp:TextBox></div>
                                    </div>
                                </li>
                                <li class="list-group-item"><p><strong>Body Attachment</strong></p>
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-1"><asp:CheckBox id="cb_fail_bodyAttachment" Text="&nbsp;Fail" runat="server" /></div>
                                        <div class="col-xs-6 col-sm-3">
                                            <asp:DropDownList class="form-control" ID="ddl_bodyAttachment" Width="200px" runat="server">
                                                <asp:ListItem Text="Select Major or Minor..." Value="ddlli_prompt_majmin_bodyAttachment" Selected="True" />
                                                <asp:ListItem Text="Minor" Value="ddlli_Minor_bodyAttachment" />
                                                <asp:ListItem Text="Major" Value="ddlli_Major_bodyAttachment" />
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-xs-6 col-sm-4">

                                        </div>
                                        <div class="col-xs-6 col-sm-4"><asp:TextBox class="form-control" id="txt_comments_bodyAttachment" placeholder="Additional Comments..." runat="server"></asp:TextBox></div>
                                    </div>
                                </li>
                            </ul>
                            <div class="panel-footer">Footer</div>
                        </div>
                    </div>
                </div>
            </div> <%--End Group I Panel--%>
            <%--Begin Group II Panel--%>
            <div class="container">
                <div class="panel-group">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" href="#collapse2"><strong>Group II - Brakes & Wheels</strong> <span class="badge" style="float: right">5</span></a>
                            </h4>
                        </div>
                        <div id="collapse2" class="panel-collapse collapse">
                            <ul class="list-group">
                                <li class="list-group-item"><p><strong>Service</strong></p>
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-1"><asp:CheckBox id="cb_fail_service" Text="&nbsp;Fail" runat="server" /></div>
                                        <div class="col-xs-6 col-sm-3">
                                            <asp:DropDownList class="form-control" ID="ddl_service" Width="200px" runat="server">
                                                <asp:ListItem Text="Select Major or Minor..." Value="ddlli_prompt_majmin_service" Selected="True" />
                                                <asp:ListItem Text="Minor" Value="ddlli_Minor_service" />
                                                <asp:ListItem Text="Major" Value="ddlli_Major_service" />
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-xs-6 col-sm-4">
                                            <label class="checkbox-inline"><input type="checkbox" value="">Adjust</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Recline</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Squeak</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Grab</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Front</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Rear</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Right</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Left</label>
                                        </div>
                                        <div class="col-xs-6 col-sm-4"><asp:TextBox class="form-control" id="txt_comments_service" placeholder="Additional Comments..." runat="server"></asp:TextBox></div>
                                    </div>
                                </li>
                                <li class="list-group-item"><p><strong>Parking</strong></p>
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-1"><asp:CheckBox id="cb_fail_parking" Text="&nbsp;Fail" runat="server" /></div>
                                        <div class="col-xs-6 col-sm-3">
                                            <asp:DropDownList class="form-control" ID="ddl_parking" Width="200px" runat="server">
                                                <asp:ListItem Text="Select Major or Minor..." Value="ddlli_prompt_majmin_parking" Selected="True" />
                                                <asp:ListItem Text="Minor" Value="ddlli_Minor_parking" />
                                                <asp:ListItem Text="Major" Value="ddlli_Major_parking" />
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-xs-6 col-sm-4">
                                            <label class="checkbox-inline"><input type="checkbox" value="">Adjust</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Recline</label>
                                           </div>
                                        <div class="col-xs-6 col-sm-4"><asp:TextBox class="form-control" id="txt_comments_parking" placeholder="Additional Comments..." runat="server"></asp:TextBox></div>
                                    </div>
                                </li>
                                <li class="list-group-item"><p><strong>Air or Vacuum Booster</strong></p>
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-1"><asp:CheckBox id="cb_fail_booster" Text="&nbsp;Fail" runat="server" /></div>
                                        <div class="col-xs-6 col-sm-3">
                                            <asp:DropDownList class="form-control" ID="ddl_booster" Width="200px" runat="server">
                                                <asp:ListItem Text="Select Major or Minor..." Value="ddlli_prompt_majmin_booster" Selected="True" />
                                                <asp:ListItem Text="Minor" Value="ddlli_Minor_booster" />
                                                <asp:ListItem Text="Major" Value="ddlli_Major_booster" />
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-xs-6 col-sm-4">
                                            <label class="checkbox-inline"><input type="checkbox" value="">Leak</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Replace</label>
                                         </div>
                                        <div class="col-xs-6 col-sm-4"><asp:TextBox class="form-control" id="txt_comments_booster" placeholder="Additional Comments..." runat="server"></asp:TextBox></div>
                                    </div>
                                </li>
                                <li class="list-group-item"><p><strong>Low Indicator</strong></p>
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-1"><asp:CheckBox id="cb_fail_lowIndicator" Text="&nbsp;Fail" runat="server" /></div>
                                        <div class="col-xs-6 col-sm-3">
                                             <asp:DropDownList class="form-control" ID="ddl_lowIndicator" Width="200px" runat="server">
                                                <asp:ListItem Text="Select Major or Minor..." Value="ddlli_prompt_majmin_lowIndicator" Selected="True" />
                                                <asp:ListItem Text="Minor" Value="ddlli_Minor_lowIndicator" />
                                                <asp:ListItem Text="Major" Value="ddlli_Major_lowIndicator" />
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-xs-6 col-sm-4">
                                            <label class="checkbox-inline"><input type="checkbox" value="">Air</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Vacuum</label>
                                        </div>
                                        <div class="col-xs-6 col-sm-4"><asp:TextBox class="form-control" id="txt_comments_lowIndicator" placeholder="Additional Comments..." runat="server"></asp:TextBox></div>
                                    </div>
                                </li>
                                <li class="list-group-item"><p><strong>Emergency System</strong></p>
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-1"><asp:CheckBox id="cb_fail_emergencySystem" Text="&nbsp;Fail" runat="server" /></div>
                                        <div class="col-xs-6 col-sm-3">
                                            <asp:DropDownList class="form-control" ID="ddl_emergencySystem" Width="200px" runat="server">
                                                <asp:ListItem Text="Select Major or Minor..." Value="ddlli_prompt_majmin_emergencySystem" Selected="True" />
                                                <asp:ListItem Text="Minor" Value="ddlli_Minor_emergencySystem" />
                                                <asp:ListItem Text="Major" Value="ddlli_Major_emergencySystem" />
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-xs-6 col-sm-4">

                                        </div>
                                        <div class="col-xs-6 col-sm-4"><asp:TextBox class="form-control" id="txt_comments_emergencySystem" placeholder="Additional Comments..." runat="server"></asp:TextBox></div>
                                    </div>
                                </li>
                                <li class="list-group-item"><p><strong>Brake Lines or Hoses</strong></p>
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-1"><asp:CheckBox id="cb_fail_brakeLines" Text="&nbsp;Fail" runat="server" /></div>
                                        <div class="col-xs-6 col-sm-3">
                                            <asp:DropDownList class="form-control" ID="ddl_brakeLines" Width="200px" runat="server">
                                                <asp:ListItem Text="Select Major or Minor..." Value="ddlli_prompt_majmin_brakeLines" Selected="True" />
                                                <asp:ListItem Text="Minor" Value="ddlli_Minor_brakeLines" />
                                                <asp:ListItem Text="Major" Value="ddlli_Major_brakeLines" />
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-xs-6 col-sm-4">
                                            <label class="checkbox-inline"><input type="checkbox" value="">Front</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Rear</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Right</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Left</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Inner Cord Damage or Defects</label>
                                        </div>
                                        <div class="col-xs-6 col-sm-4"><asp:TextBox class="form-control" id="txt_comments_brakeLines" placeholder="Additional Comments..." runat="server"></asp:TextBox></div>
                                    </div>
                                </li>
                                <li class="list-group-item"><p><strong>Brake Drums</strong></p>
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-1"><asp:CheckBox id="cb_fail_brakeDrums" Text="&nbsp;Fail" runat="server" /></div>
                                        <div class="col-xs-6 col-sm-3">
                                            <asp:DropDownList class="form-control" ID="ddl_brakeDrums" Width="200px" runat="server">
                                                <asp:ListItem Text="Select Major or Minor..." Value="ddlli_prompt_majmin_brakeDrums" Selected="True" />
                                                <asp:ListItem Text="Minor" Value="ddlli_Minor_brakeDrums" />
                                                <asp:ListItem Text="Major" Value="ddlli_Major_brakeDrums" />
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-xs-6 col-sm-4">
                                            <label class="checkbox-inline"><input type="checkbox" value="">Front</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Rear</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Right</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Left</label>
                                        </div>
                                        <div class="col-xs-6 col-sm-4"><asp:TextBox class="form-control" id="txt_comments_brakeDrums" placeholder="Additional Comments..." runat="server"></asp:TextBox></div>
                                    </div>
                                </li>
                                <li class="list-group-item"><p><strong>Master Cylinder</strong></p>
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-1"><asp:CheckBox id="cb_fail_masterCylinder" Text="&nbsp;Fail" runat="server" /></div>
                                        <div class="col-xs-6 col-sm-3">
                                            <asp:DropDownList class="form-control" ID="ddl_masterCylinder" Width="200px" runat="server">
                                                <asp:ListItem Text="Select Major or Minor..." Value="ddlli_prompt_majmin_masterCylinder" Selected="True" />
                                                <asp:ListItem Text="Minor" Value="ddlli_Minor_masterCylinder" />
                                                <asp:ListItem Text="Major" Value="ddlli_Major_masterCylinder" />
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-xs-6 col-sm-4">
                                            <label class="checkbox-inline"><input type="checkbox" value="">Leak</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Break</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Hose</label>
                                        </div>
                                        <div class="col-xs-6 col-sm-4"><asp:TextBox class="form-control" id="txt_comments_masterCylinder" placeholder="Additional Comments..." runat="server"></asp:TextBox></div>
                                    </div>
                                </li>
                                <li class="list-group-item"><p><strong>Wheel Cylinder</strong></p>
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-1"><asp:CheckBox id="cb_fail_wheelCylinder" Text="&nbsp;Fail" runat="server" /></div>
                                        <div class="col-xs-6 col-sm-3">
                                            <asp:DropDownList class="form-control" ID="ddl_wheelCylinder" Width="200px" runat="server">
                                                <asp:ListItem Text="Select Major or Minor..." Value="ddlli_prompt_majmin_wheelCylinder" Selected="True" />
                                                <asp:ListItem Text="Minor" Value="ddlli_Minor_wheelCylinder" />
                                                <asp:ListItem Text="Major" Value="ddlli_Major_wheelCylinder" />
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-xs-6 col-sm-4">
                                            <label class="checkbox-inline"><input type="checkbox" value="">Leak</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Front</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Rear</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Right</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Left</label>
                                        </div>
                                        <div class="col-xs-6 col-sm-4"><asp:TextBox class="form-control" id="txt_comments_wheelCylinder" placeholder="Additional Comments..." runat="server"></asp:TextBox></div>
                                    </div>
                                </li>
                                <li class="list-group-item"><p><strong>Wheel Bearing</strong></p>
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-1"><asp:CheckBox id="cb_fail_wheelBearing" Text="&nbsp;Fail" runat="server" /></div>
                                        <div class="col-xs-6 col-sm-3">
                                            <asp:DropDownList class="form-control" ID="ddl_wheelBearing" Width="200px" runat="server">
                                                <asp:ListItem Text="Select Major or Minor..." Value="ddlli_prompt_majmin_wheelBearing" Selected="True" />
                                                <asp:ListItem Text="Minor" Value="ddlli_Minor_wheelBearing" />
                                                <asp:ListItem Text="Major" Value="ddlli_Major_wheelBearing" />
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-xs-6 col-sm-4">
                                            <label class="checkbox-inline"><input type="checkbox" value="">Right</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Left</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Adjust</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Replace</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">+1/8"</label>
                                        </div>
                                        <div class="col-xs-6 col-sm-4"><asp:TextBox class="form-control" id="txt_comments_wheelBearing" placeholder="Additional Comments..." runat="server"></asp:TextBox></div>
                                    </div>
                                </li>
                                <li class="list-group-item"><p><strong>Wheel Lug Nuts</strong></p>
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-1"><asp:CheckBox id="cb_fail_wheelLugNuts" Text="&nbsp;Fail" runat="server" /></div>
                                        <div class="col-xs-6 col-sm-3">
                                            <asp:DropDownList class="form-control" ID="ddl_wheelLugNuts" Width="200px" runat="server">
                                                <asp:ListItem Text="Select Major or Minor..." Value="ddlli_prompt_majmin_wheelLugNuts" Selected="True" />
                                                <asp:ListItem Text="Minor" Value="ddlli_Minor_wheelLugNuts" />
                                                <asp:ListItem Text="Major" Value="ddlli_Major_wheelLugNuts" />
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-xs-6 col-sm-4">
                                            <label class="checkbox-inline"><input type="checkbox" value="">Loose</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Missing</label>
                                        </div>
                                        <div class="col-xs-6 col-sm-4"><asp:TextBox class="form-control" id="txt_comments_wheelLugNuts" placeholder="Additional Comments..." runat="server"></asp:TextBox></div>
                                    </div>
                                </li>
                                <li class="list-group-item"><p><strong>Tires</strong></p>
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-1"><asp:CheckBox id="cb_fail_tires" Text="&nbsp;Fail" runat="server" /></div>
                                        <div class="col-xs-6 col-sm-3">
                                            <asp:DropDownList class="form-control" ID="ddl_tires" Width="200px" runat="server">
                                                <asp:ListItem Text="Select Major or Minor..." Value="ddlli_prompt_majmin_tires" Selected="True" />
                                                <asp:ListItem Text="Minor" Value="ddlli_Minor_tires" />
                                                <asp:ListItem Text="Major" Value="ddlli_Major_tires" />
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-xs-6 col-sm-4">
                                            <label class="checkbox-inline"><input type="checkbox" value="">Front</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Rear</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Right</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Left</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">R.R.O</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">R.R.I</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">L.R.O</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">L.R.I</label>
                                        </div>
                                        <div class="col-xs-6 col-sm-4"><asp:TextBox class="form-control" id="txt_comments_tires" placeholder="Additional Comments..." runat="server"></asp:TextBox></div>
                                    </div>
                                </li>
                                <li class="list-group-item"><p><strong>Disc</strong></p>
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-1"><asp:CheckBox id="cb_fail_disc" Text="&nbsp;Fail" runat="server" /></div>
                                        <div class="col-xs-6 col-sm-3">
                                            <asp:DropDownList class="form-control" ID="ddl_disc" Width="200px" runat="server">
                                                <asp:ListItem Text="Select Major or Minor..." Value="ddlli_prompt_majmin_disc" Selected="True" />
                                                <asp:ListItem Text="Minor" Value="ddlli_Minor_disc" />
                                                <asp:ListItem Text="Major" Value="ddlli_Major_disc" />
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-xs-6 col-sm-4">
                                            <label class="checkbox-inline"><input type="checkbox" value="">Pads</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Rotors</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Calipers</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">-2/32"</label>
                                        </div>
                                        <div class="col-xs-6 col-sm-4"><asp:TextBox class="form-control" id="txt_comments_disc" placeholder="Additional Comments..." runat="server"></asp:TextBox></div>
                                    </div>
                                </li>
                                <li class="list-group-item"><p><strong>ABS Systems</strong></p>
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-1"><asp:CheckBox id="cb_fail_absSystem" Text="&nbsp;Fail" runat="server" /></div>
                                        <div class="col-xs-6 col-sm-3">
                                            <asp:DropDownList class="form-control" ID="ddl_absSystem" Width="200px" runat="server">
                                                <asp:ListItem Text="Select Major or Minor..." Value="ddlli_prompt_majmin_absSystem" Selected="True" />
                                                <asp:ListItem Text="Minor" Value="ddlli_Minor_absSystem" />
                                                <asp:ListItem Text="Major" Value="ddlli_Major_absSystem" />
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-xs-6 col-sm-4">

                                        </div>
                                        <div class="col-xs-6 col-sm-4"><asp:TextBox class="form-control" id="txt_comments_absSystem" placeholder="Additional Comments..." runat="server"></asp:TextBox></div>
                                    </div>
                                </li>
                                <li class="list-group-item"><p><strong>Valve Stem</strong></p>
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-1"><asp:CheckBox id="cb_fail_valveStem" Text="&nbsp;Fail" runat="server" /></div>
                                        <div class="col-xs-6 col-sm-3">
                                            <asp:DropDownList class="form-control" ID="ddl_valveStem" Width="200px" runat="server">
                                                <asp:ListItem Text="Select Major or Minor..." Value="ddlli_prompt_majmin_valveStem" Selected="True" />
                                                <asp:ListItem Text="Minor" Value="ddlli_Minor_valveStem" />
                                                <asp:ListItem Text="Major" Value="ddlli_Major_valveStem" />
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-xs-6 col-sm-4">
                                            <label class="checkbox-inline"><input type="checkbox" value="">Misaligned</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Replace</label>
                                        </div>
                                        <div class="col-xs-6 col-sm-4"><asp:TextBox class="form-control" id="txt_comments_valveStem" placeholder="Additional Comments..." runat="server"></asp:TextBox></div>
                                    </div>
                                </li>
                            </ul>
                            <div class="panel-footer">Footer</div>
                        </div>
                    </div>
                </div>
            </div> <%--End Group II Panel--%>
            <%--Begin Group III Panel--%>
            <div class="container">
                <div class="panel-group">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" href="#collapse3"><strong>Group III - Engine & Exhaust</strong> <span class="badge" style="float: right">5</span></a>
                            </h4>
                        </div>
                        <div id="collapse3" class="panel-collapse collapse">
                            <ul class="list-group">
                                <li class="list-group-item"><p><strong>Air Cleaner</strong></p>
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-1"><asp:CheckBox id="cb_fail_airCleaner" Text="&nbsp;Fail" runat="server" /></div>
                                        <div class="col-xs-6 col-sm-3">
                                            <asp:DropDownList class="form-control" ID="ddl_airCleaner" Width="200px" runat="server">
                                                <asp:ListItem Text="Select Major or Minor..." Value="ddlli_prompt_majmin_airCleaner" Selected="True" />
                                                <asp:ListItem Text="Minor" Value="ddlli_Minor_airCleaner" />
                                                <asp:ListItem Text="Major" Value="ddlli_Major_airCleaner" />
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-xs-6 col-sm-4">
                                            <label class="checkbox-inline"><input type="checkbox" value="">Tighten</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Clean</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Repair</label>
                                        </div>
                                        <div class="col-xs-6 col-sm-4"><asp:TextBox class="form-control" id="txt_comments_airCleaner" placeholder="Additional Comments..." runat="server"></asp:TextBox></div>
                                    </div>
                                </li>
                                <li class="list-group-item"><p><strong>Alternator/Generator</strong></p>
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-1"><asp:CheckBox id="cb_fail_alternator" Text="&nbsp;Fail" runat="server" /></div>
                                        <div class="col-xs-6 col-sm-3">
                                            <asp:DropDownList class="form-control" ID="ddl_alternator" Width="200px" runat="server">
                                                <asp:ListItem Text="Select Major or Minor..." Value="ddlli_prompt_majmin_alternator" Selected="True" />
                                                <asp:ListItem Text="Minor" Value="ddlli_Minor_alternator" />
                                                <asp:ListItem Text="Major" Value="ddlli_Major_alternator" />
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-xs-6 col-sm-4">
                                            <label class="checkbox-inline"><input type="checkbox" value="">Replace</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Tighten</label>
                                                  </div>
                                        <div class="col-xs-6 col-sm-4"><asp:TextBox class="form-control" id="txt_comments_alternator" placeholder="Additional Comments..." runat="server"></asp:TextBox></div>
                                    </div>
                                </li>
                                <li class="list-group-item"><p><strong>Battery Cable Hold-Down</strong></p>
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-1"><asp:CheckBox id="cb_fail_battery" Text="&nbsp;Fail" runat="server" /></div>
                                        <div class="col-xs-6 col-sm-3">
                                            <asp:DropDownList class="form-control" ID="ddl_battery" Width="200px" runat="server">
                                                <asp:ListItem Text="Select Major or Minor..." Value="ddlli_prompt_majmin_battery" Selected="True" />
                                                <asp:ListItem Text="Minor" Value="ddlli_Minor_battery" />
                                                <asp:ListItem Text="Major" Value="ddlli_Major_battery" />
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-xs-6 col-sm-4">
                                            <label class="checkbox-inline"><input type="checkbox" value="">Tighten</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Clean</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Repalce</label>
                                        </div>
                                        <div class="col-xs-6 col-sm-4"><asp:TextBox class="form-control" id="txt_comments_battery" placeholder="Additional Comments..." runat="server"></asp:TextBox></div>
                                    </div>
                                </li>
                                <li class="list-group-item"><p><strong>Drive Belts, Power Steering</strong></p>
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-1"><asp:CheckBox id="cb_fail_driveBelts" Text="&nbsp;Fail" runat="server" /></div>
                                        <div class="col-xs-6 col-sm-3">
                                            <asp:DropDownList class="form-control" ID="ddl_driveBelts" Width="200px" runat="server">
                                                <asp:ListItem Text="Select Major or Minor..." Value="ddlli_prompt_majmin_driveBelts" Selected="True" />
                                                <asp:ListItem Text="Minor" Value="ddlli_Minor_driveBelts" />
                                                <asp:ListItem Text="Major" Value="ddlli_Major_driveBelts" />
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-xs-6 col-sm-4">
                                            <label class="checkbox-inline"><input type="checkbox" value="">Adjust</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Replace</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">All</label>
                                        </div>
                                        <div class="col-xs-6 col-sm-4"><asp:TextBox class="form-control" id="txt_comments_driveBelts" placeholder="Additional Comments..." runat="server"></asp:TextBox></div>
                                    </div>
                                </li>
                                <li class="list-group-item"><p><strong>Fuel Leaks</strong></p>
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-1"><asp:CheckBox id="cb_fail_fuelLeaks" Text="&nbsp;Fail" runat="server" /></div>
                                        <div class="col-xs-6 col-sm-3">
                                            <asp:DropDownList class="form-control" ID="ddl_fuelLeaks" Width="200px" runat="server">
                                                <asp:ListItem Text="Select Major or Minor..." Value="ddlli_prompt_majmin_fuelLeaks" Selected="True" />
                                                <asp:ListItem Text="Minor" Value="ddlli_Minor_fuelLeaks" />
                                                <asp:ListItem Text="Major" Value="ddlli_Major_fuelLeaks" />
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-xs-6 col-sm-4">
                                            <label class="checkbox-inline"><input type="checkbox" value="">Carburetor</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Fuel Pump</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Tank</label>
                                        </div>
                                        <div class="col-xs-6 col-sm-4"><asp:TextBox class="form-control" id="txt_comments_fuelLeaks" placeholder="Additional Comments..." runat="server"></asp:TextBox></div>
                                    </div>
                                </li>
                                <li class="list-group-item"><p><strong>Gaskets and Seals</strong></p>
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-1"><asp:CheckBox id="cb_fail_gaskets" Text="&nbsp;Fail" runat="server" /></div>
                                        <div class="col-xs-6 col-sm-3">
                                            <asp:DropDownList class="form-control" ID="ddl_gaskets" Width="200px" runat="server">
                                                <asp:ListItem Text="Select Major or Minor..." Value="ddlli_prompt_majmin_gaskets" Selected="True" />
                                                <asp:ListItem Text="Minor" Value="ddlli_Minor_gaskets" />
                                                <asp:ListItem Text="Major" Value="ddlli_Major_gaskets" />
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-xs-6 col-sm-4">

                                        </div>
                                        <div class="col-xs-6 col-sm-4"><asp:TextBox class="form-control" id="txt_comments_gaskets" placeholder="Additional Comments..." runat="server"></asp:TextBox></div>
                                    </div>
                                </li>
                                <li class="list-group-item"><p><strong>Radiator Heater Hose</strong></p>
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-1"><asp:CheckBox id="cb_fail_radiatorHose" Text="&nbsp;Fail" runat="server" /></div>
                                        <div class="col-xs-6 col-sm-3">
                                            <asp:DropDownList class="form-control" ID="ddl_radiatorHose" Width="200px" runat="server">
                                                <asp:ListItem Text="Select Major or Minor..." Value="ddlli_prompt_majmin_radiatorHose" Selected="True" />
                                                <asp:ListItem Text="Minor" Value="ddlli_Minor_radiatorHose" />
                                                <asp:ListItem Text="Major" Value="ddlli_Major_radiatorHose" />
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-xs-6 col-sm-4">
                                            <label class="checkbox-inline"><input type="checkbox" value="">Top</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Bottom</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Tighten</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Replace</label>
                                        </div>
                                        <div class="col-xs-6 col-sm-4"><asp:TextBox class="form-control" id="txt_comments_radiatorHose" placeholder="Additional Comments..." runat="server"></asp:TextBox></div>
                                    </div>
                                </li>
                                <li class="list-group-item"><p><strong>Lines and Wiring</strong></p>
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-1"><asp:CheckBox id="cb_fail_linesWiring" Text="&nbsp;Fail" runat="server" /></div>
                                        <div class="col-xs-6 col-sm-3">
                                            <asp:DropDownList class="form-control" ID="ddl_linesWiring" Width="200px" runat="server">
                                                <asp:ListItem Text="Select Major or Minor..." Value="ddlli_prompt_majmin_linesWiring" Selected="True" />
                                                <asp:ListItem Text="Minor" Value="ddlli_Minor_linesWiring" />
                                                <asp:ListItem Text="Major" Value="ddlli_Major_linesWiring" />
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-xs-6 col-sm-4">

                                        </div>
                                        <div class="col-xs-6 col-sm-4"><asp:TextBox class="form-control" id="txt_comments_linesWiring" placeholder="Additional Comments..." runat="server"></asp:TextBox></div>
                                    </div>
                                </li>
                                <li class="list-group-item"><p><strong>Engine Operation</strong></p>
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-1"><asp:CheckBox id="cb_fail_engineOperation" Text="&nbsp;Fail" runat="server" /></div>
                                        <div class="col-xs-6 col-sm-3">
                                            <asp:DropDownList class="form-control" ID="ddl_engineOperation" Width="200px" runat="server">
                                                <asp:ListItem Text="Select Major or Minor..." Value="ddlli_prompt_majmin_engineOperation" Selected="True" />
                                                <asp:ListItem Text="Minor" Value="ddlli_Minor_engineOperation" />
                                                <asp:ListItem Text="Major" Value="ddlli_Major_engineOperation" />
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-xs-6 col-sm-4">
               
                                        </div>
                                        <div class="col-xs-6 col-sm-4"><asp:TextBox class="form-control" id="txt_comments_engineOperation" placeholder="Additional Comments..." runat="server"></asp:TextBox></div>
                                    </div>
                                </li>
                                <li class="list-group-item"><p><strong>Clutch</strong></p>
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-1"><asp:CheckBox id="cb_fail_clutch" Text="&nbsp;Fail" runat="server" /></div>
                                        <div class="col-xs-6 col-sm-3">
                                            <asp:DropDownList class="form-control" ID="ddl_clutch" Width="200px" runat="server">
                                                <asp:ListItem Text="Select Major or Minor..." Value="ddlli_prompt_majmin_clutch" Selected="True" />
                                                <asp:ListItem Text="Minor" Value="ddlli_Minor_clutch" />
                                                <asp:ListItem Text="Major" Value="ddlli_Major_clutch" />
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-xs-6 col-sm-4">
                                            <label class="checkbox-inline"><input type="checkbox" value="">Adjust</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Slipping</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Replace</label>
                                           </div>
                                        <div class="col-xs-6 col-sm-4"><asp:TextBox class="form-control" id="txt_comments_clutch" placeholder="Additional Comments..." runat="server"></asp:TextBox></div>
                                    </div>
                                </li>
                                <li class="list-group-item"><p><strong>Engine Clean</strong></p>
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-1"><asp:CheckBox id="cb_fail_engineClean" Text="&nbsp;Fail" runat="server" /></div>
                                        <div class="col-xs-6 col-sm-3">
                                            <asp:DropDownList class="form-control" ID="ddl_engineClean" Width="200px" runat="server">
                                                <asp:ListItem Text="Select Major or Minor..." Value="ddlli_prompt_majmin_engineClean" Selected="True" />
                                                <asp:ListItem Text="Minor" Value="ddlli_Minor_engineClean" />
                                                <asp:ListItem Text="Major" Value="ddlli_Major_engineClean" />
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-xs-6 col-sm-4">
                                            <label class="checkbox-inline"><input type="checkbox" value="">Oil Leak</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Valve Cover</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Right</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Left</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Filter</label>
                                        </div>
                                        <div class="col-xs-6 col-sm-4"><asp:TextBox class="form-control" id="txt_comments_engineClean" placeholder="Additional Comments..." runat="server"></asp:TextBox></div>
                                    </div>
                                </li>
                                <li class="list-group-item"><p><strong>Manifold Leak</strong></p>
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-1"><asp:CheckBox id="cb_fail_manifoldLeak" Text="&nbsp;Fail" runat="server" /></div>
                                        <div class="col-xs-6 col-sm-3">
                                            <asp:DropDownList class="form-control" ID="ddl_manifoldLeak" Width="200px" runat="server">
                                                <asp:ListItem Text="Select Major or Minor..." Value="ddlli_prompt_majmin_manifoldLeak" Selected="True" />
                                                <asp:ListItem Text="Minor" Value="ddlli_Minor_manifoldLeak" />
                                                <asp:ListItem Text="Major" Value="ddlli_Major_manifoldLeak" />
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-xs-6 col-sm-4">
                                            <label class="checkbox-inline"><input type="checkbox" value="">Tighten</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Replace</label>
                                               </div>
                                        <div class="col-xs-6 col-sm-4"><asp:TextBox class="form-control" id="txt_comments_manifoldLeak" placeholder="Additional Comments..." runat="server"></asp:TextBox></div>
                                    </div>
                                </li>
                                <li class="list-group-item"><p><strong>Exhaust and Tail Pipes</strong></p>
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-1"><asp:CheckBox id="cb_fail_exhaust" Text="&nbsp;Fail" runat="server" /></div>
                                        <div class="col-xs-6 col-sm-3">
                                            <asp:DropDownList class="form-control" ID="ddl_exhaust" Width="200px" runat="server">
                                                <asp:ListItem Text="Select Major or Minor..." Value="ddlli_prompt_majmin_exhaust" Selected="True" />
                                                <asp:ListItem Text="Minor" Value="ddlli_Minor_exhaust" />
                                                <asp:ListItem Text="Major" Value="ddlli_Major_exhaust" />
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-xs-6 col-sm-4">
                                            <label class="checkbox-inline"><input type="checkbox" value="">Leak</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Length</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Tighten</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Replace</label>
                                        </div>
                                        <div class="col-xs-6 col-sm-4"><asp:TextBox class="form-control" id="txt_comments_exhaust" placeholder="Additional Comments..." runat="server"></asp:TextBox></div>
                                    </div>
                                </li>
                                <li class="list-group-item"><p><strong>Muffler</strong></p>
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-1"><asp:CheckBox id="cb_fail_muffler" Text="&nbsp;Fail" runat="server" /></div>
                                        <div class="col-xs-6 col-sm-3">
                                            <asp:DropDownList class="form-control" ID="ddl_muffler" Width="200px" runat="server">
                                                <asp:ListItem Text="Select Major or Minor..." Value="ddlli_prompt_majmin_muffler" Selected="True" />
                                                <asp:ListItem Text="Minor" Value="ddlli_Minor_muffler" />
                                                <asp:ListItem Text="Major" Value="ddlli_Major_muffler" />
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-xs-6 col-sm-4">
                                            <label class="checkbox-inline"><input type="checkbox" value="">Tighten</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Replace</label>
                                        </div>
                                        <div class="col-xs-6 col-sm-4"><asp:TextBox class="form-control" id="txt_comments_muffler" placeholder="Additional Comments..." runat="server"></asp:TextBox></div>
                                    </div>
                                </li>
                                <li class="list-group-item"><p><strong>P.C.V. Valve</strong></p>
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-1"><asp:CheckBox id="cb_fail_pcvValve" Text="&nbsp;Fail" runat="server" /></div>
                                        <div class="col-xs-6 col-sm-3">
                                            <asp:DropDownList class="form-control" ID="ddl_pcvValve" Width="200px" runat="server">
                                                <asp:ListItem Text="Select Major or Minor..." Value="ddlli_prompt_majmin_pcvValve" Selected="True" />
                                                <asp:ListItem Text="Minor" Value="ddlli_Minor_pcvValve" />
                                                <asp:ListItem Text="Major" Value="ddlli_Major_pcvValve" />
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-xs-6 col-sm-4">

                                        </div>
                                        <div class="col-xs-6 col-sm-4"><asp:TextBox class="form-control" id="txt_comments_pcvValve" placeholder="Additional Comments..." runat="server"></asp:TextBox></div>
                                    </div>
                                </li>
                            </ul>
                            <div class="panel-footer">Footer</div>
                        </div>
                    </div>
                </div>
            </div> <%--End Group III Panel--%>
            <%--Begin Group IV Panel--%>
            <div class="container">
                <div class="panel-group">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" href="#collapse4"><strong>Group IV - Lighting & Glazing</strong> <span class="badge" style="float: right">5</span></a>
                            </h4>
                        </div>
                        <div id="collapse4" class="panel-collapse collapse">
                            <ul class="list-group">
                                <li class="list-group-item"><p><strong>Head</strong></p>
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-1"><asp:CheckBox id="cb_fail_head" Text="&nbsp;Fail" runat="server" /></div>
                                        <div class="col-xs-6 col-sm-3">
                                            <asp:DropDownList class="form-control" ID="ddl_head" Width="200px" runat="server">
                                                <asp:ListItem Text="Select Major or Minor..." Value="ddlli_prompt_majmin_head" Selected="True" />
                                                <asp:ListItem Text="Minor" Value="ddlli_Minor_head" />
                                                <asp:ListItem Text="Major" Value="ddlli_Major_head" />
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-xs-6 col-sm-4">
                                            <label class="checkbox-inline"><input type="checkbox" value="">Right</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Left</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Tighten</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Replace</label>
                                        </div>
                                        <div class="col-xs-6 col-sm-4"><asp:TextBox class="form-control" id="txt_comments_head" placeholder="Additional Comments..." runat="server"></asp:TextBox></div>
                                    </div>
                                </li>
                                <li class="list-group-item"><p><strong>Stop and Tail</strong></p>
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-1"><asp:CheckBox id="cb_fail_stopTail" Text="&nbsp;Fail" runat="server" /></div>
                                        <div class="col-xs-6 col-sm-3">
                                            <asp:DropDownList class="form-control" ID="ddl_stopTail" Width="200px" runat="server">
                                                <asp:ListItem Text="Select Major or Minor..." Value="ddlli_prompt_majmin_stopTail" Selected="True" />
                                                <asp:ListItem Text="Minor" Value="ddlli_Minor_stopTail" />
                                                <asp:ListItem Text="Major" Value="ddlli_Major_stopTail" />
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-xs-6 col-sm-4">
                                            <label class="checkbox-inline"><input type="checkbox" value="">Right</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Left</label>
                                        </div>
                                        <div class="col-xs-6 col-sm-4"><asp:TextBox class="form-control" id="txt_comments_stopTail" placeholder="Additional Comments..." runat="server"></asp:TextBox></div>
                                    </div>
                                </li>
                                <li class="list-group-item"><p><strong>Warning Flasher</strong></p>
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-1"><asp:CheckBox id="cb_fail_warningFlasher" Text="&nbsp;Fail" runat="server" /></div>
                                        <div class="col-xs-6 col-sm-3">
                                            <asp:DropDownList class="form-control" ID="ddl_warningFlasher" Width="200px" runat="server">
                                                <asp:ListItem Text="Select Major or Minor..." Value="ddlli_prompt_majmin_warningFlasher" Selected="True" />
                                                <asp:ListItem Text="Minor" Value="ddlli_Minor_warningFlasher" />
                                                <asp:ListItem Text="Major" Value="ddlli_Major_warningFlasher" />
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-xs-6 col-sm-4">
                                            <label class="checkbox-inline"><input type="checkbox" value="">Front</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Rear</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Right</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Left</label>
                                        </div>
                                        <div class="col-xs-6 col-sm-4"><asp:TextBox class="form-control" id="txt_comments_warningFlasher" placeholder="Additional Comments..." runat="server"></asp:TextBox></div>
                                    </div>
                                </li>
                                <li class="list-group-item"><p><strong>Clearance Cluster</strong></p>
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-1"><asp:CheckBox id="cb_fail_clearance" Text="&nbsp;Fail" runat="server" /></div>
                                        <div class="col-xs-6 col-sm-3">
                                            <asp:DropDownList class="form-control" ID="ddl_clearance" Width="200px" runat="server">
                                                <asp:ListItem Text="Select Major or Minor..." Value="ddlli_prompt_majmin_clearance" Selected="True" />
                                                <asp:ListItem Text="Minor" Value="ddlli_Minor_clearance" />
                                                <asp:ListItem Text="Major" Value="ddlli_Major_clearance" />
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-xs-6 col-sm-4">
                                            <label class="checkbox-inline"><input type="checkbox" value="">Front</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Rear</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Right</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Left</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Center</label>
                                        </div>
                                        <div class="col-xs-6 col-sm-4"><asp:TextBox class="form-control" id="txt_comments_clearance" placeholder="Additional Comments..." runat="server"></asp:TextBox></div>
                                    </div>
                                </li>
                                <li class="list-group-item"><p><strong>Turn Signal/Hazard</strong></p>
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-1"><asp:CheckBox id="cb_fail_turnSignal" Text="&nbsp;Fail" runat="server" /></div>
                                        <div class="col-xs-6 col-sm-3">
                                            <asp:DropDownList class="form-control" ID="ddl_turnSignal" Width="200px" runat="server">
                                                <asp:ListItem Text="Select Major or Minor..." Value="ddlli_prompt_majmin_turnSignal" Selected="True" />
                                                <asp:ListItem Text="Minor" Value="ddlli_Minor_turnSignal" />
                                                <asp:ListItem Text="Major" Value="ddlli_Major_turnSignal" />
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-xs-6 col-sm-4">
                                            <label class="checkbox-inline"><input type="checkbox" value="">Front</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Rear</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Right</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Left</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Body Side</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Indicator</label>
                                        </div>
                                        <div class="col-xs-6 col-sm-4"><asp:TextBox class="form-control" id="txt_comment_turnSignal" placeholder="Additional Comments..." runat="server"></asp:TextBox></div>
                                    </div>
                                </li>
                                <li class="list-group-item"><p><strong>Interior</strong></p>
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-1"><asp:CheckBox id="cb_fail_interior" Text="&nbsp;Fail" runat="server" /></div>
                                        <div class="col-xs-6 col-sm-3">
                                            <asp:DropDownList class="form-control" ID="ddl_interior" Width="200px" runat="server">
                                                <asp:ListItem Text="Select Major or Minor..." Value="ddlli_prompt_majmin_interior" Selected="True" />
                                                <asp:ListItem Text="Minor" Value="ddlli_Minor_interior" />
                                                <asp:ListItem Text="Major" Value="ddlli_Major_interior" />
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-xs-6 col-sm-4">
                                            <label class="checkbox-inline"><input type="checkbox" value="">Step Well</label>
                                        </div>
                                        <div class="col-xs-6 col-sm-4"><asp:TextBox class="form-control" id="txt_comments_interior" placeholder="Additional Comments..." runat="server"></asp:TextBox></div>
                                    </div>
                                </li>
                                <li class="list-group-item"><p><strong>Back Up</strong></p>
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-1"><asp:CheckBox id="cb_fail_backUp" Text="&nbsp;Fail" runat="server" /></div>
                                        <div class="col-xs-6 col-sm-3">
                                            <asp:DropDownList class="form-control" ID="ddl_backUp" Width="200px" runat="server">
                                                <asp:ListItem Text="Select Major or Minor..." Value="ddlli_prompt_majmin_backUp" Selected="True" />
                                                <asp:ListItem Text="Minor" Value="ddlli_Minor_backUp" />
                                                <asp:ListItem Text="Major" Value="ddlli_Major_backUp" />
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-xs-6 col-sm-4">
                                            <label class="checkbox-inline"><input type="checkbox" value="">Right</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Left</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Alarm</label>
                                        </div>
                                        <div class="col-xs-6 col-sm-4"><asp:TextBox class="form-control" id="txt_comments_backUp" placeholder="Additional Comments..." runat="server"></asp:TextBox></div>
                                    </div>
                                </li>
                                <li class="list-group-item"><p><strong>License Plate</strong></p>
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-1"><asp:CheckBox id="cb_fail_licensePlate" Text="&nbsp;Fail" runat="server" /></div>
                                        <div class="col-xs-6 col-sm-3">
                                            <asp:DropDownList class="form-control" ID="ddl_licensePlate" Width="200px" runat="server">
                                                <asp:ListItem Text="Select Major or Minor..." Value="ddlli_prompt_majmin_licensePlate" Selected="True" />
                                                <asp:ListItem Text="Minor" Value="ddlli_Minor_licensePlate" />
                                                <asp:ListItem Text="Major" Value="ddlli_Major_licensePlate" />
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-xs-6 col-sm-4">
        
                                        </div>
                                        <div class="col-xs-6 col-sm-4"><asp:TextBox class="form-control" id="txt_comments_licensePlate" placeholder="Additional Comments..." runat="server"></asp:TextBox></div>
                                    </div>
                                </li>
                                <li class="list-group-item"><p><strong>Instrumental Panel</strong></p>
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-1"><asp:CheckBox id="cb_fail_instrumental" Text="&nbsp;Fail" runat="server" /></div>
                                        <div class="col-xs-6 col-sm-3">
                                            <asp:DropDownList class="form-control" ID="ddl_instrumental" Width="200px" runat="server">
                                                <asp:ListItem Text="Select Major or Minor..." Value="ddlli_prompt_majmin_instrumental" Selected="True" />
                                                <asp:ListItem Text="Minor" Value="ddlli_Minor_instrumental" />
                                                <asp:ListItem Text="Major" Value="ddlli_Major_instrumental" />
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-xs-6 col-sm-4">
                                            <label class="checkbox-inline"><input type="checkbox" value="">Wiring</label>
                                        </div>
                                        <div class="col-xs-6 col-sm-4"><asp:TextBox class="form-control" id="txt_comments_instrumental" placeholder="Additional Comments..." runat="server"></asp:TextBox></div>
                                    </div>
                                </li>
                                <li class="list-group-item"><p><strong>Glass</strong></p>
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-1"><asp:CheckBox id="cb_fail_glass" Text="&nbsp;Fail" runat="server" /></div>
                                        <div class="col-xs-6 col-sm-3">
                                            <asp:DropDownList class="form-control" ID="ddl_glass" Width="200px" runat="server">
                                                <asp:ListItem Text="Select Major or Minor..." Value="ddlli_prompt_majmin_glass" Selected="True" />
                                                <asp:ListItem Text="Minor" Value="ddlli_Minor_glass" />
                                                <asp:ListItem Text="Major" Value="ddlli_Major_glass" />
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-xs-6 col-sm-4">
                                            <label class="checkbox-inline"><input type="checkbox" value="">Window</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Doors</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Windshield</label>
                                        </div>
                                        <div class="col-xs-6 col-sm-4"><asp:TextBox class="form-control" id="txt_comments_glass" placeholder="Additional Comments..." runat="server"></asp:TextBox></div>
                                    </div>
                                </li>
                                <li class="list-group-item"><p><strong>Windshield Wipers</strong></p>
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-1"><asp:CheckBox id="cb_fail_windshieldWipers" Text="&nbsp;Fail" runat="server" /></div>
                                        <div class="col-xs-6 col-sm-3">
                                            <asp:DropDownList class="form-control" ID="ddl_windshieldWipers" Width="200px" runat="server">
                                                <asp:ListItem Text="Select Major or Minor..." Value="ddlli_prompt_majmin_windshieldWipers" Selected="True" />
                                                <asp:ListItem Text="Minor" Value="ddlli_Minor_windshieldWipers" />
                                                <asp:ListItem Text="Major" Value="ddlli_Major_windshieldWipers" />
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-xs-6 col-sm-4">
                                            <label class="checkbox-inline"><input type="checkbox" value="">Blades</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Washers</label>
                                        </div>
                                        <div class="col-xs-6 col-sm-4"><asp:TextBox class="form-control" id="txt_comments_windshieldWipers" placeholder="Additional Comments..." runat="server"></asp:TextBox></div>
                                    </div>
                                </li>
                                <li class="list-group-item"><p><strong>Odometer</strong></p>
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-1"><asp:CheckBox id="cb_fail_odometer" Text="&nbsp;Fail" runat="server" /></div>
                                        <div class="col-xs-6 col-sm-3">
                                            <asp:DropDownList class="form-control" ID="ddl_odometer" Width="200px" runat="server">
                                                <asp:ListItem Text="Select Major or Minor..." Value="ddlli_prompt_majmin_odometer" Selected="True" />
                                                <asp:ListItem Text="Minor" Value="ddlli_Minor_odometer" />
                                                <asp:ListItem Text="Major" Value="ddlli_Major_odometer" />
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-xs-6 col-sm-4">
             
                                        </div>
                                        <div class="col-xs-6 col-sm-4"><asp:TextBox class="form-control" id="txt_comments_odometer" placeholder="Additional Comments..." runat="server"></asp:TextBox></div>
                                    </div>
                                </li>
                                <li class="list-group-item"><p><strong>Video Camera Light</strong></p>
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-1"><asp:CheckBox id="cb_fail_video" Text="&nbsp;Fail" runat="server" /></div>
                                        <div class="col-xs-6 col-sm-3">
                                            <asp:DropDownList class="form-control" ID="ddl_video" Width="200px" runat="server">
                                                <asp:ListItem Text="Select Major or Minor..." Value="ddlli_prompt_majmin_video" Selected="True" />
                                                <asp:ListItem Text="Minor" Value="ddlli_Minor_video" />
                                                <asp:ListItem Text="Major" Value="ddlli_Major_video" />
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-xs-6 col-sm-4">

                                        </div>
                                        <div class="col-xs-6 col-sm-4"><asp:TextBox class="form-control" id="txt_comments_video" placeholder="Additional Comments..." runat="server"></asp:TextBox></div>
                                    </div>
                                </li>
                                <li class="list-group-item"><p><strong>Interior Dome Lights</strong></p>
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-1"><asp:CheckBox id="cb_fail_interiorLights" Text="&nbsp;Fail" runat="server" /></div>
                                        <div class="col-xs-6 col-sm-3">
                                            <asp:DropDownList class="form-control" ID="ddl_interiorLights" Width="200px" runat="server">
                                                <asp:ListItem Text="Select Major or Minor..." Value="ddlli_prompt_majmin_interiorLights" Selected="True" />
                                                <asp:ListItem Text="Minor" Value="ddlli_Minor_interiorLights" />
                                                <asp:ListItem Text="Major" Value="ddlli_Major_interiorLights" />
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-xs-6 col-sm-4">

                                        </div>
                                        <div class="col-xs-6 col-sm-4"><asp:TextBox class="form-control" id="txt_comments_interiorLights" placeholder="Additional Comments..." runat="server"></asp:TextBox></div>
                                    </div>
                                </li>
                            </ul>
                            <div class="panel-footer">Footer</div>
                        </div>
                    </div>
                </div>
            </div> <%--End Group IV Panel--%>
            <%--Begin Group V Panel--%>
            <div class="container">
                <div class="panel-group">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" href="#collapse5"><strong>Group V - Emergency Equipment</strong> <span class="badge" style="float: right">5</span></a>
                            </h4>
                        </div>
                        <div id="collapse5" class="panel-collapse collapse">
                            <ul class="list-group">
                                <li class="list-group-item"><p><strong>Fire Extinguisher</strong></p>
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-1"><asp:CheckBox id="cb_fail_fireExt" Text="&nbsp;Fail" runat="server" /></div>
                                        <div class="col-xs-6 col-sm-3">
                                            <asp:DropDownList class="form-control" ID="ddl_fireExt" Width="200px" runat="server">
                                                <asp:ListItem Text="Select Major or Minor..." Value="ddlli_prompt_majmin_fireExt" Selected="True" />
                                                <asp:ListItem Text="Minor" Value="ddlli_Minor_fireExt" />
                                                <asp:ListItem Text="Major" Value="ddlli_Major_fireExt" />
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-xs-6 col-sm-4">
                                            <label class="checkbox-inline"><input type="checkbox" value="">Tighten</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Replace</label>
                                        </div>
                                        <div class="col-xs-6 col-sm-4"><asp:TextBox class="form-control" id="txt_comments_fireExt" placeholder="Additional Comments..." runat="server"></asp:TextBox></div>
                                    </div>
                                </li>
                                <li class="list-group-item"><p><strong>First Aid Kit</strong></p>
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-1"><asp:CheckBox id="cb_fail_firstAid" Text="&nbsp;Fail" runat="server" /></div>
                                        <div class="col-xs-6 col-sm-3">
                                            <asp:DropDownList class="form-control" ID="ddl_firstAid" Width="200px" runat="server">
                                                <asp:ListItem Text="Select Major or Minor..." Value="ddlli_prompt_majmin_firstAid" Selected="True" />
                                                <asp:ListItem Text="Minor" Value="ddlli_Minor_firstAid" />
                                                <asp:ListItem Text="Major" Value="ddlli_Major_firstAid" />
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-xs-6 col-sm-4">
                                            <label class="checkbox-inline"><input type="checkbox" value="">Cleanliness</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Refill</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Replace</label>
                                        </div>
                                        <div class="col-xs-6 col-sm-4"><asp:TextBox class="form-control" id="txt_comments_firstAid" placeholder="Additional Comments..." runat="server"></asp:TextBox></div>
                                    </div>
                                </li>
                                <li class="list-group-item"><p><strong>Fuses</strong></p>
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-1"><asp:CheckBox id="cb_fail_fuses" Text="&nbsp;Fail" runat="server" /></div>
                                        <div class="col-xs-6 col-sm-3">
                                            <asp:DropDownList class="form-control" ID="ddl_fuses" Width="200px" runat="server">
                                                <asp:ListItem Text="Select Major or Minor..." Value="ddlli_prompt_majmin_fuses" Selected="True" />
                                                <asp:ListItem Text="Minor" Value="ddlli_Minor_fuses" />
                                                <asp:ListItem Text="Major" Value="ddlli_Major_fuses" />
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-xs-6 col-sm-4">
                                            <label class="checkbox-inline"><input type="checkbox" value="">Replace</label>
                                        </div>
                                        <div class="col-xs-6 col-sm-4"><asp:TextBox class="form-control" id="txt_comments_fuses" placeholder="Additional Comments..." runat="server"></asp:TextBox></div>
                                    </div>
                                </li>
                                <li class="list-group-item"><p><strong>Reflectors</strong></p>
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-1"><asp:CheckBox id="cb_fail_reflectors" Text="&nbsp;Fail" runat="server" /></div>
                                        <div class="col-xs-6 col-sm-3">
                                            <asp:DropDownList class="form-control" ID="ddl_reflectors" Width="200px" runat="server">
                                                <asp:ListItem Text="Select Major or Minor..." Value="ddlli_prompt_majmin_reflectors" Selected="True" />
                                                <asp:ListItem Text="Minor" Value="ddlli_Minor_reflectors" />
                                                <asp:ListItem Text="Major" Value="ddlli_Major_reflectors" />
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-xs-6 col-sm-4">

                                        </div>
                                        <div class="col-xs-6 col-sm-4"><asp:TextBox class="form-control" id="txt_comments_reflectors" placeholder="Additional Comments..." runat="server"></asp:TextBox></div>
                                    </div>
                                </li>
                                <li class="list-group-item"><p><strong>Body Fluids Kit</strong></p>
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-1"><asp:CheckBox id="cb_fail_bodyFluidsKit" Text="&nbsp;Fail" runat="server" /></div>
                                        <div class="col-xs-6 col-sm-3">
                                            <select class="form-control" id="sel_majmin_bodyFluidsKit" style="max-width: 190px">
                                                <option>Select Major or Minor...</option>
                                                <option>Minor</option>
                                                <option>Major</option>
                                            </select>
                                        </div>
                                        <div class="col-xs-6 col-sm-4">
                                            <label class="checkbox-inline"><input type="checkbox" value="">Refill</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Replace</label>
                                        </div>
                                        <div class="col-xs-6 col-sm-4"><asp:TextBox class="form-control" id="txt_comments_bodyFluidsKit" placeholder="Additional Comments..." runat="server"></asp:TextBox></div>
                                    </div>
                                </li>
                                <li class="list-group-item"><p><strong>Strobe Light</strong></p>
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-1"><asp:CheckBox id="cb_fail_strobeLight" Text="&nbsp;Fail" runat="server" /></div>
                                        <div class="col-xs-6 col-sm-3">
                                            <select class="form-control" id="sel_majmin_strobeLight" style="max-width: 190px">
                                                <option>Select Major or Minor...</option>
                                                <option>Minor</option>
                                                <option>Major</option>
                                            </select>
                                        </div>
                                        <div class="col-xs-6 col-sm-4">

                                        </div>
                                        <div class="col-xs-6 col-sm-4"><asp:TextBox class="form-control" id="txt_comments_strobeLight" placeholder="Additional Comments..." runat="server"></asp:TextBox></div>
                                    </div>
                                </li>
                                <li class="list-group-item"><p><strong>Roof Hatch</strong></p>
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-1"><asp:CheckBox id="cb_fail_roofHatch" Text="&nbsp;Fail" runat="server" /></div>
                                        <div class="col-xs-6 col-sm-3">
                                            <select class="form-control" id="sel_majmin_roofHatch" style="max-width: 190px">
                                                <option>Select Major or Minor...</option>
                                                <option>Minor</option>
                                                <option>Major</option>
                                            </select>
                                        </div>
                                        <div class="col-xs-6 col-sm-4">
                                            <label class="checkbox-inline"><input type="checkbox" value="">Alarm</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Handle</label>
                                        </div>
                                        <div class="col-xs-6 col-sm-4"><asp:TextBox class="form-control" id="txt_comments_roofHatch" placeholder="Additional Comments..." runat="server"></asp:TextBox></div>
                                    </div>
                                </li>
                                <li class="list-group-item"><p><strong>Emergency Window</strong></p>
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-1"><asp:CheckBox id="cb_fail_emergencyWindow" Text="&nbsp;Fail" runat="server" /></div>
                                        <div class="col-xs-6 col-sm-3">
                                            <select class="form-control" id="sel_majmin_emergencyWindow" style="max-width: 190px">
                                                <option>Select Major or Minor...</option>
                                                <option>Minor</option>
                                                <option>Major</option>
                                            </select>
                                        </div>
                                        <div class="col-xs-6 col-sm-4">
                                            <label class="checkbox-inline"><input type="checkbox" value="">Alarm</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Arm</label>
                                        </div>
                                        <div class="col-xs-6 col-sm-4"><asp:TextBox class="form-control" id="txt_comments_emergencyWindow" placeholder="Additional Comments..." runat="server"></asp:TextBox></div>
                                    </div>
                                </li>
                            </ul>
                            <div class="panel-footer">Footer</div>
                        </div>
                    </div>
                </div>
            </div> <%--End Group V Panel--%>
            <%--Begin Group VI Panel--%>
            <div class="container">
                <div class="panel-group">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" href="#collapse6"><strong>Group VI - General</strong> <span class="badge" style="float: right">5</span></a>
                            </h4>
                        </div>
                        <div id="collapse6" class="panel-collapse collapse">
                            <ul class="list-group">
                                <li class="list-group-item"><p><strong>Body</strong></p>
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-1"><asp:CheckBox id="cb_fail_body" Text="&nbsp;Fail" runat="server" /></div>
                                        <div class="col-xs-6 col-sm-3">
                                            <select class="form-control" id="sel_majmin_body" style="max-width: 190px">
                                                <option>Select Major or Minor...</option>
                                                <option>Minor</option>
                                                <option>Major</option>
                                            </select>
                                        </div>
                                        <div class="col-xs-6 col-sm-4">
                                            <label class="checkbox-inline"><input type="checkbox" value="">Paint</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Condition</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Repair</label>
                                        </div>
                                        <div class="col-xs-6 col-sm-4"><asp:TextBox class="form-control" id="txt_comments_body" placeholder="Additional Comments..." runat="server"></asp:TextBox></div>
                                    </div>
                                </li>
                                <li class="list-group-item"><p><strong>Lettering</strong></p>
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-1"><asp:CheckBox id="cb_fail_lettering" Text="&nbsp;Fail" runat="server" /></div>
                                        <div class="col-xs-6 col-sm-3">
                                            <select class="form-control" id="sel_majmin_lettering" style="max-width: 190px">
                                                <option>Select Major or Minor...</option>
                                                <option>Minor</option>
                                                <option>Major</option>
                                            </select>
                                        </div>
                                        <div class="col-xs-6 col-sm-4">
 
                                        </div>
                                        <div class="col-xs-6 col-sm-4"><asp:TextBox class="form-control" id="txt_comments_lettering" placeholder="Additional Comments..." runat="server"></asp:TextBox></div>
                                    </div>
                                </li>
                                <li class="list-group-item"><p><strong>Mirror</strong></p>
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-1"><asp:CheckBox id="cb_fail_mirror" Text="&nbsp;Fail" runat="server" /></div>
                                        <div class="col-xs-6 col-sm-3">
                                            <select class="form-control" id="sel_majmin_mirror" style="max-width: 190px">
                                                <option>Select Major or Minor...</option>
                                                <option>Minor</option>
                                                <option>Major</option>
                                            </select>
                                        </div>
                                        <div class="col-xs-6 col-sm-4">
                                            <label class="checkbox-inline"><input type="checkbox" value="">Right</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Left</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Exterior</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Interior</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Crossover</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Damaged</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Tighten</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Replace</label>
                                        </div>
                                        <div class="col-xs-6 col-sm-4"><asp:TextBox class="form-control" id="txt_comments_mirror" placeholder="Additional Comments..." runat="server"></asp:TextBox></div>
                                    </div>
                                </li>
                                <li class="list-group-item"><p><strong>Service Door</strong></p>
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-1"><asp:CheckBox id="cb_fail_serviceDoor" Text="&nbsp;Fail" runat="server" /></div>
                                        <div class="col-xs-6 col-sm-3">
                                            <select class="form-control" id="sel_majmin_serviceDoor" style="max-width: 190px">
                                                <option>Select Major or Minor...</option>
                                                <option>Minor</option>
                                                <option>Major</option>
                                            </select>
                                        </div>
                                        <div class="col-xs-6 col-sm-4">

                                        </div>
                                        <div class="col-xs-6 col-sm-4"><asp:TextBox class="form-control" id="txt_comments_serviceDoor" placeholder="Additional Comments..." runat="server"></asp:TextBox></div>
                                    </div>
                                </li>
                                <li class="list-group-item"><p><strong>Emergency Door</strong></p>
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-1"><asp:CheckBox id="cb_fail_emergencyDoor" Text="&nbsp;Fail" runat="server" /></div>
                                        <div class="col-xs-6 col-sm-3">
                                            <select class="form-control" id="sel_majmin_emergencyDoor" style="max-width: 190px">
                                                <option>Select Major or Minor...</option>
                                                <option>Minor</option>
                                                <option>Major</option>
                                            </select>
                                        </div>
                                        <div class="col-xs-6 col-sm-4">
                                            <label class="checkbox-inline"><input type="checkbox" value="">Buzzer</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Latch</label>        
                                        </div>
                                        <div class="col-xs-6 col-sm-4"><asp:TextBox class="form-control" id="txt_comments_emergencyDoor" placeholder="Additional Comments..." runat="server"></asp:TextBox></div>
                                    </div>
                                </li>
                                <li class="list-group-item"><p><strong>Emergency Exit</strong></p>
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-1"><asp:CheckBox id="cb_fail_emergencyExit" Text="&nbsp;Fail" runat="server" /></div>
                                        <div class="col-xs-6 col-sm-3">
                                            <select class="form-control" id="sel_majmin_emergencyExit" style="max-width: 190px">
                                                <option>Select Major or Minor...</option>
                                                <option>Minor</option>
                                                <option>Major</option>
                                            </select>
                                        </div>
                                        <div class="col-xs-6 col-sm-4">

                                        </div>
                                        <div class="col-xs-6 col-sm-4"><asp:TextBox class="form-control" id="txt_comments_emergencyExit" placeholder="Additional Comments..." runat="server"></asp:TextBox></div>
                                    </div>
                                </li>
                                <li class="list-group-item"><p><strong>Heater/Defroster</strong></p>
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-1"><asp:CheckBox id="cb_fail_heater" Text="&nbsp;Fail" runat="server" /></div>
                                        <div class="col-xs-6 col-sm-3">
                                            <select class="form-control" id="sel_majmin_heater" style="max-width: 190px">
                                                <option>Select Major or Minor...</option>
                                                <option>Minor</option>
                                                <option>Major</option>
                                            </select>
                                        </div>
                                        <div class="col-xs-6 col-sm-4">
                                            <label class="checkbox-inline"><input type="checkbox" value="">Switch</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Motor</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Tighten</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Replace</label>
                                        </div>
                                        <div class="col-xs-6 col-sm-4"><asp:TextBox class="form-control" id="txt_comments_heater" placeholder="Additional Comments..." runat="server"></asp:TextBox></div>
                                    </div>
                                </li>
                                <li class="list-group-item"><p><strong>Horn(s) - Non Function</strong></p>
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-1"><asp:CheckBox id="cb_fail_horns" Text="&nbsp;Fail" runat="server" /></div>
                                        <div class="col-xs-6 col-sm-3">
                                            <select class="form-control" id="sel_majmin_horns" style="max-width: 190px">
                                                <option>Select Major or Minor...</option>
                                                <option>Minor</option>
                                                <option>Major</option>
                                            </select>
                                        </div>
                                        <div class="col-xs-6 col-sm-4">

                                        </div>
                                        <div class="col-xs-6 col-sm-4"><asp:TextBox class="form-control" id="txt_comments_horns" placeholder="Additional Comments..." runat="server"></asp:TextBox></div>
                                    </div>
                                </li>
                                <li class="list-group-item"><p><strong>Upholstery Seat</strong></p>
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-1"><asp:CheckBox id="cb_fail_uphSeat" Text="&nbsp;Fail" runat="server" /></div>
                                        <div class="col-xs-6 col-sm-3">
                                            <select class="form-control" id="sel_majmin_uphSeat" style="max-width: 190px">
                                                <option>Select Major or Minor...</option>
                                                <option>Minor</option>
                                                <option>Major</option>
                                            </select>
                                        </div>
                                        <div class="col-xs-6 col-sm-4">
                                            <label class="checkbox-inline"><input type="checkbox" value="">P</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">P1</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">P2</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">P3</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">P4</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">P5</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">P6</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">P7</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">P8</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">P9</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">P10</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">P11</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">D</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">D1</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">D2</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">D3</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">D4</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">D5</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">D6</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">D7</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">D8</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">D9</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">D10</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">D11</label>
                                        </div>
                                        <div class="col-xs-6 col-sm-4"><asp:TextBox class="form-control" id="txt_comments_uphSeat" placeholder="Additional Comments..." runat="server"></asp:TextBox></div>
                                    </div>
                                </li>
                                <li class="list-group-item"><p><strong>Upholstery Back</strong></p>
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-1"><asp:CheckBox id="cb_fail_uphBack" Text="&nbsp;Fail" runat="server" /></div>
                                        <div class="col-xs-6 col-sm-3">
                                            <select class="form-control" id="sel_majmin_uphBack" style="max-width: 190px">
                                                <option>Select Major or Minor...</option>
                                                <option>Minor</option>
                                                <option>Major</option>
                                            </select>
                                        </div>
                                        <div class="col-xs-6 col-sm-4">
                                            <label class="checkbox-inline"><input type="checkbox" value="">P</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">P1</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">P2</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">P3</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">P4</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">P5</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">P6</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">P7</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">P8</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">P9</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">P10</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">P11</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">D</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">D1</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">D2</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">D3</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">D4</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">D5</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">D6</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">D7</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">D8</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">D9</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">D10</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">D11</label>
                                        </div>
                                        <div class="col-xs-6 col-sm-4"><asp:TextBox class="form-control" id="uphBack" placeholder="Additional Comments..." runat="server"></asp:TextBox></div>
                                    </div>
                                </li>
                                <li class="list-group-item"><p><strong>Floor Coverings</strong></p>
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-1"><asp:CheckBox id="cb_fail_floor" Text="&nbsp;Fail" runat="server" /></div>
                                        <div class="col-xs-6 col-sm-3">
                                            <select class="form-control" id="sel_majmin_floor" style="max-width: 190px">
                                                <option>Select Major or Minor...</option>
                                                <option>Minor</option>
                                                <option>Major</option>
                                            </select>
                                        </div>
                                        <div class="col-xs-6 col-sm-4">
                                            <label class="checkbox-inline"><input type="checkbox" value="">Cement</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Replace</label>
                                        </div>
                                        <div class="col-xs-6 col-sm-4"><asp:TextBox class="form-control" id="txt_comments_floor" placeholder="Additional Comments..." runat="server"></asp:TextBox></div>
                                    </div>
                                </li>
                                <li class="list-group-item"><p><strong>Driver Seat Belt</strong></p>
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-1"><asp:CheckBox id="cb_fail_driverSeatBelt" Text="&nbsp;Fail" runat="server" /></div>
                                        <div class="col-xs-6 col-sm-3">
                                            <select class="form-control" id="sel_majmin_driverSeatBelt" style="max-width: 190px">
                                                <option>Select Major or Minor...</option>
                                                <option>Minor</option>
                                                <option>Major</option>
                                            </select>
                                        </div>
                                        <div class="col-xs-6 col-sm-4">

                                        </div>
                                        <div class="col-xs-6 col-sm-4"><asp:TextBox class="form-control" id="txt_comments_driverSeatBelt" placeholder="Additional Comments..." runat="server"></asp:TextBox></div>
                                    </div>
                                </li>
                                <li class="list-group-item"><p><strong>Exterior Condition</strong></p>
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-1"><asp:CheckBox id="cb_fail_extCondition" Text="&nbsp;Fail" runat="server" /></div>
                                        <div class="col-xs-6 col-sm-3">
                                            <select class="form-control" id="sel_majmin_extCondition" style="max-width: 190px">
                                                <option>Select Major or Minor...</option>
                                                <option>Minor</option>
                                                <option>Major</option>
                                            </select>
                                        </div>
                                        <div class="col-xs-6 col-sm-4">

                                        </div>
                                        <div class="col-xs-6 col-sm-4"><asp:TextBox class="form-control" id="txt_comments_extCondition" placeholder="Additional Comments..." runat="server"></asp:TextBox></div>
                                    </div>
                                </li>
                                <li class="list-group-item"><p><strong>Interior Condition</strong></p>
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-1"><asp:CheckBox id="cb_fail_interiorCondition" Text="&nbsp;Fail" runat="server" /></div>
                                        <div class="col-xs-6 col-sm-3">
                                            <select class="form-control" id="sel_majmin_interiorCondition" style="max-width: 190px">
                                                <option>Select Major or Minor...</option>
                                                <option>Minor</option>
                                                <option>Major</option>
                                            </select>
                                        </div>
                                        <div class="col-xs-6 col-sm-4">

                                        </div>
                                        <div class="col-xs-6 col-sm-4"><asp:TextBox class="form-control" id="txt_comments_interiorCondition" placeholder="Additional Comments..." runat="server"></asp:TextBox></div>
                                    </div>
                                </li>
                                <li class="list-group-item"><p><strong>Chains</strong></p>
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-1"><asp:CheckBox id="cb_fail_chains" Text="&nbsp;Fail" runat="server" /></div>
                                        <div class="col-xs-6 col-sm-3">
                                            <select class="form-control" id="sel_majmin_chains" style="max-width: 190px">
                                                <option>Select Major or Minor...</option>
                                                <option>Minor</option>
                                                <option>Major</option>
                                            </select>
                                        </div>
                                        <div class="col-xs-6 col-sm-4">
                                            <label class="checkbox-inline"><input type="checkbox" value="">Automatic</label>
                                            <label class="checkbox-inline"><input type="checkbox" value="">Manual</label>
                                        </div>
                                        <div class="col-xs-6 col-sm-4"><asp:TextBox class="form-control" id="txt_comments_chains" placeholder="Additional Comments..." runat="server"></asp:TextBox></div>
                                    </div>
                                </li>
                                <li class="list-group-item"><p><strong>Miscellaneous</strong></p>
                                    <div class="row">
                                        <div class="col-xs-6 col-sm-1"><asp:CheckBox id="cb_fail_misc" Text="&nbsp;Fail" runat="server" /></div>
                                        <div class="col-xs-6 col-sm-3">
                                            <select class="form-control" id="sel_majmin_misc" style="max-width: 190px">
                                                <option>Select Major or Minor...</option>
                                                <option>Minor</option>
                                                <option>Major</option>
                                            </select>
                                        </div>
                                        <div class="col-xs-6 col-sm-4">
      
                                        </div>
                                        <div class="col-xs-6 col-sm-4"><asp:TextBox class="form-control" id="txt_comments_misc" placeholder="Additional Comments..." runat="server"></asp:TextBox></div>
                                    </div>
                                </li>
                            </ul>
                            <div class="panel-footer">Footer</div>
                        </div>
                    </div>
                </div>
            </div> <%--End Group VI Panel--%>
            <br />
            <%--Begin Notes Section --%>
            <div class="container">
<%--                <form role="form">
                    <div class="form-group">--%>
                        <label for="notes">Notes:</label>
                        <textarea class="form-control" rows="5" id="notes"></textarea>
                    </div>
                <%--</form>--%>
            </div> <%--End Notes Section--%>









        </div>
    </div>



    

            <div class="form-group">
                <div class='input-group date' id='datetimepicker1'>
                    <input type='text' class="form-control" />
                    <span class="input-group-addon">
                        <span class="glyphicon glyphicon-calendar"></span>
                    </span>
                </div>
            </div>

        <script type="text/javascript">
            $(function () {
                $('#datetimepicker1').datetimepicker();
            });
        </script>
 

</asp:Content>
