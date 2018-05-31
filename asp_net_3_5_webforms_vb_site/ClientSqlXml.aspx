<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" %>

<script runat="server">

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManagerProxy ID="ScriptManagerProxy1" runat="server">
        <Services>
            <asp:ServiceReference Path="~/ClientSqlXmlService.svc" />
        </Services>
    </asp:ScriptManagerProxy>
    <p>AJAX request</p>
    <ul id="customers">
    </ul>
    <script language="javascript" type="text/javascript">
        // <!CDATA[
        ClientSqlXmlService.GetCustomerOrders(onSuccess, null, null);
        function onSuccess(result) {
            var customers = result;
            var customersUL = document.getElementById("customers");
            for (var customerIndex = 0; customerIndex < customers.length; customerIndex++) {
                var customerNode = customers[customerIndex];
                var contactName = customerNode.ContactName;
                var customerLI = document.createElement("li");
                customerLI.innerHTML = contactName;
                var ordersUL = document.createElement("ul");
                var orders = customerNode.Orders;
                for (var orderIndex = 0; orderIndex < orders.length; orderIndex++) {
                    var orderNode = orders[orderIndex];
                    var orderID = orderNode.OrderID;
                    var orderDate = orderNode.OrderDate;
                    var orderLI = document.createElement("li");
                    orderLI.innerHTML = orderID + " - " + orderDate.toLocaleDateString("en-US");
                    var orderDetailsUL = document.createElement("ul");
                    var orderDetails = orderNode.Order_Details;
                    for (var orderDetailIndex = 0; orderDetailIndex < orderDetails.length; orderDetailIndex++) {
                        var orderDetail = orderDetails[orderDetailIndex];
                        var product = orderDetail.ProductName;
                        var unitPrice = parseFloat(orderDetail.UnitPrice);
                        var quantity = parseInt(orderDetail.Quantity);
                        var orderDetailLI = document.createElement("li");
                        orderDetailLI.innerHTML = product + " (" + unitPrice.toFixed(2) + " × " + quantity + ") = " + (unitPrice * quantity).toFixed(2);
                        orderDetailsUL.appendChild(orderDetailLI);
                    }
                    orderLI.appendChild(orderDetailsUL);
                    ordersUL.appendChild(orderLI);
                }
                customerLI.appendChild(ordersUL);
                customersUL.appendChild(customerLI);
            }
        }
        // ]]>
    </script>
</asp:Content>

