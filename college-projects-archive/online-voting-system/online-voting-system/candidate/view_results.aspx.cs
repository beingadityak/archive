using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace online_voting_system.candidate
{
    public partial class view_results : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["login"].ToString() != "candidate")
            {
                Session.Abandon();
                Response.Redirect("../login.aspx");
            }
        }
    }
}