<%@ Page Title="" Language="C#" MasterPageFile="~/voter/voter_home.Master" AutoEventWireup="true" CodeBehind="home.aspx.cs" Inherits="online_voting_system.voter.home" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Online Voting System - Voter Home</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <form runat="server">
            <h1 class="jumbotron" style="text-align:center;">Welcome, <asp:Label ID="user_name" runat="server"></asp:Label></h1>
            <div>
                <span>
                    <asp:FormView ID="FormView1" runat="server" CssClass="table table-bordered" DataSourceID="ProfileDataSource">
                    <ItemTemplate>
                        <table class="table table-hover table-striped table-bordered">
                            <tr>
                                <td>Voter Name : </td>
                                <td><asp:Label ID="nameLabel" runat="server" Text='<%# Bind("name") %>' /></td>
                            </tr>
                            <tr>
                                <td>Voter City : </td>
                                <td><asp:Label ID="cityLabel" runat="server" Text='<%# Bind("city") %>' /></td>
                            </tr>
                            <tr>
                                <td>Username : </td>
                                <td><asp:Label ID="usernameLabel" runat="server" Text='<%# Bind("username") %>' /></td>
                            </tr>
                            <tr>
                                <td> Profile Picture : </td>
                                <td><asp:Image ID="V_IdLabel" runat="server" ImageUrl='<%# "showImage.ashx?id="+ Eval("V_Id")  %>' Height="200" Width="200" BackColor="Blue"/></td>
                            </tr>
                        </table>
                    </ItemTemplate>
                </asp:FormView>
                </span>
            </div>
            <asp:SqlDataSource ID="ProfileDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:Online-Voting-SystemConnectionString %>" SelectCommand="SELECT [V_Id], [name], [city], [username] FROM [voter_reg] WHERE ([username] = @username)">
                <SelectParameters>
                    <asp:SessionParameter DefaultValue="" Name="username" SessionField="username" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
        </form>
    </div>
</asp:Content>
