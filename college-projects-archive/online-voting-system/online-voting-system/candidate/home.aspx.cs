using System;

namespace online_voting_system.candidate
{
    public partial class home : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(Session["login"].ToString() != "candidate")
            {
                Session.Abandon();
                Response.Redirect("../login.aspx");
            }
            else
            {
                user_name_lbl.Text = Session["username"].ToString();
            }
        }
    }
}