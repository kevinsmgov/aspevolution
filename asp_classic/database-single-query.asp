<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
    Set DatabaseConnection = Server.CreateObject("ADODB.Connection") 
    Set CustomerRecordset = Server.CreateObject("ADODB.Recordset")
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
