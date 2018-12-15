using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace online_voting_system.voter
{
    /// <summary>
    /// Summary description for showImage
    /// </summary>
    public class showImage : IHttpHandler
    {
        String conn_str = ConfigurationManager.ConnectionStrings["db_conn"].ConnectionString;
        public void ProcessRequest(HttpContext context)
        {
            String v_id = context.Request.QueryString["id"];
            SqlConnection con = new SqlConnection(conn_str);
            con.Open();
            SqlCommand cmd = new SqlCommand("select image from voter_reg where V_Id="+v_id,con);
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