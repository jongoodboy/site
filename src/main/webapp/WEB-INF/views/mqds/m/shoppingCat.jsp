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
        width: 35px;
        border: 0;
        text-align: center;
        color: #333;
        margin-top: -10px;
    }

    .am-list-item-text {
        padding: 4px 0;
    }

    .shopping-am-list-main {
        padding: 4px 0;
    }

    .am-gallery {
        margin-bottom: 50px;
    }

    .am-btn-danger {
        height: 100%;
    }

    .buy-add-number {
        position: absolute;
        right: 0;
    }

    .am-gallery-bordered .am-gallery-item {
        padding: 0;
        margin: 3px;
    }

    .am-gallery-title, .am-gallery-desc {
        padding-left: 10px;
        padding-right: 15px;
    }

    .shoppoing-title {
        font-size: 16px;
        color: #5d5959;
    }

    .am-btn-danger {
        text-align: center;
        padding: 0;
        width: 100%;
    }
</style>
<body>
<div class="content">
    <ul class="am-list">
        <!--购物车列表-->
        <c:if test="${listMap != '[]'}">
            <c:forEach var="map" items="${listMap}">
                <li class="am-g am-list-item-desced am-list-item-thumbed am-list-item-thumb-top">
                    <div class="am-list-thumb am-u-sm-1 shopping-list">
                            <span class="xuanzhong span-select shopping-list-list" onclick="selectShopping(this)"
                                  name="select"
                                  commodityId="${map.id }"
                                  commodityNumber="${map.commodityNumber}"
                                  money="${map.commodityPice + map.freight}"
                                  shoppingNumber="${map.shoppingNumber}" freight="${map.freight}"
                                  commodityPice="${map.commodityPice}">
                            </span>
                        <%----%><!--商品单价用于计算-->
                    </div>
                    <c:set var="img" value="${fn:split(map.commodityImager, '|')}"></c:set>
                    <div class="am-list-thumb am-u-sm-4">
                        <a href="${ctx}/m/commodityDetail?commodityId=${map.id }">
                            <img src="${img[0]}"/>
                        </a>
                    </div>
                    <div class="am-list-main am-u-sm-7 shopping-am-list-main ">
                        <div class="am-list-item-text">
                            <a href="${ctx}/m/commodityDetail?commodityId=${map.id }" style="color: #333">
                                <span class="shoppoing-title">${map.commodityName}</span><br/>
                            </a>
                                <%--  <span>颜色:黑色&nbsp;尺码:40</span>--%>
                            <ul class="nav-menu">
                                <li class="active">￥${map.commodityPice}</li>
                                <li style="font-size: 14px">运费:${map.freight == null ? 0 : map.freight}</li>
                                <li class="buy-add-number">
                                    <span class="buy-span buy-del remove-number"></span>
                                    <input value="${map.shoppingNumber}" class="buy-number" type="number"
                                           onkeyup="setNumber(this)">
                                    <span class="buy-span buy-add add-number"></span>
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
                            <%--   <ul class="nav-menu">
                                   <li><i class="my-icon like"></i></li>
                                   <li class="active">99k</li>
                               </ul>--%>
                        <ul class="nav-menu">
                            <li><%--<i class="my-icon like"></i>--%>￥</li>
                            <li class="active">${itme.commodityPice}</li>
                        </ul>
                        <a href="${ctx}/m/orderPage?newBuy=yes&commodityId=${itme.id }" class="">
                            <spen class="buy">#购买</spen>
                        </a>
                    </div>
                </div>
            </li>
        </c:forEach>
    </ul>
</div>
<!-- 去结算-->
<div class="to-settle-accounts to-settle-accounts-shoppong-cat">
    <ul class="nav-menu">
        <li style="width: 70%">
            <label class="am-checkbox am-secondary" style="margin-top: 0;font-size: 14px;padding: 0;">
                <%--  <input type="checkbox" checked="checked" id="selectAll" class="selectAll">--%>
                <span class="xuanzhong span-select" id="selectAll">全选</span><span class="show-sum-money">合计:￥<span
                    class="buySumMoney"></span></span>
            </label>

        </li>
        <li class="right-menu">
            <button type="button" class="am-btn am-btn-danger <c:if test="${listMap == '[]'}">am-disabled</c:if>">去结算<%--(
                <spna class="buyNumber"></spna>
                )--%>
            </button>
        </li>
    </ul>
</div>
<footer>
    <div data-am-widget="navbar" class="am-navbar am-cf am-navbar-default">
        <ul class="am-navbar-nav am-cf am-avg-sm-4">
            <li>
                <a href="${ctx}/m" class="">
                    <i class="icon-home"></i>
                    <span>首页</span>
                </a>
            </li>
            <li class="active">
                <a href="javascript:void (0)" class="">
                    <i class="shopping-cat"></i>
                    <span>购物车</span>
                </a>
            </li>
            <li>
                <a href="${ctx}/m/personalCenter" class="">
                    <i class="personal-center"></i>
                    <span>我的</span>
                </a>
            </li>
        </ul>
    </div>
</footer>
<script>
    var selectInput = $("span[name='select']");//购物车列表
    var selectAll = $("#selectAll");//全选
    var isAll = true;//列表是否全部选中
    //商品选中
    function selectShopping(ev) {
        if ($(ev).hasClass('xuanzhong') == false) {//如果没有选择
            $(ev).addClass("xuanzhong")
            $(ev).removeClass("kong");
        } else {
            $(ev).removeClass("xuanzhong");
            $(ev).addClass("kong")
        }
        init();
    }
    $(document).ready(function () {
        init();
        //全选
        selectAll.on("click", function () {
            if ($(this).hasClass('xuanzhong') == false) {//如果没有全选
                $(this).addClass("xuanzhong")
                $(this).removeClass("kong");
                for (var i = 0; i < selectInput.length; i++) {//如果其中一个商品没有选中。把全选按钮去除
                    var selectTshi = $(selectInput[i]);
                    selectTshi.addClass("xuanzhong")
                    selectTshi.removeClass("kong");
                }
            } else {
                $(this).removeClass("xuanzhong");
                $(this).addClass("kong")
                for (var i = 0; i < selectInput.length; i++) {//如果其中一个商品没有选中。把全选按钮去除
                    var selectTshi = $(selectInput[i]);
                    selectTshi.addClass("kong");
                    selectTshi.removeClass("xuanzhong");
                }
            }
            init();
        })

        //去结算
        $(".am-btn-danger").on("click", function () {
          var imags = "";//商品图片
            var buyNumber = "";//购买的数量
            var buyCommodityId = "";//购买的商品id
            var commodityPrice = "";//商品单价
            var freight = "";//商品运费
            var commodityNames = "";//商品名称
              for (var i = 0; i < selectInput.length; i++) {//所有选中的商品去结算
                var selectTshi = $(selectInput[i]);
                if (selectTshi.hasClass('xuanzhong')) {
                    commodityNames += "~" + selectTshi.parent().parent().last().find(".shoppoing-title").html();
                    imags += "," + selectTshi.parent().next().find("img").attr("src");
                    buyNumber += ',' + selectTshi.parent().parent().last().find("input[class='buy-number']").val();//每个商品购买的数量
                    buyCommodityId += ',' + selectTshi.attr("commodityId");
                    commodityPrice += ',' + selectTshi.attr("commodityPice");
                    freight += ',' + selectTshi.attr("freight");
                }
            }
            window.location.href = ctx + "/m/orderPage?money=" + $(".buySumMoney").html()
                    + "&number=" + $(".buyNumber").html() + "&commodityPrice=" + commodityPrice
                    + "&buyNumber=" + buyNumber + "&buyCommodityId=" + buyCommodityId + "&userId=${sessionScope.mUser.id}"
                    + "&imags=" + imags + "&freight=" + freight + "&commodityNames=" + commodityNames;
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
            if (selectTshi.hasClass('kong')) {
                isAll = false;
                selectAll.addClass("xuanzhong");
                selectAll.removeClass("kong");
                continue;
            }
            var number = parseInt(selectTshi.parent().parent().last().find("input[class='buy-number']").val());//购买的数量统计 find("input[class='buy-number']").val()
            buyNumber += number;
            var money = parseFloat(selectTshi.attr("money"));//购买金额统计
            buySumMoney += (money * number);//单个商品总价
        }
        buyNumberSpan.html(buyNumber);//显示购买的数量
        buySumMoneySpen.html(parseFloat(buySumMoney, 2).toFixed(2));//显示购买总金额
        if (isAll) {
            selectAll.addClass("xuanzhong");
            selectAll.removeClass("kong");
        } else {
            selectAll.addClass("kong");
            selectAll.removeClass("xuanzhong");
        }
    }

    //减少商品
    $(".remove-number").on("click", function () {
        var commodityNumber = $(this).parent().parent().parent().parent().siblings().first().find("span").attr("commodityNumber");
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
        var commodityNumber = $(this).parent().parent().parent().parent().siblings().first().find("span").attr("commodityNumber");
        var inputNumber = $(this).prev(".buy-number");
        var inputNumberVal = inputNumber.val();
        if (parseInt(inputNumberVal) >= parseInt(commodityNumber)) {//如果加入购物车的数量大于库存
            inputNumberVal = commodityNumber;
        } else {
            if (inputNumberVal >= 99) { //最高购买数不能大于200
                inputNumberVal = 99;
            } else {
                inputNumberVal++;
            }
        }
        inputNumber.val(inputNumberVal);
        init();
    })
    //输入商品数量
    function setNumber(ev) {
        var commodityNumber = $(ev).parent().parent().parent().parent().siblings().first().find("span").attr("commodityNumber");
        var inputNumberVal = $(ev).val();
        if (!parseInt(inputNumberVal)) {
            inputNumberVal = 1;
        }
        if (parseInt(inputNumberVal) > parseInt(commodityNumber)) {//如果购买的数量大于库存
            inputNumberVal = commodityNumber;
        }
        if (inputNumberVal >= 99) {
            inputNumberVal = 99
        }
        $(ev).val(inputNumberVal);
        init();
    }
</script>
</body>
</html>
