using System;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace online_voting_system.admin
{
    public partial class view_elections : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["login"].ToString() != "admin")
            {
                Session.Abandon();
                Response.Redirect("../default.aspx");
            }
        }

        protected void start_elec_btn_Command(object sender, System.Web.UI.WebControls.CommandEventArgs e)
        {
            string id = e.CommandArgument.ToString();
            SqlConnection con = new SqlConnection();
            con.ConnectionString = WebConfigurationManager.ConnectionStrings["db_conn"].ConnectionString;
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            con.Open();
            cmd.CommandText = "UPDATE election SET active = 'yes' WHERE E_Id = @e_id";
            cmd.Parameters.AddWithValue("@e_id",id);
            if(cmd.ExecuteNonQuery() > 0)
            {
                Response.Redirect("home.aspx");
            }
            con.Close();
        }

        protected void GridView1_DataBound(object sender, EventArgs e)
        {
            for(int i = 0; i< GridView1.Rows.Count;i++)
            {
                if(GridView1.Rows[i].Cells[4].Text == "yes" || GridView1.Rows[i].Cells[5].Text == "yes")
                {
                    GridView1.Rows[i].Cells[8].Visible = false;
                }
            }
        }
    }
}