using System;

namespace online_voting_system.organization
{
    public partial class home : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(Session["login"].ToString() != "organization")
            {
                Session.Abandon();
                Response.Redirect("../login.aspx");
            }
            if(Request.QueryString["m"] != null)
            {
                msg_lbl.Visible = true;
                msg_lbl.Text = Request.QueryString["m"].ToString();
            }
        }
    }
}