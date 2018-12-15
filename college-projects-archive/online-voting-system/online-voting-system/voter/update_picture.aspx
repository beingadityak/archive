<%@ Page Title="" Language="C#" MasterPageFile="~/voter/voter_home.Master" AutoEventWireup="true" CodeBehind="update_picture.aspx.cs" Inherits="online_voting_system.voter.update_picture" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Online Voting System - Update Profile Picture</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <form runat="server">
            <div class="col-sm-6">
                <asp:FileUpload ID="img_upload" runat="server" CssClass="form-control"/>
                <asp:RequiredFieldValidator ID="img_upload_req" ForeColor="Red" runat="server" ControlToValidate="img_upload" Text="*" />
                <asp:Button ID="upload_btn" Text="Upload" runat="server" CausesValidation="true" CssClass="btn btn-primary" OnClick="upload_btn_Click" />
                <asp:Button ID="cancel_btn" Text="Cancel" runat="server" CssClass="btn btn-primary" CausesValidation="false" OnClick="cancel_btn_Click" />
            </div>
            <br />
            <div class="col-sm-6">
                <asp:Label ID="msg_lbl" runat="server" Visible="false" CssClass="alert alert-danger" />
            </div>
        </form>
    </div>
</asp:Content>
