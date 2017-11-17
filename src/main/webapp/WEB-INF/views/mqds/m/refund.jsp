<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="include/taglib.jsp" %>
<html>
<!--退费列表-->
<head>
    <%@include file="include/head.jsp" %>
    <link href="${ctxStatic}/m/css/orderList.css" rel="stylesheet">
</head>
<style>
    .am-modal-prompt-input {
        min-height: 100px;
    }

    .am-modal-btn + .am-modal-btn {
        width: 50%;
    }
</style>
<body>
<div class="content">
    <!--退费列表-->
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
    var userId = '${sessionScope.mUser.id}';//用户Id
    init();
    function init(orderState) {
        $.post("${ctx}/m/orderListDate?orderState=2&userId=bd994867b9d84bca905836b2f963ec5d", function (ret) {
            if (ret.code == "0") {
                if (ret.data.length > 0) {
                    for (var i = 0; i < ret.data.length; i++) {
                        var str = '<div class="am-slider am-slider-default am-slider-carousel boutique">';
                        <!--头部-->
                        str += '<div class="orderoOperation">';
                        var orderTitle = "待发货";//头部显示
                        var infoText = "实付款";
                        var gopay = "申请退款";
                        var shoppingInfo = '共' + ret.data[i].commodityIndex + '件商品&nbsp;&nbsp;&nbsp;' + infoText + ':<span class="pay-money">￥' + ret.data[i].sumOrderMoney + '</span>'
                        str += '<span class="order-title">' + orderTitle + '</span></div>';
                        var shoppingListIndex = ret.data[i].shppingList.length;
                        if (shoppingListIndex == 1) {//如果只是一个商品
                            str += '<ul class="one-shopping" onclick="orderDetail(\'' + ret.data[i].sumOrderNnmber + '\',\'' + ret.data[i].sumOrderMoney + '\',' + ret.data[i].orderState + ')">';
                        } else {
                            str += '<ul class="am-slides" onclick="orderDetail(\'' + ret.data[i].sumOrderNnmber + '\',\'' + ret.data[i].sumOrderMoney + '\',' + ret.data[i].orderState + ')">';
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
                        str += '<span class="shopping-info">' + shoppingInfo + '</span>';
                        str += '<hr data-am-widget="divider" style="" class="am-divider am-divider-default"/>';
                        str += '<span class="go-pay" onclick="refundMoney(\'' + ret.data[i].sumOrderNnmber + '\',\'' + ret.data[i].sumOrderMoney + '\')">' + gopay + '</span></div>'

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
    //订单详情
    function orderDetail(orderNumber, payMoney, orderState) {
        window.location.href = "${ctx}/m/orderDetail?orderNumber=" + orderNumber + "&payMoney=" + payMoney + "&orderState=" + orderState;
    }
    var paramData = {
        applyOrderNumber: 0,//退款单号
        applyMoney: 0,//退款金额
        applyDescribe: "",//退款申请描述
        createBy: userId//申请退款人Id
    }
    //申请退费
    function refundMoney(orderNnmber, orderMoney) {
        paramData.applyOrderNumber = orderNnmber;
        paramData.applyMoney = orderMoney;
        $('#my-prompt').modal({
            relatedTarget: this,
            onConfirm: function (e) {
                paramData.applyDescribe = e.data
                $.post("${ctx}/m/applyFund", paramData, function (ret) {

                })
            },
            onCancel: function (e) {
                alert('不想说!');
            }
        });

    }
</script>
</html>
