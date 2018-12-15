using System;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace online_voting_system.admin
{
    public partial class results : System.Web.UI.Page
    {
        string max_votes, org_id, can_id, elec_id;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["login"].ToString() != "admin")
            {
                Session.Abandon();
                Response.Redirect("../default.aspx");
            }
            else
            {
                string id = Request.QueryString["eid"].ToString();
                SqlConnection con = new SqlConnection();
                con.ConnectionString = WebConfigurationManager.ConnectionStrings["db_conn"].ConnectionString;
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                con.Open();
                cmd.CommandText = "SELECT Total_Vote,E_Id,C_Id,O_Id FROM election_result WHERE Total_Vote IN (SELECT MAX(Total_Vote) FROM election_result) AND E_Id = @e_id";
                cmd.Parameters.AddWithValue("@e_id", id);
                SqlDataReader results = cmd.ExecuteReader();
                if(results.HasRows)
                {
                    while(results.Read())
                    {
                        max_votes = results["Total_Vote"].ToString();
                        org_id = results["O_Id"].ToString();
                        can_id = results["C_Id"].ToString();
                        elec_id = results["E_Id"].ToString();
                    }
                }
                results.Close();
                cmd.CommandText = "INSERT INTO election_winner (max_votes,O_Id,C_Id,E_Id) VALUES (@max_votes,@orgid,@canid,@eleid)";
                cmd.Parameters.AddWithValue("@max_votes", max_votes);
                cmd.Parameters.AddWithValue("@orgid", org_id);
                cmd.Parameters.AddWithValue("@canid",can_id);
                cmd.Parameters.AddWithValue("@eleid", elec_id);
                if(cmd.ExecuteNonQuery() > 0)
                {
                    //insertion to winner table successful, update flags
                    cmd.CommandText = "UPDATE election SET result_generated = 'yes' WHERE E_Id = @election_id";
                    cmd.Parameters.AddWithValue("@election_id", elec_id);
                    if(cmd.ExecuteNonQuery() > 0)
                    {
                        
                        cmd.CommandText = "UPDATE Candidate_Reg SET Votes = 0, E_Id = NULL WHERE E_Id = @electionid";
                        cmd.Parameters.AddWithValue("@electionid", elec_id);
                        if(cmd.ExecuteNonQuery() > 0)           //go home with message..
                            Response.Redirect("home.aspx?m=" + Server.UrlEncode("Result Generated Succesfully !"));
                    }
                }
            }
        }
    }
}