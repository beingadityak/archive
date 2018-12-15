using System;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace online_voting_system
{
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(Session["login"].ToString() == "organization")
            {
                Response.Redirect("organization/home.aspx");
            }
            else if (Session["login"].ToString() == "candidate")
            {
                Response.Redirect("candidate/home.aspx");
            }
            else if (Session["login"].ToString() == "voter")
            {
                Response.Redirect("voter/home.aspx");
            }
            if (Request.QueryString["msg"] != null)
            {
                message_lbl.Text = Request.QueryString["msg"].ToString();
                message_lbl.Visible = true;
            }
        }

        protected void login_btn_Click(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection();
            con.ConnectionString= WebConfigurationManager.ConnectionStrings["db_conn"].ConnectionString;
            SqlCommand cmd = new SqlCommand();
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = "select login_type from login where Name = @username and Password = @password";
            cmd.Parameters.AddWithValue("@username", username.Text.ToString());
            cmd.Parameters.AddWithValue("@password", pwd.Text.ToString());
            SqlDataReader r = cmd.ExecuteReader();
            r.Read();
            String login_type = logintype.SelectedItem.Text.ToString();
            if (login_type.Equals("Organization"))
            {
                if ((r.HasRows) && (r["login_type"].ToString() == "Organization"))
                {
                    Session["login"] = "organization";
                    Session["username"] = username.Text.ToString();
                    Response.Redirect("organization/home.aspx");
                }
                else
                {
                    Label1.Text = "Unable To Log In to Organization ! Please, check your credentials.";
                    Label1.Visible = true;
                }
            }
            else if(login_type.Equals("Candidate"))
            {
                if ((r.HasRows) && (r["login_type"].ToString() == "Candidate"))
                {
                    Session["login"] = "candidate";
                    Session["username"] = username.Text.ToString();
                    Response.Redirect("candidate/home.aspx");
                }
                else
                {
                    Label1.Text = "Unable To Log In to Candidate ! Please, check your credentials.";
                    Label1.Visible = true;
                }
            }
            else if(login_type.Equals("Voter"))
            {
                if ((r.HasRows) && (r["login_type"].ToString() == "Voter"))
                {
                    Session["login"] = "voter";
                    Session["username"] = username.Text.ToString();
                    Response.Redirect("voter/home.aspx");
                }
                else
                {
                    Label1.Text = "Unable To Log In to Voter ! Please, check your credentials.";
                    Label1.Visible = true;
                }
            }
            con.Close();
        }
    }
}