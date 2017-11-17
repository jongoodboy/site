<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>商品管理</title>
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
    <li class="active"><a href="${ctx}/cms/category/">订单列表</a></li>
</ul>
<sys:message content="${message}"/>
<form:form id="searchForm" modelAttribute="commodity" action="${ctx}/order/orderList" method="post" class="breadcrumb form-search">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
    <ul class="ul-form">
        <li>
            <label>订单状态：</label>
            <c:forEach items="${fns:getDictList('order_state')}" var="type">
                <input id="commodityRelease${type.value}" name="commodityRelease"
                       onclick="$('#searchForm').submit();" type="radio" value="${type.value}"<c:if test="${type.value == commodity.commodityRelease}">checked </c:if>/>
                <label for="commodityRelease${type.value}">${type.label}</label>
            </c:forEach>
        </li>
        <li class="clearfix"></li>
    </ul>
</form:form>
<table id="treeTable" class="table table-striped table-bordered table-condensed">
    <tr><th>订单号</th><th>下单时间</th><th>收货地址</th><th>操作</th></tr>
    <c:forEach items="${page.getList()}" var="tpl">
        <tr>
            <td>${tpl.orderNumber}</td>
            <td><fmt:formatDate  value="${tpl.createDate}" pattern="yyyy-mm-dd HH:mm:ss" /></td>
            <td></td>
            <td><a href="${ctx}/commodity/from?id=${tpl.id}&type=1">修改</a></td>
        </tr>
    </c:forEach>
</table>
<div class="pagination">${page}</div>
</body>
</html>