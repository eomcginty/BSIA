<%@ Page Title="Create" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Create.aspx.cs" Inherits="BSIA.Create" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Create Inspection</h2>

    <!-- Modal Create Success Message-->
    <asp:Panel ID="pnl_success" runat="server" Visible="false">
        <div id="modal_success_create" role="dialog" class="modal in">
            <div class="modal-dialog" style="margin-top: 100px">
                <div class="modal-content">
                    <div class="modal-header label-success">
                        <h4 class="modal-title">Inspection Successfully Created!</h4>
                    </div>
                    <div class="modal-body">
                        <p class="text-success">Choose from the following selections.</p>
                        <a href="Default.aspx" class="btn btn-success"><span aria-hidden="true" class="glyphicon glyphicon-home"></span> Go to Home Page</a>
                        <a href="Reports.aspx" class="btn btn-success">View Bus Report</a>
                        <a href="Create.aspx" class="btn btn-success">Enter New Inspection</a>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
    </asp:Panel>

    <!-- Modal Create Error Message-->
    <asp:Panel ID="pnl_error" runat="server" Visible="false">
        <div id="modal_error_create" role="dialog" class="modal in">
            <div class="modal-dialog" style="margin-top: 100px">
                <div class="modal-content">
                    <div class="modal-header label-danger">
                        <h4 class="modal-title" style="color:#ffffff">Create Inspection Error!</h4>
                    </div>
                    <div class="modal-body">
                        <p class="text-danger">Choose from the following selections.</p>
                        <a href="Default.aspx" class="btn btn-danger">Go to Home Page</a>
                        <a href="Reports.aspx" class="btn btn-danger">View Bus Report</a>
                        <a href="Create.aspx" class="btn btn-danger">Enter New Inspection</a>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
    </asp:Panel>


    <%--Begin Bus Information Panel--%>
    <div class="panel panel-default">
        <div class="panel-heading" style="font-size: 18px; font-weight: bold; background-color: cornflowerblue">Bus Information</div>
        <div class="panel-body">

             <%--Begin Bus Selection Row--%>
            <div class="row">
                <%--Bus DropDownList--%>
                <div class="col-sm-3">
                    <div class="form-group">
                        <asp:Label ID="lbl_bus" class="control-label" runat="server" Text="Bus:" style="font-weight:bold"></asp:Label>
                        <asp:SqlDataSource ID="SqlDataSource_bus" runat="server" ConnectionString="<%$ ConnectionStrings:BSIAConnectionString%>"
                            SelectCommand="SELECT bus_number FROM BusContractorNumber bcn WHERE bcn.effective_date <= GETDATE() AND ( bcn.termination_date IS NULL OR bcn.termination_date > GETDATE()) ORDER BY bus_number * 1" DataSourceMode="DataReader">
                        </asp:SqlDataSource>
                        <asp:DropDownList class="form-control" ID="ddl_bus" Style="max-width: 300px" runat="server" 
                            DataSourceID="SqlDataSource_bus" DataTextField="bus_number" DataValueField="bus_number" AppendDataBoundItems="True">
                            <asp:ListItem>Select Bus from list</asp:ListItem>
                        </asp:DropDownList>
                        <asp:CompareValidator style="color:#b94a48" ID="CompareValidator_bus" runat="server" ErrorMessage="Select a Bus!"
                            Operator="NotEqual" ValueToCompare="Select Bus from list" ControlToValidate="ddl_bus">
                            &nbsp;Please select a Bus!
                        </asp:CompareValidator>
                    </div>
                </div>
                 <%--Season DropDownList--%>
                <div class="col-sm-3">
                    <div class="form-group">
                        <asp:Label ID="lbl_season" class="control-label" runat="server" Text="Season:" style="font-weight:bold"></asp:Label>
                        <asp:SqlDataSource ID="SqlDataSource_season" runat="server" ConnectionString="<%$ ConnectionStrings:BSIAConnectionString%>"
                            SelectCommand="SELECT [season_id], [season_name] FROM [Season]" DataSourceMode="DataReader">
                        </asp:SqlDataSource>
                        <asp:DropDownList class="form-control" ID="ddl_season" Style="max-width: 300px" runat="server"
                            DataSourceID="SqlDataSource_season" DataTextField="season_name" DataValueField="season_id" AppendDataBoundItems="True">
                            <asp:ListItem>Select Season from list</asp:ListItem>
                        </asp:DropDownList>
                        <asp:CompareValidator style="color:#b94a48" ID="CompareValidator_season" runat="server" ErrorMessage="Select a Season!"
                            Operator="NotEqual" ValueToCompare="Select Season from list" ControlToValidate="ddl_season">
                            &nbsp;Please select a Season!
                        </asp:CompareValidator>
                    </div>
                </div>
                <%--Inspection Date Calendar--%>
                <div class="col-sm-3">
                    <div class="form-group">
                        <asp:Label ID="lbl_inspectionDate" class="control-label" runat="server" Text="Inspection Date:" style="font-weight:bold"></asp:Label>
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
                <%--Submit Bus Information for Display Table--%>
                <div class="col-sm-3" style="margin-top:20px">
                     <asp:Button ID="btn_getBus" class="btn btn-primary" type="submit" runat="server" Text="Get Bus Information" OnClick="btn_getBus_Click" />
                </div>
            </div><%--End Bus Selection Row--%>
            
            <%--Begin Panel to Display Populated Table, and Verify Row--%>
            <div id="rowDisplay_busInfo" class="row" style="display: block">
                <asp:Panel class="alert alert-danger fade in" ID="pnl_error_exists" runat="server" Visible="false">
                        <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                        <i>Inspection Already Exists.</i>
                </asp:Panel>
                <asp:Panel ID="pnl_bus" runat="server" class="col-sm-12" Visible="false">
                    <div class="alert alert-info fade in" style="display:none">
                        <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                        <i>Verify Bus Information.</i>
                    </div>

                    <asp:SqlDataSource ID="SqlDataSource_busTable" runat="server" ConnectionString="<%$ ConnectionStrings:BSIAConnectionString%>"
                        SelectCommand="SELECT DISTINCT bus_number, VIN, company_name, body_description, chassis_description, model_year, bcn.contractor_id AS contractor_id FROM Bus b INNER JOIN BusContractorNumber bcn ON bcn.bus_id = b.bus_id INNER JOIN Contractor c ON c.contractor_id = bcn.contractor_id INNER JOIN BusBodyLU bl ON bl.body_id = b.body_id INNER JOIN BusChassisLU cl ON cl.chassis_id = b.chassis_id WHERE bcn.effective_date <= GETDATE() AND ( bcn.termination_date IS NULL OR bcn.termination_date > GETDATE()) AND bus_number = @bus_num" DataSourceMode="DataReader">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="ddl_bus" Name="bus_num" Type="Int32" DefaultValue="0" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <%--Begin Bus Information Repeater--%>
                    <asp:Repeater ID="repeater_busInfo" runat="server" DataSourceID="SqlDataSource_busTable">
                        <HeaderTemplate>
                            <table class="table table-striped">
                                <tr>
                                    <th style="width: 20%; background-color: #c4e7f8">Contractor Name</th>
                                    <th style="width: 20%; background-color: #c4e7f8">VIN</th>
                                    <th style="width: 10%; background-color: #c4e7f8">Model</th>
                                    <th style="width: 10%; background-color: #c4e7f8">Chassis</th>
                                    <th style="width: 10%; background-color: #c4e7f8">Body</th>
                                </tr>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tbody>
                                <tr>
                                    <td style="background-color: #f9f9f9"><asp:Label runat="server" ID="lbl_ctrName" Text='<%# Eval("company_name") %>' /></td>
                                    <td style="background-color: #f9f9f9"><asp:Label runat="server" ID="lbl_vin" Text='<%# Eval("vin") %>' /></td>
                                    <td style="background-color: #f9f9f9"><asp:Label runat="server" ID="lbl_model" Text='<%# Eval("model_year") %>' /></td>
                                    <td style="background-color: #f9f9f9"><asp:Label runat="server" ID="lbl_chassis" Text='<%# Eval("chassis_description") %>' /></td>
                                    <td style="background-color: #f9f9f9"><asp:Label runat="server" ID="lbl_body" Text='<%# Eval("body_description") %>' />
                                        <asp:Label Visible="false" ID="lbl_contractor_id" runat="server" Text='<%# Eval("contractor_id") %>' />
                                    </td>
                                </tr>
                            </tbody>
                        </ItemTemplate>
                        <FooterTemplate>
                            </tbody></table>
                        </FooterTemplate>
                    </asp:Repeater> <%--End Bus Information Repeater--%>

<%--                    <asp:GridView class="table" ID="GridView_busTable" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource_busTable" ForeColor="#333333" GridLines="None">
                        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                        <Columns>
                            <asp:BoundField DataField="company_name" HeaderText="Contractor Name" SortExpression="company_name" />
                            <asp:BoundField DataField="VIN" HeaderText="VIN" SortExpression="VIN" />
                            <asp:BoundField DataField="model_year" HeaderText="Model" SortExpression="model_year" />
                            <asp:BoundField DataField="chassis_description" HeaderText="Chassis" SortExpression="chassis_description" />
                            <asp:BoundField DataField="body_description" HeaderText="Body" SortExpression="body_description" />
                        </Columns>
                        <EditRowStyle BackColor="#999999" />
                        <FooterStyle BackColor="#c4e7f8" ForeColor="Black" Font-Bold="True" />
                        <HeaderStyle BackColor="#c4e7f8" Font-Bold="True" ForeColor="Black" />
                        <PagerStyle BackColor="#284775" ForeColor="Black" HorizontalAlign="Center" />
                        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                        <SortedAscendingCellStyle BackColor="#E9E7E2" />
                        <SortedAscendingHeaderStyle BackColor="#506C8C" />
                        <SortedDescendingCellStyle BackColor="#FFFDF8" />
                        <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                    </asp:GridView>--%>
                </asp:Panel>
            </div><%--End Panel to Display Populated Table, and Verify Row--%>
        </div><%--End Bus Panel Body--%>
    </div><%--End Bus Panel--%>

    <%--Begin Create Inspection Panel--%>
    <asp:Panel ID="pnl_inspection" runat="server" class="panel panel-default" Visible="false">
        <div class="panel-heading" style="font-size: 18px; font-weight: bold; background-color: cornflowerblue">Create Inspection</div>
        <div class="panel-body">

            <%--Additional input fields - Odometer, TAG--%>
            <div class="row">
                <%--Odometer--%>
                <div class="col-sm-3">
                    <div class="form-group" style="grid-flow: columns">
                        <asp:Label ID="lbl_odometer" class="control-label" runat="server" Text="Odometer:" Style="font-weight: bold"></asp:Label>
                        <asp:TextBox type="text" pattern="[0-9]{1,6}" runat="server" class="form-control" ID="txt_odometer" name="txt_odometer" placeholder="Numerical Data Only..." data-error="Invalid. Numbers < 999999 only." />
                        <div class="help-block with-errors"></div>
                    </div>
                </div>
                <%--TAG--%>
                <div class="col-sm-3">
                    <div class="form-group" style="grid-flow: columns">
                        <asp:Label ID="lbl_tag" class="control-label" runat="server" Text="Vehicle License Plate (TAG):" Style="font-weight: bold"></asp:Label>
                        <asp:TextBox type="text" pattern="[a-zA-Z0-9]{3,7}" runat="server" class="form-control" ID="txt_tag" name="txt_tag" placeholder="Letters/Numbers, No Spaces..." data-error="Invalid. Letters and Numbers only. No spaces." />
                        <div class="help-block with-errors"></div>
                   </div>
                </div>
                <%--Created By--%>
                <div class="col-sm-3">
                    <div class="form-group" style="grid-flow: columns">
                        <asp:Label ID="lbl_createdBy" class="control-label" runat="server" Text="Created By:" Style="font-weight: bold"></asp:Label>
                        <asp:TextBox class="form-control" ID="txt_createdby" runat="server"></asp:TextBox>

                    </div>
                </div>
                <%--Updated By--%>
                <div class="col-sm-3" style="display:none">
                    <div class="form-group" style="grid-flow: columns">
                        <asp:Label ID="lbl_updatedBy" class="control-label" runat="server" Text="Updated By:" Style="font-weight: bold"></asp:Label>
                        <asp:TextBox class="form-control" ID="txt_updatedBy" runat="server" disabled></asp:TextBox>
                    </div>
                </div>
            </div><%-- End Additional input fields - Odometer, TAG row --%>
                


     <%--Begin Create Inspection Input row--%>
            <div class="row"> 

            <%--Begin Group Panels--%>
            <asp:SqlDataSource ID="SqlDataSource_groups" runat="server" ConnectionString="<%$ ConnectionStrings:BSIAConnectionString%>"
                SelectCommand="SELECT [group_description], [group_id] FROM [InspectionGroup]" DataSourceMode="DataReader">
            </asp:SqlDataSource>
            <%--Begin Repeater Groups--%>
            <asp:Repeater ID="Repeater_groups" runat="server" DataSourceID="SqlDataSource_groups">
                <ItemTemplate>
                    <div class="container">
                        <div class="panel-group">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h4 class="panel-title">
                                        <a data-toggle="collapse" href="#div_<%# DataBinder.Eval(Container,"ItemIndex") %>"><strong><%# Eval("group_description") %></strong></a>
                                    </h4>
								    <asp:Label runat="server" ID="lbl_groupId" Text='<%# Eval("group_id") %>' Visible="False" />
                                </div>
                                <%--Begin Repeater Items--%>
                                <div id="div_<%# DataBinder.Eval(Container,"ItemIndex") %>" class="panel-collapse collapse"> 
                                    <asp:Label runat="server" ID="lbl_itemsId" Text='<%# Eval("group_id") %>' Visible="False" />
                                    <asp:SqlDataSource
                                        ConnectionString="<%$ ConnectionStrings:BSIAConnectionString %>" ID="SqlDataSource_items" runat="server"
                                        SelectCommand="SELECT item_description, item_id FROM InspectionItem WHERE InspectionItem.group_id = @group_id" DataSourceMode="DataReader">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="lbl_groupId" Name="group_id" Type="Int32" DefaultValue="0" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                    <asp:Repeater ID="Repeater_items" runat="server" DataSourceID="SqlDataSource_items">
                                        <HeaderTemplate>
                                            <table class="table table-striped">
                                                <tr>
                                                    <th style="width: 20%; background-color:#c4e7f8">Item</th>
                                                    <th style="width: 10%; background-color:#c4e7f8">Result</th>
                                                    <th style="width: 15%; background-color:#c4e7f8">Severity</th>
                                                    <th style="width: 25%; background-color:#c4e7f8">Inspection Elements</th>
                                                    <th style="width: 25%; background-color:#c4e7f8">Additional Comments</th>
                                                </tr>
                                        </HeaderTemplate>
                                        <ItemTemplate><tbody>
                                            <tr>
                                                <td style="background-color:#f9f9f9"><asp:Label runat="server" ID="Label1" Text='<%# Eval("item_description") %>' /></td>
                                                <td hidden><asp:Label runat="server" ID="lbl_elementsId" Text='<%# Eval("item_id") %>' /></td>
                                                    <asp:SqlDataSource ConnectionString="<%$ ConnectionStrings:BSIAConnectionString %>" ID="SqlDataSource_elements" runat="server"
                                                        SelectCommand="SELECT element_description FROM InspectionDetail WHERE InspectionDetail.item_id = @item_elements" DataSourceMode="DataReader">
                                                        <SelectParameters>
                                                            <asp:ControlParameter ControlID="lbl_elementsId" Name="item_elements" Type="Int32" DefaultValue="0" />
                                                        </SelectParameters>
                                                    </asp:SqlDataSource>
                                                <td style="background-color:#f9f9f9; color:indianred"><asp:CheckBox ID="cb_fail" Text="&nbsp;Fail" runat="server" /></td>
                                                <td style="background-color:#f9f9f9">
                                                    <asp:SqlDataSource ID="SqlDataSource_minmaj" runat="server" ConnectionString="<%$ ConnectionStrings:BSIAConnectionString%>"
                                                        SelectCommand="SELECT [severity_description], [score] FROM [Severity]" DataSourceMode="DataReader">
                                                    </asp:SqlDataSource>
                                                    <asp:DropDownList class="form-control" ID="ddl_severity" Style="max-width: 150px" runat="server"
                                                        DataSourceID="SqlDataSource_minmaj" DataTextField="severity_description" DataValueField="score" AppendDataBoundItems="True">
                                                        <asp:ListItem>Minor or Major...</asp:ListItem>
                                                    </asp:DropDownList>
                            <%--                        <asp:CompareValidator Style="color: #b94a48" ID="CompareValidator_severity" runat="server" ErrorMessage="Select Severity!"
                                                        Operator="NotEqual" ValueToCompare="Select Major or Minor" ControlToValidate="ddl_severity">
                                                        &nbsp;Must select Severity!
                                                    </asp:CompareValidator>--%>
                                                </td>
                                                <td style="background-color:#f9f9f9">
                                    
                                                    <asp:Repeater ID="Repeater_elements" runat="server" DataSourceID="SqlDataSource_elements">
                                                        <ItemTemplate>
                                                            <asp:CheckBox ID="cb_elements" font-bold="false" name="item_elements" DataSourceID="SqlDataSource_elements" Text='<%# Eval("element_description") %>' runat="server" />
                                                        </ItemTemplate>
                                                    </asp:Repeater>
                                                </td>
                                                <td style="background-color:#f9f9f9"><asp:TextBox class="form-control" ID="txt_comments" placeholder="Additional Comments..." runat="server"></asp:TextBox></td>
                                            </tr>
                                        </ItemTemplate>

                                        <AlternatingItemTemplate>
                                            <tr>
                                                <td style="background-color:#ffffff"><asp:Label runat="server" ID="Label1" Text='<%# Eval("item_description") %>' />
                                                <td hidden><asp:Label runat="server" ID="lbl_elementsId" Text='<%# Eval("item_id") %>' /></td>
                                                    <asp:SqlDataSource
                                                        ConnectionString="<%$ ConnectionStrings:BSIAConnectionString %>" ID="SqlDataSource_elements" runat="server"
                                                        SelectCommand="SELECT element_description FROM InspectionDetail WHERE InspectionDetail.item_id = @item_elements" DataSourceMode="DataReader">
                                                        <SelectParameters>
                                                            <asp:ControlParameter ControlID="lbl_elementsId" Name="item_elements" Type="Int32" DefaultValue="0" />
                                                        </SelectParameters>
                                                    </asp:SqlDataSource>
                                                <td style="background-color:#ffffff"><asp:CheckBox ID="cb_fail" Text="&nbsp;Fail" runat="server" Style="color: indianred" /></td>
                                                <td style="background-color:#ffffff">
                                                    <asp:SqlDataSource ID="SqlDataSource_minmaj" runat="server" ConnectionString="<%$ ConnectionStrings:BSIAConnectionString%>"
                                                        SelectCommand="SELECT [severity_description], [score] FROM [Severity]" DataSourceMode="DataReader">
                                                    </asp:SqlDataSource>
                                                    <asp:DropDownList class="form-control" ID="ddl_severity" Style="max-width: 150px" runat="server"
                                                        DataSourceID="SqlDataSource_minmaj" DataTextField="severity_description" DataValueField="score" AppendDataBoundItems="True">
                                                        <asp:ListItem>Minor or Major...</asp:ListItem>
                                                    </asp:DropDownList>
                            
                                                </td>
                                                <td style="background-color:#ffffff">
                                                    <asp:Repeater ID="Repeater_elements" runat="server" DataSourceID="SqlDataSource_elements">
                                                        <ItemTemplate>
                                                            <asp:CheckBox ID="cb_elements" name="item_elements" DataSourceID="SqlDataSource_elements" Text='<%# Eval("element_description") %>' runat="server" />
                                                        </ItemTemplate>
                                                    </asp:Repeater>
                                                </td>
                                                <td style="background-color:#ffffff"><asp:TextBox class="form-control" ID="txt_comments" placeholder="Additional Comments..." runat="server"></asp:TextBox></td>
                                            </tr>
                                        </AlternatingItemTemplate>

                                        <FooterTemplate>
                                           </tbody> </table>
                                        </FooterTemplate>
                                    </asp:Repeater>
                                </div> <%--End Repeater Items--%>

                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
            <%--End Group Panels--%>
            <br />
            <%--Begin Notes Section --%>
            <div class="container">
                <div class="form-group">
                    <asp:Label ID="lbl_notes" class="control-label" runat="server" Text="Notes:" Style="font-weight: bold"></asp:Label>
                    <textarea class="form-control" rows="3" id="ta_notes" runat="server"></textarea>
                </div>
            </div>
            <%--End Notes Section--%>
            </div> <%--<End Create Inspection Input row>--%>

            <%--Begin Acknowledgement Panel--%>
            <div class="panel panel-info">
                <div class="panel-heading" style="color: black; font-weight: bold">Acknowledgement</div>
                <div class="panel-body">
                    <div class="row">
                    <%--Force acknowledgement which will prompt for a digital signature--%>
                    <div class="form-group col-sm-5">
                        <div class="checkbox">
                            <label>
                               <%-- <input id="cb_agree_inspector" type="checkbox" onclick="$('#pnl_digital_sig_inspector').toggle();" data-error="Must acknowledge before digitally signing form." required />--%>
                                <asp:CheckBox ID="cb_agree_inspector" runat="server" type="checkbox" onclick="$('#pnl_digital_sig_inspector').toggle();" data-error="Must acknowledge before digitally signing form." required="true"/>
                                <span style="font-weight: bold">&nbsp;Inspection results have been reviewed with the Contractor.</span>
                            </label>
                            <div class="help-block with-errors"></div>
                        </div>
                    </div>
                    <div class="form-group col-sm-7">
                        <div class="checkbox">
                            <label>
                                <%--<input id="cb_agree_contractor" type="checkbox" onclick="$('#pnl_digital_sig_contractor').toggle();" data-error="Must acknowledge before digitally signing form." required />--%>
                                <asp:CheckBox ID="cb_agree_contractor" runat="server" type="checkbox" onclick="$('#pnl_digital_sig_contractor').toggle();" data-error="Must acknowledge before digitally signing form." required="true"/>
                                <span style="font-weight: bold">&nbsp;Contractor agrees with inspection results.</span>
                            </label>
                            <div class="help-block with-errors"></div>
                        </div>
                    </div>
                    </div>
                    <div class="row">
                    <%--Display User name logged in, and form to digitally sign and submit--%>
                    <div id="pnl_digital_sig_inspector" style="display: none">
                        <div class="col-sm-5">
                                <div id="signed_name_form_inspector" class="form-group">
                                    <label for="txt_sig" class="control-label">Inspector Signed Name: </label>
                                    <div class="input-group">
                                        <span class="input-group-addon" id="basic-addon">X</span>
                                        <asp:TextBox class="form-control" ID="txt_sig_inspector" runat="server" data-error="Must digitally sign form." aria-describedby="basic-addon" required="true"></asp:TextBox>
                                    </div>
                                    <div class="help-block with-errors"></div>
                                </div>
                            </div>
                        </div>
                    <div id="pnl_digital_sig_contractor" style="display: none">
                        <div class="col-sm-7">
                                <div id="signed_name_form_contractor" class="form-group">
                                    <label for="txt_sig" class="control-label">Contractor Signed Name: </label>
                                    <div class="input-group">
                                        <span class="input-group-addon" id="basic-addon2">X</span>
                                        <asp:TextBox class="form-control" ID="txt_sig_contractor_first" runat="server" placeholder="First Name..." data-error="Must digitally sign form." aria-describedby="basic-addon2" required="true"></asp:TextBox>
                                        <asp:TextBox class="form-control" ID="txt_sig_contractor_last" runat="server" placeholder="Last Name..." data-error="Must digitally sign form." aria-describedby="basic-addon2" required="true"></asp:TextBox>
                                    </div>
                                    <div class="help-block with-errors"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
           </div><%--End Acknowledgement Panel--%>

            <%--Submit Bus Inspected Information--%>
            <div class="col-sm-3" style="margin-top:20px">
                    <asp:Button ID="btn_createInspection" class="btn btn-primary" type="submit" runat="server" Text="Submit Create Inspection" Width="200px" OnClick="btn_createInspection_Click" />
            </div>

        </div><%--End Create Inspection Panel Body--%>
    </asp:Panel><%--End Create Inspection Panel--%>
    
</asp:Content>
