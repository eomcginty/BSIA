<%@ Page Title="Edit" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Edit.aspx.cs" Inherits="BSIA.Edit" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Edit Inspection</h2>

    <asp:Panel ID="pnl_success" runat="server" Visible="false">
        <!-- Trigger the modal with a button -->
        <%--<button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#myModal">Open Modal</button>--%>

        <!-- Modal Success Message-->
        <div id="modal_success_repair" role="dialog" class="modal in">
            <div class="modal-dialog" style="margin-top: 100px">
                <div class="modal-content">
                    <div class="modal-header label-success">
                        <h4 class="modal-title">Repair Successfully Updated!</h4>
                    </div>
                    <div class="modal-body">
                        <p class="text-success">All items have been repaired, this inspection will be updated to PASS.</p>
                        <p class="text-success">Choose from the following selections.</p>
                        <a href="Default.aspx" class="btn btn-success"><span aria-hidden="true" class="glyphicon glyphicon-home"></span>Go to Home Page</a>
                        <a href="Reports.aspx" class="btn btn-success">View Bus Report</a>
                        <a href="Edit.aspx" class="btn btn-success">Edit Inspection</a>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
    </asp:Panel>

    <!-- Modal Error Message-->
    <asp:Panel ID="pnl_error" runat="server" Visible="false">
        <div id="modal_error_repair" role="dialog" class="modal in">
            <div class="modal-dialog" style="margin-top: 100px">
                <div class="modal-content">
                    <div class="modal-header label-danger">
                        <h4 class="modal-title" style="color: #ffffff">Repair Inspection Error!</h4>
                        <%--<asp:Label ID="lbl_err" runat="server" Text=""</asp:Label>--%>
                    </div>
                    <div class="modal-body">
                        <p class="text-danger">Repairs are still pending for this inspection.</p>
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
                        <asp:Label ID="lbl_bus" class="control-label" runat="server" Text="Bus:" Style="font-weight: bold"></asp:Label>
                        <asp:SqlDataSource ID="SqlDataSource_bus" runat="server" ConnectionString="<%$ ConnectionStrings:BSIAConnectionString%>"
                            SelectCommand="SELECT [bus_id] FROM [Bus]" DataSourceMode="DataReader"></asp:SqlDataSource>
                        <asp:DropDownList class="form-control" ID="ddl_bus" Style="max-width: 300px" runat="server"
                            DataSourceID="SqlDataSource_bus" DataTextField="bus_id" DataValueField="bus_id" AppendDataBoundItems="True">
                            <asp:ListItem>Select Bus from list</asp:ListItem>
                        </asp:DropDownList>
                        <asp:CompareValidator Style="color: #b94a48" ID="CompareValidator_bus" runat="server" ErrorMessage="Select a Bus!"
                            Operator="NotEqual" ValueToCompare="Select Bus from list" ControlToValidate="ddl_bus">
                            &nbsp;Please select a Bus!
                        </asp:CompareValidator>
                    </div>
                </div>
                <%--Season DropDownList--%>
                <div class="col-sm-3">
                    <div class="form-group">
                        <asp:Label ID="lbl_season" class="control-label" runat="server" Text="Season:" Style="font-weight: bold"></asp:Label>
                        <asp:SqlDataSource ID="SqlDataSource_season" runat="server" ConnectionString="<%$ ConnectionStrings:BSIAConnectionString%>"
                            SelectCommand="SELECT [season_id], [season_name] FROM [Season]" DataSourceMode="DataReader"></asp:SqlDataSource>
                        <asp:DropDownList class="form-control" ID="ddl_season" Style="max-width: 300px" runat="server"
                            DataSourceID="SqlDataSource_season" DataTextField="season_name" DataValueField="season_id" AppendDataBoundItems="True">
                            <asp:ListItem>Select Season from list</asp:ListItem>
                        </asp:DropDownList>
                        <asp:CompareValidator Style="color: #b94a48" ID="CompareValidator_season" runat="server" ErrorMessage="Select a Season!"
                            Operator="NotEqual" ValueToCompare="Select Season from list" ControlToValidate="ddl_season">
                            &nbsp;Please select a Season!
                        </asp:CompareValidator>
                    </div>
                    <asp:Label ID="lbl_message" runat="server" Text="Season Message" Visible="false" Style="color: red; font-size: large"></asp:Label>
                </div>

                <%--Submit Bus Information for Display Table--%>
                <div class="col-sm-3" style="margin-top:20px">
                     <asp:Button ID="btn_getBus" class="btn btn-primary active" type="submit" runat="server" Text="Get Bus Information" OnClick="btn_getBus_Click" />
                </div>
            </div>
            <%--End Bus Selection Row--%>


            <%--Begin Panel to Display Populated Table, and Verify Row--%>
            <div id="rowDisplay_busInfo" class="row" style="display: block">
                <asp:Panel ID="pnl_bus" runat="server" class="col-sm-12" Visible="false">
                    <div class="alert alert-info fade in" style="display: none">
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
                                    <th style="width: 10%; background-color: #c4e7f8">Odometer</th>
                                    <th style="width: 10%; background-color: #c4e7f8">TAG</th>
                                    <th style="width: 15%; background-color: #c4e7f8">VIN</th>
                                    <th style="width: 10%; background-color: #c4e7f8">Model</th>
                                    <th style="width: 10%; background-color: #c4e7f8">Chassis</th>
                                    <th style="width: 10%; background-color: #c4e7f8">Body</th>
                                    <th style="width: 15%; background-color: #c4e7f8">Edit Inspection</th>
                                </tr>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tbody>
                                <tr> <%--TODO ADD Odometer and TAG in SQL--%>
                                    <td style="background-color: #f9f9f9"><asp:Label runat="server" ID="lbl_ctrName" Text='<%# Eval("company_name") %>' /></td>
                                    <td style="background-color: #f9f9f9"><asp:Label runat="server" ID="lbl_odometer" Text="15348" /></td>
                                    <td style="background-color: #f9f9f9"><asp:Label runat="server" ID="lbl_tag" Text="A123GH" /></td>
                                    <td style="background-color: #f9f9f9"><asp:Label runat="server" ID="lbl_vin" Text='<%# Eval("vin") %>' /></td>
                                    <td style="background-color: #f9f9f9"><asp:Label runat="server" ID="lbl_model" Text='<%# Eval("model_year") %>' /></td>
                                    <td style="background-color: #f9f9f9"><asp:Label runat="server" ID="lbl_chassis" Text='<%# Eval("chassis_description") %>' /></td>
                                    <td style="background-color: #f9f9f9"><asp:Label runat="server" ID="lbl_body" Text='<%# Eval("body_description") %>' /></td>
                                    <td>
                                        <asp:Button ID="btn_edit_inspection" OnClick="btn_edit_inspection_Click" runat="server" Text="Edit"></asp:Button>
                                        <asp:Button ID="btn_delete_inspection" OnClick="btn_delete_inspection_Click" runat="server" Text="Delete"></asp:Button>
                                    </td>
                                </tr>
                            </tbody>
                        </ItemTemplate>
                        <FooterTemplate>
                            </tbody></table>
                        </FooterTemplate>
                    </asp:Repeater> <%--End Bus Information Repeater--%>
                </asp:Panel>
            </div><%--End Panel to Display Populated Table, and Verify Row--%>
        </div><%--End Bus Panel Body--%>
    </div><%--End Bus Panel--%>
    
    
<%--    <asp:Panel ID="pnl_repairs" runat="server" class="panel panel-default" Visible="false">--%>
    <asp:UpdatePanel ID="upd_pnl_repairs" runat="server" class="panel panel-default" Visible="false" UpdateMode="Conditional">
        <ContentTemplate>
        <div class="panel-heading" style="font-size: 18px; font-weight: bold; background-color: cornflowerblue">Repairs</div>
        <div class="panel-body">

            <%--Begin Repeater Items--%>
            <%--<asp:Label runat="server" ID="lbl_itemsId" Text='<%# Eval("group_id") %>' Visible="False" />--%>
            <asp:SqlDataSource
                ConnectionString="<%$ ConnectionStrings:BSIAConnectionString %>" ID="SqlDataSource_repairs" runat="server"
                SelectCommand="SELECT InspectionFailures.notes, InspectionItem.item_description, Severity.severity_description, Inspections.inspection_id, InspectionFailures.element_id FROM InspectionFailures INNER JOIN Severity ON InspectionFailures.severity_id = Severity.severity_id INNER JOIN InspectionDetail ON InspectionFailures.element_id = InspectionDetail.element_id INNER JOIN InspectionItem ON InspectionDetail.item_id = InspectionItem.item_id INNER JOIN Inspections ON InspectionFailures.inspection_id = Inspections.inspection_id WHERE (Inspections.bus_id = @bus_id AND Inspections.season_id = @season_id AND repaired_date IS NULL)" DataSourceMode="DataReader">
                <SelectParameters>
                    <asp:Parameter ConvertEmptyStringToNull="false" Name="dbnull" DefaultValue="" />
                    <asp:ControlParameter ControlID="ddl_bus" Name="bus_id" Type="Int32" DefaultValue="0" />
                    <asp:ControlParameter ControlID="ddl_season"  PropertyName="SelectedIndex" Name="season_id" Type="Int32" DefaultValue="0" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:Repeater ID="Repeater_repairs" runat="server" DataSourceID="SqlDataSource_repairs">
                <HeaderTemplate>
                    <table class="table table-striped">
                        <tr>
                            <th style="width: 25%; background-color: #c4e7f8">Item</th>
                            <th style="width: 15%; background-color: #c4e7f8">Severity</th>
                            <th style="width: 30%; background-color: #c4e7f8">Notes</th>
                            <th style="width: 20%; background-color: #c4e7f8">Repair Date</th>                       
                        </tr>
                </HeaderTemplate>
                <ItemTemplate>
                    <tbody>
                        <tr>
                            <td style="background-color: #f9f9f9"><asp:Label runat="server" ID="lbl_description" Text='<%# Eval("Item_description") %>' /></td>
                            <td style="background-color: #f9f9f9"><asp:Label runat="server" ID="lbl_severity" Text='<%# Eval("severity_description") %>' /></td>
                            <td style="background-color: #f9f9f9"><asp:TextBox class="form-control" ID="txt_notes" runat="server" Text='<%# Eval("notes") %>'></asp:TextBox></td>
                            <td style="background-color: #f9f9f9"><asp:TextBox Visible="false" class="form-control" ID="txt_inspection_id" runat="server" Text='<%# Eval("inspection_id") %>'></asp:TextBox>                                                     
                                <asp:TextBox Visible="false" class="form-control" ID="txt_element_id" runat="server" Text='<%# Eval("element_id") %>'></asp:TextBox>
                                <asp:TextBox class="form-control" ID="txt_repairDate" runat="server" />
                            </td>

                                <%--Inspection Date Calendar
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
                                </div>--%>

                            </td>
                        </tr>
                </ItemTemplate>

                <%--                    <AlternatingItemTemplate>
                        <tr>
                            <td style="background-color:#ffffff"><asp:Label runat="server" ID="Label1" Text='<%# Eval("item_description") %>' />
                            <td hidden><asp:Label runat="server" ID="lbl_elementsId" Text='<%# Eval("item_id") %>' /></td>
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
                                <asp:SqlDataSource
                                    ConnectionString="<%$ ConnectionStrings:BSIAConnectionString %>" ID="SqlDataSource_elements" runat="server"
                                    SelectCommand="SELECT element_description FROM InspectionDetail WHERE InspectionDetail.item_id = @item_elements" DataSourceMode="DataReader">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="lbl_elementsId" Name="item_elements" Type="Int32" DefaultValue="0" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                <asp:Repeater ID="Repeater_elements" runat="server" DataSourceID="SqlDataSource_elements">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="cb_elements" name="item_elements" DataSourceID="SqlDataSource_elements" Text='<%# Eval("element_description") %>' runat="server" />
                                    </ItemTemplate>
                                </asp:Repeater>
                            </td>
                            <td style="background-color:#ffffff"><asp:TextBox class="form-control" ID="txt_comments" placeholder="Additional Comments..." runat="server"></asp:TextBox></td>
                        </tr>
                    </AlternatingItemTemplate>--%>

                <FooterTemplate>
                    </tbody> </table>
                </FooterTemplate>
            </asp:Repeater><%--End Repeater Items--%>   
            <asp:Button ID="btn_repair_update" OnClick="btn_repair_update_Click" runat ="server" Text="Update Repair" />
        </div><%--End Repair Panel Body--%>  
 </ContentTemplate> 
    </asp:UpdatePanel><%--End Repair Panel--%>
<%--               </asp:Panel><%--End Repair Panel--%>   



</asp:Content>
