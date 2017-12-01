<%@ taglib prefix="s" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="include/taglib.jsp" %>
<html>
<!--个人中心-->
<head>
    <%@include file="include/head.jsp" %>
</head>
<style>
    .buy-img-list {
        height: 50px;
        border: 1px solid #eee !important;
        min-height: 68px !important;
    }

    .buy-img-list .nav-menu > li {
        width: 25%;
        margin: 0;
        color: #333;
        text-align: center;
    }

    .title-personal h2 {
        padding: 0;
        margin: 0;
        color: #333;
        margin-bottom: 10px;
    }

    li.title-personal {
        font-size: 14px;
        color: #ccc;
        margin-bottom: 1px;
        min-height: 100px;
        margin-top: 14%;
        padding: 0 20px!important;
    }

    .title-personal img {
        width: 60px;
        height: 60px;
        position: absolute;
        top: 5px;
        right: 20px;
    }

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
    .nav-menu li{
        font-size: 13px;
    }
    .nav-menu li span{
        display: inline-block;
        margin-top: 4px;
    }
</style>

<body>
<div class="content">
    <s:set var="isVip" value="${sessionScope.mUser.isVip}"></s:set>
    <ul class="am-list am-list-static am-list-border">
        <li class="title-personal">
            <h2>您好,${sessionScope.jb.getString("nickname")}</h2><!--微信名 -->
            <%--<span>我的下线：996人</span>--%>
            <span>账户余额：${sessionScope.mUser.money} <a href="#">提现</a></span>
            <img class="am-img-thumbnail am-circle" src="${sessionScope.jb.getString("headimgurl")}"/><!--微信头像-->
        </li>
        <li class="buy-img-list">
            <ul class="nav-menu ul-order">
                <li>
                    <a href="${ctx}/m/orderList?index=1">
                        <i class="all-order"></i>
                        <span>全部订单</span>
                    </a>
                </li>
                <li>
                    <a href="${ctx}/m/orderList?index=2">
                        <i class="daifahuo"></i>
                        <span>待发货</span>
                    </a>
                </li>
                <li>
                    <a href="${ctx}/m/orderList?index=3">
                        <i class="daishouhuo"></i>
                        <span>待收货</span>
                    </a>
                </li>
                <li>
                    <a href="${ctx}/m/orderList?index=1">
                        <i class="reund"></i>
                        <span>退款</span>
                    </a>
                </li>
            </ul>
        </li>
        <li style="padding-top: 0">
            <ul class="personal-list">
                <li>
                  <%--  <a href="${ctx}/m/personalStores?userId=${sessionScope.mUser.id}">
                        <span>我的店铺</span>
                    </a>--%>
                      <c:if test="${isVip == '0'}">
                          <a href="${ctx}/m/?personalCenter=myStores">
                              <span>我的店铺</span>
                          </a>
                      </c:if>
                      <c:if test="${isVip == '1'}">
                          <a href="${ctx}/m/personalStoresVIP">
                              <span>我的店铺</span>
                          </a>
                      </c:if>
                    <i></i>
                </li>
                <!--如果不是会员分享出去的不是自己的分享码-->
                <c:if test="${isVip == '0'}">
                    <li>
                        <span>分享我的店铺</span>
                    </li>
                </c:if>
                <li>
                    <a href="${ctx}/m/addressList?userId=${sessionScope.mUser.id}">
                        <span>收货地址管理</span>
                    </a>
                    <i></i>
                </li>
               <%-- <li>
                    <a href="${ctx}/m/bindBankCard">
                        <span>绑定银行卡</span>
                    </a>
                    <i></i>
                </li>--%>
                <li>
                    <a href="${ctx}/m/systemSettings">
                        <span>系统设置</span>
                    </a>
                    <i></i>
                </li>
                <%--<li>
                    <a href="javascript:void (0)">
                        <span>关于</span>
                    </a>
                    <i></i>
                </li>--%>
            </ul>
        </li>
    </ul>
</div>
<footer>
    <div data-am-widget="navbar" class="am-navbar am-cf am-navbar-default"
         id="">
        <ul class="am-navbar-nav am-cf am-avg-sm-4">
            <li>
                <a href="${ctx}/m" class="">
                    <i class="icon-home"></i>
                    <span>首页</span>
                </a>
            </li>
            <li>
                <a href="${ctx}/m/shoppingCat?userId=${sessionScope.mUser.id}" class="">
                    <i class="shopping-cat"></i>
                    <span>购物车</span>
                </a>
            </li>
            <li class="active">
                <a href="javascript:void (0)" class="">
                    <i class="personal-center"></i>
                    <span>我的</span>
                </a>
            </li>
        </ul>
    </div>
</footer>
<script src="http://res.wx.qq.com/open/js/jweixin-1.2.0.js"></script>
<script>
    var isVip = '${isVip}';
    if (isVip == "0") {//如果是会员才能分享自己的分享码
        var url = "http://www.muqinonline.com${ctx}/m?code=${sessionScope.mUser.code}";
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
                title: "我的一小店,赚了不少呢,一起来赚钱吧", // 分享标题
                desc: "就是一个测试哦", // 分享描述
                link: url, // 分享链接
                imgUrl: "http://n.sinaimg.cn/photo/transform/20171115/Im15-fynshev6248469.jpg", // 分享图标
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
                title: "我的一小店,赚了不少呢,一起来赚钱吧", // 分享标题
                desc: "测试分享", // 分享描述
                link: url, // 分享链接
                imgUrl: "http://n.sinaimg.cn/photo/transform/20171115/Im15-fynshev6248469.jpg", // 分享图标
                success: function () {
                },
                cancel: function () {
                }
            });
        });
    }
</script>
</body>
</html>
