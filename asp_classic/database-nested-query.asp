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
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
    <title>Classic ASP - Database</title>
    <link href="standard.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <h1>Classic ASP - Database</h1>
    <!-- #include file="menu.asp" -->
    <p>Here's a nested query example from the Northwind database. A simple select and subsequent loop through the results. But, for each result, a nested query to return related records.</p>
    <p>The approach is obviously inefficient as the database is requeried for each iteration. It's also cumbersome to code</p>
    <ul>
        <% 
        DatabaseConnection.Open Application("ConnectionString")
        if DatabaseConnection.State = adStateOpen then
        CustomerRecordset.Open "SELECT CustomerID, ContactName FROM Customers ORDER BY ContactName", DatabaseConnection 
        Do While not CustomerRecordset.EOF
        %>
        <li>
            <%= CustomerRecordset("ContactName") %>
            <ul>
                <%
                Set customerid = DatabaseCommand.CreateParameter(, adVarChar, adParamInput, 255, CustomerRecordset("customerid"))
                DatabaseCommand.ActiveConnection  = DatabaseConnection
                DatabaseCommand.CommandText =  "SELECT OrderID, OrderDate FROM Orders WHERE CustomerID = ?"
                DatabaseCommand.CommandType = adCmdText
                DatabaseCommand.Parameters(0) = customerid
                Set OrderRecordset = DatabaseCommand.Execute
                Do While not OrderRecordset.EOF
                %>
                <li>
                    <%= OrderRecordset("OrderID") %> - <%= OrderRecordset("OrderDate") %>
                    <ul>
                        <%
                        Set orderid = DatabaseCommand.CreateParameter(, adInteger, adParamInput, , OrderRecordset("orderid"))
                        'DatabaseCommand.ActiveConnection  = DatabaseConnection
                        DatabaseCommand.CommandText =  "SELECT Products.ProductName, Products.UnitPrice, [Order Details].Quantity FROM [Order Details] INNER JOIN Products ON [Order Details].ProductID = Products.ProductID WHERE OrderID = ?"
                        DatabaseCommand.CommandType = adCmdText
                        DatabaseCommand.Parameters(0) = orderid
                        Set OrderDetailRecordset = DatabaseCommand.Execute
                        Do While not OrderDetailRecordset.EOF
                        %>
                        <li>
                            <%= OrderDetailRecordset("ProductName") %> ( <%= FormatCurrency(OrderDetailRecordset("UnitPrice")) %> × <%= OrderDetailRecordset("Quantity") %> ) = <%= FormatCurrency(OrderDetailRecordset("UnitPrice") * OrderDetailRecordset("Quantity")) %>
                        </li>
                        <%
                        OrderDetailRecordset.MoveNext
                        Loop
                        OrderDetailRecordset.Close
                        %>
                    </ul>
                </li>
                <%                    
                OrderRecordset.MoveNext
                Loop
                OrderRecordset.Close
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
