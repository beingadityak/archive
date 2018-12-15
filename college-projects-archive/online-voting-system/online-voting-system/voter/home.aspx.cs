using System;

namespace online_voting_system.voter
{
    public partial class home : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["login"].ToString() != "voter")
            {
                Session.Abandon();
                Response.Redirect("../login.aspx");
            }
            else
            {
                user_name.Text = Session["username"].ToString();
            }
        }
    }
}