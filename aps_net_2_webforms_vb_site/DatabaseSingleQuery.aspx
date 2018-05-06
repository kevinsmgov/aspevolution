<%@ Page Title="Database Single Query - ASP.NET WebForms VB" Language="VB" MasterPageFile="~/MasterPage.master" %>

<script runat="server">

    Sub Page_Load(ByVal Sender As System.Object, ByVal e As System.EventArgs)
        Dim dataSource As New AccessDataSource(Server.MapPath("~/App_Data/Northwind.mdb"), "SELECT ContactName from Customers ORDER BY ContactName")
        RepeaterCustomer.DataSource = dataSource
        RepeaterCustomer.DataBind()
    End Sub

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <p>Here's a single query example from the Northwind database. The query is hidden away in the dataset object.</p>

    <ul>
        <asp:Repeater ID="RepeaterCustomer" runat="server">
            <ItemTemplate>
                <li>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("ContactName") %>'></asp:Label></li>
            </ItemTemplate>
        </asp:Repeater>
    </ul>
</asp:Content>

