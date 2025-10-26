namespace EventStatus
{
    using System;
    using System.Web;

    public class GlobalClass : System.Web.HttpApplication
    {
        public static EventPricingController Controller;

        protected void Session_Start(Object Sender, EventArgs e)
        {
            Session.Timeout = 50; // todo??
            /*Response.Write("Session ID: "+Session.SessionID+"<BR>"+
              "Session timeout: " + Session.Timeout.ToString() + "<BR>"+
              "Session started <br>");*/

        }
        protected void Session_End(Object Sender, EventArgs e)
        {
            
        }

        public void Application_Error(Object Sender, EventArgs e)
        {

            Exception objErr = Server.GetLastError();
            if (objErr.GetBaseException() != null)
                objErr = objErr.GetBaseException();
            String ErrorText = objErr.Message.ToString() + "<BR><BR>" + objErr.StackTrace;

            // Skip our custom error page if there is no response context available, 
            // and fall back to the ASP yellow screen of death.
            // NB this.repsponse may not be available depending on ASP state,
            // so I used HttpContext.Current.Response intead.

            if (HttpContext.Current.Response != null)
            {
                Controller.HandleError(ErrorText);
                Server.ClearError();
                HttpContext.Current.Response.Redirect("InternalError.aspx");
            }
    
        }

        protected void Application_Start(Object Sender, EventArgs e)
        {
            Controller = new EventPricingController();
            Controller.Initialise();

        }

        protected void Application_PreRequestHandlerExecute(Object Sender, EventArgs e)
        {
            // Todo: case sensitive or not? probably sensitive - as apache is.
            // Should really replace the contains malarky with Action=xxx querystrings         

            if (Request.QueryString["TerminalID"] != null)
                Controller.ClientTerminalID = System.Convert.ToInt32(Request.QueryString["TerminalID"]);
            if (Request.QueryString["EmployeeID"] != null)
                Controller.ClientEmployeeID = System.Convert.ToInt64(Request.QueryString["EmployeeID"]);

            if (Request.Url.PathAndQuery.ToLower().Contains("tariffid"))
            {
                if (Controller.EPState == EventPricingAppState.SelectTariff)
                    Controller.SelectTariff(Convert.ToInt64(Request.QueryString["TariffID"]));
                Response.Redirect(Controller.EPState.ToString() + ".aspx");
            }
            else if (Request.Url.PathAndQuery.ToLower().Contains("togglegroup"))
            {
                if (Controller.EPState == EventPricingAppState.SelectGroups)
                    Controller.ToggleGroup(System.Convert.ToInt32(Request.QueryString["ToggleGroup"]));
            }
            else if (Request.Url.PathAndQuery.ToLower().Contains("confirmgroups"))
            {
                if (Controller.EPState == EventPricingAppState.SelectGroups)
                    Controller.ConfirmGroups();
                Response.Redirect(Controller.EPState.ToString() + ".aspx");
            }
            else if (Request.Url.PathAndQuery.ToLower().Contains("togglesalesarea"))
            {
                if (Controller.EPState == EventPricingAppState.SelectSalesAreas)
                    Controller.ToggleSalesArea(System.Convert.ToInt32(Request.QueryString["ToggleSalesArea"]));
            }
            else if (Request.Url.PathAndQuery.ToLower().Contains("confirmsalesareas"))
            {
                if (Controller.EPState == EventPricingAppState.SelectSalesAreas)
                    Controller.ConfirmSalesAreas();
                Response.Redirect(Controller.EPState.ToString() + ".aspx");
            }
            else if (Request.Url.PathAndQuery.ToLower().Contains("action=confirmchange"))
            {
                if (Controller.EPState == EventPricingAppState.ConfirmChangeDetails)
                    Controller.ConfirmChange();
                Response.Redirect(Controller.EPState.ToString() + ".aspx");
            }
            else if (Request.Url.PathAndQuery.ToLower().Contains("awaitcompletion"))
            {
                Response.Redirect(Controller.EPState.ToString() + ".aspx");
            }
            else if (Request.Url.PathAndQuery.ToLower().Contains("action=back"))
            {
                Controller.GoBack();
                Response.Redirect(Controller.EPState.ToString() + ".aspx");
            }
        }
    }
}