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

    .commodity-name-title {
        font-size: 24px;
        font-weight: bold;
        letter-spacing: 2px;
        color: #3a3a3a;
        line-height: 35px;
        display: inline-block;
        margin-top: 10px;
    }

    .commodity-name {
        letter-spacing: 1px;
    }

    .am-gallery-bordered .am-gallery-item {
        padding: 0;
        margin: 3px;
    }

    .am-gallery-title, .am-gallery-desc {
        padding-left: 10px;
        padding-right: 15px;
    }

    .buy-new {
        background: #eb616c;
        position: relative;
    }

    .buy-new span {
        display: inline-block;
        width: 100%;
        height: 100%;
        position: absolute;
        left: 0;
        font-size: 14px;
        color: #fff;
    }

    article .nav-menu li {
        font-size: 20px;
    }

    article .nav-menu li.active {
        font-weight: bold;
    }

    article .nav-menu {
        margin-top: 20px;
        width: 100%;
    }

    article {
        padding: 0 10px;
    }

    li.freight {
        float: right;
        color: #8a8a8a;
    }

    article div p {
        width: 100%;
    }

    .comdiyi {
        display: inline-block;
        margin-top: 25px;
    }

    .for-yuo {
        display: inline-block;
        margin: 20px 0 25px 0;
    }

    .buy-number {
        text-align: right;
        padding-right: 15px;
    }

    .number-input {
        margin-top: -20px;
        margin-left: -7px;
    }

    .buy-span {
        width: 25px;
        height: 25px;
    }
</style>
<body>
<c:set value="${commodity}" var="itme"></c:set>
<c:set value="${fn:split(itme.commodityImager, '|')}" var="imgItme"></c:set>
<div class="content">
    <!--顶部bannaer-->
    <div data-tab-panel-0 class="am-tab-panel am-active">
        <div data-am-widget="slider" class="am-slider am-slider-manual am-slider-c4">
            <div class="swiper-container">
                <div class="swiper-wrapper">
                    <c:forEach var="img" items="${imgItme}">
                        <div class="swiper-slide">
                            <img class="lazy" src="${img}">
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>

        <article data-am-widget="paragraph"
                 class="am-paragraph am-paragraph-default"
                 data-am-paragraph="{ tableScrollable: true, pureview: true }">
            <spen class="commodity-name-title">${itme.commodityName}</spen>
            <ul class="nav-menu">
                <li class="active">￥${itme.commodityPice}
                    / ${fns:getDictLabel(itme.commodityCompany,'commodity_company',0)}</li>
                <li class="freight">运费:${itme.freight == null ? 0 : itme.freight}元</li>
            </ul>
            <div>
                <spen class="commodity-name comdiyi">商品描述</spen>
                <!--商品描述-->
                ${itme.commodityMaker}
            </div>
            <!-- 评论-->
            <!--推荐商品-->
            <spen class="commodity-name for-yuo">为您推荐</spen>

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
                                <%--<ul class="nav-menu">
                                    <li><i class="my-icon like"></i></li>
                                    <li class="active">99k</li>
                                </ul>--%>
                            <ul class="nav-menu">
                                <li><%--<i class="my-icon like"></i>--%>￥</li>
                                <li class="active">${itme.commodityPice}</li>
                            </ul>
                            <a href="${ctx}/m/orderPage?newBuy=yes&commodityId=${itme.id }&userId=${sessionScope.mUser.id}"
                               class="">
                                <spen class="buy">#购买</spen>
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
            <li class="active home">
                <a href="${ctx}/m" class="">
                    <i class="icon-home"></i>
                    <span>首页</span>
                </a>
            </li>
            <%--  <li>
                  <a href="javascript:void (0)" class="">
                      <span>关注</span>
                  </a>
              </li>--%>
            <li class="join-this-shopping-cat">
                <a href="javascript:void (0);" class="">
                    <i class="vehicle"></i>
                    <span class="join-this-shopping-cat">加入购物车</span>
                </a>
            </li>
            <li class="buy-new" onclick="buyNow()">
                <span>立即购买</span>
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
                <li style="width: 60%">
                    <span style="display: inline-block;  width: 100%; overflow: hidden;text-overflow: ellipsis;white-space: nowrap;">
                        ${commodity.commodityName}
                    </span>
                    <span class="price">￥:${commodity.commodityPice}</span><br>
                    <span>库存:${commodity.commodityNumber}</span><br>
                    <%--<span>商品编号:5555522</span><br>--%>
                </li>
                <span class="close-model">x</span>
            </ul>
            <div class="buy-number">
                <p>购买数量</p>

                <span class="buy-span buy-del remove-number"></span>
                <input value="1" class="number-input" onkeyup="setNumber()"
                       type="number" name="commodityNumber">
                <span class="buy-span buy-add add-number"></span><!--加入购物车商品数量-->
                <input name="commodityId" value="${commodity.id}" hidden><!--商品id-->
            </div>
            <button type="button" class="am-btn am-btn-danger">确定</button>
        </div>
    </form>
</div>
<script>
    var mySwiper = new Swiper('.swiper-container', {
        autoplay: 3000,//可选选项，自动滑动
        autoplayDisableOnInteraction : false
    })
    $(".join-this-shopping-cat").on("click", function () {
        if ('${sessionScope.mUser.id}' != "") {
            $("#open-bottom-model").modal('open');
        } else {//没有登录，去登录
            window.location.href = "${ctx}/m/loginPage";
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
            if (inputNumberVal >= 99) { //最高购买数不能大于你200
                inputNumberVal = 99;
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
        } else if (inputNumberVal >= 99) {
            inputNumberVal = 99
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
        $("article p img").attr("style", "");//设置商品描图片
    })
    //立即购买
    function buyNow() {
        if ('${sessionScope.mUser.id}' != "") {//立即购买页面
            window.location.href = '${ctx}/m/orderPage?nowBuy=yes&commodityId=${commodity.id}&userId=${sessionScope.mUser.id}';
        } else {//没有登录，去登录
            window.location.href = "${ctx}/m/loginPage";
        }

    }
</script>
</body>
</html>
