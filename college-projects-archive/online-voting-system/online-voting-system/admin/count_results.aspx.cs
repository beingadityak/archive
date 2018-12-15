using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace online_voting_system.admin
{
    public partial class count_results : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["login"].ToString() != "admin")
            {
                Session.Abandon();
                Response.Redirect("../default.aspx");
            }
        }

        protected void gen_results_btn_Command(object sender, CommandEventArgs e)
        {
            string id = e.CommandArgument.ToString();
            Server.Transfer("results.aspx?eid=" + id);
        }
    }
}