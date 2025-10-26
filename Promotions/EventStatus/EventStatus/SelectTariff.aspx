<%@ Page Language="C#" AutoEventWireup="true"  CodeFile="SelectTariff.aspx.cs" Inherits="_Default" meta:resourcekey="PageResource1" Culture="en-GB" UICulture="en-GB" %>

<%@ Register Assembly="WebEPOSControls" Namespace="WebEPOSControls" TagPrefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Event Pricing Status</title>
    <link href="EPOSStyle.css" rel="stylesheet" type="text/css" />
</head>
<body bgcolor=black link=LightCyan alink=LightCyan vlink=LightCyan text=white>
 
    Event Pricing status:<br>
    
    <asp:Repeater ID="Repeater2" runat="server" DataSourceID="CurrentTariffs">
    <ItemTemplate>
      <asp:Label ID="Label1" runat="server" Text="Sales Area " meta:resourcekey="Label1Resource1"></asp:Label>
        <%# Eval("LabelText").ToString() %>
        <br>
    </ItemTemplate>
    </asp:Repeater>
    <asp:ObjectDataSource ID="CurrentTariffs" runat="server" SelectMethod="GetSalesAreaStatus"
        TypeName="EventStatus.RepeaterDataSource"></asp:ObjectDataSource>
    <br>
    
    Select an Event to activate, or "Standard" to deactivate an event:<br>
    <br>
        
    <asp:Repeater ID="Repeater1" runat="server" DataSourceID="AvailableTarrifs" >
     
     <ItemTemplate>
     <cc1:WebEPOSButton
       ID="WebCustomControl1_1" runat="server" 
       Colour='<%# GetTariffColour((long)Eval("ItemID")) %>'
       Text='<%# Eval("ItemText").ToString() %>'
       Action='<%# "SelectTariff.aspx?TariffID="+Eval("ItemID").ToString() %>' meta:resourcekey="WebCustomControl1_1Resource1" Selected="False" />
     </ItemTemplate>
     
    </asp:Repeater>
    <asp:ObjectDataSource ID="AvailableTarrifs" runat="server" SelectMethod="GetTariffs"
        TypeName="EventStatus.RepeaterDataSource"></asp:ObjectDataSource>
    <asp:Label ID="Label1" runat="server" ForeColor="Yellow" Text="No Events Available"
        Visible="False" Width="222px"></asp:Label>

</body>
</html>
