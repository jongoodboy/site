<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="include/taglib.jsp" %>
<html>
<!--订单页面-->
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

        h5 {
            margin: 0;
        }
    </style>
</head>
<body>
<div class="content">
    <ul class="am-list am-list-static am-list-border">
        <c:if test="${address != null}"> <!-- 默认地址-->
            <li class="selectAddress">
                <input id="addressId" value="${address.id}" hidden><!-- 收货地址的Id-->
                <h5>${address.consignee}${address.consigneePhone}</h5>
                <span>${address.province}${address.city}${address.county}${address.address}</span>
            </li>
        </c:if>
        <c:if test="${address == null}"> <!--如果没有默认地址-->
        <li class="selectAddress">
            <span>请填写收货人信息</span>
        </li>
        </c:if>
        <li class="buy-img-list">
            <ul class="nav-menu" id="show-shopping">
                <li class="buy-sum-number">
                    <span>共<span id="sumNumber"></span>件</span>
                </li>
            </ul>
        </li>
        <!-- 立即购买-->
        <c:if test="${param.nowBuy != null}">
            <li class="buy-pay-stlye">
                <ul class="nav-menu">
                    <li>
                        <span>购买数量</span>
                    </li>
                    <li style="float: right;">
                        <div class="buy-number">
                            <span class="remove-number">-</span>
                            <input value="1" id="buyNumber"/>
                            <span class="add-number">+</span>
                        </div>
                    </li>
                </ul>
            </li>
        </c:if>
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
            <li>
                <span class="payMoney">实付款:￥<span id="payMoney"></span></span>
            </li>
            <li class="right-menu">
                <button type="button" class="am-btn am-btn-danger">提交订单</button>
            </li>
        </ul>
    </div>
</div>
<script>
    $(document).ready(function () {
        var commodityPrice = 0;
        var html = '${param.html}';
        if (html != '' && html != null) {//显示购物车提交过来的购物列表
            var html = html.split(',');
            var str = "";
            for (var i = 1; i < html.length; i++) {//最多显示三个商品的图片
                if(i == 3){
                    break;
                }
                str += "<li>" + html[i] + "</li>";
            }
        }
        $("#show-shopping").append(str);
        $("#payMoney").html('${param.money}');//实付金额
        $("#sumNumber").html('${param.number}')//共件数
        var commodityNumber = 0;//立即购买-》商品库存
        var subData = {
            commodityId: '${param.buyCommodityId}',//商品id 多个用","分割
            buyNumber: '${param.buyNumber}',//每个商品购买的数量多个用","分割
            commodityPrice: '${param.commodityPrice}',//每个商品单价多个用","分割
            address:'${address.province}'+'${address.city}'+'${address.county}'+'${address.address}' ,//收货地址
            userId: '${sessionScope.mUser.id}', //个人Id
            consignee:'${address.consignee}',
            consigneePhone:'${address.consigneePhone}'
        }
        //提交订单
        $(".am-btn-danger").on("click", function () {
            if (subData.consignee == undefined || subData.consignee == null) {
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
                        var str = "<li><a href='${ctx}/m/commodityDetail?commodityId='" + ret.data.id + ">";
                        str += "<img src=" + imgSrc[1] + "></a></li>"
                        str += "<li><p>" + ret.data.commodityName + "</p>";
                        str += "<span style='color: red'>￥" + ret.data.commodityPice + "</span></li>"
                        $("#show-shopping").append(str).find("li:nth-child(3)").css("width", "75%").css("color", "#333");
                    }
                    commodityPrice = parseFloat(ret.data.commodityPice, 2).toFixed(2);//商品单价
                    $("#payMoney").html(parseInt($("#buyNumber").val()) * commodityPrice);//显示实付金额
                }
            })
        }
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
                if (buyNumber >= 200) { //最高购买数不能大于你200
                    buyNumber = 200;
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
            } else if (buyNumber >= 200) {
                buyNumber = 200
            }
            $(this).val(buyNumber);
        })
        //选择地址
        $(".selectAddress").on("click", function () {
            window.location.href = "${ctx}/m/addressList?userId=${sessionScope.mUser.id}&isOrderPage=yes&addressId="+$(this).find("input").val();
        })
    })
</script>
</body>
</html>
