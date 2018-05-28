<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
    Set customerOrdersXML = Server.CreateObject( "Microsoft.XMLDOM" )
%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
    <title>Classic ASP - Database</title>
    <link href="standard.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <h1>Classic ASP - XML</h1>
    <!-- #include file="menu.asp" -->
    <p>Here is a nested result from an XML data file</p>
    <ul>
        <% 
            If customerOrdersXML.Load(Server.MapPath("/App_Data/customer-orders.xml")) Then
            For each customersNode in customerOrdersXML.documentElement.childNodes
        %>
        <li>
            <%= customersNode.getAttribute("ContactName") %>
            <ul>
                <%
                For each ordersNode in customersNode.childNodes
                %>
                <li>
                    <%
                        orderID = ordersNode.getAttribute("OrderID")
                        orderDate = ordersNode.getAttribute("OrderDate")
                    %>
                    <%= orderID %> - <%= orderDate %>
                    <ul>
                        <%
                        For each Order_x0020_Details in ordersNode.childNodes
                            ProductName = Order_x0020_Details.selectSingleNode("Products").getAttribute("ProductName")
                            UnitPrice = CCur(Order_x0020_Details.getAttribute("UnitPrice"))
                            Quantity = CInt(Order_x0020_Details.getAttribute("Quantity"))
                        %>
                        <li>
                            <%= productName %>
                            (
                            <%= FormatCurrency(UnitPrice) %>
                            ×
                            <%= Quantity %>
                            ) =
                            <%= FormatCurrency(UnitPrice * Quantity) %>
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
        End if
        %>
    </ul>
</body>
</html>
