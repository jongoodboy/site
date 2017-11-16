<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="include/taglib.jsp" %>
<html>
<!--订单列表-->
<head>
    <%@include file="include/head.jsp" %>
</head>
<style>
    .am-header-default {
        background: #fff;
        text-align: center;
    }

    .am-header-default a {
        color: #333;
    }

    .am-header-default li.active a {
        color: red;
    }

    .am-header-default li.active {
        border-bottom: 2px solid red;
    }

    .am-slider-default {
        margin: 0;
        height: 200px;
        position: relative;
    }

    .am-slider {
        margin-top: 10px;
    }

    .am-slider li {
        height: 80px;
    }

    .orderoOperation {
        clear: both;
        text-align: right;
        width: 100%;
        padding: 5px;
    }

    .orderoOperation .shopping-info, .order-title {
        margin-right: 10px;
    }

    .orderoOperation .am-divider {
        padding: 0;
        margin: 5px 0;
    }

    .orderoOperation .go-pay {
        display: inline-block;
        padding: 3px;
        border: 1px solid red;
        text-align: center;
        margin-right: 10px;
        color: red;
        margin-bottom: 5px;
    }

    .order-title {
        color: red;
    }

    .bottom {
        position: absolute;
        bottom: 0
    }

    .am-viewport {
        background: #f9f9f9;
        padding: 3px 0;
    }

    .pay-money {
        font-weight: bold;
    }

    .one-shopping {
        list-style: none;
        padding: 0;
        height: 80px;
        background: #f9f9f9;
        margin: 0;
        overflow: hidden;
    }

    .one-shopping li {
        width: 100px;
        float: left;
    }

    .one-shopping p {
        float: left;
        width: 66%;
        font-size: 12px;
        padding: 10px 0;
        margin: 0;
    }

    .no-data {
        text-align: center;
        position: absolute;
        width: 100%;
        top: 30%;
    }
</style>
<body>
<header data-am-widget="header" class="am-header am-header-default am-header-fixed">
    <ul class="am-navbar-nav am-cf am-avg-sm-5">
        <li class="all">
            <a href="javascript:findData('')" class="">
                <span>全部</span>
            </a>
        </li>
        <li>
            <a href="javascript:findData(1)" class="">
                <span>待付款</span>
            </a>
        </li>
        <li class="shipment">
            <a href="javascript:findData(2)" class="">
                <span>待发货</span>
            </a>
        </li>
        <li class="receipt">
            <a href="javascript:findData(3)" class="">
                <span>待收货</span>
            </a>
        </li>
        <li>
            <a href="javascript:findData(4)" class="">
                <span>已取消</span>
            </a>
        </li>
    </ul>
</header>
<div class="content">
    <!--订单列表-->
</div>
</body>
<script>
    switch ('${param.index}') {
        case '1'://全部
            addClass(".all");
            init("");
            break
        case '2'://待发货
            addClass(".shipment");
            init("2")
            break
        case '3'://待收货
            addClass(".receipt");
            init("3")
            break
    }
    $(".am-navbar-nav li").on("click", function () {
        $(this).addClass("active");
        $(this).siblings().removeClass("active");
    })

    function addClass(id) {
        $("" + id + "").addClass('active');
    }
    function init(orderState) {
        $(".content").html('');
        $.post("${ctx}/m/orderListDate?orderState=" + orderState+"&userId=${sessionScope.mUser.id}", function (ret) {
            if (ret.code == "0") {
                if (ret.data.length > 0) {
                    for (var i = 0; i < ret.data.length; i++) {
                        var str = '<div class="am-slider am-slider-default am-slider-carousel boutique">';
                        <!--头部-->
                        str += '<div class="orderoOperation">';
                        var orderTitle = "已完成";//头部显示
                        var infoText = "需付款";
                        var gopay = "去支付";
                        switch (ret.data[i].orderState){
                            case "0":
                                orderTitle = "已完成";
                                infoText = "实付款";
                                gopay = "再次购买";
                                break;
                            case "1":
                                orderTitle = "等待付款";
                                break;
                            case "2":
                                orderTitle = "待发货";
                                infoText = "实付款";
                                gopay = "我要催单";
                                break;
                            case "3":
                                orderTitle = "待收货";
                                infoText = "实付款";
                                gopay = "确认收货";
                                break;
                            case "4":
                                orderTitle = "已取消";
                                infoText = "实付款";
                                gopay = "重新购买";
                                break;
                        }
                        var shoppingInfo = '共' + ret.data[i].commodityIndex + '件商品&nbsp;&nbsp;&nbsp;'+infoText+':<span class="pay-money">￥' + ret.data[i].sumOrderMoney + '</span>'
                        str += '<span class="order-title">'+orderTitle+'</span></div>';
                        var shoppingListIndex = ret.data[i].shppingList.length;
                        if (shoppingListIndex == 1) {//如果只是一个商品
                            str += '<ul class="one-shopping" onclick="orderDetail(\'' + ret.data[i].sumOrderNnmber + '\',\'' + ret.data[i].sumOrderMoney + '\','+ret.data[i].orderState+')">';
                        } else {
                            str += '<ul class="am-slides" onclick="orderDetail(\'' + ret.data[i].sumOrderNnmber + '\',\'' + ret.data[i].sumOrderMoney + '\','+ret.data[i].orderState+')">';
                        }
                        for (var j = 0; j < ret.data[i].shppingList.length; j++) {
                            var img = ret.data[i].shppingList[j].commodityImager.split("|");
                            str += '<li><img class="lazy" src="' + img[1] + '"/></li>';
                            if (shoppingListIndex == 1) {//如果只是一个商品
                                str += '<p>' + ret.data[i].shppingList[j].commodityName + '</p>'
                            }
                        }
                        str += '</ul>';
                        <!--底部-->
                        str += '<div class="orderoOperation bottom">';
                        str += '<span class="shopping-info">'+shoppingInfo+'</span>';
                        str += '<hr data-am-widget="divider" style="" class="am-divider am-divider-default"/>';
                        str += '<span class="go-pay" onclick="pay(\'' + ret.data[i].sumOrderNnmber + '\',\'' + ret.data[i].sumOrderMoney + '\','+ret.data[i].orderState+')">'+gopay+'</span></div>'

                        str += '</div>'
                        $(".content").append(str);
                    }
                    $('.am-slider').flexslider({
                        itemWidth: 100,
                        itemMargin: 5,
                        slideshow: false,
                        directionNav: false,
                        controlNav: false
                    });
                } else {
                    $(".content").append("<p class='no-data'>您还没有相关订单信息</p>")
                }
            } else {
                alert(ret.msg);
            }
        })
    }
    //切换头部菜单
    function findData(index) {
        init(index)
    }
    //订单详情
    function orderDetail(orderNumber,payMoney,orderState) {
        window.location.href = "${ctx}/m/orderDetail?orderNumber=" + orderNumber+"&payMoney="+payMoney+"&orderState="+orderState;
    }
    //去支付
    function pay(orderNumber, payMoney,orderState) {
        switch (orderState){
            case 0:
                loadingShow("再次购买功能开发中!")
                break;
            case 1:
                window.location.href = "${ctx}/m/payPage?orderNumber=" + orderNumber + "&payMoney=" + payMoney+"&orderBody=购买母亲云电商平台产品";
                break;
            case 2:
               loadingShow("催单成功!")
                break;
            case 3:
                loadingShow("确认收货功能开发中!")
                break;
            case 4:
                loadingShow("重新购买功能开发中!")
                break;
        }

    }
</script>
</html>
