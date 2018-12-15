using System;
using System.Web.UI.WebControls;

namespace online_voting_system.voter
{
    public partial class vote : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["login"].ToString() != "voter")
            {
                Session.Abandon();
                Response.Redirect("../login.aspx");
            }
        }

        protected void vote_btn_Command(object sender, CommandEventArgs e)
        {
            if(e.CommandName=="VoteBtn")
            {
                String id = e.CommandArgument.ToString();
                Server.Transfer("vote_action.aspx?eid="+id);
            }
        }
    }
}