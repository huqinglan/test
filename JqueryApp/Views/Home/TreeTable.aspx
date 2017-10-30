<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<JqueryApp.Models.category>>" %>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <%if (false)
      { %>

    <script src="../../Scripts/jquery-1.3.2-vsdoc.js" type="text/javascript"></script>

    <%} %>

    <script src="../../Scripts/jquery.ui/ui/jquery-ui-1.7.2.custom.js" type="text/javascript"></script>

    <script src="../../Scripts/treeTable/jquery.treeTable.js" type="text/javascript"></script>

    <link href="../../Content/jquery.treeTable.css" rel="stylesheet" type="text/css" />
    <link href="../../Scripts/jquery.ui/themes/ui-lightness/ui.all.css" rel="stylesheet"
        type="text/css" />
    <style type="text/css">
        .ui-button
        {
            margin: 2px 4px;
            padding: 2px;
            text-decoration: none;
            cursor: pointer;
            position: relative;
            text-align: center;
        }
        .ui-dialog .ui-state-highlight, .ui-dialog .ui-state-error
        {
            padding: 4px;
        }
        .portlet
        {
            padding: 10px;
        }
        .portlet-header
        {
            padding: 4px;
            margin-bottom: 6px;
        }
    </style>

    <script type="text/javascript">

        $(document).ready(function() {
            $(".example").treeTable({
                initialState: "expanded"
            });

            // Drag & Drop Example Code
            $("#dnd-example .file, #dnd-example .folder").draggable({
                helper: "clone",
                opacity: .75,
                refreshPositions: true,
                revert: "invalid",
                revertDuration: 300,
                scroll: true
            });

            $("#dnd-example .folder").each(function() {
                $($(this).parents("tr")[0]).droppable({
                    accept: ".file, .folder",
                    drop: function(e, ui) {
                        $($(ui.draggable).parents("tr")[0]).appendBranchTo(this);

                        // Issue a POST call to send the new location (this) of the
                        // node (ui.draggable) to the server.
                        if ($(ui.draggable).parents("tr")[0].id != this.id) {
                            $.post("TreeTableMove", { id: $(ui.draggable).parents("tr")[0].id, pid: this.id },
                            function(data) {
                                //alert("返回结果: " + data);
                                window.location.href = "TreeTable";
                            });
                        }
                    },
                    hoverClass: "accept",
                    over: function(e, ui) {
                        if (this.id != $(ui.draggable.parents("tr.parent")[0]).id && !$(this).is(".expanded")) {
                            $(this).expand();
                        }
                    }
                });
            });

            // Make visible that a row is clicked
            $("table#dnd-example tbody tr").mousedown(function() {
                $("tr.selected").removeClass("selected"); // Deselect currently selected rows
                $(this).addClass("selected");
            });

            // Make sure row is selected when span is clicked
            $("table#dnd-example tbody tr span").mousedown(function() {
                $($(this).parents("tr")[0]).trigger("mousedown");
            });

            //删除记录
            $(".btn_delete").click(function() {
                if (confirm("您确定要删除这条记录吗？")) {
                    id = $(this).attr('categoryId'); //取记录ID
                    $.post("TreeTableDelete", { id: id },
                            function(data) {
                                if (data)
                                    $("#node-" + id).remove();
                                else
                                    alert("删除失败！");
                            });
                }
            });

            //读取记录信息
            $(".btn_edit").click(function() {
                id = $(this).attr('categoryId'); //取记录ID
                $.ajax({
                    //target address
                    url: "GetCategory/" + id,
                    //post transmission
                    type: "POST",
                    //data format:JSON 
                    dataType: 'json',
                    contentType: "application/json; charset=utf-8",
                    //beforeSend: function() { },
                    success: function(result) {
                        var jsondata = eval('(' + result + ')').category;
                        if (jsondata != null) {
                            $.each(jsondata, function(i, item) {
                                $('#edit_id').val(item.id);
                                $('#title2').val(item.title);
                                $('#status2').val(item.status);
                                $('#kind2').val(item.kind);
                            });
                            $("#EditPanel").dialog('open');
                        }
                        else
                            alert("此记录不存在！");
                    }
                });
            });


            $(function() {
                $("#CreatePanel").dialog({
                    bgiframe: true,
                    autoOpen: false,
                    modal: true,
                    buttons: {
                        '取  消': function() {
                            $(this).dialog('close');
                        },
                        '创  建': function() {
                            if ($("#title1").val() != "") {
                                $.post(
                                "CreateCategory", { title: $("#title1").val(), status: $("#status1").val(), kind: $("#kind1").val() },
                                function(data) {
                                    if (data) {
                                        $("#CreatePanel").dialog('close');
                                        window.location.href = "TreeTable";
                                    }
                                    else
                                        alert("创建失败！");
                                });
                            }
                            else
                            { alert("请输入分类名！"); }
                        }

                    }
                });

                $("#EditPanel").dialog({
                    bgiframe: true,
                    autoOpen: false,
                    modal: true,
                    buttons: {
                        '取  消': function() {
                            $(this).dialog('close');
                        },
                        '保  存': function() {
                            if ($("#title2").val() != "") {
                                $.post(
                                "SaveCategory", { id: $("#edit_id").val(), title: $("#title2").val(), status: $("#status2").val(), kind: $("#kind2").val() },
                                function(data) {
                                    if (data) {
                                        $("#EditPanel").dialog('close');
                                        window.location.href = "TreeTable";
                                    }
                                    else
                                        alert("保存失败！");
                                });
                            }
                            else
                            { alert("请输入分类名！"); }
                        }

                    }
                });

                $("#btn-create").click(function() {
                    $("#CreatePanel").dialog('open');
                });

                $("#btn-create").hover(
			    function() {
			        $(this).addClass("ui-state-hover");
			    },
			    function() {
			        $(this).removeClass("ui-state-hover");
			    }
		        ).mousedown(function() {
		            $(this).addClass("ui-state-active");
		        })
		        .mouseup(function() {
		            $(this).removeClass("ui-state-active");
		        });
                $(".portlet").addClass("ui-widget ui-widget-content ui-helper-clearfix ui-corner-all")
                .find(".portlet-header").addClass("ui-widget-header ui-corner-all")
                .find(".portlet-content").addClass("ui-widget-content");
            });
        });
  
    </script>

</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="ui-widget">
        <div class="ui-state-highlight ui-corner-all" style="margin-top: 20px; padding: 0 .7em;">
            <p style=" margin:0px; padding:3px;">
                <span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>
                <%= Html.Encode(ViewData["Title"]) %>,支持拖拽更新分类层次</p>
        </div>
    </div>
    <br />
    <div class="portlet">
        <div class="portlet-header">
            树型表格
        </div>
        <p>
            <button id="btn-create" class="ui-button ui-state-default ui-corner-all">
                &nbsp;新建分类&nbsp;
            </button>
        </p>
        <div class="portlet-content">
            <div id="CategoryDiv">
                <table class="example" id="dnd-example">
                    <thead>
                        <tr>
                            <th>
                                Title
                            </th>
                            <th>
                                Status
                            </th>
                            <th>
                                Action
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        <% foreach (var item in Model)
                           { %>
                        <tr id="node-<%=item.id %>" <%if(item.parent_id!=0){Response.Write("class='child-of-node-"+item.parent_id+"'");}%>>
                            <td>
                                <span class="<%if(item.kind=="page" || item.kind=="Product"){Response.Write("file");}else{Response.Write("folder");} %>">
                                    <%=Html.Encode(item.title) %></span>
                            </td>
                            <td>
                                <%=Html.Encode(item.status) %>
                            </td>
                            <td>
                                <span id="btn-edit"></span><a href="#" class="btn_edit" categoryid="<%=item.id %>">Edit</a>
                                <span id="btn-delete"></span><a href="#" class="btn_delete" categoryid="<%=item.id %>">
                                    Delete</a>
                            </td>
                        </tr>
                        <%} %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <div id="CreatePanel" style="display: none;" title="新建分类">
        <% using (Html.BeginForm("CreateCategory", "Home", FormMethod.Post, new { id = "frm-Create", name = "frm-Create" }))
           {
        %><table border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    <label for="title">
                        title：</label>
                </td>
                <td>
                    <% =Html.TextBox("title1")%>
                </td>
            </tr>
            <tr>
                <td>
                    <label for="status">
                        status：</label>
                </td>
                <td>
                    <select id="status1" name="status1">
                        <option value="Published" selected>Published</option>
                        <option value="Draft">Draft</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>
                    <label for="kind">
                        kind：</label>
                </td>
                <td>
                    <select id="kind1" name="kind1">
                        <option value="Homepage" selected>Homepage</option>
                        <option value="Page">Page</option>
                        <option value="Category">Category</option>
                        <option value="Product">Product</option>
                    </select>
                </td>
            </tr>
        </table>
        <% } %>
    </div>
    <div id="EditPanel" style="display: none;" title="编辑分类">
        <% using (Html.BeginForm("EditCategory", "Home", FormMethod.Post, new { id = "frm-Edit", name = "frm-Edit" }))
           {
        %>
        <table border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    <label for="title">
                        title：</label><%=Html.Hidden("edit_id") %>
                </td>
                <td>
                    <% =Html.TextBox("title2")%>
                </td>
            </tr>
            <tr>
                <td>
                    <label for="status">
                        status：</label>
                </td>
                <td>
                    <select id="status2">
                        <option value="Published" selected>Published</option>
                        <option value="Draft">Draft</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>
                    <label for="kind">
                        kind：</label>
                </td>
                <td>
                    <select id="kind2">
                        <option value="Homepage" selected>Homepage</option>
                        <option value="Page">Page</option>
                        <option value="Category">Category</option>
                        <option value="Product">Product</option>
                    </select>
                </td>
            </tr>
        </table>
        <% } %>
    </div>
</asp:Content>
