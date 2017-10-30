<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script src="../../Scripts/treeview/jquery.treeview.js" type="text/javascript"></script>

    <link href="../../Scripts/treeview/jquery.treeview.css" rel="stylesheet" type="text/css" />

    <script type="text/jscript">
        $(document).ready(function() {

            // first example
            $("#navigation").treeview({
                persist: "#fast",
                collapsed: true,
                unique: true
            });

        });
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        Ä¿Â¼Ê÷</h2>
    <div class="treeview">
        <%=ViewData["TreeView"] %>
    </div>
</asp:Content>
