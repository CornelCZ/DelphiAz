<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ConfirmChangeDetails.aspx.cs" Inherits="ConfirmChangeDetails" Culture="auto" meta:resourcekey="PageResource1" UICulture="auto" %>

<%@ Register Assembly="WebEPOSControls" Namespace="WebEPOSControls" TagPrefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Event Pricing Status</title>
    <link href="EPOSStyle.css" rel="stylesheet" type="text/css" />
</head>
<body bgcolor=black link=LightCyan alink=LightCyan vlink=LightCyan text=white>
   
    Selected Event: <%Response.Write(EventStatus.GlobalClass.Controller.GetSelectedTariff());%> <br /> <br />
    Selected 
    <asp:Label ID="Label1" runat="server" meta:resourcekey="Label1Resource1" Text="sales areas"></asp:Label>:
    <%Response.Write(EventStatus.GlobalClass.Controller.GetSelectedSalesAreas());%><BR><BR>

    Please confirm this change. <BR><BR>
    <font color="yellow"> You must ensure that advertised prices are updated in line with the selected Event. </font><BR><BR>

    <table BORDER="0" CELLSPACING="0" CELLPADDING="0"><tbody><tr><td>
      <cc1:WebEPOSButton ID="WebEPOSButton1" runat="server" Text="Back" HalfWidth=True Colour="green" Action="ConfirmChangeDetails.aspx?Action=Back" meta:resourcekey="WebEPOSButton1Resource1" Selected="False"/>
    </td><td>
      <cc1:WebEPOSButton ID="WebEPOSButton2" runat="server" Text="Next" HalfWidth=True Colour="green" Action="ConfirmChangeDetails.aspx?Action=ConfirmChange" meta:resourcekey="WebEPOSButton2Resource1" Selected="False"/>
    </td></tr></tbody></table>
    <asp:Label ID="DebugRequestSPLabel" runat="server" ForeColor="Black" Text=""></asp:Label><br />
    
</body>
</html>
