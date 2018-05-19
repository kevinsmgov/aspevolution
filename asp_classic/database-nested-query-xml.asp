<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
    Set customerOrdersXML = Server.CreateObject( "Microsoft.XMLDOM" )
%>
<html>
<head>
    <meta charset="utf-8" />
    <title>Classic ASP - Database</title>
    <style>
        body {
            width: 66em;
        }
    </style>
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
            <%= customersNode.attributes(1).text %>
            <ul>
                <%
                For each ordersNode in customersNode.childNodes
                %>
                <li>
                    <%= ordersNode.attributes(0).text %> - <%= ordersNode.attributes(1).text %>
                    <ul>
                        <%
                        For each Order_x0020_Details in ordersNode.childNodes
                            ProductName = Order_x0020_Details.childNodes(0).attributes(0).text
                            UnitPrice = CCur(Order_x0020_Details.attributes(0).text)
                            Quantity = CInt(Order_x0020_Details.attributes(1).text)
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
