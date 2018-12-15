using System;
using System.Web.UI.WebControls;

namespace online_voting_system.organization
{
    public partial class can_list : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["login"].ToString() != "organization")
            {
                Session.Abandon();
                Response.Redirect("../login.aspx");
            }
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if(e.Row.RowType == DataControlRowType.DataRow)
            {
                Button del = (Button)e.Row.Cells[4].Controls[0];
                del.OnClientClick = "if(!confirm('Are you sure you want to delete this Candidate?')) return;";
            }
        }
    }
}