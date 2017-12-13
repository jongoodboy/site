<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>添加快递</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">
        $(document).ready(function() {
            $("#inputForm").validate({
                submitHandler: function(form){
                    loading('正在提交，请稍等...');
                    form.submit();
                },
                errorContainer: "#messageBox",
                errorPlacement: function(error, element) {
                    $("#messageBox").text("输入有误，请先更正。");
                    if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
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
    <li><a href="${ctx}/express/list">快递列表</a></li>
    <li class="active"><a href="#">添加快递</a></li>
</ul><br/>
<form:form id="inputForm" modelAttribute="express" action="${ctx}/express/save" method="post" class="form-horizontal">
    <form:hidden path="id"/>
    <sys:message content="${message}"/>
    <div class="control-group">
    <div class="control-group">
        <label class="control-label">快递名称:</label>
        <div class="controls">
            <form:input path="expressName" htmlEscape="false" maxlength="200" class="input-xlarge required"/>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">省内首重:</label>
        <div class="controls">
            <form:input path="expressProvinceFirst" htmlEscape="false" maxlength="200" class="input-xlarge required"/>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">省内递增:</label>
        <div class="controls">
            <form:input path="expressProvinceIncreasing" htmlEscape="false" maxlength="200" class="input-xlarge required"/>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">省外首重:</label>
        <div class="controls">
            <form:input path="expressOutsideFirst" htmlEscape="false" maxlength="200" class="input-xlarge required"/>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">省外递增:</label>
        <div class="controls">
            <form:input path="expressOutsideIncreasing" htmlEscape="false" maxlength="200" class="input-xlarge required"/>
        </div>
    </div>
    <div class="form-actions">
        <c:if test="${param.type != 0}"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</c:if>
        <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
    </div>
</form:form>
</body>
</html>