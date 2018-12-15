<%@ Page Title="" Language="C#" MasterPageFile="~/voter/voter_home.Master" AutoEventWireup="true" CodeBehind="update_profile.aspx.cs" Inherits="online_voting_system.voter.update_profile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Online Voting System - Update Profile</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <form runat="server">
            <asp:FormView ID="FormView1" runat="server" CssClass="table table-bordered table-hover table-responsive" CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="#333333">
                <EditItemTemplate>
                    <div class="form-group">
                    <table>
                        <tr>
                            <td>City : </td>
                            <td>
                                <asp:TextBox ID="cityTextBox" runat="server" Text='<%# Bind("city") %>' CssClass="form-control" />
                                <asp:RequiredFieldValidator ID="cityTextBoxReqd" runat="server" ControlToValidate="cityTextBox" Text="*" ForeColor="Red"/>
                            </td>
                        </tr>
                        <tr>
                            <td>Username : </td>
                            <td>
                                <asp:TextBox ID="usernameTextBox" runat="server" Text='<%# Bind("username") %>' CssClass="form-control"/>
                                <asp:RequiredFieldValidator ID="usernameTextBoxReqd" runat="server" ControlToValidate="usernameTextBox" Text="*" ForeColor="Red"/>
                            </td>
                        </tr>
                        <tr>
                            <td><asp:Button CssClass="btn btn-primary" ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" /></td>
                            <td><asp:Button CssClass="btn btn-primary" ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel"/></td>
                        </tr>
                    </table>
                    </div>
                </EditItemTemplate>
                <EditRowStyle BackColor="#99ccff" />
                <FooterStyle BackColor="#99ccff" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#99ccff" Font-Bold="True" ForeColor="White" />
                <ItemTemplate>
                    <table class="table table-hover table-bordered table-responsive table-striped">
                        <tr>
                            <td>City :</td>
                            <td><asp:Label ID="cityLabel" runat="server" Text='<%# Bind("city") %>' /></td>
                        </tr>
                        <tr>
                            <td>Username :</td>
                            <td><asp:Label ID="usernameLabel" runat="server" Text='<%# Bind("username") %>' /></td>
                        </tr>
                        <tr>
                            <td>Profile Photo :</td>
                            <td><asp:Image ID="imageLabel" BackColor="Blue" runat="server" Height="200" Width="200" ImageUrl ='<%# "showImage.ashx?id="+ Eval("V_Id")  %>'/></td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Button CssClass="btn btn-primary" ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" />
                            </td>
                            <td>
                                <asp:Button CssClass="btn btn-primary" ID="change_image" runat="server" OnClick="change_image_Click" Text="Change Profile Picture" />
                            </td>
                        </tr>
                    </table>
                </ItemTemplate>
                <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#EFF3FB" />
            </asp:FormView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Online-Voting-SystemConnectionString %>" SelectCommand="SELECT [V_Id], [city], [username], [image] FROM [voter_reg] WHERE ([username] = @username)" UpdateCommand="UPDATE voter_reg SET city = @city, username = @username WHERE (username = @username)">
                <SelectParameters>
                    <asp:SessionParameter Name="username" SessionField="username" Type="String" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="city" />
                    <asp:Parameter Name="username" />
                </UpdateParameters>
            </asp:SqlDataSource>
        </form>
    </div>
</asp:Content>
