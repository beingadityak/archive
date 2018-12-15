using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web;

namespace online_voting_system.organization
{
    /// <summary>
    /// Summary description for getCanImage
    /// </summary>
    public class getCanImage : IHttpHandler
    {
        String conn_str = ConfigurationManager.ConnectionStrings["db_conn"].ConnectionString;
        public void ProcessRequest(HttpContext context)
        {
            String c_id = context.Request.QueryString["id"];
            SqlConnection con = new SqlConnection(conn_str);
            con.Open();
            SqlCommand cmd = new SqlCommand("select Image from Candidate_Reg where C_Id=" + c_id, con);
            SqlDataReader rdr = cmd.ExecuteReader();
            rdr.Read();
            context.Response.BinaryWrite((Byte[])rdr[0]);
            con.Close();
            context.Response.End();
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}