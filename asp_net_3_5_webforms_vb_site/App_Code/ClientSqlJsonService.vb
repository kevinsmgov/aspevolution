Imports System.Collections.Generic
Imports System.Data.Objects
Imports System.Linq
Imports System.ServiceModel
Imports System.ServiceModel.Activation
Imports System.ServiceModel.Web

<ServiceContract(Namespace:="")> _
<AspNetCompatibilityRequirements(RequirementsMode:=AspNetCompatibilityRequirementsMode.Allowed)> _
Public Class ClientSqlJsonService

    ' To use HTTP GET, add <WebGet()> attribute. (Default ResponseFormat is WebMessageFormat.Json)
    ' To create an operation that returns XML,
    '     add <WebGet(ResponseFormat:=WebMessageFormat.Xml)>,
    '     and include the following line in the operation body:
    '         WebOperationContext.Current.OutgoingResponse.ContentType = "text/xml"
    <OperationContract()> _
    Public Sub DoWork()
        ' Add your operation implementation here
    End Sub

    ' Add more operations here and mark them with <OperationContract()> 
    ' <WebGet(ResponseFormat:=WebMessageFormat.Json, BodyStyle:=WebMessageBodyStyle.Bare)>
    <OperationContract()> Public Function GetCustomerOrders() As List(Of Customer)
        Using entities As New NorthwindModel.NorthwindEntities()
            Dim customersEntity As ObjectQuery(Of NorthwindModel.Customer) = entities.Customers
            Dim customers = From customer In customersEntity.Include("Orders").Include("Orders.Order_Details").Include("Orders.Order_Details.Product") _
                            Order By customer.ContactName _
                            Select New Customer With { _
                                .CustomerID = customer.CustomerID, _
                                .ContactName = customer.ContactName, _
                                .Orders = From order In customer.Orders _
                                          Order By order.OrderDate _
                                          Select New Order With { _
                                              .OrderID = order.OrderID, _
                                              .OrderDate = order.OrderDate, _
                                              .Order_Details = From order_detail In order.Order_Details _
                                                               Select New Order_Detail With { _
                                                                   .UnitPrice = order_detail.UnitPrice, _
                                                                   .Quantity = order_detail.Quantity, _
                                                                   .ProductName = order_detail.Product.ProductName}}}
            Return customers.ToList
        End Using
    End Function

End Class

Public Class Customer
    Public CustomerID As String
    Public ContactName As String
    Public Orders As IEnumerable(Of Order)
End Class

Public Class Order
    Public OrderID As Integer
    Public OrderDate As DateTime
    Public Order_Details As IEnumerable(Of Order_Detail)
End Class

Public Class Order_Detail
    Public UnitPrice As Decimal
    Public Quantity As Integer
    Public ProductName As String
End Class