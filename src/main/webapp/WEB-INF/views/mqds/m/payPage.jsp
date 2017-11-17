<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="include/taglib.jsp" %>
<html>
<!--订单页面-->
<head>
    <%@include file="include/head.jsp" %>
</head>
<style>
    .to-settle-accounts {
        height: 50px;
        width: 60%;
        margin: auto;
        line-height: 50px;
        bottom: 20%;
        right: 20%;
    }

    .am-list > li {
        border: 0;
        margin-bottom: 5px;
    }

    .buy-pay-stlye {
        height: 50px;
    }

    .buy-pay-stlye > .nav-menu {
        color: #333 !important;
        width: 100%;
    }

    .am-btn-danger {
        width: 100%;
        height: 100%;
        font-size: 22px;
        font-weight: bold;
    }
</style>
<body>
<div class="content">
    <ul class="am-list am-list-static am-list-border">
        <li>
            <span>订单号:${param.orderNumber}</span>
        </li>
        <li class="buy-pay-stlye">
            <ul class="nav-menu">
                <li>
                    <span>应付总额</span>
                </li>
                <li style="float: right;color: red">
                    <span>￥${param.payMoney}</span>
                </li>
            </ul>
        </li>
        <li class="buy-pay-stlye">
            <ul class="nav-menu">
                <li>
                    <span>支付方式</span>
                </li>
                <li style="float: right;color: red">
                    <span>在线支付</span>
                </li>
            </ul>
        </li>
    </ul>
    <!-- 提交订单-->
    <div class="to-settle-accounts">
        <button type="button" class="am-btn am-btn-danger" onclick="onBridgeReady()">确认支付</button>
    </div>
</div>
<!-- 支付成功页面-->
<div class="am-modal am-modal-alert" tabindex="-1" id="pay-success">
    <div class="am-modal-dialog">
        <%-- <div class="am-modal-hd">Amaze UI</div>--%>
        <div class="am-modal-bd">
            支付成功,静等商品发货
        </div>
        <div class="am-modal-footer">
            <span class="am-modal-btn">确定</span>
        </div>
    </div>
</div>
<script>
    function onBridgeReady() {
        $(".am-btn-danger").html("支付中...").addClass("am-disabled");//设置为不可用
        WeixinJSBridge.invoke(
                'getBrandWCPayRequest', {
                    "appId": '${appid}',     //公众号名称，由商户传入
                    "timeStamp": '${timestamp}',         //时间戳，自1970年以来的秒数
                    "nonceStr": '${nonceStr}', //随机串
                    "package": '${packageValue}',
                    "signType": "MD5",         //微信签名方式：
                    "paySign": '${paySign}' //微信签名
                },
                function (res) {
                    if (res.err_msg == "get_brand_wcpay_request:ok") {// 使用以上方式判断前端返回,微信团队郑重提示：res.err_msg将在用户支付成功后返回    ok，但并不保证它绝对可靠。
                        loadingShow("支付成功");
                        $(".am-btn-danger").html("已支付");
                        paySuccess();
                    } else if (res.err_msg == "get_brand_wcpay_request:cancel") {//  支付过程中用户取消
                        loadingShow("支付被您取消了");
                        $(".am-btn-danger").html("确认支付").removeClass("am-disabled");
                    } else if (res.err_msg == " get_brand_wcpay_request:fail") {//  支付失败
                        loadingShow("支付失败");
                        $(".am-btn-danger").html("确认支付").removeClass("am-disabled");
                    }else{
                        loadingShow(res.err_msg);
                    }
                }
        );
    }
    if (typeof WeixinJSBridge == "undefined") {
        if (document.addEventListener) {
            /* document.addEventListener('WeixinJSBridgeReady', onBridgeReady, false);*/
        } else if (document.attachEvent) {
            document.attachEvent('WeixinJSBridgeReady', onBridgeReady);
            document.attachEvent('onWeixinJSBridgeReady', onBridgeReady);
        }
    } else {
        onBridgeReady();
    }
    //支付成功之后把订单改为已支付，待发货
    function paySuccess() {
        //0已完成,1待付款,2.待发货,3已发货,4已取消)
        $.post("${ctx}/m/updateOrderState?orderNumber=${param.orderNumber}&state=2&isVIP=${sessionScope.mUser.isVip}", function (ret) {
            if (ret.code == "0") {
                window.location.href = ctx + "/m";//返回首页
            }
        })
    }
</script>
</body>
</html>
