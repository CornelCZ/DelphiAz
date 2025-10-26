using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class ConfirmChangeDetails : System.Web.UI.Page
{
    protected override void InitializeCulture()
    {
        EventStatus.GlobalClass.Controller.LocalisePage(this);
    }
    protected override void OnLoad(EventArgs e)
    {
        base.OnLoad(e);
        //DebugRequestSPLabel.Text = EventStatus.GlobalClass.Controller.GetStoredProcParams();

    }
}
