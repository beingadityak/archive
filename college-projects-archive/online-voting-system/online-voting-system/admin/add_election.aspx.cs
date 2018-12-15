using System;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace online_voting_system.admin
{
    public partial class add_election : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(Session["login"].ToString() != "admin")
            {
                Session.Abandon();
                Response.Redirect("../default.aspx");
            }
            DateValidator.ValueToCompare = DateTime.Now.ToShortDateString();
        }

        protected void add_elec_btn_Click(object sender, EventArgs e)
        {
            DateTime dateOfElection = Convert.ToDateTime(election_date.Text);
            String electionName = election_name.Text.ToString();
            SqlConnection con = new SqlConnection();
            con.ConnectionString = WebConfigurationManager.ConnectionStrings["db_conn"].ConnectionString;
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            con.Open();

            cmd.CommandText = "INSERT INTO election (E_Name,vote_date) VALUES(@e_name,@vote_date)";
            cmd.Parameters.AddWithValue("@e_name", electionName);
            cmd.Parameters.AddWithValue("@vote_date", dateOfElection);
            int num_rows = cmd.ExecuteNonQuery();
            if(num_rows > 0)
            {
                //election added successfully
                Response.Redirect("home.aspx?m="+Server.UrlEncode("Election Added Successfully !"));
            }
            else
            {
                //election add failure
            }
        }
    }
}