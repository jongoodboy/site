<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="include/taglib.jsp" %>
<html>
<!--绑定银行卡-->
<head>
    <%@include file="include/head.jsp" %>
</head>
<style>
    .add-address-div {
        position: fixed;
        bottom: 0;
        width: 100%;
        background: #f9f9f9;
        height: 50px;
    }

    .add-address-div .am-btn-danger {
        width: 100%;
        height: 100%;
        display: block;
    }

    .am-list h5 {
        margin: 0;
        color: #333;
    }

    .card-div {
        padding: 65px 10px;
        color: #fff;
        font-size: 20px;
    }

    .card-div span {
        display: block;
        width: 100%;
        text-align: left;
        padding-left: 10px;
    }

    .am-divider-default {
        border-top: 1px solid #fdf6f6;
        margin: 0;
        margin: 5px 0;
    }

    #loading .am-modal-dialog {
        position: absolute;
        top: 20%;
        right: 25%;
        width: 50%;
    }

    .am-list-border {
        margin-bottom: 52px;
    }

    .am-list-static.am-list-border > li {
        padding: 0;
        margin: 0;
    }

    .bottom-model > .model-title li {
        line-height: 50px;
        border-bottom: 1px solid #eee;
    }

    .bottom-model > .model-title li input {
        height: 50px;
        width: 80%;
        border: none;
        text-align: right;
        overflow: hidden;
        white-space: nowrap;
    }

    .bottom-model > .model-title li input:focus {
        outline: none;
    }

    .bottom-model > .model-title li span {
        height: 50px;
        width: 20%;
        display: inline-block;
        float: left;
    }

    form {
        margin: 0;
    }

    .del-bank {
        display: inline-block;
        position: absolute;
        color: #a5a4a4;
        bottom: 10px;
        right: 15px;
        width: auto !important;
        font-size: 15px;
    }

    .select-bank, .select-bank-find {
        display: inline-block;
        position: absolute;
        color: #dd514c;
        top: 5px;
        width: auto !important;
        font-size: 20px;
        font-weight: bold;
    }

    .select-bank-find {
        top: 10px;
        color: #a5a4a4;
        font-size: 15px;
    }
</style>
<body>
<div class="content">
    <ul class="am-list am-list-static am-list-border">
        <c:set var="banklist" value="${bankList}"></c:set>
        <c:forEach var="bank" items="${banklist}" varStatus="status">
            <li>
                <c:set var="cradLenght" value="${fn:length(bank.cardNumber)}"></c:set><!-- 银行卡的长度-->
                <div class="card-div <c:if test="${status.index%2==0}">bank-2</c:if><c:if test="${status.index%2!=0}">bank-1</c:if>">
                    <span>${bank.bankName}</span>
                    <span style="font-size: 14px">${bank.cardType}</span>
                    <span>****&nbsp;&nbsp;&nbsp;&nbsp;
                        ****&nbsp;&nbsp;&nbsp;&nbsp;
                        ****&nbsp;&nbsp;&nbsp;&nbsp;
                            ${fn:substring(bank.cardNumber,cradLenght-4,cradLenght )}</span>
                    <c:if test="${param.bankId == bank.id}"><!--从提现过来。显示已经选中-->
                    <span class="select-bank">已选中</span>
                    </c:if>
                    <c:if test="${param.bankId != null && param.bankId != bank.id}"><!--从提现过来。显示已经选中-->
                    <span class="select-bank-find" id="${bank.id}">选择</span>
                    </c:if>
                    <span class="del-bank" id="${bank.id}">删除 </span>
                </div>
            </li>
        </c:forEach>
    </ul>
    <div class="add-address-div">
        <button type="button" class="am-btn am-btn-danger">+添加卡号</button>
    </div>
</div>
<!--底部弹出添加银行卡-->
<div class="am-modal-actions" id="open-bottom-model">
    <form id="bankCard">
        <div class="bottom-model">
            <ul class="am-list model-title">
                <%--  <li class="am-g am-list-item-dated">
                      <span>开户银行</span>
                      <input name="consignee" placeholder="请输入持卡人姓名">
                  </li>--%>
                <li class="am-g am-list-item-dated">
                    <span>银行卡号</span>
                    <input name="cardNumber" type="number" oninput="if(value.length>19)value=value.slice(0,19)"
                           placeholder="请输入银行卡号">
                </li>
                <li class="am-g am-list-item-dated">
                    <span>持卡人</span>
                    <input name="cardName" maxlength="5" placeholder="请输入持卡人姓名">
                </li>
                <li class="am-g am-list-item-dated">
                    <span>身份证号</span>
                    <input name="idCard" type="number" oninput="if(value.length>18)value=value.slice(0,18)"
                           placeholder="请输入持卡人身份证号">
                </li>
                <li class="am-g am-list-item-dated">
                    <span>手机号</span>
                    <input name="stayBankPhone" type="number" oninput="if(value.length>11)value=value.slice(0,11)"
                           max="11"
                           placeholder="请输入银行预留手机号">
                </li>
            </ul>
            <button type="button" class="am-btn am-btn-danger" onclick="saveBindBank()">确定</button>
            <button type="reset" id="reset" hidden></button>
        </div>
    </form>
</div>
<!-- 删除银行卡-->
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
    $(".am-btn-danger,.update-address").on("click", function () {
        $("#open-bottom-model").modal('open');
    })
    //绑定银行卡
    var isSubmit = false;
    function saveBindBank() {
        if (isSubmit) {//防止重复点击
            return;
        }
        var cardNumber = $("input[name='cardNumber']").val();//银行卡号
        var cardName = $("input[name='cardName']").val();//持卡人姓名
        var idCard = $("input[name='idCard']").val();//身份证号
        var stayBankPhone = $("input[name='stayBankPhone']").val();//银行预留手机号
        if (cardNumber.length != 19 && cardNumber.length != 16) {
            loadingShow("请输入正确的卡号");
            return;
        }
        if (cardName == "") {
            loadingShow("请输入持卡人姓名");
            return;
        }

        if (idCard == "" || idCard.length < 16) {
            loadingShow("请输入有效的身份证");
            return;
        }
        if (stayBankPhone == "") {
            loadingShow("请输入预留手机号");
            return;
        }
        if (!(/^1[3|4|5|8][0-9]\d{4,8}$/.test(stayBankPhone))) {
            loadingShow("请输入正确的手机号");
            return;
        }
        isSubmit = true;
        var ValidDATA = {//验证银行卡是否有效
            acctName: cardName,
            acctPan: cardNumber,
            certId: idCard,
            phoneNum: stayBankPhone
        }
        //验证银行卡是否有效
        $.post("${ctx}/bindVaildCard", ValidDATA, function (ret) {
            var data = JSON.parse(ret.data);
            if (data.showapi_res_body.code == "0") {//如果验证成功
                //保存银行卡信息
                var BankDATA = {
                    cardNumber: cardNumber,
                    cardName: cardName,
                    idCard: idCard,
                    stayBankPhone: stayBankPhone,
                    bankAddress: data.showapi_res_body.belong.area,//开户行地址
                    bankName: data.showapi_res_body.belong.bankName,//所属银行
                    cardType: data.showapi_res_body.belong.cardType,//银行卡类型 如借记卡，储蓄卡
                    userId: '${param.userId}'//用户Id
                }
                //保存银行卡信息
                $.post("${ctx}/m/saveBankCard", BankDATA, function (ret) {
                    isSubmit = false;
                    loadingShow(ret.msg, 3000);
                    if (ret.code == "0") {
                        $("#reset").click();//清空表单
                        $("#open-bottom-model").modal('close');//关闭弹出框
                        if ('${param.split}' != '' && ${banklist == '[]'}) {//从提现点击过来。并且没有绑定过银行卡
                            self.location = document.referrer;
                        } else {
                            window.location.href = window.location.href;//刷新
                        }
                    }

                })
            } else {//校验失败
                loadingShow("校验错误,请确保银行卡号,持卡人姓名,身份证号,银行预留手机号真实有效!", 3000);
                isSubmit = false;
            }
        })
    }
    //删除银行卡
    $(".del-bank").on("click", function () {
        $('#confirm').modal({
            relatedTarget: this,
            onConfirm: function (options) {
                $(this.relatedTarget).parent().parent().remove();
                $.post("${ctx}/m/delBank?bankId=" + $(this.relatedTarget).attr("id"), function (ret) {
                    loadingShow(ret.msg);
                    if (ret.code == "0") {
                    }
                })
            },
            onCancel: function () {

            }
        });
    })

    //选择银行
    $(".select-bank-find").on("click", function () {
        var bankId = $(this).attr("id");
        var url = document.referrer.split("split=yes");//截取防止重复
        self.location = url[0] + "&split=yes&selecBankId=" + bankId;//返回并刷新上一页面
    })

</script>
</body>
</html>
