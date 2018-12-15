using System;
using System.Web.UI;

namespace online_voting_system
{
    public class Global : System.Web.HttpApplication
    {

        protected void Application_Start(object sender, EventArgs e)
        {
            ScriptResourceDefinition myDef = new ScriptResourceDefinition();
            myDef.Path = "~/scripts/jquery-3.1.0.min.js";
            ScriptManager.ScriptResourceMapping.AddDefinition("jquery", null, myDef);
        }

        protected void Session_Start(object sender, EventArgs e)
        {
            Session["login"] = "guest";
        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {

        }

        protected void Application_AuthenticateRequest(object sender, EventArgs e)
        {

        }

        protected void Application_Error(object sender, EventArgs e)
        {

        }

        protected void Session_End(object sender, EventArgs e)
        {
            Session["login"] = "guest";
        }

        protected void Application_End(object sender, EventArgs e)
        {

        }
    }
}