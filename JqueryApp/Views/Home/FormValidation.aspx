<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script src="../../Scripts/validate/jquery.validate.min.js" type="text/javascript"></script>

    <script type="text/javascript">
        $().ready(function() {

            //$("#test-form").validate({ submitHandler: function() { alert("提交成功!") } });  //将提示信息显示在每项的后面
            $("#test-form").validate({
                errorLabelContainer: "#ErrMessageBox",
                wrapper: "li",
                submitHandler: function() { alert("提交成功!") } //验证通后调用方法
            }); //将提示信息显示在顶部信息框内

            /////////////////自定义验证方法/////////////////////////////////////////////////////////

            // 中文字两个字节    
            jQuery.validator.addMethod("rangelength", function(value, element, param) {
                var length = value.length;
                for (var i = 0; i < value.length; i++) {
                    if (value.charCodeAt(i) > 127) {
                        length++;
                    }
                }
                return this.optional(element) || (length >= param[0] && length <= param[1]);
            }, "输入的值在3-15个字节之间。");

            // 身份证号码验证    
            jQuery.validator.addMethod("idcardno", function(value, element) {
                return this.optional(element) || idcardno(value);
            }, "请正确输入您的身份证号码。");

            // 字符验证    
            jQuery.validator.addMethod("username", function(value, element) {
                return this.optional(element) || /^[\u0391-\uFFE5\w]+$/.test(value);
            }, "用户名只能包括中文字、英文字母、数字和下划线。");

            // 手机号码验证    
            jQuery.validator.addMethod("mobile", function(value, element) {
                var length = value.length;
                return this.optional(element) || (length == 11 && /^(((13[0-9]{1})|(15[0-9]{1}))+\d{8})$/.test(value));
            }, "请正确填写您的手机号码。");

            // 电话号码验证    
            jQuery.validator.addMethod("phone", function(value, element) {
                var tel = /^(\d{3,4}-?)?\d{7,9}$/g;
                return this.optional(element) || (tel.test(value));
            }, "请正确填写您的电话号码。");

            // 邮政编码验证    
            jQuery.validator.addMethod("zipCode", function(value, element) {
                var tel = /^[0-9]{6}$/;
                return this.optional(element) || (tel.test(value));
            }, "请正确填写您的邮政编码。");

            ///////////////////////////////////////////////////////////////////////////////////////////

            $("#username").rules("add", {
                required: true,
                username: true, //调用自定函数
                rangelength: [6, 20],
                messages: {
                    required: "用户名不能为空。",
                    rangelength: "用户名输入的值在3-15个字节之间。"
                }
            });

            $("#email").rules("add", {
                required: true,
                email: true,
                messages: {
                    required: "Email不能为空。",
                    email: "Email格试不正确，例：XXX@163.com。"

                }
            });

            $("#password").rules("add", {
                required: true,
                rangelength: [6, 50],
                messages: {
                    required: "密码不能空。",
                    rangelength: "密码必须为6-50位字符之间。"
                }
            });

            $("#confirmPassword").rules("add", {
                required: true,
                equalTo: "#password",
                rangelength: [6, 50],
                messages: {
                    required: "验证密码不能空。", equalTo: "两次密码输入不一样。",
                    rangelength: "验证密码必须为6-50位字符之间。"
                }
            });

        });
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <p>
        测试表单，没有实际数据交互，展示一些常用的表单验证项。
    </p>
    <h2>
        表单验证</h2>
    <ul id="ErrMessageBox" style="display: none;">
    </ul>
    <% using (Html.BeginForm(null, null, FormMethod.Post, new { id = "test-form", name = "test-form" }))
       { %>
    <div>
        <fieldset>
            <legend>提交内容</legend>
            <p class="form-element">
                <label for="username">
                    用户名:</label>
                <%= Html.TextBox("username")%>
                <%= Html.ValidationMessage("username")%>
            </p>
            <p class="form-element">
                <label for="email">
                    Email:</label>
                <%= Html.TextBox("email")%>
                <%= Html.ValidationMessage("email")%>
            </p>
            <p class="form-element">
                <label for="password">
                    密码:</label>
                <%= Html.Password("password")%>
                <%= Html.ValidationMessage("password")%>
            </p>
            <p class="form-element">
                <label for="confirmPassword">
                    验证密码:</label>
                <%= Html.Password("confirmPassword")%>
                <%= Html.ValidationMessage("confirmPassword")%>
            </p>
            <p>
                <input type="submit" value="提交" />
            </p>
        </fieldset>
    </div>
    <% } %>
</asp:Content>
