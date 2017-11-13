<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="include/taglib.jsp" %>
<html>
<head>
    <%@include file="include/head.jsp" %>
</head>
<style>
    .boutique .am-slides li {
        height: 150px;
    }

    .boutique .am-slides li img {
        height: 100%;
    }

    .boutique .am-slides .am-slider-desc {
        height: 30px;
        font-size: 12px;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
    }

    .am-slider-default {
        margin-bottom: 5px;
    }
</style>
<body>
<%--<header data-am-widget="header"--%>
<%--class="am-header am-header-default am-header-fixed">--%>
<%--<div class="am-header-left am-header-nav">--%>
<%--<a href="#left-link" class="">--%>
<%--<i class="am-header-icon am-icon-home"></i>--%>
<%--</a>--%>
<%--</div>--%>
<%--<h1 class="am-header-title">--%>
<%--<a href="#title-link" class="">--%>
<%--所有商品--%>
<%--</a>--%>
<%--</h1>--%>
<%--<div class="am-header-right am-header-nav">--%>
<%--<a href="#right-link" class="">--%>
<%--<i class="am-header-icon am-icon-bars"></i>--%>
<%--</a>--%>
<%--</div>--%>
<%--</header>--%>
<c:set value="${commodityList}" var="list"/>
<div class="header">
    <input placeholder="输入您要查找的货物名称" class="input-search">
    <button class="but-search"><span class="am-icon-search"></span></button>
    <ul class="nav-menu">
        <li class="active">推荐</li>
        <li>热门</li>
    </ul>
</div>
<div class="content">
    <!--必卖商品-->
    <div data-tab-panel-0 class="am-tab-panel am-active">
        <div data-am-widget="slider" class="am-slider am-slider-manual am-slider-c4">
            <ul class="am-slides">
                <c:forEach items="${list}" end="7" var="itme">
                    <c:if test="${itme.commodityState == '3'}"><!-- 必卖商品-->
                        <c:set var="img" value="${fn:split(itme.commodityImager, '|')}"/>
                        <li>
                            <a href="${ctx}/m/commodityDetail?commodityId=${itme.id }">
                                <img class="lazy" src="${img[0]}"/>
                            </a>
                        </li>
                    </c:if>
                </c:forEach>
            </ul>
        </div>
        <span>推荐精品</span>
        <div class="am-slider am-slider-default am-slider-carousel boutique"
             data-am-flexslider="{itemWidth: 150, itemMargin: 5, slideshow: false,directionNav:false,controlNav:false}">
            <ul class="am-slides">
                <c:forEach items="${list}" var="itme" end="7">
                    <c:if test="${itme.commodityState == '1'}"><!-- 精选商品-->
                        <c:set var="img" value="${fn:split(itme.commodityImager, '|')}"/>
                        <li>
                            <a href="${ctx}/m/commodityDetail?commodityId=${itme.id }">
                                <img class="lazy" src="${img[0]}"/>
                            </a>
                        </li>
                    </c:if>
                </c:forEach>
            </ul>
        </div>
        <ul data-am-widget="gallery" class="am-gallery am-avg-sm-1 am-avg-md-3 am-avg-lg-4 am-gallery-bordered"
            data-am-gallery="{  }">
            <c:forEach var="itme" items="${list}">
                <li>
                    <div class="am-gallery-item">
                        <c:set var="img" value="${fn:split(itme.commodityImager,'|')}"/>
                        <a href="${ctx}/m/commodityDetail?commodityId=${itme.id }" class="">
                            <img class="lazy" data-original="${img[0]}"/>
                            <h3 class="am-gallery-title">${itme.commodityName}</h3>
                        </a>
                        <div class="am-gallery-desc">
                            <ul class="nav-menu">
                                <li><i class="my-icon like"></i></li>
                                <li class="active">99k</li>
                            </ul>
                            <ul class="nav-menu">
                                <li><%--<i class="my-icon like"></i>--%>￥</li>
                                <li class="active">${itme.commodityPice}</li>
                            </ul>
                            <a href="/front/m/orderPage?newBuy=yes&commodityId=${itme.id }&userId=${sessionScope.mUser.id}" class="">
                                <spen class="buy">购买</spen>
                            </a>
                        </div>
                    </div>
                </li>
            </c:forEach>
        </ul>
    </div>
</div>
<footer>
    <div data-am-widget="navbar" class="am-navbar am-cf am-navbar-default"
         id="">
        <ul class="am-navbar-nav am-cf am-avg-sm-4">
            <li class="active">
                <a href="${ctx}/m" class="">
                    <span>首页</span>
                </a>
            </li>
            <li onclick="openPage('${ctx}/m/shoppingCat?userId=${sessionScope.mUser.id}')">
                <a href="javascript:void(0);" class="">
                    <span>购物车</span>
                </a>
            </li>
            <li onclick="openPage('${ctx}/m/personalCenter')">
                <a href="javascript:void(0);" class="">
                    <span>我的</span>
                </a>
            </li>
        </ul>
    </div>
</footer>
<script>
    var userId = '${sessionScope.mUser.id}';
    function openPage(url) {
        if (userId != "") {//已经登录
            window.location.href = url;
        } else {//没有登录，去登录
            window.location.href = "${ctx}/m/bindPhone?url=" +url;
        }
    }
</script>
</body>
</html>
