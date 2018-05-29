<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" %>

<script runat="server">

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <p>AJAX request</p>
    <ul id="customers">
    </ul>
    <script src="ClientSqlXml.js" type="text/javascript">
    </script>
</asp:Content>

