<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="include/taglib.jsp" %>
<html>
<!--使用说明详情-->
<head>
    <%@include file="include/head.jsp" %>
</head>
<body>
<div class="content" style="padding: 5px">
    <c:forEach items="${instructionsLsit}" var="itme">
        ${itme.instructionsContent}
    </c:forEach>
</div>
<script>
    $(document).ready(function () {
        $("p img").attr("style", "width:100%");//设置商品描图片
    })
</script>
</body>
</html>
