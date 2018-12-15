using System;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace online_voting_system.candidate
{
    public partial class change_party : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["login"].ToString() != "candidate")
            {
                Session.Abandon();
                Response.Redirect("../login.aspx");
            }
        }
        protected void change_btn_click(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection();
            con.ConnectionString = WebConfigurationManager.ConnectionStrings["db_conn"].ConnectionString;
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            con.Open();
            cmd.CommandText = "UPDATE Candidate_Reg SET O_Id = (SELECT O_Id FROM org_table WHERE Name = @org_name) WHERE User_Name = @user_name";
            cmd.Parameters.AddWithValue("@org_name",party_list.SelectedValue.ToString());
            cmd.Parameters.AddWithValue("@user_name", Session["username"].ToString());
            int num_rows = cmd.ExecuteNonQuery();
            if(num_rows > 0)
            {
                Response.Redirect("home.aspx");
            }
            con.Close();
        }
    }
}