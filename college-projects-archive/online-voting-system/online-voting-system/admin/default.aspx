<%@ Page Title="" Language="C#" MasterPageFile="~/admin/admin_panel.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="online_voting_system.admin.WebForm1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
            <h1>Admin Panel Login</h1>
            <form class="form-horizontal jumbotron col-sm-8" method="post" runat="server">
                <div class="form-group">
                <label class="control-label col-sm-2" for="username">Username:</label>
                <div class="col-sm-6">
                    <asp:TextBox ID="username" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
                <asp:RequiredFieldValidator ID="username_required" runat="server" ControlToValidate="username" Text="*" ForeColor="Red" ErrorMessage="Please Enter Username"/>
              </div>

              <div class="form-group">
                <label class="control-label col-sm-2" for="pwd">Password:</label>
                <div class="col-sm-6"> 
                  <asp:TextBox ID="pwd" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                </div>
                  <asp:RequiredFieldValidator ID="password_required" runat="server" ControlToValidate="pwd" Text="*" ForeColor="Red" ErrorMessage="Please Enter Password"/>
              </div>
              <div class="form-group"> 
                <div class="col-sm-offset-2 col-sm-10">
                    <asp:Button ID="login_btn" runat="server" Text="Login" CssClass="btn btn-primary" OnClick="login_btn_Click" CausesValidation="true"/>
                </div>
              </div>
            <div class="form-group">
                <div class="col-sm-8">
                    <asp:ValidationSummary ID="login_err_sum" CssClass="alert alert-danger" runat="server" />
                </div>
            </div>
                <div class="form-group">
                    <div class="col-sm-8">
                        <asp:Label ID="err_msg" runat="server" CssClass="alert alert-danger" Visible="false" />
                    </div>
                </div>
            </form>
    </div>
</asp:Content>
