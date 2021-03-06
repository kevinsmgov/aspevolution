﻿<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<% 
    If Request.QueryString("json").Count = 1 then
        Set DatabaseConnection = Server.CreateObject("ADODB.Connection") 
        Set DatabaseCommand = Server.CreateObject("ADODB.Command") 
        Set DatabaseStream = Server.CreateObject("ADODB.Stream")
        Set customerOrdersXML = Server.CreateObject( "Microsoft.XMLDOM")
        Set customerOrdersXSLT = Server.CreateObject( "Microsoft.XMLDOM" )
        DatabaseConnection.Open Application("ConnectionStringSQL")
        DatabaseStream.Open
        if DatabaseConnection.State = adStateOpen then
            DatabaseCommand.ActiveConnection = DatabaseConnection
            DatabaseCommand.CommandText = "SELECT Customers.CustomerID, Customers.ContactName, Orders.OrderID, Orders.OrderDate, [Order Details].UnitPrice, [Order Details].Quantity, [Order Details].Discount, Products.ProductName FROM Customers INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID INNER JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID INNER JOIN Products ON [Order Details].ProductID = Products.ProductID ORDER BY Customers.ContactName, Orders.OrderDate FOR XML AUTO, ROOT('root')"
            DatabaseCommand.Properties("Output Stream") = DatabaseStream
            DatabaseCommand.Execute , , 1024 'instead of adExecuteStream
            DatabaseStream.Position = 0
            if customerOrdersXML.LoadXML(DatabaseStream.ReadText) then
                If customerOrdersXSLT.Load(Server.MapPath("/App_Data/client-sql-xml-json.xslt")) Then
                    result = customerOrdersXML.transformNode(customerOrdersXSLT)
                    Response.Clear
                    Response.ContentType = "text/json"
                    Response.Write(result)
                    Response.End
                End if
            End if
        End if
    End if
%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8 ">
    <title>Classic ASP - Database</title>
    <link href="standard.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <h1>Classic ASP - Database</h1>
    <!-- #include file="menu.asp" -->
    <p>AJAX request</p>
    <ul id="customers">
    </ul>
</body>
</html>
<script src="client-sql-xml-json.js" type="text/javascript">
</script>
