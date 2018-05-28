<%@  language="javascript" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
    var DatabaseConnection = Server.CreateObject("ADODB.Connection");
    var DatabaseCommand = Server.CreateObject("ADODB.Command");
    var CustomerRecordset = Server.CreateObject("ADODB.Recordset");
    var OrderRecordset = Server.CreateObject("ADODB.Recordset");
    var OrderDetailRecordset = Server.CreateObject("ADODB.Recordset");
%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
    <title>Classic ASP - Database</title>
    <link href="standard.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <h1>Classic ASP - Database</h1>
    <!-- #include file="menu.asp" -->
    <p>Here's a nested query example from the Northwind database. The query uses the data shaping provider to produce an hierarchical result.</p>
    <p>Data shaping is something of a precursor to LINQ (although, they are not complete exclusive to each other). The query requests the three levels of rows from the database and then relates them on the client side to create the hierarchy.</p>
    <ul>
        <% 
            DatabaseConnection.Open(Application("ConnectionStringDataShape"));
            if (DatabaseConnection.State == adStateOpen) {
                CustomerRecordset.Open("SHAPE {SELECT CustomerID, ContactName FROM Customers ORDER BY ContactName} APPEND ((SHAPE {SELECT OrderID, OrderDate, CustomerID FROM Orders} APPEND ({SELECT [Order Details].OrderID, Products.ProductName, [Order Details].UnitPrice, [Order Details].Quantity FROM [Order Details] INNER JOIN Products ON [Order Details].ProductID = Products.ProductID } AS rsLineItem RELATE OrderID to OrderID )) AS rsCustomerOrders RELATE CustomerID to CustomerID)", DatabaseConnection);
                while (!CustomerRecordset.EOF) {
        %>
        <li>
            <%= CustomerRecordset("ContactName") %>
            <ul>
                <%
                    var OrderRecordset = CustomerRecordset("rsCustomerOrders").Value;
                    while (!OrderRecordset.EOF) {
                %>
                <li>
                    <%= OrderRecordset("OrderID") %>
                        -
                        <%= OrderRecordset("OrderDate") %>
                    <ul>
                        <%
                        var OrderDetailRecordset = OrderRecordset("rsLineItem").Value;
                        while (!OrderDetailRecordset.EOF) {
                        %>
                        <li>
                            <%= OrderDetailRecordset.ProductName %>
                            (
                            <%= FormatCurrency(OrderDetailRecordset("UnitPrice")) %>
                            ×
                            <%= OrderDetailRecordset("Quantity") %>
                            )
                            =
                            <%= FormatCurrency(OrderDetailRecordset("UnitPrice") * OrderDetailRecordset("Quantity")) %>
                        </li>
                        <%;
                            OrderDetailRecordset.MoveNext();
                        }
                        %>
                    </ul>
                </li>
                <%                    
                        OrderRecordset.MoveNext();
                    }
                %>
            </ul>
        </li>
        <%
                    CustomerRecordset.MoveNext();
                }
                CustomerRecordset.Close();
                DatabaseConnection.Close();
            }
        %>
    </ul>
</body>
</html>
