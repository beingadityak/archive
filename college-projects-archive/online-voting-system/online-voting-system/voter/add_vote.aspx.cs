using System;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace online_voting_system.voter
{
    public partial class add_vote : System.Web.UI.Page
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
                string c_id = Request.QueryString["cid"];
                string o_id = Request.QueryString["oid"];
                string e_id = Request.QueryString["eid"];
                con.Open();
                cmd.CommandText = "UPDATE Candidate_Reg SET Votes = Votes + 1 WHERE C_Id = @c_id";
                cmd.Parameters.AddWithValue("@c_id", c_id);
                int num_rows = cmd.ExecuteNonQuery();
                if (num_rows > 0)
                {
                    cmd.CommandText = "UPDATE election SET votes = votes + 1 WHERE E_Id = @e_id";
                    cmd.Parameters.AddWithValue("@e_id", e_id);
                    int num_rows1 = cmd.ExecuteNonQuery();
                    if (num_rows1 > 0)
                    {
                        cmd.CommandText = "SELECT * FROM election_result WHERE O_Id = @o_id";
                        cmd.Parameters.AddWithValue("@o_id", o_id);
                        SqlDataReader rdr = cmd.ExecuteReader();
                        if (rdr.HasRows == false)
                        {
                            // new data insertion
                            rdr.Close();
                            cmd.CommandText = "INSERT INTO election_result (Total_Vote,O_Id,C_Id,E_Id) VALUES (1,@oid,@cid,@eid)";
                            cmd.Parameters.AddWithValue("@oid", o_id);
                            cmd.Parameters.AddWithValue("@cid", c_id);
                            cmd.Parameters.AddWithValue("@eid", e_id);
                            int num_rows2a = cmd.ExecuteNonQuery();
                            if (num_rows2a > 0)
                            {
                                // voted successful, so update the flags for security purposes
                                cmd.CommandText = "UPDATE voter_reg SET last_e_id = @elecid WHERE username = @usernm";
                                cmd.Parameters.AddWithValue("@elecid", e_id);
                                cmd.Parameters.AddWithValue("@usernm", Session["username"]);
                                if (cmd.ExecuteNonQuery() > 0)
                                {
                                    // finally, go home
                                    Response.Redirect("home.aspx");
                                }
                            }
                        }
                        else
                        {
                            // update old data
                            rdr.Close();
                            cmd.CommandText = "UPDATE election_result SET Total_Vote = Total_Vote + 1 WHERE O_Id = @orgid AND C_Id = @canid AND E_Id = @eleid";
                            cmd.Parameters.AddWithValue("@orgid", o_id);
                            cmd.Parameters.AddWithValue("@canid", c_id);
                            cmd.Parameters.AddWithValue("@eleid", e_id);
                            int num_rows2b = cmd.ExecuteNonQuery();
                            if (num_rows2b > 0)
                            {
                                // voted successful, so update the flags for security purposes
                                cmd.CommandText = "UPDATE voter_reg SET last_e_id = @elid WHERE username = @usename";
                                cmd.Parameters.AddWithValue("@elid", e_id);
                                cmd.Parameters.AddWithValue("@usename",Session["username"]);
                                if(cmd.ExecuteNonQuery() > 0)
                                {
                                    // finally, go home
                                    Response.Redirect("home.aspx");
                                }
                            }
                        }
                    }
                }
                con.Close();
            }
        }
    }
}