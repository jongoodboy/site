<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>添加特产</title>
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
    <li><a href="${ctx}/commodityClassification/list">特产列表</a></li>
    <li class="active"><a href="#">添加商品</a></li>
</ul>
<br/>
<form:form id="inputForm" modelAttribute="classification" action="${ctx}/commodityClassification/save" method="post"
           class="form-horizontal">
    <form:hidden path="id"/>
    <sys:message content="${message}"/>
    <div class="control-group">
        <label class="control-label">所属区域:</label>
        <div class="controls">
            <form:select path="commodityClassificationParant" class="input-mini">
                <form:options items="${fns:getDictList('commodity_classification')}" itemLabel="label" itemValue="value"
                              htmlEscape="false"/>
            </form:select>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">特产名称:</label>
        <div class="controls">
            <form:input path="commodityClassificationName" htmlEscape="false" maxlength="200"
                        class="input-xxlarge required measure-input"/>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">缩略图:</label>
        <div class="controls">
            <input type="hidden" id="image" name="commodityClassificationThumbnail" value="${classification.commodityClassificationThumbnail}" />
            <sys:ckfinder input="image" type="thumb" uploadPath="/cms/article" selectMultiple="false"/>
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