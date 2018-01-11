<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="include/taglib.jsp" %>
<html>
<!--会员导引页面-->
<head>
    <%@include file="include/head.jsp" %>
</head>
<style>
    .vip-but{
        width: 50%;
        position: absolute;
        bottom: 5%;
        left: 25%;
        height: 50px;
        line-height: 50px;
        padding: 0;
        border-radius: 3px;
        letter-spacing: 1px;
        font-size: 14px;
        background: url("${ctxStatic}/m/img/vip-but.png") center center no-repeat;
        background-size: 100% 100%;
    }
</style>
<c:set value="${listBanner}" var="banner"></c:set>
<c:set value="${fn:split(banner[0].commodityImager, '|')}" var="imgItme"></c:set>
<body style="background: url(${ctxStatic}/m/img/new-vip.jpg) no-repeat center; background-size: 100% 100%;">
    <a class="am-btn vip-but" href="${ctx}/m/commodityDetail?commodityId=${banner[0].id}" target="_blank"></a>
</body>
</html>
