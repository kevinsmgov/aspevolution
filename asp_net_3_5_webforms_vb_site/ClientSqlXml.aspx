<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" %>

<script runat="server">

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManagerProxy ID="ScriptManagerProxy1" runat="server">
        <Services>
            <asp:ServiceReference Path="~/ClientSqlXmlService.svc" />
        </Services>
    </asp:ScriptManagerProxy>
    <p>AJAX request</p>
    <ul id="customers"></ul>
    <script language="javascript" type="text/javascript" src="ClientSqlXml.js"></script>
</asp:Content>

