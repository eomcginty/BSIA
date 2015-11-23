<%@ Page Title="Create" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Create.aspx.cs" Inherits="BSIA.Create" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Create Inspection</h2>

    <%--Begin Bus Information Panel--%>
    <div class="panel panel-default">
        <div class="panel-heading" style="font-size: 18px; font-weight: bold; background-color: cornflowerblue">Bus Information</div>
        <div class="panel-body">

            <%--Begin Bus Selection Row--%>
            <div class="row">
                <%--Form alerts--%>
                <div class="alert alert-info fade in" style="display:none">
                    <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                    <i>Select Bus, Season, and Inspection Date.</i>
                </div>
                <div class="alert alert-warning fade in" style="display:none">
                    <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                    <i>Bus already has an inspection completed for this season.</i>
                </div>
                <div class="alert alert-warning fade in" style="display:none">
                    <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                    <i>Bus is currently locked for editing by another inspector.</i>
                </div>
                <%--Bus DropDownList--%>
                <div class="col-sm-3">
                    <div class="form-group">
                        <asp:Label ID="lbl_bus" class="control-label" runat="server" Text="Bus:" style="font-weight:bold"></asp:Label>
                        <asp:SqlDataSource ID="SqlDataSource_bus" runat="server" ConnectionString="<%$ ConnectionStrings:BSIAConnectionString%>"
                            SelectCommand="SELECT [bus_id] FROM [Bus]" DataSourceMode="DataReader">
                        </asp:SqlDataSource>
                        <asp:DropDownList class="form-control" ID="ddl_bus" Style="max-width: 300px" runat="server" 
                            DataSourceID="SqlDataSource_bus" DataTextField="bus_id" DataValueField="bus_id" AppendDataBoundItems="True">
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
                <asp:Panel ID="pnl_bus" runat="server" class="col-sm-12" Visible="false">
                    <div class="alert alert-info fade in" style="display:none">
                        <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                        <i>Verify Bus Information.</i>
                    </div>
                    <asp:SqlDataSource ID="SqlDataSource_busTable" runat="server" ConnectionString="<%$ ConnectionStrings:BSIAConnectionString%>"
                        SelectCommand="SELECT DISTINCT bus_number, VIN, company_name, body_description, chassis_description, model_year FROM Bus b INNER JOIN BusContractorNumber bcn ON bcn.bus_id = b.bus_id INNER JOIN Contractor c ON c.contractor_id = bcn.contractor_id INNER JOIN BusBodyLU bl ON bl.body_id = b.body_id INNER JOIN BusChassisLU cl ON cl.chassis_id = b.chassis_id WHERE bcn.effective_date <= GETDATE() AND ( bcn.termination_date IS NULL OR bcn.termination_date > GETDATE()) AND bus_number = @bus_num" DataSourceMode="DataReader">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="ddl_bus" Name="bus_num" Type="Int32" DefaultValue="0" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:GridView class="table" ID="GridView_busTable" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource_busTable" ForeColor="#333333" GridLines="None">
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
                    </asp:GridView>
                </asp:Panel>
            </div><%--End Panel to Display Populated Table, and Verify Row--%>
        </div><%--End Bus Panel Body--%>
    </div><%--End Bus Panel--%>

    <%--Begin Create Inspection Panel--%>
    <asp:Panel ID="pnl_inspection" runat="server" class="panel panel-default" Visible="false">
        <%--<div class="panel panel-default">--%>
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
                            <asp:SqlDataSource ID="SqlDataSource_createdBy" runat="server" ConnectionString="<%$ ConnectionStrings:BSIAConnectionString%>" SelectCommand="SELECT created_by FROM Bus where bus_id = 400" DataSourceMode="DataReader"></asp:SqlDataSource>
                            <asp:TextBox class="form-control" Text='<%# Eval("created_by") %>' ID="txt_createdBy" runat="server" DataSourceID="SqlDataSource_createdBy"></asp:TextBox>
                        </div>
                    </div>
                    <%--Updated By--%>
                    <div class="col-sm-3">
                        <div class="form-group" style="grid-flow: columns">
                            <asp:Label ID="lbl_updatedBy" class="control-label" runat="server" Text="Updated By:" Style="font-weight: bold"></asp:Label>
                            <asp:TextBox class="form-control" ID="txt_updatedBy" runat="server" disabled></asp:TextBox>
                        </div>
                    </div>
                </div><%-- End Additional input fields - Odometer, TAG--%>



     <%--Begin Create Inspection Panel--%>
                <div class="row">
<%--    <div class="panel panel-default">
        <div class="panel-heading" style="font-size: 18px; font-weight: bold; background-color: cornflowerblue">Create Inspection</div>
        <div class="panel-body">--%>

        <%--Begin Group Panels--%>
        <asp:SqlDataSource ID="SqlDataSource_groups" runat="server" ConnectionString="<%$ ConnectionStrings:BSIAConnectionString%>"
            SelectCommand="SELECT [group_description], [group_id] FROM [InspectionGroup]" DataSourceMode="DataReader">

        </asp:SqlDataSource>
        <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource_groups">
            <ItemTemplate>
                <div class="container">
                    <div class="panel-group">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h4 class="panel-title">
                                    <a data-toggle="collapse" href="#collapse1"><strong><%# Eval("group_description") %></strong> <span class="badge" style="float: right">5</span></a>
                                </h4>
								        <asp:Label runat="server" ID="lbl_groupId" Text='<%# Eval("group_id") %>' Visible="False" />
                            </div>

                            <div> <%--Begin Repeater Items--%>
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
                                        <table class="table">
                                            <tr>
                                                <th style="width: 20%">Item</th>
                                                <th style="width: 10%">Result</th>
                                                <th style="width: 15%">Severity</th>
                                                <th style="width: 25%">Inspection Elements</th>
                                                <th style="width: 25%">Additional Comments</th>
                                            </tr>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <tr>
                                            <td bgcolor="#d9edf7"><asp:Label runat="server" ID="Label1" Text='<%# Eval("item_description") %>' /></td>
                                            <td bgcolor="#d9edf7" hidden><asp:Label runat="server" ID="lbl_elementsId" Text='<%# Eval("item_id") %>' /></td>
                                                        <asp:SqlDataSource
                                                    ConnectionString="<%$ ConnectionStrings:BSIAConnectionString %>" ID="SqlDataSource_elements" runat="server"
                                                    SelectCommand="SELECT element_description FROM InspectionDetail WHERE InspectionDetail.item_id = @item_elements" DataSourceMode="DataReader">
                                                    <SelectParameters>
                                                        <asp:ControlParameter ControlID="lbl_elementsId" Name="item_elements" Type="Int32" DefaultValue="0" />
                                                    </SelectParameters>
                                                </asp:SqlDataSource>
                                            <td bgcolor="#d9edf7"><asp:CheckBox ID="cb_fail_ballJoints_e" Text="&nbsp;Fail" runat="server" Style="color: indianred" /></td>
                                            <td bgcolor="#d9edf7">
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
                                            <td bgcolor="#d9edf7">
                                    
                                                <asp:Repeater ID="Repeater_elements" runat="server" DataSourceID="SqlDataSource_elements">
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="cb_elements" font-bold="false" name="item_elements" DataSourceID="SqlDataSource_elements" Text='<%# Eval("element_description") %>' runat="server" />
                                                    </ItemTemplate>
                                                </asp:Repeater>
                                            </td>
                                            <td bgcolor="#d9edf7"><asp:TextBox class="form-control" ID="txt_comments_ballJoints_e" placeholder="Additional Comments..." runat="server"></asp:TextBox></td>
                                        </tr>
                                    </ItemTemplate>

                                    <AlternatingItemTemplate>
                                        <tr>
                                            <td><asp:Label runat="server" ID="Label1" Text='<%# Eval("item_description") %>' />
                                            <td hidden><asp:Label runat="server" ID="lbl_id" Text='<%# Eval("item_id") %>' /></td>
                                            <td><asp:CheckBox ID="cb_fail_ballJoints_e" Text="&nbsp;Fail" runat="server" Style="color: indianred" /></td>
                                            <td>
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
                                            <td>
                                                <asp:SqlDataSource
                                                    ConnectionString="<%$ ConnectionStrings:BSIAConnectionString %>" ID="SqlDataSource_elements" runat="server"
                                                    SelectCommand="SELECT element_description FROM InspectionDetail WHERE InspectionDetail.item_id = @item_elements" DataSourceMode="DataReader">
                                                    <SelectParameters>
                                                        <asp:ControlParameter ControlID="lbl_id" Name="item_elements" Type="Int32" DefaultValue="0" />
                                                    </SelectParameters>
                                                </asp:SqlDataSource>
                                                <asp:Repeater ID="Repeater_elements" runat="server" DataSourceID="SqlDataSource_elements">
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="cb_elements" name="item_elements" DataSourceID="SqlDataSource_elements" Text='<%# Eval("element_description") %>' runat="server" />
                                                    </ItemTemplate>
                                                </asp:Repeater>
                                            </td>
                                            <td><asp:TextBox class="form-control" ID="txt_comments_ballJoints_e" placeholder="Additional Comments..." runat="server"></asp:TextBox></td>
                                        </tr>
                                    </AlternatingItemTemplate>

                                    <FooterTemplate>
                                        </table>
                                    </FooterTemplate>
                                </asp:Repeater>
                            </div> <%--End Repeater Items--%>


                        </div>
                    </div>
                </div>

            </ItemTemplate>
        </asp:Repeater>
        <%--End Group Panels--%>



       <%-- </div>End Create Inspection Panel Body--%>
    <%--</div>End Create Inspection Panel--%>


                <%--Begin Notes Section --%>
                <div class="container">
                    <div class="form-group">
                        <asp:Label ID="lbl_notes" class="control-label" runat="server" Text="Notes:" Style="font-weight: bold"></asp:Label>
                        <textarea class="form-control" rows="3" id="ta_notes" runat="server"></textarea>
                    </div>
                </div>
                <%--End Notes Section--%>

                <%--Begin Acknowledgement Panel--%>
                <asp:Table ID="Table1" class="table" runat="server" DataSourceID="SqlDataSource_sig">
                    <asp:TableHeaderRow >
                        <asp:TableHeaderCell ColumnSpan="2" BackColor="#c4e7f8" ForeColor="Black">Acknowledgement</asp:TableHeaderCell>
                    </asp:TableHeaderRow>
                    <asp:TableRow>
                        <asp:TableCell>
                            <asp:CheckBox ID="CheckBox1" type="checkbox" name="cb_agree" Text="&nbsp;Inspection results have been reviewed with the Contractor." data-error="Must acknowledge before digitally signing form." runat="server" />
                                <div class="help-block with-errors"></div>
                        </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                        <asp:TableCell>
                            <asp:Label ID="lbl_sig" DataSourceID="SqlDataSource_sig" class="control-label" runat="server" Text='<%# Eval("model_year") %>' Style="font-weight: bold"></asp:Label>
                            <asp:SqlDataSource ID="SqlDataSource_sig" runat="server" ConnectionString="<%$ ConnectionStrings:BSIAConnectionString%>"
                                SelectCommand="SELECT model_year FROM Bus" DataSourceMode="DataReader"></asp:SqlDataSource>
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table><%--End Acknowledgement Panel--%>

                <%--Submit Bus Inspected Information--%>
                <div class="col-sm-3" style="margin-top:20px">
                     <asp:Button ID="btn_createInspection" class="btn btn-primary" type="submit" runat="server" Text="Submit Create Inspection" Width="200px" />
                </div>

            </div><%--End Create Inspection Panel Body--%>
        <%--</div>--%><%--End Create Inspection Div--%>
    </asp:Panel><%--End Create Inspection Panel--%>

    
</asp:Content>
