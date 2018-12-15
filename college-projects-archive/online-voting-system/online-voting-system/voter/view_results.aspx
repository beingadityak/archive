<%@ Page Title="" Language="C#" MasterPageFile="~/voter/voter_home.Master" AutoEventWireup="true" CodeBehind="view_results.aspx.cs" Inherits="online_voting_system.voter.view_results" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Online Voting System - View Results</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="form1" runat="server">
        <div class="container-fluid">
            <h1 class="jumbotron">View Results</h1>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Online-Voting-SystemConnectionString %>" SelectCommand="select winner.max_votes,winner.O_Id,winner.C_Id,winner.E_Id,org.Name as OrgName,can.Name as CanName,ele.E_Name as EleName,ele.vote_date from election_winner as winner inner join org_table as org on org.O_Id = winner.O_Id inner join Candidate_Reg as can on can.C_Id = winner.C_Id inner join election as ele on ele.E_Id = winner.E_Id"></asp:SqlDataSource>
            <asp:GridView EmptyDataText="No Results Yet !" CssClass="table table-hover table-bordered" ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1">
                <Columns>
                    <asp:BoundField DataField="max_votes" HeaderText="Winning Votes" SortExpression="max_votes" />
                    <asp:BoundField DataField="OrgName" HeaderText="Winner Organization Name" SortExpression="OrgName" />
                    <asp:BoundField DataField="CanName" HeaderText="Winner Candidate Name" SortExpression="CanName" />
                    <asp:BoundField DataField="EleName" HeaderText="Election Name" SortExpression="EleName" />
                    <asp:BoundField DataField="vote_date" HeaderText="Election Date" SortExpression="vote_date" />
                </Columns>
            </asp:GridView>
        </div>
    </form>
</asp:Content>
