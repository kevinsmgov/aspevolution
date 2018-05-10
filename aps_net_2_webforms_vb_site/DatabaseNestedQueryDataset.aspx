<%@ Page Title="Database Nested Query - ASP.NET WebForms VB" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="True" %>

<script runat="server">

    Sub Page_Load(ByVal Sender As System.Object, ByVal e As System.EventArgs)
        Dim dataset As New NorthwindDataSet
        Dim CustomersTableAdapter As New NorthwindDataSetTableAdapters.CustomersTableAdapter
        Dim OrdersTableAdapter As New NorthwindDataSetTableAdapters.OrdersTableAdapter
        Dim Order_DetailsTableAdapter As New NorthwindDataSetTableAdapters.Order_DetailsTableAdapter
        CustomersTableAdapter.Fill(dataset.Customers)
        OrdersTableAdapter.Fill(dataset.Orders)
        Order_DetailsTableAdapter.Fill(dataset.Order_Details)
        RepeaterCustomer.DataSource = dataset
        RepeaterCustomer.DataBind()
    End Sub

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <p>Here's a nested query example from the Northwind database. The Dataset manages the relations and nested content automatically</p>

    <ul>
        <asp:Repeater ID="RepeaterCustomer" runat="server">
            <ItemTemplate>
                <li>
                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("ContactName") %>'></asp:Label>
                    <ul>
                        <asp:Repeater ID="RepeaterOrder" runat="server" DataSource='<%# CType(Container.DataItem, Data.DataRowView).Row.GetChildRows("Customers_Orders") %>'>
                            <ItemTemplate>
                                <li>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("OrderID") %>'></asp:Label>
                                    <asp:Label ID="Label2" runat="server" Text='<%# CType(Eval("OrderDate"), DateTime).ToShortDateString() %>'></asp:Label>
                                    <ul>
                                        <asp:Repeater ID="RepeaterOrderDetail" runat="server" DataSource='<%# CType(Container.DataItem, Data.DataRow).GetChildRows("Orders_Order Details") %>'>
                                            <ItemTemplate>
                                                <li>
                                                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("ProductName") %>'></asp:Label>
                                                    (
                                                    <asp:Label ID="Label2" runat="server" Text='<%# Eval("UnitPrice") %>'></asp:Label>
                                                    ×
                                                    <asp:Label ID="Label3" runat="server" Text='<%# Eval("Quantity") %>'></asp:Label>
                                                    ) =
                                                    <asp:Label ID="Label4" runat="server" Text='<%# Eval("UnitPrice") * Eval("Quantity") %>'></asp:Label>
                                                </li>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </ul>
                                </li>
                            </ItemTemplate>
                        </asp:Repeater>
                    </ul>
                </li>
            </ItemTemplate>
        </asp:Repeater>
    </ul>
</asp:Content>

