using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebEPOSControls
{
    [DefaultProperty("Text")]
    [ToolboxData("<{0}:WebEPOSButton runat=server></{0}:WebEPOSButton>")]
    public class WebEPOSButton : WebControl
    {
        [Bindable(true)]
        [Category("Appearance")]
        [DefaultValue("")]
        [Localizable(true)]
        public string Text
        {
            get
            {
                String s = (String)ViewState["Text"];
                return ((s == null) ? String.Empty : s);
            }

            set
            {
                ViewState["Text"] = value;
            }
        }
        [Bindable(true)]
        [Category("Appearance")]
        [DefaultValue("blue")]
        [Localizable(true)]
        public string Colour
        {
            get
            {
                String s = (String)ViewState["Colour"];
                return ((s == null) ? "blue" : s);
            }

            set
            {
                ViewState["Colour"] = value;
            }
        }
        [Bindable(true)]
        [Category("Appearance")]
        [DefaultValue("")]
        [Localizable(true)]
        public string Action
        {
            get
            {
                String s = (String)ViewState["Action"];
                return ((s == null) ? String.Empty : s);
            }

            set
            {
                ViewState["Action"] = value;
            }
        }
        [Bindable(true)]
        [Category("Appearance")]
        [DefaultValue(true)]
        [Localizable(true)]
        public bool Selected
        {
            get
            {
                if (ViewState["Selected"] == null)
                   return false;
                else
                  return ViewState["Selected"].Equals(true);
            }

            set
            {
                ViewState["Selected"] = value;
            }
        }

        [Bindable(true)]
        [Category("Appearance")]
        [DefaultValue(false)]
        [Localizable(true)]
        public bool HalfWidth
        {
            get
            {
                if (ViewState["HalfWidth"] == null)
                    return false;
                else
                    return ViewState["HalfWidth"].Equals(true);
            }

            set
            {
                ViewState["HalfWidth"] = value;
            }
        }

        protected override void RenderContents(HtmlTextWriter output)
        {
            String s, DisplayAttribs, LegacyColour, LegacyDisplayAttribs;

            int LegacyWidth;

            if (Selected)
                DisplayAttribs = Colour+"up";
            else
                DisplayAttribs = Colour;

            if (DisplayAttribs.ToLower() == "blueup") LegacyColour = "#797AFE";
            else if (DisplayAttribs.ToLower() == "green") LegacyColour = "#090";
            else LegacyColour = "#009";

            if (HalfWidth) {
                LegacyWidth = 140;
                DisplayAttribs = DisplayAttribs + " halfwidth";
            } else {
                LegacyWidth = 280;
            }
            
            LegacyDisplayAttribs = String.Format(@"bgcolor='{0}' width='{1}'".Replace("\'", "\""),
                 LegacyColour, LegacyWidth);

            /*
             
            s = 
      @"<table class='{0} button'> 
        <tr>
          <td class='c11'/>
          <td class='c12'/>
          <td class='c13'/>
        </tr>
        <tr>
          <td class='c21'/>
          <td {3} class='c22' align=center>
            <a href='{1}'> <p>&nbsp;</p> <p>{2}</p> <p>&nbsp;</p> </font> </a> 
          </td>
          <td class='c23'/>
        </tr>
        <tr>
          <td class='c31'/>
          <td class='c32'/>
          <td class='c33'/>
        </tr>        
      </table>".Replace("\'", "\""); 
             
             */

            s =
      @"<table class='{0} button'> 
        <tr>
          <td class='c11'/>
          <td class='c12'/>
          <td class='c13'/>
        </tr>
        <tr>
          <td class='c21'/>
          <td {3} class='c22' align=center>
            <a href='{1}'> <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p> <p><font size='+4'>{2}</font></p> <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>  </a> 
          </td>
          <td class='c23'/>
        </tr>
        <tr>
          <td class='c31'/>
          <td class='c32'/>
          <td class='c33'/>
        </tr>        
      </table>".Replace("\'", "\""); 


            output.Write(s, DisplayAttribs, Action, Text, LegacyDisplayAttribs);

        }
    }
}
