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
            Dim DatabaseConnection As New OleDb.OleDbConnection(System.Configuration.ConfigurationManager.ConnectionStrings.Item("NorthwindConnectionStringDatashape").ConnectionString)
            DatabaseConnection.Open()
            If DatabaseConnection.State = ConnectionState.Open Then
                Dim CustomerCommand As New OleDb.OleDbCommand("SHAPE {SELECT CustomerID, ContactName FROM Customers ORDER BY ContactName} APPEND ((SHAPE {SELECT OrderID, OrderDate, CustomerID FROM Orders} APPEND ({SELECT [Order Details].OrderID, Products.ProductName, [Order Details].UnitPrice, [Order Details].Quantity FROM [Order Details] INNER JOIN Products ON [Order Details].ProductID = Products.ProductID } AS rsLineItem RELATE OrderID to OrderID )) AS rsCustomerOrders RELATE CustomerID to CustomerID)", DatabaseConnection)
                Dim CustomerRecordset As OleDb.OleDbDataReader = CustomerCommand.ExecuteReader
                If CustomerRecordset.HasRows Then
                    Do While CustomerRecordset.Read()
        %>
        <li>
            <%= CustomerRecordset("ContactName") %>
            <ul>
                <%
                    Dim OrderRecordset As OleDb.OleDbDataReader = CustomerRecordset("rsCustomerOrders")
                    Do While OrderRecordset.Read
                %>
                <li>
                    <%= OrderRecordset("OrderID") %> - <%= OrderRecordset("OrderDate") %>
                    <ul>
                        <%
                            Dim OrderDetailRecordset As OleDb.OleDbDataReader = OrderRecordset("rsLineItem")
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

