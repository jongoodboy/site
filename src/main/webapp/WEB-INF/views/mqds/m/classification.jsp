<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="include/taglib.jsp" %>
<html>
<head>
    <%@include file="include/head.jsp" %>
</head>
<style>
    body {
        text-align: center;
        color: #5d5959;
    }

    .left-menu {
        width: 100px;
        height: 100%;
        background: #fff;
        position: fixed;
        left: 0;
        z-index: 999;
        overflow: auto;
        padding-bottom: 30px;
    }

    .rgiht-content {
        width: 100%;
        background: #eee;
        height: 100%;
        position: fixed;
        overflow-x: scroll;
        padding: 30px 10px 60px 110px;
    }

    .classification-menu {
        list-style: none;
        line-height: 55px;
        padding: 0px;
    }

    .classification-menu li {
        border-bottom: 1px solid #eee;
        font-size: 14px;
    }

    .classification-menu li.active {
        background: #eee;
        color: #e65c5c;
    }

    .rgiht-content li img {
        width: 50%;
        height: 10%;
    }

    .rgiht-content li span {
        display: inline-block;
        width: 100%;
        font-size: 12px;
        margin-top: 5px;
    }
</style>
<body>
<div class="left-menu">
    <ul class="classification-menu">
        <c:forEach items="${fns:getDictList('commodity_classification')}" var="itme">
            <li value="${itme.value}">${itme.label}</li>
        </c:forEach>
    </ul>
</div>
<div class="rgiht-content">
    <ul data-am-widget="gallery" class="am-gallery am-avg-sm-3 am-avg-md-3 am-avg-lg-4 am-gallery-bordered am-no-layout"
        data-am-gallery="{  }">
    </ul>
</div>
<footer>
    <div data-am-widget="navbar" class="am-navbar am-cf am-navbar-default"
         id="">
        <ul class="am-navbar-nav am-cf am-avg-sm-4">
            <li class="home">
                <a href="${ctx}/m" class="">
                    <i class="icon-home"></i>
                    <span>首页</span>
                </a>
            </li>
            <li class="active">
                <a href="${ctx}/m/classification" class="">
                    <i class="classification"></i>
                    <span>分类</span>
                </a>
            </li>
            <li onclick="openPage('${ctx}/m/shoppingCat?userId=${sessionScope.mUser.id}')">
                <a href="javascript:void(0);" class="">
                    <i class="shopping-cat"></i>
                    <span>购物车</span>
                </a>
            </li>
            <li onclick="openPage('${ctx}/m/personalCenter')">
                <a href="javascript:void(0);" class="">
                    <i class="personal-center"></i>
                    <span>我的</span>
                </a>
            </li>
        </ul>
    </div>
</footer>
<script>
    var phone = '${sessionScope.mUser.phone}';
    var login = '${sessionScope.mUser.login}';
    function openPage(url) {
        if (login == "no" || login == "") {//如果手动注销过
            window.location.href = "${ctx}/m/loginPage";
            return;
        } else {//已经绑定
            window.location.href = url;
        }
    }
    //左边菜单点击
    $(".classification-menu li").on("click", function () {
        $(this).addClass("active");
        $(this).siblings().removeClass("active");
        var value = $(this).attr("value");
        pageInit(value)
    })
    //页面数据加载
    function pageInit(value) {
        $(".rgiht-content ul").html("");
        $.post("${ctx}/m/classificationData?value=" + value, function (ret) {
            if (ret.code == "0") {
                var str = "";
                for (var i = 0; i < ret.data.length; i++) {
                    str += '<li onclick="openSpenclty(\'' + ret.data[i].id + '\',\'' + ret.data[i].commodityClassificationName + '\')"><img class="lazy" src="' + ret.data[i].commodityClassificationThumbnail + '"><span>' + ret.data[i].commodityClassificationName + '</span></li>';
                }
                $(".rgiht-content ul").append(str);
            } else {
                $(".rgiht-content ul").html("<span style='display: inline-block;margin-top: 100%'>该地区下暂无特产</span>");
            }
        })
    }
    $(document).ready(function () {
        $(".classification-menu li:first").click();//页面加载完第一个地区点击一下
    })
    //点击特产
    function openSpenclty(id, name) {
        window.location.href = "${ctx}/m/specialtyPage?belongSpecialty=" + id + "&specialtyName=" + name;
    }
</script>
</body>
</html>
