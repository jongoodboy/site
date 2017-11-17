<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="include/taglib.jsp" %>
<html>
<!--订单详情页面-->
<head>
    <%@include file="include/head.jsp" %>
    <style>
        li.buy-pay-stlye {
            margin-top: 5px;
        }

        li.shppoing-list {
            min-height: 80px;
            margin: 0;
            border-bottom: 1px solid #f9f9f9;
            overflow: hidden;
            font-size: 12px;
        }

        .shppoing-list ul li {
            float: left;
            width: 75%;
        }

        .shppoing-list ul li:nth-child(1) {
            width: 60px;
        }

        h5 {
            margin: 0;
        }

        .but-info {
            color: #333;
            line-height: 30px;
        }

        .am-btn-default {
            margin-top: 5px;
        }
    </style>
</head>
<body>
<div class="content">
    <ul class="am-list am-list-static am-list-border">
        <li>
            <c:set var="address" value="${listMap.address}"></c:set>
            <h5>${consignee}${consigneePhone}</h5>
            <span>${address}</span>
        </li>
        <c:set value="0" var="commodityPice"></c:set>
        <c:forEach items="${listMap.commidityList}" var="itme" varStatus="index">
            <li class="buy-pay-stlye shppoing-list" onclick="commodityDetail('${itme.id}')">
                <c:set var="img" value="${fn:split(itme.commodityImager,'|')}"></c:set>
                <ul class="nav-menu">
                    <li>
                        <img class="lazy" src="${img[0]}"/>
                    </li>
                    <li>
                        <span>${itme.commodityName}</span><br/>
                        <span>￥${itme.commodityPice}<span>&nbsp;&nbsp;运费:${itme.freight == null ? 0 : itme.freight }</span></span><br/>
                        <span>数量:${itme.commodityNumber}</span>
                    </li>
                </ul>
            </li>
        </c:forEach>
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
    <div class="to-settle-accounts">
        <ul class="nav-menu">
            <li>
                <span class="payMoney">实付款:￥<span id="payMoney">${param.payMoney}</span></span>
            </li>
            <li class="right-menu">
                <c:if test="${param.orderState == '1'}">
                    <button type="button" class="am-btn am-btn-danger">去支付</button>
                </c:if>
                <c:if test="${param.orderState == '2'}">
                    <button type="button" class="am-btn but-info">已支付</button>
                </c:if>
                <c:if test="${param.orderState == '3'}">
                    <button type="button" class="am-btn but-info">侍收货</button>
                </c:if>
                <c:if test="${param.orderState == '4'}">
                    <button type="button" class="am-btn but-info">退款中</button>
                </c:if>
                <c:if test="${param.orderState == '5'}">
                    <button type="button" class="am-btn but-info">已退款</button>
                </c:if>
            </li>
        </ul>
    </div>
</div>
<script>
    //商品详情
    function commodityDetail(id) {
        window.location.href = "${ctx}/m/commodityDetail?commodityId=" + id;
    }
    $(".am-btn-danger").on("click", function () {
        window.location.href = "${ctx}/m/payPage?orderNumber=${param.orderNumber}&payMoney=${param.payMoney}&orderBody=购买母亲云电商平台产品";
    })
</script>
</body>
</html>
