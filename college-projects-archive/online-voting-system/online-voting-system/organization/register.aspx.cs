using System;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace online_voting_system.organization
{
    public partial class register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void submit_btn_Click(object sender, EventArgs e)
        {
            string organizationname,Email,Username,Password,reg_msg=null;
            organizationname = oname.Text.ToString();
            Email = email.Text.ToString();
            Username = username.Text.ToString();
            Password = password.Text.ToString();

            SqlConnection con = new SqlConnection();
            con.ConnectionString = WebConfigurationManager.ConnectionStrings["db_conn"].ConnectionString;
            SqlCommand cmd = new SqlCommand();
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = "INSERT INTO org_table (Name,Email,User_Name,Password) VALUES (@organizationname,@Email,@Username,@Password)";
            cmd.Parameters.AddWithValue("@organizationname", organizationname);
            cmd.Parameters.AddWithValue("@Email", Email);
            cmd.Parameters.AddWithValue("@Username", Username);
            cmd.Parameters.AddWithValue("@Password", Password);
            int num_rows = cmd.ExecuteNonQuery();
            if (num_rows > 0)
            {
                    //insertion successful...
                    reg_msg = "Organization is Registered Successfully !";
                    Response.Redirect("../login.aspx?msg=" + Server.UrlEncode(reg_msg));
            }
                else
                {
                    //insertion failure...
                    reg_msg = "Organization is Not Registered !";
                    Response.Redirect("../login.aspx?msg=" + Server.UrlEncode(reg_msg));
                }
            con.Close();
        }

        [System.Web.Services.WebMethod]
        public static bool UserNameChecker(string newUserName)
        {
            if (newUserName != "")
            {
                SqlConnection con = new SqlConnection(WebConfigurationManager.ConnectionStrings["db_conn"].ConnectionString);
                con.Open();
                SqlCommand cmd = new SqlCommand("select Name from login where Name=@username", con);
                cmd.Parameters.AddWithValue("@username", newUserName);

                object found = cmd.ExecuteScalar();

                if (found != null)
                    return true;
                else
                    return false;
            }
            else
            {
                return true;
            }
        }

    }
}