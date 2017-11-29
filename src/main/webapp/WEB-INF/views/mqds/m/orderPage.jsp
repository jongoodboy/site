<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="include/taglib.jsp" %>
<html>
<!--订单页面-->
<head>
    <%@include file="include/head.jsp" %>
    <style>
        body {
            position: relative;
        }

        .show-shopping img {
            width: 100%;
            height: 100%;
        }
        .buy-img-list {
            height: 125px;
        }

        h5 {
            margin: 0;
        }

        li.right-menu .am-btn-danger {
            width: 100%;
        }

        .to-settle-accounts {
            border-top: 1px solid #eee;
        }

        .am-list-border > li {
            border-bottom: 1px solid #eee;
        }

        li.selectAddress {
            padding-left: 30px !important;
            height: 80px;
            margin: auto;
            padding-left: 12.5% !important;
            padding-right: 12.5% !important;
        }

        h5 {
            font-size: 14px;
            padding-top: 2px;
        }

        h5 span {
            display: inline-block;
            margin: 3px 0;
        }

        h5 span:nth-child(2) {
            float: right;
            font-weight: normal;
        }

        .buy-img-list .nav-menu > li {
            width: 40%;
        }

        .freight-money {
            display: inline-block;
            float: right;
            margin-right: 10px;
        }

        .pading-10, .pading-10 span {
            color: #333;
            letter-spacing: 1px;
            font-size: 14px;
        }

        .commodity-name{
            font-size: 16px;
            color: #5d5959;
            text-align: left;
            word-break:break-all;
            display:-webkit-box;
            -webkit-line-clamp:2;
            -webkit-box-orient:vertical;
            overflow:hidden;
            font-weight: bold;
            letter-spacing: 1px;
        }
        .commodity-money{
            display: inline-block;
            color: red;
            text-align: right;
            width: 100%;
            position: absolute;
            right: 20px;
            bottom: 10px;
        }
        .no-location{
            text-align: center;
            padding-top: 5%;
        }
        .no-location i{
            left: 20%;
        }
    </style>
</head>
<body>
<div class="content">
    <ul class="am-list am-list-static am-list-border">
        <c:if test="${address != null}"> <!-- 默认地址-->
            <li class="selectAddress">
                <input id="addressId" value="${address.id}" hidden><!-- 收货地址的Id-->
                <h5><span>收货人:${address.consignee}</span><span>${address.consigneePhone}</span></h5>
                <span class="address-detail-location">
                    <i></i>
                ${address.province}${address.city}${address.county}${address.address}
                </span>
            </li>
        </c:if>
        <c:if test="${address == null}"> <!--如果没有默认地址-->
            <li class="selectAddress">
                <span class="address-detail-location no-location">
                    请填写收货人信息  <i></i>
                </span>
            </li>
        </c:if>
        <!-- 立即购买-->
        <c:if test="${param.nowBuy != null}">

        </c:if>
        <%-- <li class="buy-pay-stlye" style="position: fixed;bottom: 50px;width: 100%">
             <ul class="nav-menu">
                 <li>
                     <span>支付方式</span>
                 </li>
                 <li style="float: right;color: red">
                     <span>在线支付</span>
                 </li>
             </ul>
         </li>--%>
    </ul>
    <!-- 提交订单-->
    <div class="to-settle-accounts">
        <ul class="nav-menu">

            <li class="right-menu">
                <button type="button" class="am-btn am-btn-danger">提交订单</button>
            </li>
            <li style="float: right;color: #333;font-size: 14px;letter-spacing: 1px">
                实付款:<span class="payMoney">￥<span id="payMoney"></span></span>
            </li>
        </ul>
    </div>
</div>
<script>
    $(document).ready(function () {
        var commodityPrice = 0;//单价
        var imags = '${param.imags}';//购物车点击过来图片
        var carPrice = '${param.commodityPrice}';//商品单价
        var buyCommodityId = '${param.buyCommodityId}';//商品Id
        var buyNumber = '${param.buyNumber}'//商品购买数量
        var freight = '${param.freight}';//商品运费
        var commodityNames = '${param.commodityNames}';//商品名称
        if (imags != '' && imags != null) {//显示购物车提交过来的购物列表
            var imags = imags.split(',');
            var carPrice = carPrice.split(',');
            var buyCommodityId = buyCommodityId.split(',');
            var buyNumber = buyNumber.split(',');
            var freight = freight.split(',');
            var commodityNames = commodityNames.split('~');
            var str = "";
            for (var i = 1; i < imags.length; i++) {//最多显示三个商品的图片
                str += "<li class='buy-img-list'><ul class='nav-menu show-shopping'><li><a href='${ctx}/m/commodityDetail?commodityId=" + buyCommodityId[i] + "'>";
                str += "<img src=" + imags[i] + "></a></li>"
                str += "<li style='width: 55%'><p class='commodity-name'>" + commodityNames[i] + "</p>";
                str += "<span class='commodity-money'>￥" + carPrice[i] + "</span></li></ul></li>";
                str += '<li class="pading-10">运费:<span class="freight-money">' + freight[i] + '元</span></li>'
                str += '<li class="pading-10">购买数量:<span class="freight-money">' +buyNumber[i] + '</span></li>'
            }
        }
        $(".am-list-border").append(str);
        $("#payMoney").html('${param.money}');//实付金额
        $("#sumNumber").html('${param.number}')//共件数
        var commodityNumber = 0;//立即购买-》商品库存
        var subData = {
            commodityId: '${param.buyCommodityId}',//商品id 多个用","分割
            buyNumber: '${param.buyNumber}',//每个商品购买的数量多个用","分割
            commodityPrice: '${param.commodityPrice}',//每个商品单价多个用","分割
            address: '${address.province}' + '${address.city}' + '${address.county}' + '${address.address}',//收货地址
            userId: '${sessionScope.mUser.id}', //个人Id
            consignee: '${address.consignee}',
            consigneePhone: '${address.consigneePhone}'
        }
        //提交订单
        $(".am-btn-danger").on("click", function () {
            if (subData.consignee == undefined || subData.consignee == null || subData.consignee == "") {
                loadingShow("请先选择收货人");
                return;
            }
            if (('${param.nowBuy}' != "")) {//如果立即购买
                subData.buyNumber = $("#buyNumber").val();
            }
            $.post("${ctx}/m/saveOrder", subData, function (data) {
                /* loadingShow()*/
                if (data.code == "0") {
                    window.location.href = "${ctx}/m/payPage?orderNumber=" + data.orderNumber + "&payMoney=" + $("#payMoney").html() + "&orderBody=购买母亲云电商平台产品";
                } else {
                    loadingShow(data.msg);
                }
            });
        })
        if ('${param.nowBuy}' != "") {//如果立即购买
            $(".buy-sum-number").hide();
            $.post("${ctx}/m/commodityById?commodityId=${param.commodityId}", function (ret) {
                if (ret.code == "0") {
                    commodityNumber = ret.data.commodityNumber;
                    subData.commodityId = ret.data.id;
                    subData.commodityPrice = ret.data.commodityPice;
                    var img = ret.data.commodityImager;
                    if (img != null && img != "" && img != undefined) {//拼接显示商品信息
                        var imgSrc = img.split("|")
                        var str = "<li class='buy-img-list'><ul class='nav-menu show-shopping'><li><a href='${ctx}/m/commodityDetail?commodityId='" + ret.data.id + ">";
                        str += "<img src=" + imgSrc[1] + "></a></li>"
                        str += "<li style='width: 55%'><p class='commodity-name'>" + ret.data.commodityName + ret.data.commodityName +ret.data.commodityName +ret.data.commodityName +ret.data.commodityName +"</p>";
                        str += "<span class='commodity-money'>￥" + ret.data.commodityPice + "</span></ul></li></li>"
                        str += '<li class="pading-10">运费:<span class="freight-money">' + ret.data.freight + '元</span></li>'
                        str += '<li class="buy-pay-stlye pading-10""> <ul class="nav-menu"> <li> <span>购买数量</span> </li>'
                        str += '<li style="float: right;"> <div class="buy-number"><span class="buy-span buy-del remove-number"></span> <input value="1" id="buyNumber" style="margin-top: -10px; margin-left: -5px"/>'
                        str += '<span class="buy-span buy-add add-number"></span> </div></li> </ul> </li>';
                        $(".am-list-border").append(str);
                    }
                    commodityPrice = parseFloat(ret.data.commodityPice + ret.data.freight, 2).toFixed(2);//商品单价
                    $("#payMoney").html(parseInt($("#buyNumber").val()) * commodityPrice);//显示实付金额
                    //减少商品数量
                    $(".remove-number").on("click", function () {
                        var buyNumber = $("#buyNumber").val();
                        if (buyNumber <= 1) {
                            buyNumber = 1;
                        } else {
                            buyNumber--;
                        }
                        $("#buyNumber").val(buyNumber);
                        $("#payMoney").html(parseFloat(buyNumber * commodityPrice).toFixed(2));
                    })
                    //添加商品数量
                    $(".add-number").on("click", function () {
                        var buyNumber = $("#buyNumber").val();
                        if (parseInt(buyNumber) >= parseInt(commodityNumber)) {//如果加入购物车的数量大于库存
                            buyNumber = commodityNumber;
                        } else {
                            if (buyNumber >= 99) { //最高购买数不能大于你200
                                buyNumber = 99;
                            } else {
                                buyNumber++;
                            }
                        }
                        $("#buyNumber").val(buyNumber);
                        $("#payMoney").html(parseFloat(buyNumber * commodityPrice).toFixed(2));

                    })
                    //输入商品数量
                    $("#buyNumber").on("keyup", function () {
                        var buyNumber = $(this).val();
                        if (!parseInt(buyNumber)) {
                            buyNumber = 1;
                        }
                        if (buyNumber >= commodityNumber) {//如果加入购物车的数量大于库存
                            buyNumber = commodityNumber;
                        } else if (buyNumber >= 99) {
                            buyNumber = 99
                        }
                        $(this).val(buyNumber);
                        $("#payMoney").html(parseFloat(buyNumber * commodityFreight).toFixed(2));
                    })
                }
            })
        }

        //选择地址
        $(".selectAddress").on("click", function () {
            window.location.href = "${ctx}/m/addressList?userId=${sessionScope.mUser.id}&isOrderPage=yes&addressId=" + $(this).find("input").val();
        })
    })
</script>
</body>
</html>
