<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="include/taglib.jsp" %>
<html>
<!--会员导引页面-->
<head>
    <%@include file="include/head.jsp" %>
</head>
<style>
    .am-btn-danger{
        width: 60%;
        position: absolute;
        bottom: 10%;
        left: 20%;
        height: 50px;
        line-height: 50px;
        padding: 0;
        border-radius: 3px;
        letter-spacing: 1px;
        font-size: 14px;
    }
</style>
<c:set value="${listBanner}" var="banner"></c:set>
<c:set value="${fn:split(banner[0].commodityImager, '|')}" var="imgItme"></c:set>
<body style="background: url(${ctxStatic}/m/img/new-vip.jpg) no-repeat center; background-size: 100% 100%;">
    <a class="am-btn am-btn-danger" href="${ctx}/m/commodityDetail?commodityId=${banner[0].id}" target="_blank">成为会员</a>
</body>
</html>
