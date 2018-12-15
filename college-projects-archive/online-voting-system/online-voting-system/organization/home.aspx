<%@ Page Title="" Language="C#" MasterPageFile="~/organization/org_home.Master" AutoEventWireup="true" CodeBehind="home.aspx.cs" Inherits="online_voting_system.organization.home" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Online Voting System - Organization Home</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
    <form runat="server">
        <asp:Label ID="msg_lbl" runat="server" CssClass="alert alert-info" Visible="false" />
        <div class="jumbotron">
            <h2>Homepage - Online Voting System Organization Panel</h2>
        </div>
        <p>

            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Online-Voting-SystemConnectionString %>" SelectCommand="SELECT c.Name, c.C_Id, c.Votes,ele.vote_date, org.Name, ele.E_Name FROM Candidate_Reg c inner join org_table org on org.O_Id = c.E_Id inner join election ele on ele.E_Id = c.E_Id where ele.active = 'yes' AND org.User_Name = @username">
                <SelectParameters>
                    <asp:SessionParameter Name="username" SessionField="username" />
                </SelectParameters>
            </asp:SqlDataSource>
        </p>
        <p>

            <asp:GridView EmptyDataText="No Candidates Currently Active in any election !" CssClass ="table table-hover table-bordered" ID="GridView1" runat="server" DataSourceID="SqlDataSource1" AutoGenerateColumns="False" DataKeyNames="C_Id">
                <Columns>
                    <asp:BoundField DataField="Name" HeaderText="Candidate Name" SortExpression="Name" />
                    <asp:BoundField DataField="E_Name" HeaderText="Busy with Election" SortExpression="E_Name" />
                    <asp:BoundField DataField="Name1" HeaderText="Organization Name" SortExpression="Name1" />
                    <asp:BoundField DataField="Votes" HeaderText="Total Votes" SortExpression="Votes" />
                    <asp:BoundField DataField="vote_date" HeaderText="Date Of Election" SortExpression="vote_date" />
                    <asp:TemplateField ShowHeader="true" HeaderText="Candidate Image">
                        <ItemTemplate>
                            <asp:Image ID="C_IdLabel" runat="server" ImageUrl='<%# "getCanImage.ashx?id="+ Eval("C_Id")  %>' Height="200" Width="200" BackColor="Blue" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </p>
    </form>
</div>
</asp:Content>
