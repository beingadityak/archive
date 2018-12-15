<%@ Page Title="" Language="C#" MasterPageFile="~/admin/admin_panel_home.Master" AutoEventWireup="true" CodeBehind="count_results.aspx.cs" Inherits="online_voting_system.admin.count_results" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Online Voting System - Count Results</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="form1" runat="server">
        <div class="container-fluid">
            <div class="jumbotron">
                <h1>Count Votes</h1>
            </div>
            <p>
                <asp:GridView ID="GridView1" EmptyDataText="No Elections Found !" CssClass="table table-hover table-bordered" runat="server" AutoGenerateColumns="False" DataKeyNames="E_Id" DataSourceID="SqlDataSource1">
                    <Columns>
                        <asp:BoundField DataField="vote_date" HeaderText="Date Of Election" SortExpression="vote_date" />
                        <asp:BoundField DataField="votes" HeaderText="Vote Count" SortExpression="votes" />
                        <asp:BoundField DataField="E_Name" HeaderText="Election Name" SortExpression="E_Name" />
                        <asp:TemplateField ShowHeader="false">
                            <ItemTemplate>
                                <asp:Button Text="Generate Results" CssClass="btn btn-info" ID="gen_results_btn" runat="server" CommandName="GenResultsBtn" CommandArgument='<%# Eval("E_Id") %>' OnCommand="gen_results_btn_Command" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Online-Voting-SystemConnectionString %>" SelectCommand="SELECT [E_Id], [vote_date], [votes], [active], [over], [E_Name] FROM [election] WHERE ([over] = @over) AND [active] = @active">
                    <SelectParameters>
                        <asp:Parameter DefaultValue="yes" Name="over" Type="String" />
                        <asp:Parameter DefaultValue="no" Name="active" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>

            </p>
        </div>
    </form>
</asp:Content>
