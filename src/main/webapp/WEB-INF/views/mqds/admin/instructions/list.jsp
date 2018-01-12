<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
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
    <li class="active"><a href="#">使用说明列表</a></li>
    <li><a href="${ctx}/instructions/from">添加使用说明</a></li>
</ul>
<sys:message content="${message}"/>
<table id="treeTable" class="table table-striped table-bordered table-condensed">
    <tr>
        <th>说明类型</th>
        <th>创建者</th>
        <th>操作</th>
    </tr>
    <c:forEach items="${page.getList()}" var="tpl">
        <tr>
            <td>${fns:getDictLabel(tpl.instructionsType, 'instructions_type', '说明类型')}</td>
            <td>${tpl.createName}</td>
            <td><a href="${ctx}/instructions/from?id=${tpl.id}&type=1">修改</a></td>
        </tr>
    </c:forEach>
</table>
<div class="pagination">${page}</div>
</body>
</html>