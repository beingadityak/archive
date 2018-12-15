<%@ Page Title="" Language="C#" MasterPageFile="~/organization/org_home.Master" AutoEventWireup="true" CodeBehind="register_for_election.aspx.cs" Inherits="online_voting_system.organization.register_for_election" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Online Voting System - Register for Election</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <form id="form1" method="post" runat="server" class="form-horizontal">
        <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true"></asp:ScriptManager>
        <div class="container-fluid">
            <div class="jumbotron">
                <h1>Register for Election</h1>
            </div>
                            <asp:UpdatePanel ID="is_allowed_panel" runat="server">
                                <ContentTemplate>
                                    <div class="form-group">
                                    <label for="elec_name" class="control-label col-sm-2">
                                        Election Name : 
                                    </label>
                                    <div class ="col-sm-6">
                                        <asp:DropDownList OnChange ="checkIfAlreadyRegistered(this)" ID="elec_name" runat="server" CssClass="form-control" DataSourceID="SqlDataSource1" DataTextField="E_Name" DataValueField="E_Name" AppendDataBoundItems="true">
                                            <Items>
                                                <asp:ListItem Text="Select..." Value="NA" />
                                            </Items>
                                        </asp:DropDownList>
                                    </div>
                                        <asp:Label ID="lblStatus" runat="server" EnableViewState="true"></asp:Label>
                                    <asp:RequiredFieldValidator ID="rfv1" runat="server" ControlToValidate="elec_name" InitialValue="NA" Text="*" ForeColor="Red" />
                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>
            <div class="form-group">
                <label for="candidate_name" class="control-label col-sm-3">
                    Your Candidate for this election : 
                </label>
                <div class="col-sm-6">
                    <asp:DropDownList ID="candidate_name" CssClass="form-control" runat="server" DataSourceID="SqlDataSource2" DataTextField="Name" DataValueField="Name" AppendDataBoundItems="true">
                        <Items>
                            <asp:ListItem Text="Select..." Value="NA" />
                        </Items>
                    </asp:DropDownList>
                </div>
                <asp:RequiredFieldValidator ID="rfv2" runat="server" ControlToValidate="candidate_name" InitialValue="NA" Text="*" ForeColor="Red" />
            </div>
            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                    <asp:Button Text="Register For Election" ID="reg_elec_btn" CssClass="btn btn-primary" runat="server" OnClick="reg_elec_btn_Click" />
                    <asp:Label ID="reg_msg" runat="server" CssClass="alert alert-danger" Visible="false" />
                </div>
            </div>
        </div>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Online-Voting-SystemConnectionString %>" SelectCommand="SELECT [E_Name] FROM [election] WHERE ([active] = @active)">
            <SelectParameters>
                <asp:Parameter DefaultValue="yes" Name="active" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:Online-Voting-SystemConnectionString %>" SelectCommand="select c.Name from Candidate_Reg c inner join org_table o on c.O_id = o.O_Id where o.User_Name = @User_Name">
            <SelectParameters>
                <asp:SessionParameter Name="User_Name" SessionField="username" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:HiddenField ID="hidden" runat="server" />
    </form>
    <script type="text/javascript">
        var electionName;
        function checkIfAlreadyRegistered(eleName)
        {
            electionName = eleName.options[eleName.selectedIndex].innerHTML;
            PageMethods.IsRegisteredChecker(electionName,OnSucceeded);
        }
        function OnSucceeded(result, userContext, methodName) 
        {   
            lbl = document.getElementById('<%=lblStatus.ClientID %>'); 

            if (methodName == "IsRegisteredChecker")
            { 
                if (result == true) 
                { 
                    lbl.textContent = 'One-Time Registration Only'; 
                    lbl.style.color = "red"; 
                } 
                else 
                { 
                    lbl.textContent = 'Registration Available';
                    lbl.style.color = "green"; 
                }
                document.getElementById('<%=hidden.ClientID %>').value = lbl.innerHTML;
            } 
        } 
    </script>
</asp:Content>
