<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script src="../../Scripts/validate/jquery.validate.min.js" type="text/javascript"></script>

    <script type="text/javascript">
        $().ready(function() {

            //$("#test-form").validate({ submitHandler: function() { alert("�ύ�ɹ�!") } });  //����ʾ��Ϣ��ʾ��ÿ��ĺ���
            $("#test-form").validate({
                errorLabelContainer: "#ErrMessageBox",
                wrapper: "li",
                submitHandler: function() { alert("�ύ�ɹ�!") } //��֤ͨ����÷���
            }); //����ʾ��Ϣ��ʾ�ڶ�����Ϣ����

            /////////////////�Զ�����֤����/////////////////////////////////////////////////////////

            // �����������ֽ�    
            jQuery.validator.addMethod("rangelength", function(value, element, param) {
                var length = value.length;
                for (var i = 0; i < value.length; i++) {
                    if (value.charCodeAt(i) > 127) {
                        length++;
                    }
                }
                return this.optional(element) || (length >= param[0] && length <= param[1]);
            }, "�����ֵ��3-15���ֽ�֮�䡣");

            // ���֤������֤    
            jQuery.validator.addMethod("idcardno", function(value, element) {
                return this.optional(element) || idcardno(value);
            }, "����ȷ�����������֤���롣");

            // �ַ���֤    
            jQuery.validator.addMethod("username", function(value, element) {
                return this.optional(element) || /^[\u0391-\uFFE5\w]+$/.test(value);
            }, "�û���ֻ�ܰ��������֡�Ӣ����ĸ�����ֺ��»��ߡ�");

            // �ֻ�������֤    
            jQuery.validator.addMethod("mobile", function(value, element) {
                var length = value.length;
                return this.optional(element) || (length == 11 && /^(((13[0-9]{1})|(15[0-9]{1}))+\d{8})$/.test(value));
            }, "����ȷ��д�����ֻ����롣");

            // �绰������֤    
            jQuery.validator.addMethod("phone", function(value, element) {
                var tel = /^(\d{3,4}-?)?\d{7,9}$/g;
                return this.optional(element) || (tel.test(value));
            }, "����ȷ��д���ĵ绰���롣");

            // ����������֤    
            jQuery.validator.addMethod("zipCode", function(value, element) {
                var tel = /^[0-9]{6}$/;
                return this.optional(element) || (tel.test(value));
            }, "����ȷ��д�����������롣");

            ///////////////////////////////////////////////////////////////////////////////////////////

            $("#username").rules("add", {
                required: true,
                username: true, //�����Զ�����
                rangelength: [6, 20],
                messages: {
                    required: "�û�������Ϊ�ա�",
                    rangelength: "�û��������ֵ��3-15���ֽ�֮�䡣"
                }
            });

            $("#email").rules("add", {
                required: true,
                email: true,
                messages: {
                    required: "Email����Ϊ�ա�",
                    email: "Email���Բ���ȷ������XXX@163.com��"

                }
            });

            $("#password").rules("add", {
                required: true,
                rangelength: [6, 50],
                messages: {
                    required: "���벻�ܿա�",
                    rangelength: "�������Ϊ6-50λ�ַ�֮�䡣"
                }
            });

            $("#confirmPassword").rules("add", {
                required: true,
                equalTo: "#password",
                rangelength: [6, 50],
                messages: {
                    required: "��֤���벻�ܿա�", equalTo: "�����������벻һ����",
                    rangelength: "��֤�������Ϊ6-50λ�ַ�֮�䡣"
                }
            });

        });
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <p>
        ���Ա���û��ʵ�����ݽ�����չʾһЩ���õı���֤�
    </p>
    <h2>
        ����֤</h2>
    <ul id="ErrMessageBox" style="display: none;">
    </ul>
    <% using (Html.BeginForm(null, null, FormMethod.Post, new { id = "test-form", name = "test-form" }))
       { %>
    <div>
        <fieldset>
            <legend>�ύ����</legend>
            <p class="form-element">
                <label for="username">
                    �û���:</label>
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
                    ����:</label>
                <%= Html.Password("password")%>
                <%= Html.ValidationMessage("password")%>
            </p>
            <p class="form-element">
                <label for="confirmPassword">
                    ��֤����:</label>
                <%= Html.Password("confirmPassword")%>
                <%= Html.ValidationMessage("confirmPassword")%>
            </p>
            <p>
                <input type="submit" value="�ύ" />
            </p>
        </fieldset>
    </div>
    <% } %>
</asp:Content>
