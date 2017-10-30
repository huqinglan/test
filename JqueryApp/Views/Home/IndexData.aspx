<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="indexContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        <%= Html.Encode(ViewData["Message"]) %></h2>
        <p>数据库采用SQLite</p>
    <table width="100%">
        <thead>
            <tr>
                <th>
                    实例名
                </th>
                <th>
                    插件
                </th>
                <th>
                    说明
                </th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>
                    <%= Html.ActionLink("表单验证", "FormValidation", "Home")%>
                </td>
                <td>
                    <a href="http://docs.jquery.com/Plugins/Validation" target="_blank">Validation</a>
                </td>
                <td>常见的一些验证操作</td>
            </tr>
            <tr>
                <td>
                    <%= Html.ActionLink("树型表格", "TreeTable", "Home")%>
                </td>
                <td>
                    <a href="http://plugins.jquery.com/project/treeTable" target="_blank">treeTable</a>
                </td><td>无限级数据管理应用,支持拖拽更新记录层次</td>
            </tr>
            <tr>
                <td>
                    <%= Html.ActionLink("TreeView", "TreeView", "Home")%>
                </td>
                <td>
                    <a href="http://plugins.jquery.com/project/treeTable" target="_blank">treeTable</a>
                </td><td>无限级数据管理应用,支持拖拽更新记录层次</td>
            </tr>
            
        </tbody>
    </table>
</asp:Content>
