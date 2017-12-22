<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <meta name="decorator" content="default"/>
    <%@include file="/WEB-INF/views/include/treetable.jsp" %>
    <script type="text/javascript">
        $(document).ready(function() {
        });
        function page(n,s){
            $("#pageNo").val(n);
            $("#pageSize").val(s);
            $("#searchForm").submit();
            return false;
        }
        function updateSort() {
            loading('正在提交，请稍等...');
            $("#listForm").attr("action", "${ctx}/cms/category/updateSort");
            $("#listForm").submit();
        }
    </script>
    <style>
        .form-search .ul-form li label{
            width: auto;
            margin: 0;
        }
        .form-search .ul-form li{
            margin-right:40px;
        }
    </style>
</head>
<body>
<ul class="nav nav-tabs">
    <li class="active"><a href="#">特产列表</a></li>
    <li><a href="${ctx}/commodityClassification/from">添加特产</a></li>
</ul>
<sys:message content="${message}"/>
<form:form id="searchForm" modelAttribute="classification" action="${ctx}/commodityClassification/list" method="post" class="breadcrumb form-search">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
    <form:select path="commodityClassificationParant" class="input-mini"  onchange="$('#searchForm').submit();">
        <form:option value="">所有地区</form:option>
        <form:options items="${fns:getDictList('commodity_classification')}" itemLabel="label" itemValue="value" htmlEscape="false" />
    </form:select>
</form:form>
<table id="treeTable" class="table table-striped table-bordered table-condensed">
    <tr><th>特产名</th><th>所属于地区</th><th>操作</th></tr>
    <c:forEach items="${page.getList()}" var="tpl">
        <tr>
            <td><a href="${ctx}/commodityClassification/from?id=${tpl.id}&type=0">${tpl.commodityClassificationName}</a></td>
            <td>${fns:getDictLabel(tpl.commodityClassificationParant, 'commodity_classification', '所属区域')}</td>
            <td><a href="${ctx}/commodityClassification/from?id=${tpl.id}&type=1">修改</a></td>
        </tr>
    </c:forEach>
</table>
<div class="pagination">${page}</div>
</body>
</html>