<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>添加商品</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">
        $(document).ready(function() {
            imagesPreview();//执行显示图片
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
    <li><a href="${ctx}/commodity/list">商品列表</a></li>
    <li class="active"><a href="#">添加商品</a></li>
</ul><br/>
<form:form id="inputForm" modelAttribute="commodity" action="${ctx}/commodity/save" method="post" class="form-horizontal">
    <form:hidden path="id"/>
    <sys:message content="${message}"/>

    <div class="control-group">
        <label class="control-label">商品名称:</label>
        <div class="controls">
            <form:input path="commodityName" htmlEscape="false" maxlength="200" class="input-xxlarge measure-input"/>
        </div>
    </div>

    <div class="control-group">
        <label class="control-label">商品类型:</label>
        <div class="controls">
            <form:select path="commodityType" class="input-mini">
                <form:options items="${fns:getDictList('commodity_type')}" itemLabel="label" itemValue="value" htmlEscape="false" />
            </form:select>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">商品状态:</label>
        <div class="controls">
            <form:select path="commodityState" class="input-mini">
                <form:options items="${fns:getDictList('commodity_state')}" itemLabel="label" itemValue="value" htmlEscape="false" />
            </form:select>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">商品发布状态:</label>
        <div class="controls">
            <form:select path="commodityRelease" class="input-mini">
                <form:options items="${fns:getDictList('commodity_release')}" itemLabel="label" itemValue="value" htmlEscape="false" />
            </form:select>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">商品单位:</label>
        <div class="controls">
            <form:select path="commodityCompany" class="input-mini">
                <form:options items="${fns:getDictList('commodity_company')}" itemLabel="label" itemValue="value" htmlEscape="false" />
            </form:select>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">商品单价:</label>
        <div class="controls">
            <form:input path="commodityPice" htmlEscape="false" maxlength="200" type="number"/>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">商品图片:</label>
        <div class="controls">
            <sys:ckfinder input="images" type="images" uploadPath="/cms/article" selectMultiple="true"/>
            <input type="hidden" id="images" name="commodityImager"  value="${commodity.commodityImager}" />
        </div>
    </div>

    <div class="control-group">
        <label class="control-label">商品库存量:</label>
        <div class="controls">
            <form:input path="commodityNumber" htmlEscape="false" maxlength="3" type="number"/>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">商品描述</label>
        <div class="controls">
          <form:textarea id="content" htmlEscape="true" path="commodityMaker" rows="4" maxlength="200"/>
           <%--  <textarea id="commodityMaker" name="commodityMaker" cols="20" rows="2" class="ckeditor">${commodity.commodityMaker}</textarea>--%>
            <sys:ckeditor replace="commodityMaker" uploadPath="/cms/article" />
        </div>
    </div>

    <div class="form-actions">
        <c:if test="${param.type != 0}"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</c:if>
        <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
    </div>
</form:form>
</body>
</html>