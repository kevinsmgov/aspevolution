<%@ Page Title="Database Nested Query - ASP.NET WebForms VB" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="True" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Xml" %>

<script runat="server">

    Sub Page_Load(ByVal Sender As System.Object, ByVal e As System.EventArgs)
        Dim DatabaseConnection As New System.Data.SqlClient.SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings.Item("NorthwindSQLConnectionString").ConnectionString)
        DatabaseConnection.Open()
        If DatabaseConnection.State = ConnectionState.Open Then
            Dim CustomerCommand As New System.Data.SqlClient.SqlCommand("SELECT Customers.CustomerID, Customers.ContactName, Orders.OrderID, Orders.OrderDate, [Order Details].UnitPrice, [Order Details].Quantity, [Order Details].Discount, Products.ProductName FROM Customers INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID INNER JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID INNER JOIN Products ON [Order Details].ProductID = Products.ProductID ORDER BY Customers.ContactName, Orders.OrderDate FOR XML AUTO, ROOT('root')", DatabaseConnection)
            Dim xmlDocment As New System.Xml.XmlDocument()
            xmlDocment.Load(CustomerCommand.ExecuteXmlReader())
            Xml1.Document = xmlDocment
        End If
    End Sub

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <p>Here's a nested query example from the Northwind SQL database. It leverages the XML features introduced in SQL 2005 to create the hierarchy as nested XML in the SQL response. It uses an XSLT transformation to emit the hierarchy in the page.</p>

    <ul>
        <asp:Xml ID="Xml1" runat="server" TransformSource="~/DatabaseNestedQuerySQLXML.xslt"></asp:Xml>
    </ul>
</asp:Content>

