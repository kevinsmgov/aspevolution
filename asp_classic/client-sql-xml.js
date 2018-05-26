
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
function myFunction(xml) {
    var xmlDoc = xml.responseXML;
    var customers = xmlDoc.getElementsByTagName("Customers");
    var customerList = document.getElementById("customers");
    for (var customerIndex = 0; customerIndex < customers.length; customerIndex++) {
        setTimeout(function (customerIndex) {
            var customerNode = customers[customerIndex];
            var contactNameAttribute = customerNode.getAttribute("ContactName");
            var contactNameElement = document.createElement("li");
            contactNameElement.innerHTML = contactNameAttribute;
            var ordersList = document.createElement("ul");
            var orders = customerNode.getElementsByTagName("Orders");
            for (var orderIndex = 0; orderIndex < orders.length; orderIndex++) {
                var orderNode = orders[orderIndex];
                var orderID = orderNode.getAttribute("OrderID")
                var orderDate = new Date(Date.parse(orderNode.getAttribute("OrderDate")))
                var orderElement = document.createElement("li")
                orderElement.innerHTML = orderID + " - " + orderDate.toLocaleDateString("en-US")
                ordersList.appendChild(orderElement)
                var orderDetailList = document.createElement("ul")
                var orderDetails = orderNode.getElementsByTagName("Order_x0020_Details");
                for (var orderDetailIndex = 0; orderDetailIndex < orderDetails.length; orderDetailIndex++) {
                    var orderDetail = orderDetails[orderDetailIndex];
                    var product = orderDetail.getElementsByTagName("Products").item(0).getAttribute("ProductName");
                    var unitPrice = parseFloat(orderDetail.getAttribute("UnitPrice"));
                    var quantity = parseInt(orderDetail.getAttribute("Quantity"));
                    var orderDetailElement = document.createElement("li");
                    orderDetailElement.innerHTML = product + " (" + unitPrice.toFixed(2) + " × " + quantity + ") = " + (unitPrice * quantity).toFixed(2)
                    orderDetailList.appendChild(orderDetailElement);
                }
                ordersList.appendChild(orderDetailList);
            }
            contactNameElement.appendChild(ordersList);
            customerList.appendChild(contactNameElement);
        }, 1000, customerIndex);
    }
}
loadDoc();