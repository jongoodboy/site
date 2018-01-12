<%@ taglib prefix="s" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="include/taglib.jsp" %>
<html>
<!--使用说明-->
<head>
    <%@include file="include/head.jsp" %>
</head>
<style>
    .personal-list {
        list-style: none;
        padding: 0;
        margin: 0;
        font-size: 14px;
        padding: 0px 10px;
    }

    .personal-list li {
        border-bottom: 1px solid #eee;
        line-height: 60px;
        position: relative;
    }

    .am-list-border ul li a {
        color: #333;
    }

    .personal-list a {
        width: 100%;
        display: inline-block;
    }

    .nav-menu li {
        font-size: 13px;
    }

    .nav-menu li span {
        display: inline-block;
        margin-top: 4px;
    }
</style>
<body>
<div class="content">
    <ul class="am-list am-list-static am-list-border">
        <li style="padding-top: 0">
            <ul class="personal-list">
                <c:forEach items="${fns:getDictList('instructions_type')}" var="type">
                    <li>
                        <a href="${ctx}/m/instructionsDetail?instructionsType=${type.value}">
                            <span>${type.label}</span>
                        </a>
                        <i></i>
                    </li>
                </c:forEach>
            </ul>
        </li>
    </ul>
</div>
</body>
</html>
