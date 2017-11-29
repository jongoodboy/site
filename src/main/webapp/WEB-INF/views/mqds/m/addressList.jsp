<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="include/taglib.jsp" %>
<html>
<!--地址列表-->
<head>
    <%@include file="include/head.jsp" %>
    <link href="${ctxStatic}/m/address/css/LArea.css" rel="stylesheet">
    <script src="${ctxStatic}/m/address/js/LArea.js"></script>
    <script src="${ctxStatic}/m/address/js/LAreaData1.js"></script>
</head>
<style>
    .add-address-div {
        position: fixed;
        bottom: 0;
        width: 100%;
        height: 49px;
    }

    .add-address-div .am-btn-danger {
        width: 100%;
        margin: auto;
        display: block;
        height: 100%;
    }

    .am-divider-default {
        border-top: 1px solid #fdf6f6;
        margin: 0;
        margin: 5px 0;
    }

    .am-ucheck-icons {
        top: 3px;
    }

    .am-list-static.am-list-border > li {
        padding-bottom: 0;
        border-bottom: 10px solid #eee;
        line-height: 35px;
        padding-top: 8px;
    }

    .am-list-static.am-list-border > li span {
        display: inline-block;
        width: 100%;
        padding: 0 30px;
    }

    .operation {
        position: absolute;
        right: 20px;
        bottom: 3px;
    }

    .operation a {
        margin-left: 10px;
        color: #333;
        font-size: 14px;
    }

    .bottom-model > .model-title li {
        line-height: 50px;
        border-bottom: 1px solid #eee;
        font-size: 14px;
        letter-spacing: 1px;
    }

    .bottom-model > .model-title li input {
        height: 50px;
        line-height: 50px;
        width: 77%;
        border: none;
    }
    .bottom-model{
        padding: 0 12px;
    }
    #loading .am-modal-dialog {
        position: absolute;
        width: 60%;
        top: 5%;
        right: 20%;
    }

    .phone-address {
        position: absolute;
        top: 10px;
        text-align: right;
        right: -10px;
    }

    #loading {
        z-index: 1108;
    }

    form {
        margin: 0;
    }
    .bottom-model > .am-btn-danger{
        font-weight: normal;
        font-size: 16px;
        padding: 0;
    }
</style>
<body>
<div class="content">
    <c:set value="${param.isOrderPage}" var="isOrderPage"></c:set>  <!--如果是生成订单页面点过来的-->
    <c:set value="${param.addressId}" var="addressId"></c:set>  <!--如果是生成订单页面点过来的-->
    <ul class="am-list am-list-static am-list-border">
        <c:forEach var="itme" items="${list}">
            <li  <c:if test="${isOrderPage!= null}"> onclick="selectAddess('${itme.id}')" </c:if>>

                <span <c:if test="${isOrderPage!= null and addressId == itme.id}">style="color: red" </c:if>>
                        收货人:${itme.consignee}
                </span>
                <span class="phone-address"> ${itme.consigneePhone}</span>
                <span>${itme.province}${itme.city}${itme.county}${itme.address}</span>
                <hr data-am-widget="divider" style="" class="am-divider am-divider-default"/>
                <c:if test="${param.isOrderPage == null}"><!--不是生成订单页面点击过来-->
                <label class="am-radio" addressId="${itme.id}">
                    <i class="<c:if test="${itme.isDefault == '0'}">you</c:if><c:if test="${itme.isDefault != '0'}">mei</c:if>"></i>
                        <%--%-- <input type="radio" name="isDefault" value="${itme.id}" data-am-ucheck
                                <c:if test="${itme.isDefault == '0'}">checked</c:if>>&ndash;%&gt;--%>
                    设为默认地址
                </label>
                </c:if>
                <div class="operation">
                    <a class="update-address" id="${itme.id}">编辑</a>
                    <a class="del-address" id="${itme.id}">删除</a>
                </div>

            </li>
        </c:forEach>
    </ul>

    <div class="add-address-div">
        <button type="button" class="am-btn am-btn-danger">+新建地址</button>
    </div>
</div>
<!--底部弹出新增地址-->
<div class="am-modal-actions" id="open-bottom-model">
    <form id="address">
        <div class="bottom-model">
            <ul class="am-list model-title">
                <input name="id" hidden><!--id 修改时用到-->
             <%--   <span class="close-model">x</span>--%>
                <li class="am-g am-list-item-dated">
                    <span>收货人:</span><input name="consignee">
                </li>
                <li class="am-g am-list-item-dated">
                    <span>联系方式:</span>
                    <input name="consigneePhone" maxlength="11">
                </li>
                <li class="am-g am-list-item-dated">
                    <span>所在区域:</span>
                    <input id="demo1" name="location" readonly>
                </li>
                <li class="am-g am-list-item-dated">
                    <span>详细地址:</span><input name="receipAddress">
                </li>
            </ul>
            <button type="button" class="am-btn am-btn-danger" onclick="saveAddress()">确&nbsp;&nbsp;&nbsp;&nbsp;定</button>
            <button type="reset" id="reset" hidden></button>
        </div>
    </form>
</div>
<!-- 删除地址-->
<div class="am-modal am-modal-confirm" tabindex="-1" id="confirm">
    <div class="am-modal-dialog">
        <div class="am-modal-hd">温馨提示</div>
        <div class="am-modal-bd">
            你，确定要删除这条记录吗？
        </div>
        <div class="am-modal-footer">
            <span class="am-modal-btn" data-am-modal-cancel>取消</span>
            <span class="am-modal-btn" data-am-modal-confirm>确定</span>
        </div>
    </div>
</div>
<script>
    $(".update-address").on("click", function () {
        $("#reset").click();
        $.post("${ctx}/m/addressDetail?adddressId=" + $(this).attr("id"), function (ret) {
            if (ret.code == "0") {
                $("input[name='id']").val(ret.data.id);
                $("input[name='consignee']").val(ret.data.consignee);
                $("input[name='consigneePhone']").val(ret.data.consigneePhone);
                $("input[name='location']").val(ret.data.province + "," + ret.data.city + "," + ret.data.county);
                $("input[name='receipAddress']").val(ret.data.address);
                $("#open-bottom-model").modal('open');
            }
        })
    })
    $(".am-btn-danger").on("click", function () {
        $("#reset").click();
        $("#open-bottom-model").modal('open');
    })
    $(".close-model").on("click", function () {
        $("#open-bottom-model").modal('close');
    })
    $(".del-address").on("click", function () {
        $('#confirm').modal({
            relatedTarget: this,
            onConfirm: function (options) {
                $.post("${ctx}/m/delAddress?adddressId=" + $(this.relatedTarget).attr("id"), function (data) {
                    if (data.code == "0") {
                        window.location.href = window.location.href;//刷新当前页面
                    }
                })
            },
            onCancel: function () {

            }
        });
    })
    //三级联动
    var area1 = new LArea();
    area1.init({
        'trigger': '#demo1', //触发选择控件的文本框，同时选择完毕后name属性输出到该位置
        'valueTo': '#value1', //选择完毕后id属性输出到该位置
        'keys': {
            id: 'id',
            name: 'name'
        }, //绑定数据源相关字段 id对应valueTo的value属性输出 name对应trigger的value属性输出
        'type': 1, //数据源类型
        'data': LAreaData //数据源
    });
    area1.value = [6, 11, 7];//控制初始位置，注意：该方法并不会影响到input的value
    //保存收货地址
    function saveAddress() {
        var consignee = $("input[name='consignee']").val();
        var consigneePhone = $("input[name='consigneePhone']").val();
        var location = $("input[name='location']").val();
        var receipAddress = $("input[name='receipAddress']").val();

        if (consignee == "") {
            loadingShow("收货人不能为空");
            return;
        }
        if (consigneePhone == "") {
            loadingShow("联系方式不能为空");
            return;
        }
        if (!(/^1[3|4|5|8][0-9]\d{4,8}$/.test(consigneePhone))) {
            loadingShow("请输入正确的手机号");
            return;
        }
        if (location == "") {
            loadingShow("所在区域不能为空");
            return;
        }
        var locationList = location.split(",");//分割地址
        if (receipAddress == "") {
            loadingShow("详细地址不能为空");
            return;
        }
        var DATA = {
            id: $("input[name='id']").val(),
            consignee: consignee,
            consigneePhone: consigneePhone,
            address: receipAddress,
            province: locationList[0] == undefined ? "" : locationList[0],//省
            city: locationList[1] == undefined ? "" : locationList[1],//市
            county: locationList[2] == undefined ? "" : locationList[2],//区/县
            userId: '${param.userId}',//个人Id
            isDefault: "1"//是否是默认地址 默认不是 (0是,1不是)
        }
        if ('${list}' == '[]') {//如果没有添加过地址
            DATA.isDefault = "0"//设置第一个为默认地址
        }
        $.post("${ctx}/m/saveAddress", DATA, function (data) {
            if (data.code == "0") {
                $("#open-bottom-model").modal('close');
                if ('${isOrderPage}' != null && '${isOrderPage}' != undefined && '${isOrderPage}' != "") {
                    self.location = document.referrer;//返回并刷新上一页面
                } else {
                    window.location.href = window.location.href;//刷新
                }
            }
        })
    }
    //更改默认地址
    $(function () {
        $(".am-radio").click(function () {
            $.post("${ctx}/m/checkedDefault?adddressId=" + $(this).attr("addressId") + "&userId=${param.userId}", function (data) {
                if (data.code == "0") {
                    window.location.href = window.location.href;//刷新
                }
            })
        });
    });
    //选择地址
    function selectAddess(id) {
        $.post("${ctx}/m/checkedDefault?adddressId=" + id + "&userId=${param.userId}", function (data) {
            if (data.code == "0") {
                self.location = document.referrer;//返回并刷新上一页面
            }
        })
    }
</script>
</body>
</html>
