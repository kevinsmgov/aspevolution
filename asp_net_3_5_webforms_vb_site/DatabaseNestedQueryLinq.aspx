<%@ Page Title="Database Nested Query - ASP.NET WebForms VB" Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="True" %>
<%@ Import Namespace="System.Data.Objects" %>
<%@ Import Namespace="System.Data.Linq" %>
<%@ Import Namespace="System.Linq" %>

<script runat="server">

    Sub Page_Load(ByVal Sender As System.Object, ByVal e As System.EventArgs)
        Dim entities As New NorthwindModel.NorthwindEntities
        Dim customersEntity As ObjectQuery(Of NorthwindModel.Customer) = entities.Customers
        Dim customers = From customer In customersEntity.Include("Orders").Include("Orders.Order_Details").Include("Orders.Order_Details.Product") _
                        Order By customer.ContactName
        RepeaterCustomer.DataSource = customers
        RepeaterCustomer.DataBind()
    End Sub

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <p>Here's a nested query example from the Northwind database. The entity framework model provides navigators to nested collections</p>

    <ul>
        <asp:Repeater ID="RepeaterCustomer" runat="server">
            <ItemTemplate>
                <li>
                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("ContactName") %>'></asp:Label>
                    <ul>
                        <asp:Repeater ID="RepeaterOrder" runat="server" DataSource='<%# CType(Container.DataItem, NorthwindModel.Customer).Orders %>'>
                            <ItemTemplate>
                                <li>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("OrderID") %>'></asp:Label>
                                    <asp:Label ID="Label2" runat="server" Text='<%# CType(Eval("OrderDate"), DateTime).ToShortDateString() %>'></asp:Label>
                                    <ul>
                                        <asp:Repeater ID="RepeaterOrderDetail" runat="server" DataSource='<%# CType(Container.DataItem, NorthwindModel.Order).Order_Details %>'>
                                            <ItemTemplate>
                                                <li>
                                                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("Product.ProductName") %>'></asp:Label>
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

