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
    }

    li.title-personal {
        font-size: 14px;
        color: #ccc;
        margin-bottom: 1px;
    }

    .title-personal img {
        width: 60px;
        height: 60px;
        position: absolute;
        top: 5px;
        right: 5px;
    }

    .personal-list {
        list-style: none;
        padding: 0;
        margin: 0;
    }

    .personal-list li {
        border-bottom: 1px solid #f9f9f9;
        line-height: 50px;
        position: relative;
    }

    .personal-list li:after {
        content: ">";
        display: inline-block;
        position: absolute;
        top: 0;
        right: 0;
        color: #EEEEEE;
    }

    .am-list-border ul li a {
        color: #333;
    }

    .personal-list a {
        width: 100%;
        display: inline-block;
    }
</style>
<body>
<div class="content">
    <ul class="am-list am-list-static am-list-border">
        <li class="title-personal">
            <h2>蛮吉</h2>
            <span>我的下线：996人</span>
            <img class="am-img-thumbnail am-circle" src="http://s.amazeui.org/media/i/demos/bing-1.jpg"/>
        </li>
        <li class="buy-img-list">
            <ul class="nav-menu">
                <li>
                    <a href="${ctx}/m/orderList?index=1">
                        <span>全部订单</span>
                    </a>
                </li>
                <li>
                    <a href="${ctx}/m/orderList?index=2">
                        <span>待发货</span>
                    </a>
                </li>
                <li>
                    <a href="${ctx}/m/orderList?index=3">
                        <span>待收货</span>
                    </a>
                </li>
                <li>
                    <a href="javascript:void (0)">
                        <span>退款</span>
                    </a>
                </li>
            </ul>
        </li>
        <li>
            <ul class="personal-list">
                <li>
                    <span>我的店铺</span>
                </li>
                <li>
                    <a href="${ctx}/m/addressList?userId=${sessionScope.mUser.id}">
                        <span>收货地址管理</span>
                    </a>
                </li>
                <li>
                    <a href="${ctx}/m/bindBankCard">
                        <span>绑定银行卡</span>
                    </a>
                </li>
                <li>
                    <a href="${ctx}/m/systemSettings">
                        <span>系统设置</span>
                    </a>
                </li>
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
                    <span>首页</span>
                </a>
            </li>
            <li>
                <a href="${ctx}/m/shoppingCat?userId=${sessionScope.mUser.id}" class="">
                    <span>购物车</span>
                </a>
            </li>
            <li class="active">
                <a href="javascript:void (0)" class="">
                    <span>我的</span>
                </a>
            </li>
        </ul>
    </div>
</footer>
</body>
</html>
