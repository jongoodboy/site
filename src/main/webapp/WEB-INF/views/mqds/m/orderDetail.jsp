<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="include/taglib.jsp" %>
<html>
<!--订单详情页面-->
<head>
    <%@include file="include/head.jsp" %>
    <style>
        #show-shopping img {
            width: 100%;
        }

        #show-shopping p {
            margin: 0;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

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
    </style>
</head>
<body>
<div class="content">
    <ul class="am-list am-list-static am-list-border">
        <li>
            <c:set var="address" value="${listMap.address}"></c:set>
            <h5>${address.consignee}${address.consigneePhone}</h5>
            <span>${address.province}${address.city}${address.county}${address.address}</span>
        </li>
        <c:forEach items="${listMap.commidityList}" var="itme" varStatus="index">
            <li class="buy-pay-stlye shppoing-list" onclick="commodityDetail('${itme.id}')">
                <c:set var="img" value="${fn:split(itme.commodityImager,'|')}"></c:set>
                    <ul class="nav-menu">
                        <li>
                            <img class="lazy" src="${img[0]}"/>
                        </li>
                        <li>
                            <span>${itme.commodityName}</span><br/>
                            <span>数量:${itme.commodityNumber}</span><br/>
                            <span>￥${itme.commodityPice}</span>
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
    <!-- 提交订单-->
    <div class="to-settle-accounts">
        <ul class="nav-menu">
            <%--  <li>
                  <span class="payMoney">实付款:￥<span id="payMoney"></span></span>
              </li>--%>
            <li class="right-menu">
                <button type="button" class="am-btn am-btn-danger">去支付</button>
            </li>
        </ul>
    </div>
</div>
<script>
    function  commodityDetail(id) {
        window.location.href="${ctx}/m/commodityDetail?commodityId="+id;
    }
</script>
</body>
</html>
