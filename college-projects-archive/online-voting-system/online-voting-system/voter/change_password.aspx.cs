using System;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Web.UI.WebControls;

namespace online_voting_system.voter
{
    public partial class change_password : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["login"].ToString() != "voter")
            {
                Session.Abandon();
                Response.Redirect("../login.aspx");
            }
        }

        protected void ChangePasswordPushButton_Command(object sender, CommandEventArgs e)
        {
            if(e.CommandName == "Cancel")
            {
                Response.Redirect("home.aspx");
            }
            else if(e.CommandName=="ChangePassword")
            {
                SqlConnection con = new SqlConnection();
                con.ConnectionString = WebConfigurationManager.ConnectionStrings["db_conn"].ConnectionString;
                String newpass;
                SqlCommand cmd = new SqlCommand();
                newpass = NewPassword.Text;
                cmd.Connection = con;
                cmd.CommandText = "UPDATE login SET password = @newpassword WHERE Name=@username";
                cmd.Parameters.AddWithValue("@newpassword", newpass);
                cmd.Parameters.AddWithValue("@username", Session["username"]);
                con.Open();
                int rows_affected = cmd.ExecuteNonQuery();
                if(rows_affected > 0)
                {
                    cmd.CommandText = "UPDATE voter_reg SET password = (SELECT password FROM login WHERE Name = @username) WHERE username = @username";
                    if(cmd.ExecuteNonQuery() > 0)
                    {
                        // password update successful
                        String msg = Server.UrlEncode("Password Update Successful !");
                        Response.Redirect("../logout.aspx?m="+msg);
                    }
                    else
                    {
                        //password update failed
                        String msg = Server.UrlEncode("Password Update Failed !");
                        Response.Redirect("../logout.aspx?m=" + msg);
                    }
                }
                con.Close();
            }
        }
    }
}