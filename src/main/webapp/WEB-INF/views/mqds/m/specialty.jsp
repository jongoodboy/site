<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="include/taglib.jsp" %>
<html>
<head>
    <%@include file="include/head.jsp" %>
    <link href="${ctxStatic}/m/css/indexAndShop.css" rel="stylesheet">
</head>
<style>
    .header {
        line-height: 50px;
        text-align: center;
        font-size: 16px;
        border-bottom: 10px solid #eee;
        letter-spacing: 2px;
    }
</style>
<body>
<%--<div class="header">
    ${param.specialtyName}
</div>--%>
<div class="content" id="content">
    <!--必卖商品-->
    <div data-tab-panel-0 class="am-tab-panel am-active">
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
    $("title").html("${param.specialtyName}");
    var phone = '${sessionScope.mUser.phone}';
    var login = '${sessionScope.mUser.login}';
    function openPage(url) {
        window.location.href = url;
        return;
        if (login == "no" || login == "") {//如果手动注销过
            window.location.href = "${ctx}/m/loginPage";
            return;
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
        belongSpecialty: '${param.belongSpecialty}'
    }
    var userId = '${sessionScope.mUser.id}';//用户Id
    //页面初始数据
    function init() {
        isLoading = false;
        $.post("${ctx}/m/specialtyData", paramData, function (ret) {
            if (ret.code == "0") {
                paramData.pageNo++;
                var data = ret.data;//商品数据
                var commodityListStr = "";//商品列表
                for (var i = 0; i < data.length; i++) {//商品列表
                    var img = "";
                    if (data[i].commodityImager != null) {
                        img = data[i].commodityImager.split("|");
                    }
                    var style = "";
                    if (data.length == 1) { //如果只有一个商品
                        style = "border-bottom: 1px solid #eee;margin-bottom: 8px;";
                    }
                    commodityListStr += '<li style="'+style+'"><div class="am-gallery-item">';
                    commodityListStr += ' <a href="${ctx}/m/commodityDetail?commodityId=' + data[i].id + '" class=""><img class="lazy" src="' + img[1] + '"/>';
                    //commodityListStr += '<div class="am-gallery-desc"><hr/></ul><ul class="nav-menu"><li>￥</li>';
                    var price = data[i].commodityPice;
                    if ((/(^[1-9]\d*$)/.test(price))) {
                        price += ".00"
                    }
                    commodityListStr += '<h3>' + data[i].commodityName + '</h3><span>￥' + price + '</span></a>';
                }
                if (commodityListStr != "") {
                    $("#commodityLsit").append(commodityListStr);//商品列表
                    isLoading = true;//如果还有数据可以再给滑动加载
                } else {
                    $("#commodityLsit").append('<span style="display: inline-block; width:100%;text-align: center; margin-top: 30%">暂无商品信息</span>');//商品列表
                }
                if (data.length < paramData.pageSize) {
                    isScroll = false;//不可以滑动了
                }
                /*  if (data.length < paramData.pageSize && paramData.pageNo > 1) {
                 loadingShow("数据加载完啦", "2000");
                 return;
                 }*/
                loadingClose();//关闭加载提示
                //$("img.lazy").lazyload();//图片懒加载  src换成data-original
            }
        })
    }
    //立即购买
    function buyNow(commodityId) {
        if (userId != "") {//立即购买页面
            window.location.href = '${ctx}/m/orderPage?nowBuy=yes&commodityId=' + commodityId + '&userId=' + userId;
        } else {//没有登录，去登录
            window.location.href = "${ctx}/m/loginPage";
        }

    }
</script>
</body>
</html>
