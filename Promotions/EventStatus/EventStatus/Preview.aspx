<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Preview.aspx.cs" Inherits="Preview" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Event Pricing Status - Preview</title>
    <link href="EPOSStyle.css" rel="stylesheet" type="text/css" />
</head>
<body bgcolor=black link=LightCyan alink=LightCyan vlink=LightCyan text=white
  onload="changeColour('PreviewMessage')">
  
    <form id="form1" runat="server">
    <div>
    
        <p  style="color: red; border: 8px solid red; padding: 8px;" id="PreviewMessage">
        
        <b>Event Pricing functionality is disabled during theme preview.</b><br/><br/>
        </p>
        
       <script type="text/javascript">
<!--

           function changeColour(elementId) {
               var interval = 1000;
               var colour1 = "#ff0000"
               var colour2 = "#000000";
               if (document.getElementById) {
                   var element = document.getElementById(elementId);
                   element.style.borderColor = (element.style.borderColor == colour1) ? colour2 : colour1;
                   setTimeout("changeColour('" + elementId + "')", interval);
               }
           }

//-->
</script>
    
    </div>
    </form>
</body>
</html>

