<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="include/taglib.jsp" %>
<html>
<!--订单列表-->
<head>
    <%@include file="include/head.jsp" %>
    <link href="${ctxStatic}/m/css/orderList.css" rel="stylesheet">
</head>
<body>
<header data-am-widget="header" class="am-header am-header-default <%--am-header-fixed--%>">
    <ul class="am-navbar-nav am-cf am-avg-sm-5">
        <li class="all">
            <a href="javascript:findData('')" class="">
                <i class="all-order"></i><br/>
                <span>全部订单</span>
            </a>
        </li>
        <li>
            <a href="javascript:findData(1)" class="">
                <i class="unpaid"></i><br/>
                <span>待付款</span>
            </a>
        </li>
        <li class="shipment">
            <a href="javascript:findData(2)" class="">
                <i class="daifahuo"></i><br/>
                <span>待发货</span>
            </a>
        </li>
        <li class="receipt">
            <a href="javascript:findData(3)" class="">
                <i class="daishouhuo"></i><br/>
                <span>待收货</span>
            </a>
        </li>
        <li class="complete">
            <a href="javascript:findData(-1)" class="">
                <i class="complete"></i><br/>
                <span>已完成</span>
            </a>
        </li>
    </ul>
</header>
<div class="content">
    <!--订单列表-->
</div>
<div class="am-modal am-modal-prompt" tabindex="-1" id="my-prompt">
    <div class="am-modal-dialog">
        <div class="am-modal-hd">申请退款描述</div>
        <div class="am-modal-bd">
            <textarea type="text" class="am-modal-prompt-input"></textarea>
        </div>
        <div class="am-modal-footer">
            <span class="am-modal-btn" data-am-modal-cancel>取消</span>
            <span class="am-modal-btn" data-am-modal-confirm>提交申请</span>
        </div>
    </div>
</div>
</body>
<script>
    var userId = '${sessionScope.mUser.id}'; //'';
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
        case '0'://已完成
            addClass(".complete");
            init("0")
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
        $.post("${ctx}/m/orderListDate?orderState=" + orderState + "&userId=" + userId, function (ret) {
            if (ret.code == "0") {
                if (ret.data.length > 0) {
                    for (var i = 0; i < ret.data.length; i++) {
                        var str = '<div class="am-slider am-slider-default am-slider-carousel boutique" >';
                        <!--头部-->
                        str += '<div class="orderoOperation" onclick="orderDetail(\'' + ret.data[i].sumOrderNnmber + '\',\'' + ret.data[i].sumOrderMoney + '\',' + ret.data[i].orderState + ')">';
                        var orderTitle = "已完成";//头部显示
                        var infoText = "需付款";
                        var gopay = "去支付";
                        switch (ret.data[i].orderState) {
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
                                orderTitle = "已发货";
                                infoText = "实付款";
                                gopay = "确认收货";
                                break;
                            case "4":
                                orderTitle = "退款中";
                                infoText = "实付款";
                                gopay = "取消申请";
                                break;
                            case "5":
                                orderTitle = "已退款";
                                infoText = "实付款";
                                gopay = "退款成功";
                                break;
                        }
                        var sumMoney = parseFloat(ret.data[i].sumOrderMoney).toFixed(2);//商品总价格单价+运费

                        str += '<span class="orderNumber">订单号:' + ret.data[i].sumOrderNnmber + '</span><span class="order-title">' + orderTitle + '</span></div>';
                        var shoppingListIndex = ret.data[i].shppingList.length;
                        str += '<ul class="one-shopping">';
                        for (var j = 0; j < ret.data[i].shppingList.length; j++) {
                            var commodityStateSpan = "暂无物流信息";
                            var commodityState = ret.data[i].shppingList[j].comState;//每个商品的发货状态
                            var operation = "";//操作提示
                            switch (commodityState) {
                                case "0":
                                    commodityStateSpan = "交易已完成";
                                    break;
                                case "1":
                                    commodityStateSpan = "等待付款";
                                    break;
                                case "2":
                                    operation = "申请退款";
                                    break;
                                case "3":
                                    commodityStateSpan = "物流信息:" + ret.data[i].shppingList[j].comExpress +
                                            "&nbsp;&nbsp;货运号:" + ret.data[i].shppingList[j].comExpressNumber
                                            + "<span class='show-express' onclick='showExpress(\""+ret.data[i].shppingList[j].comExpressNumber+"\")'>查看物流</span>";
                                    operation = "确认收货"
                                    break;
                                case "4":
                                    commodityStateSpan = "退款申请受理中";
                                    operation = "";
                                    break;
                                case "5":
                                    commodityStateSpan = "已退款";
                                    break;
                            }

                            var img = ret.data[i].shppingList[j].comImage.split("|");
                            str += '<li><img class="lazy" src="' + img[1] + '" onclick="commodityDetail(\'' + ret.data[i].shppingList[j].comId + '\')"/>';
                            str += '<div><span class="commodityName" onclick="commodityDetail(\'' + ret.data[i].shppingList[j].comId + '\')">' + ret.data[i].shppingList[j].comName + '</span>';
                            str += '<span class="buy-number-order-list">数量:' + ret.data[i].shppingList[j].comNumber + '' + ret.data[i].shppingList[j].comCompany + '</span>';
                            if (operation != "") {
                                /* alert(ret.data[i].shppingList[j].);*/
                                var refundMoney = (ret.data[i].shppingList[j].comPrice + ret.data[i].shppingList[j].comFreight) * ret.data[i].shppingList[j].comNumber;//支付总金额
                                str += '<span class="refund" onclick="operation(\'' + ret.data[i].sumOrderNnmber + '\',\'' + ret.data[i].shppingList[j].orderId + '\',\'' + refundMoney +
                                        '\',' + ret.data[i].shppingList[j].comState + ')">' + operation + '</span>'

                            }
                            str += '</div></li>';
                            /*  if (gopay != "去支付") {*///不等于待付款(去支付) 才有物流信息
                            var comFreight = ret.data[i].shppingList[j].comFreight;
                            if (comFreight == 0) {
                                comFreight = "包邮"
                            }
                            str += '<span class="cxpress">重量:' + ret.data[i].shppingList[j].comWeight + 'kg&nbsp;&nbsp;&nbsp;单价:' + ret.data[i].shppingList[j].comPrice + '</span>';
                            str += '<span class="cxpress">运费:' + comFreight + '</span>';
                            str += '<span class="cxpress">' + commodityStateSpan + '</span>';
                            /* }*/
                        }
                        str += '</ul>';
                        <!--底部-->
                        str += '<div class="orderoOperation bottom">';
                        var shoppingInfo = '共' + ret.data[i].commodityIndex + '件商品&nbsp;&nbsp;&nbsp;' + infoText + ':<span class="pay-money">￥' + sumMoney + '</span>'
                        str += '<span class="shopping-info">' + shoppingInfo + '</span>';
                        if (ret.data[i].orderState == 1) {//只有没有支付过订单才会显示去支付的按钮！其他操作暂时隐藏
                            str += '<span class="go-pay" onclick="pay(\'' + ret.data[i].sumOrderNnmber + '\',\'' + sumMoney + '\',' + ret.data[i].orderState + ')">' + gopay + '</span>';
                        }
                        str += '</div></div>'
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
    //订单详情 暂时不要
    function orderDetail(orderNumber, payMoney, orderState) {
        return;
        window.location.href = "${ctx}/m/orderDetail?orderNumber=" + orderNumber + "&payMoney=" + payMoney + "&orderState=" + orderState;
    }
    //商品详情
    function commodityDetail(id) {
        window.location.href = "${ctx}/m/commodityDetail?commodityId=" + id;
    }
    //去支付
    function pay(orderNumber, payMoney, orderState) {
        switch (orderState) {
            case 1:
                window.location.href = "${ctx}/m/payPage?orderNumber=" + orderNumber + "&payMoney=" + payMoney + "&orderBody=购买母亲云电商平台产品";
                break;
        }

    }
    var paramData = {
        applyOrderNumber: 0,//退款单号
        applyOrderId: "",//订单号对应的订单ID
        applyMoney: 0,//退款金额
        applyDescribe: "",//退款申请描述
        createBy: userId//申请退款人Id
    }
    //申请退费
    function operation(orderNnmber, orderId, orderMoney, orderState) {
        switch (orderState) {
            case 2:
                paramData.applyOrderNumber = orderNnmber;
                paramData.applyMoney = orderMoney;
                paramData.applyOrderId = orderId;
                $('#my-prompt').modal({
                    relatedTarget: this,
                    onConfirm: function (e) {
                        if (e.data == "") {
                            loadingShow("请输入申请描述")
                            return;
                        }
                        paramData.applyDescribe = e.data
                        $.post("${ctx}/m/applyFund", paramData, function (ret) {
                            if (ret.code == "0") {
                                loadingShow(ret.msg);
                                init("");
                            } else {
                                loadingShow(ret.msg);
                            }
                        })
                    },
                    onCancel: function (e) {

                    }
                });
                break;
            case 3:
                $.post("${ctx}/m/confirmReceipt?orderId=" + orderId, paramData, function (ret) {
                    if (ret.code == "0") {
                        loadingShow(ret.msg);
                        init("");
                    } else {
                        loadingShow(ret.msg);
                    }
                })
                break;
        }
    }

    //查看物流信息
    function showExpress(number) {
        window.location.href = "${ctx}/expressInfo?number=" + number;
    }
</script>
</html>
