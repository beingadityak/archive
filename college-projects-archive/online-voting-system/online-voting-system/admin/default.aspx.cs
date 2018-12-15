using System;

namespace online_voting_system.admin
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        public readonly String ADMIN_UNAME = "admin_user";
        public readonly String ADMIN_PASS = "admin1234";

        protected void Page_Load(object sender, EventArgs e)
        {
            if(Session["login"].ToString() == "admin")
            {
                Response.Redirect("home.aspx");
            }
            else
            { }
        }

        protected void login_btn_Click(object sender, EventArgs e)
        {
            String admin_uname, admin_pass;
            admin_uname = username.Text;
            admin_pass = pwd.Text;
            if(admin_uname == ADMIN_UNAME && admin_pass == ADMIN_PASS)
            {
                Session["login"] = "admin";
                Session["username"] = admin_uname;
                Response.Redirect("home.aspx"); 
            }
            else
            {
                err_msg.Text = "Error in logging you in !";
                err_msg.Visible = true;
            }
        }
    }
}