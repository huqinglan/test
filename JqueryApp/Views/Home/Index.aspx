<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="indexContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        <%= Html.Encode(ViewData["Message"]) %></h2>
    <table width="100%">
        <tr>
            <td>
                <%= Html.ActionLink("表单验证", "FormValidation", "Home")%>
            </td>
            <td>
                调用JQuery的Validation插件，网址http://docs.jquery.com/Plugins/Validation
            </td>
        </tr>
        <tr>
            <td>
                <%= Html.ActionLink("TreeTable", "TreeTable", "Home")%>
            </td>
            <td>
                
            </td>
        </tr>
    </table>
</asp:Content>
