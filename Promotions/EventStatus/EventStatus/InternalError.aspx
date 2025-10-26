<%@ Page Language="C#" AutoEventWireup="true" CodeFile="InternalError.aspx.cs" Inherits="InternalError" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Internal Error</title>
    <link href="EPOSStyle.css" rel="stylesheet" type="text/css" />
</head>
<body bgcolor=black link=LightCyan alink=LightCyan vlink=LightCyan text=white
  onload="changeColour('ErrorMessage')">
  
    <form id="form1" runat="server">
    <div>
    
        <p  style="color: red; border: 8px solid red; padding: 8px;" id="ErrorMessage">
        
        <b> Aztec Back Office web application encountered an error:</b><br/><br/>
        <%Response.Write(EventStatus.GlobalClass.Controller.LastError);%> <br/>
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
