<%@ Page Title="" Language="C#" MasterPageFile="~/voter/voter_home.Master" AutoEventWireup="true" CodeBehind="vote.aspx.cs" Inherits="online_voting_system.voter.vote" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Online Voting System - Vote</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="form1" runat="server" class="form-horizontal">
        <div class="container-fluid">
            <div class="jumbotron">
                <h1>Select Election</h1>
            </div>
                <asp:GridView ID="GridView1" EmptyDataText="No Elections open !" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1">
                    <Columns>
                        <asp:BoundField DataField="E_Name" HeaderText="Election Name" SortExpression="E_Name" />
                        <asp:TemplateField ShowHeader="false">
                            <ItemTemplate>
                                <asp:Button ID="vote_btn" runat="server" Text="Start Voting" CssClass="btn btn-primary" CommandName="VoteBtn" OnCommand="vote_btn_Command" CommandArgument='<%# Eval("E_Id") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Online-Voting-SystemConnectionString %>" SelectCommand="SELECT [E_Id],[E_Name] FROM [election] WHERE ([active] = @active) AND vote_date = cast(GETDATE() as date)">
                    <SelectParameters>
                        <asp:Parameter DefaultValue="yes" Name="active" Type="String" />
                        <asp:SessionParameter DefaultValue="" Name="username" SessionField="username" />
                    </SelectParameters>
                </asp:SqlDataSource>
        </div>
    </form>
</asp:Content>
