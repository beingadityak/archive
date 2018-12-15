using System;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace online_voting_system.admin
{
    public partial class view_active_elections : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["login"].ToString() != "admin")
            {
                Session.Abandon();
                Response.Redirect("../default.aspx");
            }
        }

        protected void stop_elec_btn_Command(object sender, System.Web.UI.WebControls.CommandEventArgs e)
        {
            if(e.CommandName=="StopElecBtn")
            {
                string id = e.CommandArgument.ToString();
                SqlConnection con = new SqlConnection();
                con.ConnectionString = WebConfigurationManager.ConnectionStrings["db_conn"].ConnectionString;
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                con.Open();

                cmd.CommandText = "UPDATE election SET active = 'no', [over] = 'yes' WHERE E_Id = @electionid";
                cmd.Parameters.AddWithValue("@electionid", id);
                if (cmd.ExecuteNonQuery() > 0)
                {
                        cmd.CommandText = "UPDATE voter_reg SET last_e_id = NULL WHERE last_e_id = @elecid";
                        cmd.Parameters.AddWithValue("@elecid", id);
                        if (cmd.ExecuteNonQuery() > 0)
                        {
                            // election stopped successfully
                            Response.Redirect("home.aspx");
                        }
                }

                con.Close();
            }
        }
    }
}