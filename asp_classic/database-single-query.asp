<!DOCTYPE html>
<%
    Set DatabaseConnection = Server.CreateObject("ADODB.Connection") 
    Set CustomerRecordset = Server.CreateObject("ADODB.Recordset")
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
    <p>Here's a single query example from the Northwind database. A simple select and subsequent loop through the results.</p>
    <ul>
        <% 
        DatabaseConnection.Open Application("ConnectionString")
        if DatabaseConnection.State = adStateOpen then
            CustomerRecordset.Open "SELECT ContactName FROM Customers ORDER BY ContactName", DatabaseConnection 
            Do While not CustomerRecordset.EOF
        %>
        <li><%= CustomerRecordset("ContactName") %></li>
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
