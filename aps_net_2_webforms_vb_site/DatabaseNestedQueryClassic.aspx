<%@ Page Title="Database Single Query - ASP.NET WebForms VB" Language="VB" MasterPageFile="~/MasterPage.master" %>

<%@ Import Namespace="System.Data" %>
<script runat="server">

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <p>Here's a nested query example from the Northwind database. ASP.Net supports classic ASP syntax and similar object constructs (making it easier to convert legacy code over)</p>
    <ul>
        <% 
            Dim DatabaseConnection As New OleDb.OleDbConnection(System.Configuration.ConfigurationManager.ConnectionStrings.Item("NorthwindConnectionString").ConnectionString)
            DatabaseConnection.Open()
            If DatabaseConnection.State = ConnectionState.Open Then
                Dim CustomerCommand As New OleDb.OleDbCommand("SELECT CustomerID, ContactName FROM Customers ORDER BY ContactName", DatabaseConnection)
                Dim CustomerRecordset As OleDb.OleDbDataReader = CustomerCommand.ExecuteReader
                If CustomerRecordset.HasRows Then
                    Do While CustomerRecordset.Read()
        %>
        <li>
            <%= CustomerRecordset("ContactName") %>
            <ul>
                <%
                    Dim OrderCommand As New OleDb.OleDbCommand("SELECT OrderID, OrderDate FROM Orders WHERE CustomerID = @customerid", DatabaseConnection)
                    OrderCommand.Parameters.Add(New OleDb.OleDbParameter("@customerid", CustomerRecordset("CustomerID")))
                    Dim OrderRecordset As OleDb.OleDbDataReader = OrderCommand.ExecuteReader()
                    Do While OrderRecordset.Read
                %>
                <li>
                    <%= OrderRecordset("OrderID") %> - <%= OrderRecordset("OrderDate") %>
                    <ul>
                        <%
                            Dim OrderDetailCommand As New OleDb.OleDbCommand("SELECT Products.ProductName, Products.UnitPrice, [Order Details].Quantity FROM [Order Details] INNER JOIN Products ON [Order Details].ProductID = Products.ProductID WHERE OrderID = @orderid", DatabaseConnection)
                            OrderDetailCommand.Parameters.Add(New OleDb.OleDbParameter("@orderid", OrderRecordset("OrderID")))
                            Dim OrderDetailRecordset As OleDb.OleDbDataReader = OrderDetailCommand.ExecuteReader
                            Do While OrderDetailRecordset.Read
                        %>
                        <li>
                            <%= OrderDetailRecordset("ProductName") %> ( <%= FormatCurrency(OrderDetailRecordset("UnitPrice")) %> × <%= OrderDetailRecordset("Quantity") %> ) = <%= FormatCurrency(OrderDetailRecordset("UnitPrice") * OrderDetailRecordset("Quantity")) %>
                        </li>
                        <%
                            Loop
                            OrderDetailRecordset.Close()
                        %>
                    </ul>
                </li>
                <%                    
                    Loop
                    OrderRecordset.Close()
                %>
            </ul>
        </li>
        <%
                    Loop
                    CustomerRecordset.Close()
                    DatabaseConnection.Close()
                End If
            End If
        %>
    </ul>
</asp:Content>

