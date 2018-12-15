<%@ Page Title="" Language="C#" MasterPageFile="~/admin/admin_panel_home.Master" AutoEventWireup="true" CodeBehind="view_active_elections.aspx.cs" Inherits="online_voting_system.admin.view_active_elections" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Online Voting System - View Active Elections</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="form1" runat="server" method="post">
        <div class="container-fluid">
            <h1 class="jumbotron">View Active Elections</h1>
        </div>
        <p>
            <asp:GridView ID="GridView1" EmptyDataText="No Active Elections found !" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" CssClass="table table-bordered table-responsive table-condensed">
                <Columns>
                    <asp:BoundField DataField="vote_date" HeaderText="Date Of Election" SortExpression="vote_date" />
                    <asp:BoundField DataField="E_Name" HeaderText="Election Name" SortExpression="E_Name" />
                    <asp:BoundField DataField="votes" HeaderText="Total Votes" SortExpression="votes" />
                    <asp:BoundField DataField="result_generated" HeaderText="Is Result generated ?" SortExpression="result_generated" />
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Button ID="stop_elec_btn" runat="server" CommandName="StopElecBtn" CommandArgument='<%# Eval("E_Id") %>' OnCommand="stop_elec_btn_Command" Text="Stop Election" CssClass="btn btn-warning" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Online-Voting-SystemConnectionString %>" SelectCommand="SELECT [E_Id],[vote_date], [votes], [result_generated], [E_Name] FROM [election] WHERE ([active] = @active AND [over] = @over AND [result_generated] = @result_generated)">
                <SelectParameters>
                    <asp:Parameter DefaultValue="yes" Name="active" Type="String" />
                    <asp:Parameter DefaultValue="no" Name="over" Type="String" />
                    <asp:Parameter DefaultValue="no" Name="result_generated" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
        </p>
    </form>
</asp:Content>
