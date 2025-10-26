<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SelectGroups.aspx.cs" Inherits="SelectGroups" %>

<%@ Register Assembly="WebEPOSControls" Namespace="WebEPOSControls" TagPrefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Event Pricing Status</title>
    <link href="EPOSStyle.css" rel="stylesheet" type="text/css" />
</head>
<body bgcolor=black link=LightCyan alink=LightCyan vlink=LightCyan text=white>

    Select event groups to enable:<br />
    <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SelectGroupSource">
        <ItemTemplate>
          <cc1:WebEPOSButton           
            ID="WebEPOSButton1" runat="server" 
            Text='<%# Eval("ItemText").ToString()%>'
            Selected=<%# Eval("ItemSelected")%>
            Action='<%# "SelectGroups.aspx?ToggleGroup="+Eval("ItemID").ToString()%>'
          />      
        </ItemTemplate>
    </asp:Repeater>

    <asp:ObjectDataSource ID="SelectGroupSource" runat="server" SelectMethod="GetTariffGroups"
        TypeName="EventStatus.RepeaterDataSource"></asp:ObjectDataSource>
       
       
    <table BORDER="0" CELLSPACING="0" CELLPADDING="0"><tbody><tr><td>
      <cc1:WebEPOSButton ID="WebEPOSButton1" runat="server" Text="Back" HalfWidth=true Colour="green" Action="SelectGroups.aspx?Action=Back"/>
    </td><td>
      <cc1:WebEPOSButton ID="WebCustomControl1_1" runat="server" Text="Next" HalfWidth=true Colour="green" Action="SelectGroups.aspx?Action=ConfirmGroups"/>
    </td></tr></tbody></table>

</body>
</html>
