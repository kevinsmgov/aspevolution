<%@ WebService Language="VB" Class="ClientSqlXml" %>

Imports System.Collections.Generic
Imports System.Data
Imports System.Web
Imports System.Web.Script.Services
Imports System.Web.Script.Serialization
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports System.Xml

<WebService(Namespace:="http://localhost/")> _
<WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)> _
<System.Web.Script.Services.ScriptService> _
Public Class ClientSqlXml
    Inherits System.Web.Services.WebService
    'UseHttpGet:=True, 
    <WebMethod()> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)> _
    Public Function GetCustomerOrders() As List(Of Customer)
        Dim js As New JavaScriptSerializer
        Dim DatabaseConnection As New System.Data.SqlClient.SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings.Item("NorthwindSQLConnectionString").ConnectionString)
        DatabaseConnection.Open()
        If DatabaseConnection.State = ConnectionState.Open Then
            Dim CustomerCommand As New System.Data.SqlClient.SqlCommand("SELECT Customers.CustomerID, Customers.ContactName, Orders.OrderID, Orders.OrderDate, [Order Details].UnitPrice, [Order Details].Quantity, [Order Details].Discount, Products.ProductName FROM Customers INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID INNER JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID INNER JOIN Products ON [Order Details].ProductID = Products.ProductID ORDER BY Customers.ContactName, Orders.OrderDate FOR XML AUTO, ROOT('root')", DatabaseConnection)
            Dim xmlDocument As New System.Xml.XmlDocument
            Dim Customers As New List(Of Customer)

            xmlDocument.Load(CustomerCommand.ExecuteXmlReader())
            Dim CustomerNode As XmlElement
            For Each CustomerNode In xmlDocument.DocumentElement.GetElementsByTagName("Customers")
                Dim Customer As New Customer
                Customer.ContactName = CustomerNode.GetAttribute("ContactName")
                Customer.Orders = New List(Of Order)
                Dim OrderNode As XmlElement
                For Each OrderNode In CustomerNode.GetElementsByTagName("Orders")
                    Dim Order As New Order
                    Order.OrderID = OrderNode.GetAttribute("OrderID")
                    Order.OrderDate = DateTime.Parse(OrderNode.GetAttribute("OrderDate"))
                    Order.OrderDetails = New List(Of OrderDetail)
                    Dim OrderDetailNode As XmlElement
                    For Each OrderDetailNode In OrderNode.GetElementsByTagName("Order_x0020_Details")
                        Dim OrderDetail As New OrderDetail
                        OrderDetail.UnitPrice = Decimal.Parse(OrderDetailNode.GetAttribute("UnitPrice"))
                        OrderDetail.Quantity = Decimal.Parse(OrderDetailNode.GetAttribute("Quantity"))
                        OrderDetail.ProductName = CType(OrderDetailNode.GetElementsByTagName("Products")(0), XmlElement).GetAttribute("ProductName")
                        Order.OrderDetails.Add(OrderDetail)
                    Next
                    Customer.Orders.Add(Order)
                Next
                Customers.Add(Customer)
            Next
            Context.Response.Clear()
            Context.Response.Write(js.Serialize(Customers))
            Context.Response.End()
        End If
        Return Nothing
    End Function

End Class

Public Class OrderDetail
    Public UnitPrice As Double
    Public Quantity As Integer
    Public ProductName As String
End Class

Public Class Order
    Public OrderID As Integer
    Public OrderDate As DateTimeOffset
    Public OrderDetails As List(Of OrderDetail)
End Class

Public Class Customer
    Public CustomerID As String
    Public ContactName As String
    Public Orders As List(Of Order)
End Class