<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="include/taglib.jsp" %>
<html>
<!--商品详情-->
<head>
    <%@include file="include/head.jsp" %>
</head>
<style>
    form {
        margin: 0;
    }
</style>
<body>
<c:set value="${commodity}" var="itme"></c:set>
<c:set value="${fn:split(itme.commodityImager, '|')}" var="imgItme"></c:set>
<div class="content">
    <!--顶部bannaer-->
    <div data-tab-panel-0 class="am-tab-panel am-active">
        <div data-am-widget="slider" class="am-slider am-slider-manual am-slider-c4">
            <ul class="am-slides">
                <c:forEach var="img" items="${imgItme}">
                    <li>
                        <img class="lazy" src="${img}">
                    </li>
                </c:forEach>
            </ul>
        </div>


        <article data-am-widget="paragraph"
                 class="am-paragraph am-paragraph-default"
                 data-am-paragraph="{ tableScrollable: true, pureview: true }">
            <spen class="commodity-name">${itme.commodityName}</spen>
            <ul class="nav-menu">
                <li><%--<i class="my-icon like"></i>--%>￥</li>
                <li class="active">${itme.commodityPice}
                    / ${fns:getDictLabel(itme.commodityCompany,'commodity_company',0)}</li>
                <li style="float: right">运费:15元</li>
            </ul>
            <div>
                <spen class="commodity-name">商品描述</spen>
                <!--商品描述-->
                ${itme.commodityMaker}
            </div>
            <!-- 评论-->
            <!--推荐商品-->
            <spen class="commodity-name">为您推荐</spen>

        </article>
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
                            <a href="/front/m/orderPage?newBuy=yes&commodityId=${itme.id }" class="">
                                <spen class="buy">购买</spen>
                            </a>
                        </div>
                    </div>
                </li>
            </c:forEach>
        </ul>
    </div>
</div>
<footer>
    <div data-am-widget="navbar" class="am-navbar am-cf am-navbar-default "
         id="">
        <ul class="am-navbar-nav am-cf am-avg-sm-4">
            <%-- <li>
                 <a href="${ctx}/m" class="">
                     <span>首页</span>
                 </a>
             </li>--%>
            <li>
                <a href="javascript:void (0)" class="">
                    <span>关注</span>
                </a>
            </li>
            <li>
                <a href="javascript:void (0);" class="">
                    <span class="join-this-shopping-cat">加入购物车</span>
                </a>
            </li>
            <li class="active">
                <a href="javascript:buyNuew()" class="">
                    <span>立即购买</span>
                </a>
            </li>
        </ul>
    </div>
</footer>
<!--底部弹出加入购物车-->
<div class="am-modal-actions" id="open-bottom-model">
    <form id="addShoppingCat">
        <input name="userId" value="${sessionScope.mUser.id}" hidden><!--当前用记Id-->
        <div class="bottom-model">
            <ul class="model-title">
                <li>
                    <img class="lazy"
                         src="${imgItme[0]}">
                </li>
                <li>
                    <span class="price">￥:${commodity.commodityPice}</span><br>
                    <span>库存:${commodity.commodityNumber}</span><br>
                    <%--<span>商品编号:5555522</span><br>--%>
                </li>
                <span class="close-model">x</span>
            </ul>
            <div class="buy-number">
                <span class="remove-number">-</span><input value="1" class="number-input" onkeyup="setNumber()"
                                                           type="number" name="commodityNumber"><span
                    class="add-number">+</span><!--加入购物车商品数量-->
                <input name="commodityId" value="${commodity.id}" hidden><!--商品id-->
            </div>
            <button type="button" class="am-btn am-btn-danger">确定</button>
        </div>
    </form>
</div>
<script>
    $(".join-this-shopping-cat").on("click", function () {
        if ('${sessionScope.mUser.id}' != "") {
            $("#open-bottom-model").modal('open');
        } else {//没有登录，去登录
            window.location.href = "${ctx}/m/loginPage?url=" + window.location.href;
        }
    })
    $(".close-model").on("click", function () {
        $("#open-bottom-model").modal('close');
    })
    var commodityNumber = parseInt('${commodity.commodityNumber}');
    var inputNumber = $(".number-input");
    //减少商品
    $(".remove-number").on("click", function () {
        var inputNumberVal = inputNumber.val();
        if (inputNumberVal <= 1) {
            inputNumberVal = 1;
        } else {
            inputNumberVal--;
        }
        inputNumber.val(inputNumberVal);
    })
    //添加商品
    $(".add-number").on("click", function () {
        var inputNumberVal = inputNumber.val();
        if (inputNumberVal >= commodityNumber) {//如果加入购物车的数量大于库存
            inputNumberVal = commodityNumber;
        } else {
            if (inputNumberVal >= 200) { //最高购买数不能大于你200
                inputNumberVal = 200;
            } else {
                inputNumberVal++;
            }

        }
        inputNumber.val(inputNumberVal);
    })
    //输入商品数量
    function setNumber() {
        var inputNumberVal = inputNumber.val();
        if (!parseInt(inputNumberVal)) {
            inputNumberVal = 1;
        }
        if (inputNumberVal >= commodityNumber) {//如果加入购物车的数量大于库存
            inputNumberVal = commodityNumber;
        } else if (inputNumberVal >= 200) {
            inputNumberVal = 200
        }
        inputNumber.val(inputNumberVal);
    }
    //添加到购物车
    $(".am-btn-danger").on("click", function () {
        $(this).attr("disabled", "disabled");//设置为禁用
        $.post("${ctx}/m/addShoppingCat", $("#addShoppingCat").serialize(), function (data) {
            if (data.code == '0') {
                loadingShow(data.msg);
                $("#open-bottom-model").modal('close');
            } else {
                loadingShow(data.msg);
            }
        })
        $(this).removeAttr("disabled");//设置为可用
    })
    $(document).ready(function () {
        $("article img").css("width", "100%");//设置商品描图片
    })
    //立即购买
    function buyNuew() {
        if ('${sessionScope.mUser.id}' != "") {//立即购买页面
            window.location.href = '${ctx}/m/orderPage?newBuy=yes&commodityId=${commodity.id}';
        } else {//没有登录，去登录
            window.location.href = "${ctx}/m/loginPage?url=" + window.location.href;
        }

    }
</script>
</body>
</html>
