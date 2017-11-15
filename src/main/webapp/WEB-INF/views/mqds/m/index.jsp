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
    <input placeholder="输入您要查找的货物名称" class="input-search" id="commodityName">
    <button class="but-search"><span class="am-icon-search"></span></button>
    <ul class="nav-menu">
        <li class="active" onclick="tapMenu(this,1)">推荐</li>
        <li onclick="tapMenu(this,2)">热门</li>
    </ul>
</div>
<div class="content" id="content">
    <!--必卖商品-->
    <div data-tab-panel-0 class="am-tab-panel am-active">
        <div data-am-widget="slider" class="am-slider am-slider-manual am-slider-c4">
            <ul class="am-slides tt" id="banner">
                <!--必卖商品banner -->
            </ul>
        </div>

        <div class="am-slider am-slider-default am-slider-carousel boutique"
             data-am-flexslider="{itemWidth: 150, itemMargin: 5, slideshow: false,directionNav:false,controlNav:false}">
            <span>推荐精品</span>
            <ul class="am-slides" id="products">
                <!--推荐精品 -->
            </ul>
        </div>
        <ul data-am-widget="gallery" class="am-gallery am-avg-sm-1 am-avg-md-3 am-avg-lg-4 am-gallery-bordered"
            data-am-gallery="{  }" id="commodityLsit">
            <!--商品列表-->
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

    var phone = '${sessionScope.mUser.phone}';
    function openPage(url) {
        if (phone == "") {//没有绑定过手机号
            window.location.href = "${ctx}/m/bindPhone?url=" + url;
        } else {//已经绑定
            window.location.href = url;
        }
    }
    $(document).ready(function () {
        loadingShow();//首次提示
        init();

    })
    var isScroll = true;
    var isLoading = true;//确保滑动每次加载一次
    $(window).scroll(function () {//向下滑动
        if ($(window).scrollTop() >= (document.getElementById("content").scrollHeight - window.screen.height)) {
            if (isScroll && isLoading) {
                init();
            }

        }
    });
    var paramData = {
        pageNo: 0,
        pageSize: 5,
        type: 1,//1推荐2热门
        commodityName: ""//模糊查询商品名称
    }
    var userId = '${sessionScope.mUser.id}';//用户Id
    //页面初始数据
    function init() {
        isLoading = false;
        $.post("${ctx}/m/indexData", paramData, function (ret) {
            if (ret.code == "0") {
                paramData.pageNo++;
                if (paramData.pageNo == 1 && paramData.type == 1 && paramData.commodityName == "") {//只加载一次
                    var banner = ret.banner;//商品banenr
                    var strBanner = "";//顶部图片banner
                    for (var i = 0; i < banner.length; i++) {
                        var img = "";
                        if (banner[i].commodityImager != null) {
                            img = banner[i].commodityImager.split("|");
                        }
                        strBanner += '<li> <a href="${ctx}/m/commodityDetail?commodityId=' + banner[i].id + '"> <img  class="lazy" src="' + img[1] + '"/></a></li>';
                    }
                    $("#banner").append(strBanner);//顶部banner图
                    $('#banner').parent().flexslider({
                        slideshow: false,
                        directionNav: false,
                        controlNav: false
                    });
                    var products = ret.products;//推荐精品
                    var productsStr = "";//推荐精品数据拼接
                    for (var i = 0; i < products.length; i++) {
                        var img = "";
                        if (products[i].commodityImager != null) {
                            img = products[i].commodityImager.split("|");
                        }
                        productsStr += '<li> <a href="${ctx}/m/commodityDetail?commodityId=' + products[i].id + '"> <img  class="lazy" src="' + img[1] + '"/></a></li>';
                    }
                    $('#products').append(productsStr);
                    $('#products').parent().flexslider({
                        itemWidth: 150,
                        slideshow: false,
                        directionNav: false,
                        controlNav: false
                    });
                }
                var data = ret.listCommodity;//商品数据
                var commodityListStr = "";//商品列表
                for (var i = 0; i < data.length; i++) {//商品列表
                    var img = "";
                    if (data[i].commodityImager != null) {
                        img = data[i].commodityImager.split("|");
                    }
                    commodityListStr += '<li><div class="am-gallery-item">';
                    commodityListStr += ' <a href="${ctx}/m/commodityDetail?commodityId=' + data[i].id + '" class=""><img class="lazy" data-original="' + img[1] + '"/>';
                    commodityListStr += '<h3 class="am-gallery-title">' + data[i].commodityName + '</h3></a>';
                    commodityListStr += '<div class="am-gallery-desc"><ul class="nav-menu"><li><i class="my-icon like"></i></li>';
                    commodityListStr += '<li class="active">99k</li></ul><ul class="nav-menu"><li><%--<i class="my-icon like"></i>--%>￥</li>';
                    commodityListStr += '<li class="active">' + data[i].commodityPice + '</li></ul>';
                    commodityListStr += '<a href="${ctx}/m/orderPage?newBuy=yes&commodityId=' + data[i].id + '&userId=' + userId + '">';
                    commodityListStr += '<spen class="buy">购买</spen></a></div></div></li>';
                }
                if (commodityListStr != "") {
                    $("#commodityLsit").append(commodityListStr);//商品列表
                    $("img.lazy").lazyload();//图片懒加载
                    isLoading = true;//如果还有数据可以再给滑动加载
                }
                if (data.length < paramData.pageSize) {
                    isScroll = false;//不可以滑动了
                }
                if (data.length < paramData.pageSize && paramData.pageNo > 1) {
                    loadingShow("数据加载完啦", "2000");
                    return;
                }
                loadingClose();//关闭加载提示
            }
        })
    }
    //头部推荐和热门两切换
    function tapMenu(ev, type) {
        $("#commodityName").val("");
        loadingShow();//加载提示
        paramData.pageNo = 0;
        paramData.type = type;
        isScroll = true;
        isLoading = true;
        paramData.commodityName = "";
        $(ev).siblings().removeClass("active");
        $(ev).addClass("active");
        if (type == 2) {//热门
            $(".am-slider").hide();
        } else {//推荐
            $(".am-slider").show();
        }
        $("#commodityLsit").html("");//清空
        init();
    }
    //模糊搜索商品名称
    $(".but-search").on("click", function () {
        var commodityName = $("#commodityName").val();
        if (commodityName == "") {
            return;
        }
        paramData.commodityName = commodityName;
        paramData.pageNo = 0;
        paramData.type = 1;//所有商品
        isScroll = true;
        isLoading = true;
        $(".am-slider").hide();
        $("#commodityLsit").html("");//清空
        init();

    })
</script>
</body>
</html>
