<%@ WebService Language="VB" Class="ClientSqlXml" %>

Imports System.Data
Imports System.Web
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports System.Xml

<WebService(Namespace:="http://localhost/")> _
<WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)> _
Public Class ClientSqlXml
    Inherits System.Web.Services.WebService

    <WebMethod()> _
    Public Function GetCustomerOrders() As XmlDocument
        Dim DatabaseConnection As New System.Data.SqlClient.SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings.Item("NorthwindSQLConnectionString").ConnectionString)
        DatabaseConnection.Open()
        If DatabaseConnection.State = ConnectionState.Open Then
            Dim CustomerCommand As New System.Data.SqlClient.SqlCommand("SELECT Customers.CustomerID, Customers.ContactName, Orders.OrderID, Orders.OrderDate, [Order Details].UnitPrice, [Order Details].Quantity, [Order Details].Discount, Products.ProductName FROM Customers INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID INNER JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID INNER JOIN Products ON [Order Details].ProductID = Products.ProductID ORDER BY Customers.ContactName, Orders.OrderDate FOR XML AUTO, ROOT('root')", DatabaseConnection)
            Dim xmlDocument As New System.Xml.XmlDocument
            xmlDocument.Load(CustomerCommand.ExecuteXmlReader())
            Return xmlDocument
        End If
        Return New XmlDocument
    End Function

End Class
