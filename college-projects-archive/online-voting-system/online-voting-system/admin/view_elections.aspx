<%@ Page Title="" Language="C#" MasterPageFile="~/admin/admin_panel_home.Master" AutoEventWireup="true" CodeBehind="view_elections.aspx.cs" Inherits="online_voting_system.admin.view_elections" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Online Voting System - View All Elections</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="form1" runat="server" method="post">
    <div class="container-fluid">
        <h1 class="jumbotron">View All Elections</h1>
        <p>
                <asp:GridView ID="GridView1" EmptyDataText="No Elections Found !" OnDataBound="GridView1_DataBound" CssClass="table table-bordered table-hover table-condensed" runat="server" AutoGenerateColumns="False" DataKeyNames="E_Id" DataSourceID="SqlDataSource1">
                <Columns>
                    <asp:BoundField DataField="E_Id" HeaderText="Election ID" ReadOnly="true" SortExpression="E_Id" />
                    <asp:BoundField DataField="vote_date" HeaderText="Date Of Voting" SortExpression="vote_date" />
                    <asp:BoundField DataField="E_Name" HeaderText="Election Name" SortExpression="E_Name" />
                    <asp:BoundField DataField="votes" HeaderText="Total Votes" ReadOnly="true" SortExpression="votes" />
                    <asp:BoundField DataField="active" HeaderText="Is Active ?" ReadOnly="true" SortExpression="active" />
                    <asp:BoundField DataField="over" HeaderText="Is Over ?" ReadOnly="true" SortExpression="over" />
                    <asp:BoundField DataField="result_generated" ReadOnly="true" HeaderText="Is Result Generated ?" SortExpression="result_generated" />
                    <asp:CommandField ButtonType="Button" ShowEditButton="True" HeaderText="Edit" ShowHeader="true" ControlStyle-CssClass="btn btn-primary" />
                    <asp:TemplateField ShowHeader="false">
                        <ItemTemplate>
                            <asp:Button CssClass="btn btn-success" ID="start_elec_btn" runat="server" Text="Start Election" CommandArgument='<%# Eval("E_Id") %>' CommandName="StartElection" OnCommand="start_elec_btn_Command" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Online-Voting-SystemConnectionString %>" SelectCommand="SELECT * FROM [election]" UpdateCommand="UPDATE [election] SET [vote_date] = @vote_date, [E_Name] = @E_Name WHERE [E_Id] = @E_Id" DeleteCommand="DELETE FROM [election] WHERE [E_Id] = @E_Id" InsertCommand="INSERT INTO [election] ([vote_date], [votes], [active], [result_generated], [E_Name]) VALUES (@vote_date, @votes, @active, @result_generated, @E_Name)">
                <DeleteParameters>
                    <asp:Parameter Name="E_Id" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter DbType="Date" Name="vote_date" />
                    <asp:Parameter Name="votes" Type="Int32" />
                    <asp:Parameter Name="active" Type="String" />
                    <asp:Parameter Name="result_generated" Type="String" />
                    <asp:Parameter Name="E_Name" Type="String" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter DbType="Date" Name="vote_date" />
                    <asp:Parameter Name="E_Name" Type="String" />
                </UpdateParameters>
                </asp:SqlDataSource>
        </p>

    </div>
    </form>
</asp:Content>
