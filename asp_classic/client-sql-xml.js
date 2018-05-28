
function loadDoc() {
    var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function () {
        if (this.readyState == 4 && this.status == 200) {
            myFunction(this);
        }
    };
    xhttp.open("GET", "client-sql-xml.asp?xml", true);
    xhttp.send();
}
function myFunction(xhr) {
    var xmlDoc = xhr.responseXML;
    var customers = xmlDoc.getElementsByTagName("Customers");
    var customersUL = document.getElementById("customers");
    for (var customerIndex = 0; customerIndex < customers.length; customerIndex++) {
        setTimeout(function (customerIndex) {
            var customerNode = customers[customerIndex];
            var contactNameAttribute = customerNode.getAttribute("ContactName");
            var customerLI = document.createElement("li");
            customerLI.innerHTML = contactNameAttribute;
            var ordersUL = document.createElement("ul");
            var orders = customerNode.getElementsByTagName("Orders");
            for (var orderIndex = 0; orderIndex < orders.length; orderIndex++) {
                var orderNode = orders[orderIndex];
                var orderID = orderNode.getAttribute("OrderID")
                var orderDate = new Date(Date.parse(orderNode.getAttribute("OrderDate")))
                var orderLI = document.createElement("li")
                orderLI.innerHTML = orderID + " - " + orderDate.toLocaleDateString("en-US")
                var orderDetailsUL = document.createElement("ul")
                var orderDetails = orderNode.getElementsByTagName("Order_x0020_Details");
                for (var orderDetailIndex = 0; orderDetailIndex < orderDetails.length; orderDetailIndex++) {
                    var orderDetail = orderDetails[orderDetailIndex];
                    var product = orderDetail.getElementsByTagName("Products").item(0).getAttribute("ProductName");
                    var unitPrice = parseFloat(orderDetail.getAttribute("UnitPrice"));
                    var quantity = parseInt(orderDetail.getAttribute("Quantity"));
                    var orderDetailLI = document.createElement("li");
                    orderDetailLI.innerHTML = product + " (" + unitPrice.toFixed(2) + " × " + quantity + ") = " + (unitPrice * quantity).toFixed(2)
                    orderDetailsUL.appendChild(orderDetailLI);
                }
                orderLI.appendChild(orderDetailsUL);
                ordersUL.appendChild(orderLI)
            }
            customerLI.appendChild(ordersUL);
            customersUL.appendChild(customerLI);
        }, 1000, customerIndex);
    }
}
loadDoc();