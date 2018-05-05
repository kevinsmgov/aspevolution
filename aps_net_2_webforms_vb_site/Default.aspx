<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage.master" %>

<script runat="server">

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <p>
        When ASP.NET was developed, a strategic goal was to bring VB6 users into the web development world with an environment that was similar to VB6 Windows development. 
        .NET Framework 1.x is no longer supported so I can't include it in this demo series. 
        We'll have to start with .NET Framework 2.0
    </p>
    <p>
        One of the big features in ASP.NET Framework 2.0 was dynamic compilation. This allowed developers to work with websites as they did with classic ASP - drop an updated file on the server and have it immediately available to the site visitors.
    </p>
    <p>
        Another feature was "code behind". 
        This allowed the bulk of the application code for any page to be separated from the html part of the page. 
        The one aspect of this was to allow designers and developers to work on a project without stepping on each other's toes as much.
    </p>
    <p>
        A more significant feature, however, was the "dataset". This component allowed a developer to model data for the site as first class objects and query and update the database via those objects. Previously, database access was managed through text (SQL queries, field names, update statements, all strings of text passed to and from the database connection) which was prone to error and difficult to catch until runtime. Datasets addressed a lot of that.
    </p>
    <p>
        From the page design side, the biggest feature was master pages. Previously, common html content had to be included in each page manually. With master pages, a common template was automatically shared across multiple pages.
    </p>
</asp:Content>

