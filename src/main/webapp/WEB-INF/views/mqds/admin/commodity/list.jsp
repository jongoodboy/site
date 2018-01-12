<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>商品管理</title>
    <meta name="decorator" content="default"/>
    <%@include file="/WEB-INF/views/include/treetable.jsp" %>
    <script type="text/javascript">
        $(document).ready(function () {
        });
        function page(n, s) {
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
        .form-search .ul-form li label {
            width: auto;
            margin: 0;
        }

        .form-search .ul-form li {
            margin-right: 40px;
        }
    </style>
</head>
<body>
<ul class="nav nav-tabs">
    <li class="active"><a href="#">商品列表</a></li>
    <li><a href="${ctx}/commodity/from">添加商品</a></li>
</ul>
<sys:message content="${message}"/>
<form:form id="searchForm" modelAttribute="commodity" action="${ctx}/commodity/list" method="post"
           class="breadcrumb form-search">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
    <ul class="ul-form">
        <li>
            <label>商品类型：${commodityType}</label>
            <select name="commodityType" onchange="$('#searchForm').submit();">
                <option value="">全部</option>
                <c:forEach items="${fns:getDictList('commodity_type')}" var="itme">
                    <option value="${itme.value}" <c:if
                            test="${commodity.commodityType == itme.value }">selected</c:if>>${itme.label}</option>
                </c:forEach>
            </select>
        </li>
        <li>
            <label>商品状态：</label>
            <select name="commodityState" onchange="$('#searchForm').submit();" style="width: 100px">
                <option value="">全部</option>
                <c:forEach items="${fns:getDictList('commodity_state')}" var="itme">
                    <option value="${itme.value}" <c:if
                            test="${commodity.commodityState == itme.value }">selected</c:if>>${itme.label}</option>
                </c:forEach>
            </select>
        </li>
        <li>
            <label>上线状态：</label>
            <c:forEach items="${fns:getDictList('commodity_release')}" var="type">
                <input id="commodityRelease${type.value}" name="commodityRelease"
                       onclick="$('#searchForm').submit();" type="radio" value="${type.value}"
                       <c:if test="${type.value == commodity.commodityRelease}">checked </c:if>/>
                <label for="commodityRelease${type.value}">${type.label}</label>
            </c:forEach>
        </li>
        <li>
            <label>商品名称：</label>
            <form:input path="commodityName" htmlEscape="false" maxlength="200" class="required" placeholder="商品名称"/>
            <input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>
        </li>
        <li class="clearfix"></li>
    </ul>
</form:form>
<table id="treeTable" class="table table-striped table-bordered table-condensed">
    <tr>
        <th>商品名称</th>
        <th>商品类型</th>
        <th>商品状态</th>
        <th>商品位置</th>
        <th>发布状态</th>
        <th>操作</th>
    </tr>
    <c:forEach items="${page.getList()}" var="tpl">
        <tr>
            <td><a href="${ctx}/commodity/from?id=${tpl.id}&type=0">${tpl.commodityName}</a></td>
            <td>${fns:getDictLabel(tpl.commodityType, 'commodity_type', '商品类型')}</td>
            <td>${fns:getDictLabel(tpl.commodityState, 'commodity_state', '商品状态')}</td>
            <td>${tpl.commodityPosition}</td>
            <td>${fns:getDictLabel(tpl.commodityRelease, 'commodity_release', '发布状态')}</td>
            <td><a href="${ctx}/commodity/from?id=${tpl.id}&type=1">修改</a>
                &nbsp;&nbsp;<%--<a href="#">下架</a>--%></td>
        </tr>
    </c:forEach>
</table>
<div class="pagination">${page}</div>
</body>
</html>