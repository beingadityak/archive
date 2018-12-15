using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace online_voting_system.voter
{
    public partial class vote_action : System.Web.UI.Page
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
                SqlConnection con = new SqlConnection();
                con.ConnectionString = WebConfigurationManager.ConnectionStrings["db_conn"].ConnectionString;
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                con.Open();
                cmd.CommandText = "SELECT last_e_id FROM voter_reg WHERE username = @sess_username AND last_e_id = @query_eid";
                cmd.Parameters.AddWithValue("@sess_username", Session["username"].ToString());
                cmd.Parameters.AddWithValue("@query_eid", Request.QueryString["eid"]);
                SqlDataReader security = cmd.ExecuteReader();
                if(security.HasRows)
                {
                    // sorry, already voted
                    security.Close();
                    Response.Redirect("home.aspx");
                }
                con.Close();
            }
        }

        protected void vote_can_btn_Command(object sender, CommandEventArgs e)
        {
            if(e.CommandName == "VoteCanBtn")
            {
                string[] commandArgs = e.CommandArgument.ToString().Split(new char[] { ',' });
                string cid = commandArgs[0];
                string oid = commandArgs[1];
                string eid = commandArgs[2];
                Server.Transfer("add_vote.aspx?cid="+cid+"&oid="+oid+"&eid="+eid);
            }
        }
    }
}