<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#inputForm").validate({
                submitHandler: function (form) {
                    loading('正在提交，请稍等...');
                    form.submit();
                },
                errorContainer: "#messageBox",
                errorPlacement: function (error, element) {
                    $("#messageBox").text("输入有误，请先更正。");
                    if (element.is(":checkbox") || element.is(":radio") || element.parent().is(".input-append")) {
                        error.appendTo(element.parent().parent());
                    } else {
                        error.insertAfter(element);
                    }
                }
            });
        });
    </script>
</head>
<body>
<ul class="nav nav-tabs">
    <li><a href="${ctx}/instructions/list">使用说明列表</a></li>
    <li class="active"><a href="#">添加使用说明</a></li>
</ul>
<br/>
<form:form id="inputForm" modelAttribute="instructions" action="${ctx}/instructions/save" method="post"
           class="form-horizontal">
<form:hidden path="id"/>
<sys:message content="${message}"/>
<div class="control-group">
    <div class="control-group">
        <label class="control-label">所属说明:</label>
        <div class="controls">
            <form:select path="instructionsType" class="input">
                <form:options items="${fns:getDictList('instructions_type')}" itemLabel="label" itemValue="value"
                              htmlEscape="false"/>
            </form:select>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">使用说明内容</label>
        <div class="controls">
            <form:textarea htmlEscape="true" path="instructionsContent" cclass="required" rows="4"
                           maxlength="200"/>
            <sys:ckeditor replace="instructionsContent" uploadPath="/cms/article"/>
        </div>
    </div>
    <div class="form-actions">
        <c:if test="${param.type != 0}"><input id="btnSubmit" class="btn btn-primary" type="submit"
                                               value="保 存"/>&nbsp;</c:if>
        <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
    </div>
    </form:form>
</body>
</html>