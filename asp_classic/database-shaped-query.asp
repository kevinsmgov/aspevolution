<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
    Set DatabaseConnection = Server.CreateObject("ADODB.Connection") 
    Set DatabaseCommand = Server.CreateObject("ADODB.Command") 
    Set CustomerRecordset = Server.CreateObject("ADODB.Recordset")
    Set OrderRecordset = Server.CreateObject("ADODB.Recordset")
    Set OrderDetailRecordset = Server.CreateObject("ADODB.Recordset")
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
    <p>Here's a nested query example from the Northwind database. The query uses the data shaping provider to produce an hierarchical result.</p>
    <p>Data shaping is something of a precursor to LINQ (although, they are not complete exclusive to each other). The query requests the three levels of rows from the database and then relates them on the client side to create the hierarchy.</p>
    <ul>
        <% 
        DatabaseConnection.Open Application("ConnectionStringDataShape")
        if DatabaseConnection.State = adStateOpen then
            CustomerRecordset.Open "SHAPE {SELECT CustomerID, ContactName FROM Customers ORDER BY ContactName} APPEND ((SHAPE {SELECT OrderID, OrderDate, CustomerID FROM Orders} APPEND ({SELECT [Order Details].OrderID, Products.ProductName, [Order Details].UnitPrice, [Order Details].Quantity FROM [Order Details] INNER JOIN Products ON [Order Details].ProductID = Products.ProductID } AS rsLineItem RELATE OrderID to OrderID )) AS rsCustomerOrders RELATE CustomerID to CustomerID)", DatabaseConnection 
            Do While not CustomerRecordset.EOF
        %>
        <li>
            <%= CustomerRecordset("ContactName") %>
            <ul>
                <%
                    Set OrderRecordset = CustomerRecordset("rsCustomerOrders").Value
                    Do While not OrderRecordset.EOF
                %>
                <li>
                    <%= OrderRecordset("OrderID") %>
                        -
                        <%= OrderRecordset("OrderDate") %>
                    <ul>
                        <%
                            Set OrderDetailRecordset = OrderRecordset("rsLineItem").Value
                            Do While not OrderDetailRecordset.EOF
                        %>
                        <li>
                            <%= OrderDetailRecordset("ProductName") %>
                            (
                            <%= FormatCurrency(OrderDetailRecordset("UnitPrice")) %>
                            ×
                            <%= OrderDetailRecordset("Quantity") %>
                            )
                            =
                            <%= FormatCurrency(OrderDetailRecordset("UnitPrice") * OrderDetailRecordset("Quantity")) %>
                        </li>
                        <%
                            OrderDetailRecordset.MoveNext
                            Loop
                        %>
                    </ul>
                </li>
                <%                    
                        OrderRecordset.MoveNext
                    Loop
                %>
            </ul>
        </li>
        <%
            CustomerRecordset.MoveNext
            Loop
            CustomerRecordset.Close
            DatabaseConnection.Close
        End if
        %>
    </ul>
</body>
</html>
