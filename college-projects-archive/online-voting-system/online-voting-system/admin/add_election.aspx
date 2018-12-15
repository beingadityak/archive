<%@ Page Title="" Language="C#" MasterPageFile="~/admin/admin_panel_home.Master" AutoEventWireup="true" CodeBehind="add_election.aspx.cs" Inherits="online_voting_system.admin.add_election" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Online Voting System - Add Election</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <h1 class="jumbotron">Add Election</h1>
    </div>
    <form runat="server" class="form-horizontal col-sm-8" method="post">
        <div class="form-group">
            <label class="control-label col-sm-2" for="election_date" >
                Election Date : 
            </label>
            <div class="col-sm-6">
                <asp:TextBox ID="election_date" runat="server" TextMode="Date" CssClass="form-control"></asp:TextBox>
            </div>
            <asp:CompareValidator ID="DateValidator" runat="server" ControlToValidate="election_date" ErrorMessage="Date must not be before today" Operator="GreaterThan" Type="Date" />
            <asp:RequiredFieldValidator ID="date_req" runat="server" ControlToValidate="election_date" ErrorMessage="Date of election is required" Text="*" ForeColor="Red" />
        </div>
        <div class="form-group">
            <label class="control-label col-sm-2" for="election_name">Election Name : </label>
            <div class="col-sm-6">
                <asp:TextBox ID="election_name" runat="server" CssClass="form-control" />
            </div>
            <asp:RequiredFieldValidator ID="ele_name_req" runat="server" ControlToValidate="election_name" ErrorMessage="Election name is required" Text="*" ForeColor="Red" />
        </div>
        <div class="form-group"> 
            <div class="col-sm-offset-2 col-sm-10">
                <asp:Button ID="add_elec_btn" runat="server" Text="Add Election" CssClass="btn btn-primary" OnClick="add_elec_btn_Click" CausesValidation="true"/>
            </div>
        </div>
    </form>
</asp:Content>
