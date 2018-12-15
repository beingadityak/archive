using System;
using System.Data.SqlClient;
using System.IO;
using System.Web.Configuration;

namespace online_voting_system.voter
{
    public partial class update_picture : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["login"].ToString() != "voter")
            {
                Session.Abandon();
                Response.Redirect("../login.aspx");
            }
        }

        protected void upload_btn_Click(object sender, EventArgs e)
        {
            if(img_upload.PostedFile.FileName == "")
            {
                // no file specified
            }
            else
            {


                String extension = Path.GetExtension(img_upload.PostedFile.FileName);
                switch (extension.ToLower())
                {
                    case ".bmp":
                    case ".jpg":
                    case ".gif":
                    case ".png":
                        break;
                    default:
                        // this type of file is not allowed...
                        msg_lbl.Visible = true;
                        msg_lbl.Text = "This type of file is not allowed !";
                        return;
                }
                String serverfileName = Session["username"] + Path.GetExtension(img_upload.PostedFile.FileName);

                int length = img_upload.PostedFile.ContentLength;
                byte[] pic = new byte[length];

                img_upload.PostedFile.InputStream.Read(pic, 0, length);

                    SqlConnection con = new SqlConnection();
                    con.ConnectionString = WebConfigurationManager.ConnectionStrings["db_conn"].ConnectionString;
                    SqlCommand cmd = new SqlCommand();
                    con.Open();
                    cmd.Connection = con;
                    cmd.CommandText = "UPDATE voter_reg SET image = @image WHERE username=@username";
                    cmd.Parameters.AddWithValue("@username", Session["username"]);
                    cmd.Parameters.AddWithValue("@image", pic);
                    //cmd.Parameters.AddWithValue("@image_url", fileName);
                    int num_rows = cmd.ExecuteNonQuery();
                    if(num_rows > 0)
                    {
                    // image added successfully
                    msg_lbl.Visible = false;
                    msg_lbl.Text = null;
                    Response.Redirect("update_profile.aspx");
                    }
                    con.Close();
            }
        }

        protected void cancel_btn_Click(object sender, EventArgs e)
        {
            Response.Redirect("update_profile.aspx");
        }
    }
}