<%@ Page Title="" Language="C#" MasterPageFile="~/voter/voter_home.Master" AutoEventWireup="true" CodeBehind="vote_action.aspx.cs" Inherits="online_voting_system.voter.vote_action" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Online Voting System - Vote</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="form1" runat="server" class="form-horizontal">
        <div class="container-fluid">
            <div class="jumbotron">
                <h1>Vote Your Person</h1>
            </div>
            <p>

                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1">
                    <Columns>
                        <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                        <asp:BoundField DataField="Name1" HeaderText="Organization" SortExpression="Name1" />
                        <asp:TemplateField ShowHeader="true" HeaderText="Candidate Image">
                            <ItemTemplate>
                                <asp:Image ID="C_IdLabel" runat="server" ImageUrl='<%# "showCanImage.ashx?id="+ Eval("C_Id")  %>' Height="200" Width="200" BackColor="Blue" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField ShowHeader="true" HeaderText="Action">
                            <ItemTemplate>
                                <asp:Button ID="vote_can_btn" CssClass="btn btn-success" Text="Vote" runat="server" CommandName="VoteCanBtn" CommandArgument='<%# Eval("C_Id")+","+ Eval("O_Id")+","+Eval("E_Id") %>' OnCommand="vote_can_btn_Command" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Online-Voting-SystemConnectionString %>" SelectCommand="SELECT Candidate.C_Id, Candidate.E_Id, Organization.O_Id, Candidate.Name, Candidate.Image,Organization.Name FROM Candidate_Reg Candidate INNER JOIN org_table Organization on Candidate.O_Id = Organization.O_Id WHERE Candidate.E_Id = @E_Id">
                    <SelectParameters>
                        <asp:QueryStringParameter Name="E_Id" QueryStringField="eid" />
                    </SelectParameters>
                </asp:SqlDataSource>

            </p>
        </div>
    </form>
</asp:Content>
