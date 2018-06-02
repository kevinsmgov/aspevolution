ClientSqlXmlService.GetCustomerOrders(onSuccess, null, null);
function onSuccess(result) {
    var customers = result;
    var customersUL = document.getElementById("customers");
    for (var customerIndex in customers) {
        var customer = customers[customerIndex];
        var contactName = customer.ContactName;
        var customerLI = document.createElement("li");
        customerLI.innerHTML = contactName;
        var ordersUL = document.createElement("ul");
        var orders = customer.Orders;
        for (var orderIndex in orders) {
            var order = orders[orderIndex];
            var orderID = order.OrderID;
            var orderDate = order.OrderDate;
            var orderLI = document.createElement("li");
            orderLI.innerHTML = orderID + " - " + orderDate.toLocaleDateString("en-US");
            var orderDetailsUL = document.createElement("ul");
            var orderDetails = order.Order_Details;
            for (var orderDetailIndex in orderDetails) {
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