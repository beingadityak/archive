using System;

namespace online_voting_system
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String logout_msg;
            if (Request.QueryString["m"] != null)
            {
                logout_msg = Server.UrlEncode(Request.QueryString["m"].ToString());
            }
            else
            {
                logout_msg = Server.UrlEncode("You Have Logged Out !");
            }
            Session.Abandon();
            Response.Redirect("login.aspx?msg="+logout_msg);
        }
    }
}