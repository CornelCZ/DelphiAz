<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SelectSalesAreas.aspx.cs" Inherits="_Default" Culture="auto" meta:resourcekey="PageResource1" UICulture="auto" %>

<%@ Register Assembly="WebEPOSControls" Namespace="WebEPOSControls" TagPrefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Event Pricing Status</title>
    <link href="EPOSStyle.css" rel="stylesheet" type="text/css" />
</head>
<body bgcolor=black link=LightCyan alink=LightCyan vlink=LightCyan text=white>
    Select 
    <asp:Label ID="Label1" runat="server" Text="sales areas" meta:resourcekey="Label1Resource1"></asp:Label>
    to change:<br />
    <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SelectGroupSource">
        <ItemTemplate>
          <cc1:WebEPOSButton           
            ID="WebCustomControl1_1" runat="server" 
            Text='<%# Eval("ItemText").ToString() %>'
            Selected='<%# Eval("ItemSelected") %>'
            Action='<%# "SelectSalesAreas.aspx?ToggleSalesArea="+Eval("ItemID").ToString() %>' meta:resourcekey="WebCustomControl1_1Resource1"
          />      
        </ItemTemplate>
    </asp:Repeater>
    <asp:ObjectDataSource ID="SelectGroupSource" runat="server" SelectMethod="GetSalesAreas"
        TypeName="EventStatus.RepeaterDataSource"></asp:ObjectDataSource>
        
    <table BORDER="0" CELLSPACING="0" CELLPADDING="0"><tbody><tr><td>
      <cc1:WebEPOSButton ID="WebEPOSButton1" runat="server" Text="Back" HalfWidth=True Colour="green" Action="SelectSalesAreas.aspx?Action=Back" meta:resourcekey="WebEPOSButton1Resource1" Selected="False"/>
    </td><td>
      <cc1:WebEPOSButton ID="WebCustomControl1_1" runat="server" Text="Next" HalfWidth=True Colour="green" Action="SelectSalesAreas.aspx?Action=ConfirmSalesAreas" meta:resourcekey="WebCustomControl1_1Resource2" Selected="False"/>
    </td></tr></tbody></table>
</body>
</html>
