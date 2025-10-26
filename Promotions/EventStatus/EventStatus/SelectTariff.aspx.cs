using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Threading;

public partial class _Default : System.Web.UI.Page 
{
    protected override void InitializeCulture() 
    {
        EventStatus.GlobalClass.Controller.LocalisePage(this);
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            EventStatus.GlobalClass.Controller.Initialise();
            if (!EventStatus.GlobalClass.Controller.AreTariffsDefined())
                Label1.Visible = true;
            if (EventStatus.GlobalClass.Controller.EPState != EventStatus.EventPricingAppState.SelectTariff)
                Response.Redirect(EventStatus.GlobalClass.Controller.EPState.ToString() + ".aspx");
        }
    }

    protected string GetTariffColour(long ID)
    {
        if (ID == -1)
        {
            return "blue";
        }
        else
        {
            return "green";
        }
    }
}
