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
    <li class="active"><a href="#">快递列表</a></li>
    <li><a href="${ctx}/express/from">添加快递</a></li>
</ul>
<sys:message content="${message}"/>
<table id="treeTable" class="table table-striped table-bordered table-condensed">
    <tr><th>名称</th><th>省内首重</th><th>省内递增</th><th>省外首重</th><th>省外递增</th><th>操作</th></tr>
    <c:forEach items="${page.getList()}" var="tpl">
        <tr>
            <td><a href="${ctx}/express/from?id=${tpl.id}&type=0">${tpl.expressName}</a></td>
            <td>${tpl.expressProvinceFirst}</td>
            <td>${tpl.expressProvinceIncreasing}</td>
            <td>${tpl.expressOutsideFirst}</td>
            <td>${tpl.expressOutsideIncreasing}</td>
            <td><a href="${ctx}/express/from?id=${tpl.id}&type=1">修改</a></td>
        </tr>
    </c:forEach>
</table>
<div class="pagination">${page}</div>
</body>
</html>