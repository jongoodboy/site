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

        .am-list-border {
            margin-bottom: 50px;
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

        .commodity-name {
            font-size: 16px;
            color: #5d5959;
            text-align: left;
            word-break: break-all;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
            font-weight: bold;
            letter-spacing: 1px;
        }

        .commodity-money {
            display: inline-block;
            color: red;
            text-align: right;
            width: 100%;
            position: absolute;
            right: 20px;
            bottom: 10px;
        }

        .no-location {
            text-align: center;
            padding-top: 5%;
        }

        .no-location i {
            left: 20%;
        }

        .am-table-bordered {
            font-size: 12px;
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
                实付:<span class="payMoney">￥<span id="payMoney"></span></span>
            </li>
        </ul>
    </div>
</div>
<!--底部弹出快递选择-->
<%--<div class="am-modal-actions" id="open-bottom-model">
    <div class="bottom-model">
        <table class="am-table am-table-bordered">
            <tr>
                <th>快递名称</th>
                <th>省内首重(kg/元)</th>
                <th>省内递增(kg/元)</th>
                <th>省外首重(kg/元)</th>
                <th>省外递增(kg/元)</th>
            </tr>
            <tbody>
                <c:forEach var="itme" items="${expressList}">
                    <tr>
                        <td>${itme.expressName}</td>
                        <td>${itme.expressProvinceFirst}</td>
                        <td>${itme.expressProvinceIncreasing}</td>
                        <td>${itme.expressOutsideFirst}</td>
                        <td>${itme.expressOutsideIncreasing}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>--%>
<script>
    $(document).ready(function () {
        if ('${param.nowBuy}' != "") {//如果立即购买
            var commodityNumber = 0;//立即购买-》商品库存
            $(".buy-sum-number").hide();
            $.post("${ctx}/m/commodityById?commodityId=${param.commodityId}", function (ret) {
                if (ret.code == "0") {
                    var commodityDiscount = ret.data.commodityDiscount;//商品折扣
                    var commodityDiscountNum = ret.data.commodityDiscountNum;//满足打折的数量
                    commodityNumber = ret.data.commodityNumber;
                    subData.commodityId = ret.data.id;
                    subData.commodityPrice = ret.data.commodityPice;
                    var img = ret.data.commodityImager;
                    var weight = ret.data.weight;//商品重量
                    var expressProvinceFirst, expressProvinceIncreasing;//首重-递增
                    if ('${address.province}' == "贵州省") {//省内
                        expressProvinceFirst = ret.express.expressProvinceFirst;//省内首重
                        expressProvinceIncreasing = ret.express.expressProvinceIncreasing;//省内递增
                    } else {
                        expressProvinceFirst = ret.express.expressOutsideFirst;//省外首重
                        expressProvinceIncreasing = ret.express.expressOutsideIncreasing;//省外递增
                    }
                    var express, expressStr;
                    if (ret.data.freeShipping == "1") {//是否包邮1包0不包
                        express = 0.00;
                        expressStr = "包邮";
                    } else {
                        express = expressAddPrice(weight, expressProvinceFirst, expressProvinceIncreasing);//计算运费
                        expressStr = parseFloat(express).toFixed(2) + "元";
                    }
                    if (img != null && img != "" && img != undefined) {//拼接显示商品信息
                        var imgSrc = img.split("|")
                        var str = "<li class='buy-img-list'><ul class='nav-menu show-shopping'><li><a href='${ctx}/m/commodityDetail?commodityId='" + ret.data.id + ">";
                        str += "<img src=" + imgSrc[1] + "></a></li>"
                        str += "<li style='width: 55%'><p class='commodity-name'>" + ret.data.commodityName + "</p>";
                        str += "<span class='commodity-money'>￥" + ret.data.commodityPice + "</span></ul></li></li>"
                        str += '<li class="pading-10">快递:<span class="freight-money select-express">' + ret.express.expressName + '</span></li>'//快递
                        str += '<li class="pading-10">运费:<span class="freight-money this-express">' + expressStr + '</span></li>'//计算后的运费
                        str += '<li class="pading-10">重量:<span class="freight-money">' + ret.data.weight + 'kg</span></li>'
                        str += '<li class="buy-pay-stlye pading-10""> <ul class="nav-menu"> <li> <span>购买数量</span> </li>'
                        str += '<li style="float: right;"> <div class="buy-number"><span class="buy-span buy-del remove-number"></span> <input value="1" id="buyNumber" style="margin-top: -10px; margin-left: -5px"/>'
                        str += '<span class="buy-span buy-add add-number"></span> </div></li> </ul>';
                        if(commodityDiscountNum != undefined && commodityDiscount != undefined){
                            str += '<li class="pading-10">购买' + commodityDiscountNum + '个商品享有' + commodityDiscount + '折优惠</li>';
                        }
                        str += '</li>'
                        $(".am-list-border").append(str);
                    }
                    commodityPrice = parseFloat(ret.data.commodityPice).toFixed(2);//商品单价
                    $("#payMoney").html(parseFloat(parseInt($("#buyNumber").val()) * (parseFloat(commodityPrice) + parseInt(express))).toFixed(2));//显示实付金额

                    //减少商品数量
                    $(".remove-number").on("click", function () {
                        var buyNumber = $("#buyNumber").val();
                        if (buyNumber != 1) {
                            var reduceWeight = (parseInt(buyNumber) - 1) * weight;
                            if (buyNumber <= 1) {
                                buyNumber = 1;
                            } else {
                                buyNumber--;
                            }

                            $("#buyNumber").val(buyNumber);
                            var thisWeight = 0;
                            if (expressStr != "包邮") {
                                thisWeight = parseInt(expressAddPrice(reduceWeight, expressProvinceFirst, expressProvinceIncreasing));
                                $(".this-express").html(parseFloat(thisWeight).toFixed(2) + "元");
                            }
                            var discount = 1;//1默认不打折
                            if (commodityDiscount != undefined && commodityDiscountNum != undefined && buyNumber >= commodityDiscountNum) {//如果有打折并且购买数量大于等于打折数量就开始打折
                                discount = commodityDiscount / 10;
                            }
                            $("#payMoney").html(parseFloat(((buyNumber * commodityPrice) * discount) + thisWeight).toFixed(2));
                        }
                    })
                    //添加商品数量
                    $(".add-number").on("click", function () {
                        var buyNumber = $("#buyNumber").val();
                        var addWeight = (parseInt(buyNumber) + 1) * weight;
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
                        var thisWeight = 0;
                        if (expressStr != "包邮") {
                            thisWeight = parseInt(expressAddPrice(addWeight, expressProvinceFirst, expressProvinceIncreasing));
                            $(".this-express").html(parseFloat(thisWeight).toFixed(2) + "元");
                        }
                        var discount = 1;//1默认不打折
                        if (commodityDiscount != undefined && commodityDiscountNum != undefined && buyNumber >= commodityDiscountNum) {//如果有打折并且购买数量大于等于打折数量就开始打折
                            discount = commodityDiscount / 10;
                        }
                        $("#payMoney").html(parseFloat(((buyNumber * commodityPrice) * discount) + thisWeight).toFixed(2));
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
                        $("#payMoney").html(parseFloat(buyNumber * commodityPrice).toFixed(2));
                    })
                    //选择快递
                    $(".select-express").on("click", function () {
                        $("#open-bottom-model").modal('open');
                    })
                }
            })
        } else {//购物车
            var commodityPrice = 0;//单价
            var imags = '${param.imags}';//购物车点击过来图片
            var carPrice = '${param.commodityPrice}';//商品单价
            var buyCommodityId = '${param.buyCommodityId}';//商品Id
            var buyNumber = '${param.buyNumber}'//商品购买数量
            var freight = '${param.freight}';//商品运费
            var commodityNames = '${param.commodityNames}';//商品名称
            var expressName = '${param.expressName}';//快递名称
            var expressProvinceFirst = '${param.expressProvinceFirst}';//省内首重
            var expressProvinceIncreasing = '${param.expressProvinceIncreasing}';//省内递增
            var expressOutsideFirst = '${param.expressOutsideFirst}';//省外首重
            var expressOutsideIncreasing = '${param.expressOutsideIncreasing}';//省外递增
            var weight = '${param.weight}';//商品重量
            var payMoney = '${param.money}';
            var freeShipping = '${param.freeShipping}';//是否包邮 1包0不包
            var commodityDiscount = "${param.commodityDiscount}";//商品折扣
            var commodityDiscountNum = "${param.commodityDiscountNum}";//商品折扣满足数量
            if (imags != '' && imags != null) {//显示购物车提交过来的购物列表
                var imags = imags.split(',');
                var carPrice = carPrice.split(',');
                var buyCommodityId = buyCommodityId.split(',');
                var buyNumber = buyNumber.split(',');
                var freight = freight.split(',');
                var commodityNames = commodityNames.split('~');
                var expressName = expressName.split(',');//快递名称
                var weight = weight.split(',');
                var expressProvinceFirst = expressProvinceFirst.split(',');//省内首重
                var expressProvinceIncreasing = expressProvinceIncreasing.split(',');//省内递增
                var expressOutsideFirst = expressOutsideFirst.split(',');//省外首重
                var expressOutsideIncreasing = expressOutsideIncreasing.split(',');//省外递增
                var freeShipping = freeShipping.split(",");//是否包邮
                var commodityDiscount = commodityDiscount.split(",");//商品折扣
                var commodityDiscountNum = commodityDiscountNum.split(",");//商品折扣满足数量
                var str = "";
                for (var i = 1; i < imags.length; i++) {//最多显示三个商品的图片
                    var expressFirst, expressIncreasing, thisWeight, express = 0.00, expressStr;
                    thisWeight = weight[i] * buyNumber[i];
                    if (i == 1) {//第一次把原计算的金额清空
                        payMoney = 0;
                    }
                    if ('${address.province}' == "贵州省") {//省内
                        expressFirst = expressProvinceFirst[i];//省内首重
                        expressIncreasing = expressProvinceIncreasing[i];//省内递增
                    } else {
                        expressFirst = expressOutsideFirst[i];//省外首重
                        expressIncreasing = expressOutsideIncreasing[i];//省外递增
                    }
                    if (freeShipping[i] == "0") {
                        express = expressAddPrice(thisWeight, expressFirst, expressIncreasing);//计算运费
                        expressStr = express + "元";
                    } else {
                        expressStr = "包邮";
                    }
                    var discount = 1;//1默认不打折
                    if (commodityDiscount[i] != "" && commodityDiscountNum[i] != "" && buyNumber[i] >= commodityDiscountNum[i]) {
                        discount = commodityDiscount[i] / 10;
                    }
                    payMoney = ((buyNumber[i] * carPrice[i]) * discount) + parseInt(express) + payMoney;
                    str += "<li class='buy-img-list'><ul class='nav-menu show-shopping'><li><a href='${ctx}/m/commodityDetail?commodityId=" + buyCommodityId[i] + "'>";
                    str += "<img src=" + imags[i] + "></a></li>"
                    str += "<li style='width: 55%'><p class='commodity-name'>" + commodityNames[i] + "</p>";
                    str += "<span class='commodity-money'>￥" + carPrice[i] + "</span></li></ul></li>";
                    str += '<li class="pading-10">快递:<span class="freight-money select-express">' + expressName[i] + '快递</span></li>'//快递
                    str += '<li class="pading-10">运费:<span class="freight-money">' + expressStr + '</span></li>'
                    str += '<li class="pading-10">重量:<span class="freight-money">' + weight[i] + 'kg</span></li>'
                    str += '<li class="pading-10">购买数量:<span class="freight-money">' + buyNumber[i] + '</span></li>'
                    if(commodityDiscountNum[i] != "" && commodityDiscount[i] != ""){
                        str += '<li class="pading-10">购买' + commodityDiscountNum[i] + '个商品享有' + commodityDiscount[i] + '折优惠</li>';
                    }
                }
            }
            $(".am-list-border").append(str);
            $("#payMoney").html(parseFloat(payMoney).toFixed(2));//实付金额
            $("#sumNumber").html('${param.number}')//共件数
        }
        var subData = {
            commodityId: '${param.buyCommodityId}',//商品id 多个用","分割
            buyNumber: '${param.buyNumber}',//每个商品购买的数量多个用","分割
            commodityPrice: '${param.commodityPrice}',//每个商品单价多个用","分割
            address: '${address.province}' + '${address.city}' + '${address.county}' + '${address.address}',//收货地址
            userId: '${sessionScope.mUser.id}', //个人Id
            consignee: '${address.consignee}',
            consigneePhone: '${address.consigneePhone}',
            expressName: '${param.expressName}'//快递名称多个用","分割
        }
        //提交订单
        $(".am-btn-danger").on("click", function () {
            if (subData.consignee == undefined || subData.consignee == null || subData.consignee == "") {
                loadingShow("请先选择收货人");
                return;
            }
            if (('${param.nowBuy}' != "")) {//如果立即购买
                subData.buyNumber = $("#buyNumber").val();
                subData.expressName = $(".select-express").html();
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

        //选择地址
        $(".selectAddress").on("click", function () {
            window.location.href = "${ctx}/m/addressList?userId=${sessionScope.mUser.id}&isOrderPage=yes&addressId=" + $(this).find("input").val();
        })
    })
    /**
     * 运费计算+总金额运算
     * @param weight 商品重量
     * @param expressFirst 首重
     * @param expressIncreasing 递增
     */
    function expressAddPrice(weight, expressFirst, expressIncreasing) {
        if (weight <= 1) {//如果小于等于首重
            return expressFirst
        } else {
            var weightProvinceIncreasing = parseInt(weight);
            return (parseFloat(parseInt(expressFirst) + (expressIncreasing * parseInt(weightProvinceIncreasing))).toFixed(2))
        }
    }
</script>
</body>
</html>
