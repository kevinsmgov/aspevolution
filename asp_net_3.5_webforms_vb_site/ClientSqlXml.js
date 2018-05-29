function loadDoc() {
    var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function () {
        if (this.readyState === 4 && this.status === 200) {
            myFunction(this);
        }
    };
    xhttp.open("POST", "/ClientSqlXml.asmx/GetCustomerOrders", true);
    xhttp.setRequestHeader('Content-Type', 'text/json');
    xhttp.send();
}

function myFunction(xhr) {
    var customers = JSON.parse(xhr.responseText);
    var customersUL = document.getElementById("customers");
    for (var customerIndex = 0; customerIndex < customers.length; customerIndex++) {
        setTimeout(function (customerIndex) {
            var customerNode = customers[customerIndex];
            var contactName = customerNode.ContactName;
            var customerLI = document.createElement("li");
            customerLI.innerHTML = contactName;
            var ordersUL = document.createElement("ul");
            var orders = customerNode.Orders;
            for (var orderIndex = 0; orderIndex < orders.length; orderIndex++) {
                var orderNode = orders[orderIndex];
                var orderID = orderNode.OrderID;
                var orderDate = new Date(Date.parse(orderNode.OrderDate));
                var orderLI = document.createElement("li");
                orderLI.innerHTML = orderID + " - " + orderDate.toLocaleDateString("en-US");
                var orderDetailsUL = document.createElement("ul");
                var orderDetails = orderNode.OrderDetails;
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
        }, 1000, customerIndex);
    }
}

loadDoc();