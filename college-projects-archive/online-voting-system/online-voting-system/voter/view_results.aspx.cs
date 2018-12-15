using System;

namespace online_voting_system.voter
{
    public partial class view_results : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["login"].ToString() != "voter")
            {
                Session.Abandon();
                Response.Redirect("../login.aspx");
            }
        }
    }
}