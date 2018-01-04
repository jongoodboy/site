<%@ taglib prefix="s" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="include/taglib.jsp" %>
<html>
<!--提现页面-->
<head>
    <%@include file="include/head.jsp" %>
</head>
<style>
    .personal-list {
        list-style: none;
        padding: 0 5px;
        margin: 0;
        font-size: 14px;
        margin-top: -25px;
    }

    .personal-list li {
        border-bottom: 1px solid #eee;
        line-height: 60px;
        position: relative;
    }

    .am-list-border ul li a {
        color: #333;
    }

    .personal-list a {
        width: 100%;
        display: inline-block;
    }

    .personal-list input.money-input {
        border: none;
        padding: 10px 5px;
        line-height: 60px;
        font-size: 20px;
        width: 60%;
        display: inline-block;
    }

    .personal-list li:last-child {
        border-bottom: 10px solid #eee;
    }

    .span-money {
        font-size: 30px;
        margin-top: 10px;
        display: inline-block;
        float: left;
    }

    .all-money {
        color: #0e90d2;
        display: inline-block;
        float: right;
        margin-top: 10px;
    }

    li p {
        margin: 0;
    }

    .am-btn-danger {
        width: 100%;
        height: 100%;
    }

    body {
        height: 100%;
    }

    .quick {
        padding: 0 10px;
    }

    .phone-code span {
        display: inline-block;
        width: 100%;
    }

    li.phone-code {
        line-height: 30px;
        position: relative;
        text-align: center;
        padding: 10px 0px;
    }

    li.phone-code input {
        width: 80px;
        border: 0;
        text-align: center;
    }

    span.get-phone-code {
        width: 100px;
        position: absolute;
        right: 0;
        color: #0e90d2;
        text-align: right;
    }
</style>
<body>
<div class="content">
    <ul class="am-list am-list-static am-list-border">
        <form id="cashWithDrawal">
            <input name="bankNumber" value="${bank.cardNumber}" hidden><!-- 银行卡号 -->
            <input name="bankAddress" value="${bank.bankAddress}" hidden><!-- 银行开户行 -->
            <input name="bankNumberName" value="${bank.cardName}" hidden><!-- 银行卡号对应的姓名 -->
            <input name="bankName" value="${bank.bankName}" hidden><!-- 所属银行 -->
            <input name="userId" value="${param.userId}" hidden><!-- 提现者的ID -->
            <input name="balance" hidden><!--账户余额-->
            <li style="padding: 0 1px">
                <ul class="personal-list">
                    <li>
                        <c:set var="cradLenght" value="${fn:length(bank.cardNumber)}"></c:set><!-- 银行卡的长度-->
                        <a href="${ctx}/m/bindBankCard?userId=${param.userId}&bankId=${bank.id}&split=yes">
                            <c:if test="${bank != null}">
                                 <span>${bank.bankName}<span
                                         class="quick">(${fn:substring(bank.cardNumber,cradLenght-4,cradLenght )})</span>快捷</span>
                            </c:if>
                            <c:if test="${bank == null}">
                                <span>请先绑定银行卡</span>
                            </c:if>
                        </a>
                        <i></i>
                    </li>
                    <li>
                        <span class="span-money">￥</span>
                        <input type="number" class="money-input" name="getCash"
                               oninput="if(value.length>5)value=value.slice(0,5)"
                               placeholder="可提现到卡${param.withdrawalsMoney}元"/>
                        <span class="all-money">全部提现</span>
                    </li>
                    <li class="phone-code">
                        <span>为了本次交易安全请输入验证码</span>
                        <span>${fn:substring(sessionScope.mUser.phone,0,3 )}****${fn:substring(sessionScope.mUser.phone,7,11 )}</span>
                        <input type="number" id="phoneCode" oninput="if(value.length>6)value=value.slice(0,6)"
                               placeholder="验证码"/>
                        <span class="get-phone-code">获取验证码</span>
                    </li>
                </ul>
            </li>

            <li style="padding-top: 0">
                <p>1.提现时间:每月1号到10号;</p>
                <p>2.到账时间:今日提现次日到账;</p>
            </li>
        </form>
    </ul>
</div>
<div class="to-settle-accounts">
    <button type="button" class="am-btn am-btn-danger" onclick="confirmation()">确认提现</button>
</div>
<script>
    $("title").html("提现到银行卡");
    var index = 59;
    var code = $(".get-phone-code");
    var codeBut = true;
    var mUserphone = '${sessionScope.mUser.phone}';//用户手机号
    var phoneCode = "";//手机验证码
    var withdrawalsMoney = '${param.withdrawalsMoney}';//账户金额
    //确认提现
    function confirmation() {
        var getCash = $("input[name='getCash']").val();
        if (getCash == "") {
            loadingShow("请输入提现金额,且提现金额必须是有效数字", 2000);
            return;
        }
        var code = $("#phoneCode").val();
        if (code != phoneCode) {
            loadingShow("验证码不正确");
            return;
        }
        $("input[name='balance']").val(parseFloat(withdrawalsMoney - getCash).toFixed(2));//设置账户余额
        $.post("${ctx}/m/withdrawals", $("#cashWithDrawal").serialize(), function (ret) {
            loadingShow(ret.msg);
            if (ret.code == "0") {
                self.location = '${ctx}/m/personalCenter';//返回个人中心
            }
        })
    }
    //输入提现金额
    $("input[name='getCash']").on("keyup", function () {
        var getCash = $(this);
        if (getCash.val() > parseFloat(withdrawalsMoney)) {
            getCash.val(withdrawalsMoney);
        }
    })
    //全部提现
    $(".all-money").on("click", function () {
        $("input[name='getCash']").val(withdrawalsMoney);
    })
    //获取验证码
    code.on("click", function () {
        if (codeBut) {
            codeBut = false;
            countDown();
            $.post("${ctx}/getPhoneCode?phone=" + mUserphone, function (ret) {
                var data = JSON.parse(ret.data);
                phoneCode = data.obj;//短信验证码
            })
        }
    })
    //多少秒之后可以再获取验证码
    function countDown() {
        code.html(index + "s后再获取");
        index--;
        if (index < 0) {
            code.html("获取验证码");
            index = 59;
            codeBut = true;
            return;
        }
        setTimeout(countDown, "1000");
    }
</script>
</body>
</html>
