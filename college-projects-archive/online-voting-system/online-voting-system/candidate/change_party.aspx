<%@ Page Title="" Language="C#" MasterPageFile="~/candidate/candidate_home.Master" AutoEventWireup="true" CodeBehind="change_party.aspx.cs" Inherits="online_voting_system.candidate.change_party" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Online Voting System - Change Organization</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="form1" runat="server" method="post" class="form-horizontal">
        <div class="container-fluid">
            <div class="jumbotron">
                <h1>Change your Organization</h1>
            </div>
                <div class="form-group">
                    <label class="control-label col-sm-2" for="party_list">Organization Name (where you want to go) : </label>
                    <div class="col-sm-6">
                        <asp:DropDownList CssClass ="form-control" ID="party_list" runat="server" DataSourceID="SqlDataSource1" DataTextField="Name" DataValueField="Name" />
                    </div>
                </div>
                <div class="form-group"> 
                    <div class="col-sm-offset-2 col-sm-10">
                        <asp:Button ID="change_btn" runat="server" Text="Change Organization" CssClass="btn btn-primary" OnClick="change_btn_click" CausesValidation="true"/>
                    </div>
                </div>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Online-Voting-SystemConnectionString %>" SelectCommand="SELECT [Name] FROM [org_table]" />
        </div>
    </form>
</asp:Content>
