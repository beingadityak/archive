<%@ Page Title="" Language="C#" MasterPageFile="~/organization/organization.Master" AutoEventWireup="true" CodeBehind="register.aspx.cs" Inherits="online_voting_system.organization.register" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Online Voting System - Organization Registration</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <div class="container-fluid">
            <h1> Political Party/Organization Registration </h1>
        <form class="form-horizontal" method="post" runat="server">
            <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true"></asp:ScriptManager>
              <div class="form-group">
                <label class="control-label col-sm-2" for="oname">Organization Name:</label>
                <div class="col-sm-6">
                  <asp:TextBox ID="oname" runat="server" CssClass="form-control text-capitalize"></asp:TextBox>
                </div>
                    <asp:RequiredFieldValidator ID="oname_req" runat="server" ControlToValidate="oname" Text="*" ForeColor="Red" ErrorMessage="Please Enter the Organization Name" />
              </div>
              <div class="form-group">
                <label class="control-label col-sm-2" for="email">Email:</label>
                <div class="col-sm-6"> 
                  <asp:TextBox ID="email" runat="server" CssClass="form-control" TextMode="Email"></asp:TextBox>
                </div>
                  <asp:RequiredFieldValidator ID="email_req" runat="server" ControlToValidate="email" Text="*" ForeColor="Red" ErrorMessage="Please Enter the Organization Email Address" />
              </div>
            <asp:UpdatePanel ID="usrname_update_panel" runat="server">
                <ContentTemplate>
                    <div class="form-group">
                        <label class="control-label col-sm-2" for="username">Username:</label>
                        <div class="col-sm-6"> 
                          <asp:TextBox ID="username" runat="server" MaxLength="20" CssClass="form-control" OnChange ="CheckUserName(this)"></asp:TextBox>
                        </div>
                        <asp:Label ID="lblStatus" runat="server" EnableViewState="true"/>
                        <asp:RequiredFieldValidator ID="username_req" runat="server" ControlToValidate="username" Text="*" ForeColor="Red" ErrorMessage="Please Enter the Username" />
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
            
              <div class="form-group">
                <label class="control-label col-sm-2" for="password">Password:</label>
                <div class="col-sm-6"> 
                  <asp:TextBox ID="password" runat="server" CssClass="form-control" CausesValidation="True" TextMode="Password"></asp:TextBox>
                </div>
                  <asp:RequiredFieldValidator ID="password_req" runat="server" ControlToValidate="password" Text="*" ForeColor="Red" ErrorMessage="Please Enter the Password" />
              </div>
            
              <div class="form-group">
                <label class="control-label col-sm-2" for="cnfpassword">Confirm Password:</label>
                <div class="col-sm-6"> 
                  <asp:TextBox ID="cnfpassword" runat="server" CssClass="form-control" CausesValidation="True" TextMode="Password"></asp:TextBox>
                </div>
                  <asp:RequiredFieldValidator ID="cnfpassword_req" runat="server" ControlToValidate="cnfpassword" Text="*" ForeColor="Red" ErrorMessage="Please Confirm the Password" />
                  <div class="col-sm-3">
                      <asp:CompareValidator ID="passvalidate" runat="server" ControlToValidate="cnfpassword" ControlToCompare="password" ErrorMessage="Passwords Do Not Match !" CssClass="alert alert-danger"/>
                  </div>
              </div>

              <div class="form-group"> 
                <div class="col-sm-offset-2 col-sm-10">
                    <asp:Button ID="submit_btn" runat="server" Text="Register" CssClass="btn btn-primary" OnClick="submit_btn_Click" CausesValidation="true" />
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
