<%@ Page Title="" Language="C#" MasterPageFile="~/candidate/candidate_home.Master" AutoEventWireup="true" CodeBehind="home.aspx.cs" Inherits="online_voting_system.candidate.home" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="form1" runat="server">
    <div class ="container-fluid">
        <h1 class="jumbotron" style="text-align:center;">Welcome, <asp:Label ID="user_name_lbl" runat="server"></asp:Label></h1>
        
        <p>
            <asp:FormView ID="FormView1" runat="server" CssClass="table table-bordered" DataSourceID="SqlDataSource1">
                <ItemTemplate>
                    <table class="table table-hover table-striped table-bordered">
                        <tr>
                            <td>Candidate Name : </td>
                            <td><asp:Label ID="NameLabel" runat="server" Text='<%# Bind("Name") %>' /></td>
                        </tr>
                        <tr>
                            <td>Username : </td>
                            <td><asp:Label ID="User_NameLabel" runat="server" Text='<%# Bind("User_Name") %>' /></td>
                        </tr>
                        <tr>
                            <td>Picture : </td>
                            <td><asp:Image ID="C_IdLabel" runat="server" ImageUrl='<%# "showCanImage.ashx?id="+ Eval("C_Id")  %>' Height="200" Width="200" BackColor="Gray"/></td>
                        </tr>
                    </table>
                    <br />
                </ItemTemplate>
            </asp:FormView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Online-Voting-SystemConnectionString %>" SelectCommand="SELECT [Name], [C_Id], [User_Name] FROM [Candidate_Reg] WHERE ([User_Name] = @User_Name)">
                <SelectParameters>
                    <asp:SessionParameter Name="User_Name" SessionField="username" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
        </p>

    </div>
    </form>
</asp:Content>
