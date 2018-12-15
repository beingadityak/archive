using System;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;
using System.Web.Configuration;

namespace online_voting_system
{
    public partial class register : System.Web.UI.Page
    {
        protected String LabelProperty
        {
            get
            {
                return hidden.Value;
            }
            set
            {
                hidden.Value = value;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
               
        }

        protected void reg_button_Click(object sender, EventArgs e)
        {
            
            DateTime dateOfBirth = Convert.ToDateTime(dob.Text);
            DateTime today = DateTime.Now;
            TimeSpan ts = today - dateOfBirth;
            DateTime age = DateTime.MinValue + ts;

            int years = age.Year - 1;
            String uname_status = hidden.Value;
            if(uname_status == "username available")
            {
                if (years > 18)
                {
                    String votername, uname, pass, cityname,reg_msg=null,def_pro_pic=null;

                    def_pro_pic = Server.MapPath("./voter/profile-images/userimage.png");
                    MemoryStream stream = new MemoryStream();
                    Bitmap bmp = new Bitmap(def_pro_pic);
                    bmp.Save(stream, System.Drawing.Imaging.ImageFormat.Jpeg);

                    byte[] image = stream.ToArray();
                
                    votername = vname.Text.ToString();
                    uname = username.Text.ToString();
                    pass = password.Text.ToString();
                    cityname = city.Text.ToString();
                    SqlConnection con = new SqlConnection();
                    con.ConnectionString = WebConfigurationManager.ConnectionStrings["db_conn"].ConnectionString;
                    SqlCommand cmd = new SqlCommand();
                    con.Open();
                    cmd.Connection = con;
                    cmd.CommandText = "INSERT INTO voter_reg (name,city,username,password,image) VALUES (@votername,@city,@username,@password,@image)";
                    cmd.Parameters.AddWithValue("@votername", votername);
                    cmd.Parameters.AddWithValue("@username", uname);
                    cmd.Parameters.AddWithValue("@password", pass);
                    cmd.Parameters.AddWithValue("@city", cityname);
                    cmd.Parameters.AddWithValue("@image",image);
                    int num_rows = cmd.ExecuteNonQuery();
                    if(num_rows > 0)
                        {
                            //insertion successful...
                            reg_msg = "Voter is Registered Successfully !";
                            Response.Redirect("login.aspx?msg=" + Server.UrlEncode(reg_msg));
                        }
                        else
                        {
                            //insertion failure...
                            reg_msg = "Voter is Not Registered !";
                            Response.Redirect("login.aspx?msg=" + Server.UrlEncode(reg_msg));
                        }
                    con.Close();
                }
                else
                {
                    reg_msg.Text = "You Cannot Register, Because you are below 18 years of age";
                    reg_msg.CssClass = "alert alert-danger";
                    reg_msg.Visible = true;
                }
            }
            else
            {
                reg_msg.Text = "Invalid Username provided !";
                reg_msg.CssClass = "alert alert-danger";
                reg_msg.Visible = true;
            }
        }

        [System.Web.Services.WebMethod]
        public static bool UserNameChecker(string newUserName)
        {
            if(newUserName != "")
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