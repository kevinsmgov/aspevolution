<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
    Set DatabaseConnection = Server.CreateObject("ADODB.Connection") 
    Set DatabaseCommand = Server.CreateObject("ADODB.Command") 
    Set DatabaseStream = Server.CreateObject("ADODB.Stream")
    Set customerOrdersXML = Server.CreateObject( "Microsoft.XMLDOM" )
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
    <p>Here's a nested query example from the Northwind database. By using the "FOR XML" clause in the SQL query, the result is returned with the hierarchy intact allowing us to traverse it easily.</p>
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
            if customerOrdersXML.LoadXML(xmlString) then
            For each customersNode in customerOrdersXML.documentElement.childNodes
        %>
        <li>
            <%= customersNode.getAttribute("ContactName") %>
            <ul>
                <%
                For each ordersNode in customersNode.childNodes
                %>
                <li>
                    <%
                        orderID = ordersNode.getAttribute("OrderID")
                        orderDate = ordersNode.getAttribute("OrderDate")
                    %>
                    <%= orderID %> - <%= orderDate %>
                    <ul>
                        <%
                        For each Order_x0020_Details in ordersNode.childNodes
                            ProductName = Order_x0020_Details.selectSingleNode("Products").getAttribute("ProductName")
                            UnitPrice = CCur(Order_x0020_Details.getAttribute("UnitPrice"))
                            Quantity = CInt(Order_x0020_Details.getAttribute("Quantity"))
                        %>
                        <li>
                            <%= productName %>
                            (
                            <%= FormatCurrency(UnitPrice) %>
                            ×
                            <%= Quantity %>
                            ) =
                            <%= FormatCurrency(UnitPrice * Quantity) %>
                        </li>
                        <%
                        Next
                        %>
                    </ul>
                </li>
                <%                    
                Next
                %>
            </ul>
        </li>
        <%
        Next
            End if
        End if
        %>
    </ul>
</body>
</html>
