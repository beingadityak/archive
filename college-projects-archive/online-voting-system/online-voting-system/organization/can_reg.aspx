<%@ Page Title="" Language="C#" MasterPageFile="~/organization/org_home.Master" AutoEventWireup="true" CodeBehind="can_reg.aspx.cs" Inherits="online_voting_system.organization.can_reg" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <h1> Candidate Registration </h1>
        <form class="form-horizontal" method="post" runat="server">
            <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true"></asp:ScriptManager>
            <div class="form-group">
                <label class="control-label col-sm-2" for="cname">Candidate Name:</label>
                <div class="col-sm-6">
                  <asp:TextBox ID="cname" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
                  <asp:RequiredFieldValidator ID="cname_required" runat="server" ControlToValidate="cname" Text="*" ForeColor="Red" ErrorMessage="Please Enter Name"/>
              </div>
            <div class="form-group">
                <label class="control-label col-sm-2" for="cphoto">Candidate Photo:</label>
                <div class="col-sm-6">
                  <asp:FileUpload ID="cphoto" runat="server" CssClass="form-control" />
                </div>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="cphoto" Text="*" ForeColor="Red" ErrorMessage="Please Provide a Photo"/>
            </div>
            <asp:UpdatePanel ID="username_update_panel" runat="server">
                <ContentTemplate>
                    <div class="form-group">
                        <label class="control-label col-sm-2" for="username">Username:</label>
                            <div class="col-sm-6"> 
                              <asp:TextBox ID="username" MaxLength="20" runat="server" CssClass="form-control" OnChange ="CheckUserName(this)"></asp:TextBox>
                            </div>
                        <asp:Label ID="lblStatus" runat="server" EnableViewState="true"></asp:Label>
                        <asp:RequiredFieldValidator ID="username_required" runat="server" ControlToValidate="username" Text="*" ForeColor="Red" ErrorMessage="Please Enter Username"/>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
            
              <div class="form-group">
                <label class="control-label col-sm-2" for="password">Password:</label>
                <div class="col-sm-6"> 
                  <asp:TextBox ID="password" runat="server" CssClass="form-control" CausesValidation="True" TextMode="Password"></asp:TextBox>
                </div>
                  <asp:RequiredFieldValidator ID="password_required" runat="server" ControlToValidate="password" Text="*" ForeColor="Red" ErrorMessage="Please Enter Password"/>
              </div>
            
              <div class="form-group">
                <label class="control-label col-sm-2" for="cnfpassword">Confirm Password:</label>
                <div class="col-sm-6"> 
                  <asp:TextBox ID="cnfpassword" runat="server" CssClass="form-control" CausesValidation="True" TextMode="Password"></asp:TextBox>
                </div>
                  <asp:RequiredFieldValidator ID="cnfpass_required" runat="server" ControlToValidate="cnfpassword" Text="*" ForeColor="Red" ErrorMessage="Please Confirm The Password"/>
                  <asp:CompareValidator ID="passvalidate" runat="server" ControlToValidate="cnfpassword" ControlToCompare="password" ErrorMessage="Passwords Do Not Match !" CssClass="alert alert-danger"/>
              </div>

              <div class="form-group"> 
                <div class="col-sm-offset-2 col-sm-10">
                    <asp:Button ID="reg_button" runat="server" Text="Register" CssClass="btn btn-primary" OnClick="reg_button_Click" CausesValidation="true"/>
                    <asp:Label ID="reg_msg" runat="server" Visible="false"></asp:Label>
                </div>
              </div>

            <div class="form-group">
                <div class="col-sm-8">
                    <asp:ValidationSummary ID="reg_summary" runat="server" CssClass="alert alert-danger" />
                </div>
            </div>
            <asp:HiddenField ID="hidden" runat="server" />
        </form>
    </div>
    <script type="text/javascript">  
  
        function CheckUserName(oName) 
        {
            PageMethods.UserNameChecker(oName.value, OnSucceeded); 
        }

        function OnSucceeded(result, userContext, methodName) 
        {   
            lbl = document.getElementById('<%=lblStatus.ClientID %>'); 

            if (methodName == "UserNameChecker") 
            { 
                if (result == true) 
                { 
                    lbl.textContent = 'username not available'; 
                    lbl.style.color = "red"; 
                } 
                else 
                { 
                    lbl.textContent = 'username available';
                    lbl.style.color = "green"; 
                }
                document.getElementById('<%=hidden.ClientID %>').value = lbl.innerHTML;
            } 
        }  
    </script>
</asp:Content>
