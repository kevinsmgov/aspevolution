<%@ Page Title="Database Single Query - ASP.NET WebForms VB" Language="VB" MasterPageFile="~/MasterPage.master" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Xml" %>

<script runat="server">

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <p>Here's a nested query example from the Northwind SQL database. It leverages the XML features introduced in SQL 2005 to create the hierarchy as nested XML in the SQL response</p>
    <ul>
        <% 
            Dim DatabaseConnection As New System.Data.SqlClient.SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings.Item("NorthwindSQLConnectionString").ConnectionString)
            DatabaseConnection.Open()
            If DatabaseConnection.State = ConnectionState.Open Then
                Dim CustomerCommand As New System.Data.SqlClient.SqlCommand("SELECT Customers.CustomerID, Customers.ContactName, Orders.OrderID, Orders.OrderDate, [Order Details].UnitPrice, [Order Details].Quantity, [Order Details].Discount, Products.ProductName FROM Customers INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID INNER JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID INNER JOIN Products ON [Order Details].ProductID = Products.ProductID ORDER BY Customers.ContactName, Orders.OrderDate FOR XML AUTO, ROOT('root')", DatabaseConnection)
                Dim xmlDocument As New System.Xml.XmlDocument
                xmlDocument.Load(CustomerCommand.ExecuteXmlReader())
                Dim CustomerNodeList As XmlNodeList = xmlDocument.SelectNodes("root/Customers")
                Dim CustomerNode As XmlNode

                For Each CustomerNode In CustomerNodeList
        %>
        <li>
            <%= CustomerNode.SelectSingleNode("@ContactName").Value %>
            <ul>
                <%
                    Dim OrdersNodeList As XmlNodeList = CustomerNode.SelectNodes("Orders")
                    Dim OrderNode As XmlNode
                    For Each OrderNode In OrdersNodeList
                %>
                <li>
                    <%= OrderNode.SelectSingleNode("@OrderID").Value %> 
                    - 
                    <%= CType(OrderNode.SelectSingleNode("@OrderDate").Value, DateTime) %>
                    <ul>
                        <%
                            Dim OrderDetailNodeList As XmlNodeList = OrderNode.SelectNodes("Order_x0020_Details")
                            Dim OrderDetailNode As XmlNode
                            For Each OrderDetailNode In OrderDetailNodeList
                        %>
                        <li>
                            <%= OrderDetailNode.SelectSingleNode("Products").SelectSingleNode("@ProductName").Value %> ( <%= FormatCurrency(CType(OrderDetailNode.SelectSingleNode("@UnitPrice").Value, Decimal)) %> × <%= OrderDetailNode.SelectSingleNode("@Quantity").Value %> ) = <%= FormatCurrency(CType(OrderDetailNode.SelectSingleNode("@UnitPrice").Value, Decimal) * CType(OrderDetailNode.SelectSingleNode("@Quantity").Value, Single)) %>
                        </li>
                        <%
                            Next
                        %>
                    </ul>
                </li>
                <%                    
                    Next
                %>
            </ul>
        </li>
        <%
                Next
            End If
        %>
    </ul>
</asp:Content>

