<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" %>

<script runat="server">

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <p>Here's a single query example from the Northwind database. The query is hidden away in the dataset object.</p>

    <ul>
        <asp:Repeater ID="Repeater1" runat="server" DataSourceID="ObjectDataSourceCustomer">
            <ItemTemplate>
                <li>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("ContactName") %>'></asp:Label></li>
            </ItemTemplate>
        </asp:Repeater>
    </ul>
    <asp:ObjectDataSource ID="ObjectDataSourceCustomer" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="NorthwindDataSetTableAdapters.CustomersTableAdapter">
    </asp:ObjectDataSource>
</asp:Content>

