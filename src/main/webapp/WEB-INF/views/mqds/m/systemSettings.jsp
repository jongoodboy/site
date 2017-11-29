<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="include/taglib.jsp" %>
<html>
<!--系统列表-->
<head>
    <%@include file="include/head.jsp" %>
</head>
<style>
    .but-out-system {
        width: 60%;
        margin: auto;
        position: absolute;
        left: 20%;
        bottom: 10%;
    }
    .am-btn{
        width: 100%;
        margin: 5px auto;
    }
</style>
<body>
<div class="content">
    <ul class="am-list am-list-static am-list-border">
        <li class="buy-pay-stlye">
            <ul class="nav-menu">
                <li>
                    <span>当前版本</span>
                </li>
                <li style="float: right">
                    <span>V0.0.1</span>
                </li>
            </ul>
        </li>
    </ul>
    <div class="but-out-system">
        <button type="button" class="am-btn am-btn-default">注销登录</button>
    </div>
</div>
</body>
<script>
    $(".am-btn-default").on("click",function () {
        $.post("${ctx}/m/loginOut?userId=${sessionScope.mUser.id}",function (data) {
           window.location.href = "${ctx}/m"
        })
    })
</script>
</html>

