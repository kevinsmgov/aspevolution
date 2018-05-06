<%@ Page Title="Database Single Query - ASP.NET WebForms VB" Language="VB" MasterPageFile="~/MasterPage.master" %>

<%@ Import Namespace="System.Data" %>
<script runat="server">

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <p>Here's a single query example from the Northwind database. ASP.Net supports classic ASP syntax and similar object constructs (making it easier to convert legacy code over)</p>

    <ul>
        <%
            Dim DatabaseConnection As New OleDb.OleDbConnection(System.Configuration.ConfigurationManager.ConnectionStrings.Item("NorthwindConnectionString").ConnectionString)
            DatabaseConnection.Open()
            If DatabaseConnection.State = ConnectionState.Open Then
                Dim CustomerCommand As New OleDb.OleDbCommand("SELECT ContactName from Customers ORDER BY ContactName", DatabaseConnection)
                Dim CustomerRecordset As OleDb.OleDbDataReader = CustomerCommand.ExecuteReader()
                Do While CustomerRecordset.Read
        %>
        <li><%= CustomerRecordset("ContactName") %></li>
        <% 
                loop
            End If
        %>
    </ul>
</asp:Content>

