<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="include/taglib.jsp" %>
<html>
<head>
    <%@include file="include/head.jsp" %>
    <link href="${ctxStatic}/m/css/indexAndShop.css" rel="stylesheet">
    <!--我的店铺-->
</head>
<style>
    .shop-name {
        display: inline-block;
        width: auto;
        overflow: hidden;
        border: 0;
        text-overflow: ellipsis;
        white-space: nowrap;
        width: 70%;
    }
</style>
<body>
<%--<c:if test="${param.personalCenter != null}">--%><!--如果会员-->
<div class="am-panel am-panel-default" style="background: url(${ctxStatic}/m/img/myStores.jpg)
        no-repeat center center;background-size: 100% 100%;min-height: 130px;padding-top: 18px">
    <div class="am-panel-bd" style="padding: 0;">
        <c:if test="${sessionScope.shopImgUrl != null}"><!--分享者的店铺-->
        <img class="am-img-thumbnail am-circle" src="${sessionScope.shopImgUrl}"/>
        <span class="shop-name">${shopName}</span>
        </c:if>
        <c:if test="${param.myself == 'yes' && sessionScope.shopImgUrl == null}"><!--自己的店铺-->
        <img class="am-img-thumbnail am-circle" src="${sessionScope.jb.getString("headimgurl")}"/>
        <span class="shop-name">${sessionScope.jb.getString("nickname")}的店铺</span>
        </c:if>
    </div>
</div>
<%--</c:if>--%>
<c:set value="${commodityList}" var="list"/>
<div class="header">
    <input placeholder="输入您要查找的货物名称" class="input-search" id="commodityName" onkeyup="findCommdityByName()">
    <button class="but-search"><span class="sousuo"></span></button>
    <ul class="nav-menu">
        <li class="active" onclick="tapMenu(this,1)">推荐</li>
        <li onclick="tapMenu(this,2)">热门</li>
    </ul>
</div>
<div class="content" id="content">
    <!--必卖商品-->
    <div data-tab-panel-0 class="am-tab-panel am-active">
        <div data-am-widget="slider" class="am-slider am-slider-manual am-slider-c4">
            <div class="swiper-container banner">
                <div class="swiper-wrapper" id="banner">
                    <!--必卖商品banner -->
                </div>
            </div>
        </div>
        <ul data-am-widget="gallery" class="am-gallery am-avg-sm-1 am-avg-md-3 am-avg-lg-4 am-gallery-bordered"
            data-am-gallery="{  }" id="commodityXisMenu">
            <!--6个商品菜单-->
        </ul>
        <div class="am-slider am-slider-carousel boutique">
            <span class="title">推荐精品</span>
            <div class="swiper-container products">
                <div class="swiper-wrapper" id="products">
                    <!--推荐精品 -->
                </div>
            </div>
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
            <li class="active home">
                <a href="${ctx}/m" class="">
                    <i class="icon-home"></i>
                    <span>首页</span>
                </a>
            </li>
            <li>
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
<script src="http://res.wx.qq.com/open/js/jweixin-1.2.0.js"></script>
<script>
    $(document).ready(function () {
        var shopImgUrl = '${sessionScope.shopImgUrl}';//如果已经别人分享出去的店铺不可以再分享
        var shopName = '${sessionScope.jb.getString("nickname")}' + '的店铺';//分享的标题
        var imgUrl = '${sessionScope.jb.getString("headimgurl")}';//分享出去的图片
        var url = window.location.href + "&code=${sessionScope.mUser.code}&shopName=" + shopName + "&shopImgUrl=" + imgUrl;//分享的路径
        url = encodeURI(url);
        var desc = '加入母亲电商,赚取丰厚回报!';//分享描述
        //url必须是获取的当前的页面路径
        $.post("${ctx}/m/getWxConfig?url=" + window.location.href, function (ret) {
            //微信分享
            wx.config({
                debug: false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
                appId: ret.appId, // 必填，公众号的唯一标识
                timestamp: ret.timestamp, // 必填，生成签名的时间戳
                nonceStr: ret.nonceStr, // 必填，生成签名的随机串
                signature: ret.signature,// 必填，签名，见附录1
                jsApiList: [
                    'onMenuShareTimeline',
                    'onMenuShareAppMessage'
                ] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
            });
            wx.error(function (res) {
                console.log(res);
            });

        })
        wx.ready(function () {
            //分享给朋友
            wx.onMenuShareAppMessage({
                title: shopName, // 分享标题
                desc: desc, // 分享描述
                link: url, // 分享链接
                imgUrl: imgUrl, // 分享图标
                // type: 'link', // 分享类型,music、video或link，不填默认为link
                dataUrl: '', // 如果type是music或video，则要提供数据链接，默认为空
                success: function () {
                    /*	alert('测试：成功发送给朋友');*/
                },
                cancel: function () {
                    /*	alert('测试：取消了发送给朋友');*/
                }
            });
            //分享到朋友圈
            wx.onMenuShareTimeline({
                title: shopName, // 分享标题
                link: url, // 分享链接
                imgUrl: imgUrl, // 分享图标
                success: function () {
                },
                cancel: function () {
                }
            });
            //分享到QQ
            wx.onMenuShareQQ({
                title: shopName, // 分享标题
                desc: desc, // 分享描述
                link: url, // 分享链接
                imgUrl: imgUrl, // 分享图标
                success: function () {
                    // 用户确认分享后执行的回调函数
                },
                cancel: function () {
                    // 用户取消分享后执行的回调函数
                }
            });
            //分享到QQ空间
            wx.onMenuShareQZone({
                title: shopName, // 分享标题
                desc: desc, // 分享描述
                link: url, // 分享链接
                imgUrl: imgUrl, // 分享图标
                success: function () {
                    // 用户确认分享后执行的回调函数
                },
                cancel: function () {
                    // 用户取消分享后执行的回调函数
                }
            });
        });

    })
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
                        strBanner += '<div class="swiper-slide"> <a href="${ctx}/m/commodityDetail?commodityId=' + banner[i].id + '"> <img  class="lazy" src="' + img[1] + '"/></a></div>';
                    }
                    $("#banner").append(strBanner);//顶部banner图
                    var mySwiper = new Swiper('.banner', {
                        effect: 'fade',
                        loop: true,
                        autoplay: 3000,//可选选项，自动滑动
                        autoplayDisableOnInteraction: false
                    })
                    var products = ret.products;//推荐精品
                    var productsStr = "";//推荐精品数据拼接
                    for (var i = 0; i < products.length; i++) {
                        var img = "";
                        var imgSrc = "";
                        if (products[i].commodityImager != null) {
                            img = products[i].commodityImager.split("|");
                            for (var k = 0; k < img.length; k++) {
                                if (img[k] != null && img[k] != "") {
                                    imgSrc = img[k];
                                    break;
                                }
                            }
                        }
                        productsStr += '<div class="swiper-slide"><a href="${ctx}/m/commodityDetail?commodityId=' + products[i].id + '"> <img  class="lazy" src="' + imgSrc + '"/>';
                        productsStr += '<span class="img-name">' + products[i].commodityName + '</span></a></div>';
                    }
                    $('#products').append(productsStr);
                    var mySwiper = new Swiper('.products', {
                        slidesPerView: 'auto',//'auto'
                        onTransitionEnd: function (swiper) {
                            if (swiper.progress == 1) {
                                swiper.activeIndex = swiper.slides.length - 1
                            }
                        }
                    })
                    if (productsStr == "") {//如果没有精品图片
                        $('#products').parent().hide();
                    }
                    var data = ret.listIndexMenuSix;//首页6个菜单商品
                    var commodityXisMenuStr = "";//首页6个菜单商品列表
                    for (var i = 0; i < data.length; i++) {//首页6个菜单商品商品列表
                        var img = "";
                        if (data[i].commodityImager != null) {
                            img = data[i].commodityImager.split("|");
                        }
                        commodityXisMenuStr += '<li><div class="am-gallery-item">';
                        commodityXisMenuStr += ' <a href="${ctx}/m/commodityDetail?commodityId=' + data[i].id + '" class=""><img class="lazy" src="' + img[1] + '"/>';
                        /*   commodityXisMenuStr += '<div class="am-gallery-desc"><hr/></ul><ul class="nav-menu"><li>￥</li>';*/
                        var price = data[i].commodityPice;
                        if ((/(^[1-9]\d*$)/.test(price))) {
                            price += ".00"
                        }
                        /*  commodityXisMenuStr += '<li class="active">' + price + '</li><li>';
                         commodityXisMenuStr += '<a href="javascript:buyNow(\'' + data[i].id + '\')">';
                         commodityXisMenuStr += '<spen class="buy">#购买</spen></a></li></ul></div></div></li>';*/
                        commodityXisMenuStr += '<h3>' + data[i].commodityName + '</h3><span>￥' + price + '</span></a>';
                    }

                    $("#commodityXisMenu").append(commodityXisMenuStr);//首页6个菜单商品商品列表
                }
                var data = ret.listCommodity;//商品数据
                var commodityListStr = "";//商品列表
                for (var i = 0; i < data.length; i++) {//商品列表
                    var img = "";
                    if (data[i].commodityImager != null) {
                        img = data[i].commodityImager.split("|");
                    }
                    var style = "";
                    if (data.length == 1) { //如果只有一个商品
                        style = "border-bottom: 1px solid #eee;margin-bottom: 8px;border-top: 10px solid #eee;";
                    }
                    commodityListStr += '<li style="' + style + '"><div class="am-gallery-item">';
                    commodityListStr += ' <a href="${ctx}/m/commodityDetail?commodityId=' + data[i].id + '" class=""><img class="lazy" src="' + img[1] + '"/>';
                    //commodityListStr += '<div class="am-gallery-desc"><hr/></ul><ul class="nav-menu"><li>￥</li>';
                    var price = data[i].commodityPice;
                    if ((/(^[1-9]\d*$)/.test(price))) {
                        price += ".00"
                    }
                    /*     commodityListStr += '<li class="active">' + price + '</li><li>';
                     commodityListStr += '<a href="javascript:buyNow(\'' + data[i].id + '\')">';
                     commodityListStr += '<spen class="buy">#购买</spen></a></li></ul></div></div></li>';*/
                    commodityListStr += '<h3>' + data[i].commodityName + '</h3><span>￥' + price + '</span></a>';
                }
                if (commodityListStr != "") {
                    $("#commodityLsit").append(commodityListStr);//商品列表
                    isLoading = true;//如果还有数据可以再给滑动加载
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
        findCommdityByName();

    })
    ///模糊搜索商品名称
    function findCommdityByName() {
        var commodityName = $("#commodityName").val();
        if (commodityName == "") {
            $(".am-slider").show();
            $("#commodityXisMenu").show();
            return;
        }
        paramData.commodityName = commodityName;
        paramData.pageNo = 0;
        paramData.type = 1;//所有商品
        isScroll = true;
        isLoading = true;
        $(".am-slider").hide();
        $("#commodityLsit").html("");//清空
        $("#commodityXisMenu").hide();
        init();
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
