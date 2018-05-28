
function loadDoc() {
    var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function () {
        if (this.readyState === 4 && this.status === 200) {
            myFunction(this);
        }
    };
    xhttp.open("GET", "client-sql-xml-json.asp?json", true);
    xhttp.send();
}
function myFunction(xhr) {
    var customers = JSON.parse(xhr.responseText);
    var customersUL = document.getElementById("customers");
    for (var customerIndex = 0; customerIndex < customers.length; customerIndex++) {
        setTimeout(function (customerIndex) {
            var customerNode = customers[customerIndex];
            var contactName = customerNode.contactName;
            var customerLI = document.createElement("li");
            customerLI.innerHTML = contactName;
            var ordersUL = document.createElement("ul");
            var orders = customerNode.orders;
            for (var orderIndex = 0; orderIndex < orders.length; orderIndex++) {
                var orderNode = orders[orderIndex];
                var orderID = orderNode.orderID;
                var orderDate = new Date(Date.parse(orderNode.orderDate));
                var orderLI = document.createElement("li");
                orderLI.innerHTML = orderID + " - " + orderDate.toLocaleDateString("en-US");
                var orderDetailsUL = document.createElement("ul");
                var orderDetails = orderNode.orderDetails;
                for (var orderDetailIndex = 0; orderDetailIndex < orderDetails.length; orderDetailIndex++) {
                    var orderDetail = orderDetails[orderDetailIndex];
                    var product = orderDetail.productName;
                    var unitPrice = parseFloat(orderDetail.unitPrice);
                    var quantity = parseInt(orderDetail.quantity);
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