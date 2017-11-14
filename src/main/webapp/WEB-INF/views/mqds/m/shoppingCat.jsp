<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="include/taglib.jsp" %>
<html>
<!--购物车-->
<head>
    <%@include file="include/head.jsp" %>
</head>
<style>
    .am-list li {
        height: 100px;
        padding: 0;
    }

    .am-list-main {
        padding: 0;
        height: 100%;
    }

    .am-list-main .nav-menu {
        position: absolute;
        height: 20px;
        bottom: 5px;
        width: 98%;
    }

    .am-list-thumb {
        height: 100%;
        padding: 5px;
    }

    .am-list-thumb img {
        width: 100%;
        height: 100%;
    }

    .am-list .am-secondary {
        margin-top: 40px;
        margin-left: 5px;
    }

    .am-secondary {
        color: #333;
        font-size: 10px;
    }

    .buy-number {
        width: 30px;
        border: 0;
        text-align: center;
        color: #333;
    }

    .buy-span {
        background: red;
        display: inline-block;
        width: 20px;
        text-align: center;
        height: 20px;
    }

    .am-gallery {
        margin-bottom: 50px;
    }

    .am-btn-danger {
        height: 100%;
    }

    .sum-money {
        font-size: 15px;
        margin-left: 20px;
    }
    .shopping-cat-null{
        display: inline-block;
        text-align: center;
        width: 100%;
        line-height: 50px;
        font-size: 20px;
    }
</style>
<body>
<div class="content">
    <ul class="am-list">
        <!--购物车列表-->
        <c:if test="${listMap != '[]'}">
            <c:forEach var="map" items="${listMap}">
                <li class="am-g am-list-item-desced am-list-item-thumbed am-list-item-thumb-top">
                    <div class="am-list-thumb am-u-sm-1">
                        <label class="am-checkbox am-secondary">
                            <input type="checkbox" checked="checked"
                                   name="select" value="2" commodityId="${map.id }"
                                   commodityNumber="${map.commodityNumber}"
                                   money="${map.commodityPice}" shoppingNumber="${map.shoppingNumber}" data-am-ucheck checked><!--商品单价用于计算-->
                        </label>
                    </div>
                    <c:set var="img" value="${fn:split(map.commodityImager, '|')}"></c:set>
                    <div class="am-list-thumb am-u-sm-4">
                        <a href="${ctx}/m/commodityDetail?commodityId=${map.id }">
                            <img src="${img[0]}"/>
                        </a>
                    </div>
                    <div class="am-list-main am-u-sm-7">
                        <div class="am-list-item-text">
                            <a href="${ctx}/m/commodityDetail?commodityId=${map.id }" style="color: #333">
                                <span>${map.commodityName}</span><br/>
                            </a>
                                <%--  <span>颜色:黑色&nbsp;尺码:40</span>--%>
                            <ul class="nav-menu">
                                <li><i class="my-icon like"></i></li>
                                <li class="active">${map.commodityPice}</li>
                                <li style="float: right">
                                    <span class="buy-span buy-del remove-number">-</span>
                                    <input value="${map.shoppingNumber}" class="buy-number" type="number"
                                           onkeyup="setNumber(this)">
                                    <span class="buy-span buy-add add-number">+</span>
                                </li>
                            </ul>
                        </div>
                    </div>
                </li>
            </c:forEach>
        </c:if>
        <c:if test="${listMap == '[]'}">
            <span class="shopping-cat-null">您的购物车空空如也!</span>
        </c:if>
    </ul>
    <!-- 去结算-->
    <div class="to-settle-accounts">
        <ul class="nav-menu">
            <li>
                <label class="am-checkbox am-secondary">
                    <input type="checkbox" checked="checked" class="selectAll" value="3" data-am-ucheck checked> 全选
                    <span class="sum-money">合计:￥<span class="buySumMoney"></span></span>
                </label>
            </li>
            <li class="right-menu">
                <button type="button" class="am-btn am-btn-danger <c:if test="${listMap == '[]'}">am-disabled</c:if>" >去结算(
                    <spna class="buyNumber"></spna>
                    )
                </button>
            </li>
        </ul>
    </div>
    <spen class="commodity-name">为您推荐</spen>
    <ul data-am-widget="gallery" class="am-gallery am-avg-sm-2 am-avg-md-3 am-avg-lg-4 am-gallery-bordered"
        data-am-gallery="{  }">
        <c:forEach items="${commodityList}" var="itme">
            <li>
                <div class="am-gallery-item">
                    <c:set var="img" value="${fn:split(itme.commodityImager,'|')}"/>
                    <a href="${ctx}/m/commodityDetail?commodityId=${itme.id }" class="">
                        <img class="lazy" data-original="${img[0]}"/>
                        <h3 class="am-gallery-title">${itme.commodityName}</h3>
                    </a>
                    <div class="am-gallery-desc">
                        <ul class="nav-menu">
                            <li><i class="my-icon like"></i></li>
                            <li class="active">99k</li>
                        </ul>
                        <ul class="nav-menu">
                            <li><%--<i class="my-icon like"></i>--%>￥</li>
                            <li class="active">${itme.commodityPice}</li>
                        </ul>
                        <a href="${ctx}/m/orderPage?newBuy=yes&commodityId=${itme.id }" class="">
                            <spen class="buy">购买</spen>
                        </a>
                    </div>
                </div>
            </li>
        </c:forEach>
    </ul>
</div>
<script>
    var selectInput = $("input[name='select']");//购物车列表
    var selectAll = $(".selectAll");//全选
    var isAll = true;//列表是否全部选中
    $(document).ready(function () {
        init();
        //商品选中
        selectInput.on("click", function () {
            init();
        })
        //全选
        selectAll.on("click", function () {
            if ($(this).is(':checked') == false) {//如果没有全选
                selectInput.uCheck('uncheck');
            } else {
                selectInput.attr('checked', true);//购物车列表全选
            }
            init();
        })
        //去结算
        $(".am-btn-danger").on("click", function () {
            var str = "";//订单页面显示列表
            var buyNumber = "";//购买的数量
            var buyCommodityId = "";//购买的商品id
            var commodityPrice = "";//商品单价
            for (var i = 0; i < selectInput.length; i++) {//所有选中的商品去结算
                var selectTshi = $(selectInput[i]);
                if (selectTshi.is(':checked')) {
                    str += ',' + selectTshi.parent().parent().next().html();
                    buyNumber += ',' + selectTshi.parent().parent().parent().last().find("input[class='buy-number']").val();//每个商品购买的数量
                    buyCommodityId += ',' + selectTshi.attr("commodityId");
                    commodityPrice += ',' + selectTshi.attr("money");
                }
            }
            window.location.href = ctx + "/m/orderPage?html=" + str + "&money=" + $(".buySumMoney").html()
                    + "&number=" + $(".buyNumber").html() + "&commodityPrice=" + commodityPrice
                    + "&buyNumber=" + buyNumber + "&buyCommodityId=" + buyCommodityId+"&userId=${sessionScope.mUser.id}";
        })
    })
    function init() {
        isAll = true;
        var buyNumber = 0;//商品总数量
        var buySumMoney = 0.00;//商品总金额
        var buyNumberSpan = $(".buyNumber");//显示购买数量
        var buySumMoneySpen = $(".buySumMoney");//显示购买数量
        for (var i = 0; i < selectInput.length; i++) {//如果其中一个商品没有选中。把全选按钮去除
            var selectTshi = $(selectInput[i]);
            if (selectTshi.is(':checked') == false) {
                isAll = false;
                selectAll.uCheck('uncheck');
                continue;
            }
            var number = parseInt(selectTshi.parent().parent().parent().last().find("input[class='buy-number']").val());//购买的数量统计 find("input[class='buy-number']").val()
            buyNumber += number;
            var money = parseFloat(selectTshi.attr("money"));//购买金额统计
            buySumMoney += (money * number);//单个商品总价
        }
        buyNumberSpan.html(buyNumber);//显示购买的数量
        buySumMoneySpen.html(buySumMoney);//显示购买总金额
        if (isAll) {
            selectAll.attr('checked', true);
        } else {
            selectAll.uCheck('uncheck');
        }
    }

    //减少商品
    $(".remove-number").on("click", function () {
        var commodityNumber = $(this).parent().parent().parent().parent().siblings().first().find("input").attr("commodityNumber");
        var inputNumber = $(this).next(".buy-number");
        var inputNumberVal = inputNumber.val();
        if (inputNumberVal <= 1) {
            inputNumberVal = 1;
        } else {
            inputNumberVal--;
        }
        inputNumber.val(inputNumberVal);
        init();
    })
    //添加商品
    $(".add-number").on("click", function () {
        var commodityNumber = $(this).parent().parent().parent().parent().siblings().first().find("input").attr("commodityNumber");
        var inputNumber = $(this).prev(".buy-number");
        var inputNumberVal = inputNumber.val();
        if (parseInt(inputNumberVal) >= parseInt(commodityNumber)) {//如果加入购物车的数量大于库存
            inputNumberVal = commodityNumber;
        } else {
            if (inputNumberVal >= 200) { //最高购买数不能大于你200
                inputNumberVal = 200;
            } else {
                inputNumberVal++;
            }
        }
        inputNumber.val(inputNumberVal);
        init();
    })
    //输入商品数量
    function setNumber(ev) {
        var commodityNumber = $(ev).parent().parent().parent().parent().siblings().first().find("input").attr("commodityNumber");
        var inputNumberVal = $(ev).val();
        if (!parseInt(inputNumberVal)) {
            inputNumberVal = 1;
        }
        if (parseInt(inputNumberVal) > parseInt(commodityNumber)) {//如果购买的数量大于库存
            inputNumberVal = commodityNumber;
        }
        if (inputNumberVal >= 200) {
            inputNumberVal = 200
        }
        $(ev).val(inputNumberVal);
        init();
    }
</script>
</body>
</html>
