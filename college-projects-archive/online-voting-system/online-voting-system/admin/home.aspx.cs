using System;

namespace online_voting_system.admin
{
    public partial class home : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(Session["login"].ToString() != "admin")
            {
                Session.Abandon();
                Response.Redirect("../default.aspx");
            }
            else
            {
                username_text.Text = Session["username"].ToString();
            }
            if(Request.QueryString["m"] == null)
            {}
            else
            {
                message_text.Visible = true;
                message_text.Text = Request.QueryString["m"].ToString();
            }
        }
    }
}