<!DOCTYPE html>
<%
    Dim DatabaseConnection, DatabaseRecordset
    Set DatabaseConnection = Server.CreateObject("ADODB.Connection") 
    Set DatabaseRecordset = Server.CreateObject("ADODB.Recordset")
%>
<html>
<head>
    <meta charset="utf-8" />
    <title>Classic ASP - Database</title>
</head>
<body>
    <h1>Classic ASP - Database</h1>
    <ul>
        <% 
        DatabaseConnection.Open Application("ConnectionString")
        if DatabaseConnection.State = adStateOpen then
            DatabaseRecordset.Open "SELECT * FROM Customers ORDER BY ContactName", DatabaseConnection 
            Do While not DatabaseRecordset.EOF
        %>
        <li><%= DatabaseRecordset("ContactName") %></li>
        <%
                DatabaseRecordset.MoveNext
            Loop
            DatabaseRecordset.Close
            DatabaseConnection.Close
        End if
        %>
    </ul>
</body>
</html>
