<%@ Page Title="" Language="C#" MasterPageFile="~/organization/org_home.Master" AutoEventWireup="true" CodeBehind="can_list.aspx.cs" Inherits="online_voting_system.organization.can_list" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Online Voting System - View/Delete Candidate List</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="form1" runat="server">
    <div class="container-fluid">
        <h1>View/Delete Candidate List</h1> 
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Online-Voting-SystemConnectionString %>" SelectCommand="select c.C_Id,c.Name,c.Image,c.User_Name, o.Name from Candidate_Reg c INNER JOIN org_table o ON o.O_Id = c.O_Id AND o.User_Name = @User_Name" DeleteCommand="DELETE FROM Candidate_Reg WHERE C_Id = @C_Id">
                <SelectParameters>
                    <asp:SessionParameter DefaultValue="" Name="User_name" SessionField="username" Type="String" />
                </SelectParameters>
                <DeleteParameters>
                    <asp:Parameter Type="Int32" Name="C_Id" />
                </DeleteParameters>
            </asp:SqlDataSource>
            <asp:GridView ID="GridView1" ShowHeaderWhenEmpty="false" OnRowDataBound="GridView1_RowDataBound" EmptyDataText="No Candidates Found !" runat="server" CssClass="table table-responsive table-hover" AutoGenerateColumns="False" DataKeyNames="C_Id" DataSourceID="SqlDataSource1" BackColor="White" BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" CellPadding="4">
                <Columns>
                    <asp:BoundField DataField="C_Id" HeaderText="Candidate ID" InsertVisible="False" ReadOnly="True" SortExpression="C_Id" />
                    <asp:BoundField DataField="Name" HeaderText="Candidate Name" SortExpression="Name" />
                    <asp:BoundField DataField="Name1" HeaderText="Organization Name" SortExpression="Name1" />
                    <asp:BoundField DataField="User_Name" HeaderText="Candidate Username" SortExpression="User_Name" />
                    <asp:CommandField ButtonType="Button" ShowDeleteButton="True" ControlStyle-CssClass="btn btn-danger" />
                </Columns>
            </asp:GridView>
    </div>
    </form>
</asp:Content>
