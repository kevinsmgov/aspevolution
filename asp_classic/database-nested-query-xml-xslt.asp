<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
    Set customerOrdersXML = Server.CreateObject( "Microsoft.XMLDOM" )
    Set customerOrdersXSLT = Server.CreateObject( "Microsoft.XMLDOM" )
%>
<html>
<head>
    <meta charset="utf-8" />
    <title>Classic ASP - Database</title>
    <style>
        body {
            width: 66em;
        }
    </style>
</head>
<body>
    <h1>Classic ASP - XML</h1>
    <!-- #include file="menu.asp" -->
    <p>Here is a nested result from an XML data file transformed by XSLT</p>
    <% 
        customerOrdersXML.async = false
        customerOrdersXSLT.async = false
        If customerOrdersXML.Load(Server.MapPath("/App_Data/customer-orders.xml")) Then
            If customerOrdersXSLT.Load(Server.MapPath("/App_Data/customer-orders.xslt")) Then
                Response.Write(customerOrdersXML.transformNode(customerOrdersXSLT))
            End if
        End if
    %>
</body>
</html>
