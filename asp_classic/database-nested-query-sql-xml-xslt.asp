<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
    Set DatabaseConnection = Server.CreateObject("ADODB.Connection") 
    Set DatabaseCommand = Server.CreateObject("ADODB.Command") 
    Set DatabaseStream = Server.CreateObject("ADODB.Stream")
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
    <h1>Classic ASP - Database</h1>
    <!-- #include file="menu.asp" -->
    <p>Here's a nested query example from the Northwind database. A simple select and subsequent loop through the results. But, for each result, a nested query to return related records.</p>
    <p>The approach is obviously inefficient as the database is requeried for each iteration. It's also cumbersome to code</p>
    <ul>
        <% 
        DatabaseConnection.Open Application("ConnectionStringSQL")
        DatabaseStream.Open
        if DatabaseConnection.State = adStateOpen then
            DatabaseCommand.ActiveConnection = DatabaseConnection
            DatabaseCommand.CommandText = "SELECT Customers.CustomerID, Customers.ContactName, Orders.OrderID, Orders.OrderDate, [Order Details].UnitPrice, [Order Details].Quantity, [Order Details].Discount, Products.ProductName FROM Customers INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID INNER JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID INNER JOIN Products ON [Order Details].ProductID = Products.ProductID ORDER BY Customers.ContactName, Orders.OrderDate FOR XML AUTO, ROOT('root')"
            DatabaseCommand.Properties("Output Stream") = DatabaseStream
            DatabaseCommand.Execute , , 1024 'instead of adExecuteStream
            DatabaseStream.Position = 0
            xmlString = DatabaseStream.ReadText
            customerOrdersXSLT.async = false
            if customerOrdersXML.LoadXML(xmlString) then
                If customerOrdersXSLT.Load(Server.MapPath("/App_Data/customer-orders.xslt")) Then
                    Response.Write(customerOrdersXML.transformNode(customerOrdersXSLT))
                End if
            End if
        End if
        %>
    </ul>
</body>
</html>
