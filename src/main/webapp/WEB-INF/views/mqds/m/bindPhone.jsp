<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="include/taglib.jsp" %>
<html>
<head>
    <%@include file="include/head.jsp" %>
</head>
<style>
    body,html{
        overflow: hidden;
    }
    .am-header-default{
        background: #fff;
    }
    .am-header-default .am-header-title a {
        color: #333;
        font-size: 16px;
    }
    .am-header-default .am-header-nav > a:after {
        content: "X";
        text-align: center;
        position: absolute;
        top: -20px;
        left: 0;
        display: inline-block;
        color: #333;
    }

    .am-list {
        margin-top: 10%;
    }

    .am-list li {
        border-bottom: 1px solid #eee;
        line-height: 50px;
    }

    .content {
        padding: 10px;
    }

    .am-list-item-hd {
        border: 0;
    }

    .am-list-date {
        display: inline-block;
        padding: 5px;
        top: 5px;
        line-height: 30px;
        font-size: 1.4rem;
    }

    .am-btn-default {
        width: 80%;
        margin-left: 10%;
        line-height: 26px;
        letter-spacing: 10px;
    }
    .version {
        display: block;
        width: 100%;
        text-align: center;
        position: absolute;
        bottom: 10px;
        color: #ccc;
        font-size: 13px;
        letter-spacing: 1px;
    }
    .am-list{
        margin:10%;
    }
    .am-btn.am-radius{
        border-radius: 5px;
    }
</style>
<body>
<header data-am-widget="header"
        class="am-header am-header-default">
    <div class="am-header-left am-header-nav">
        <a href="javascript:history.back(-1)"></a>
    </div>
    <h1 class="am-header-title">
        <a href="javascript:void(0)" class="">
            绑定手机号
        </a>
    </h1>
</header>
<div class="content">
    <ul class="am-list">
        <li class="am-g am-list-item-dated">
            <i class="phone"></i>手机号<input class="am-list-item-hd" maxlength="11" id="phone" onblur="verification()">
            <span class="am-list-date">获取验证码</span>
        </li>
        <li class="am-g am-list-item-dated">
            <i class="suo"></i>验证码<input class="am-list-item-hd" maxlength="6" id="code">
        </li>
    </ul>
    <button type="button" class="am-btn am-btn-default am-radius" onclick="bindPhone()">绑定</button>
    <span class="version">母亲云电商&copy;2017</span>
</div>
</body>
<script>
    var url = '';//${param.url}
    if (url == '') {
        url = "${ctx}/m";
    }
    var phoneCode = "";//手机验证码
    //绑定
    function bindPhone() {
        var phone = $("#phone").val();
        var code = $("#code").val();
        if (phone == "") {
            loadingShow("手机号不能为空");
            return;
        }
        if (!(/^1[3|4|5|8][0-9]\d{4,8}$/.test(phone))) {
            loadingShow("请输入正确的手机号");
            return;
        }
        if (code == "") {
            loadingShow("请输入验证码");
            return;
        }
        if (code != phoneCode) {
            loadingShow("验证码不正确");
            return;
        }
        $.post("${ctx}/m/bind?phone=" + phone, function (data) {
            if (data.code == "0") {
                window.location.href = url;
            } else {
                loadingShow(ret.msg);
            }
        })
    }
    //获取验证码
    var index = 59;
    var code = $(".am-list-date");
    var codeBut = true;
    code.on("click", function () {
        var phone = $("#phone").val();
        if (phone == "") {
            loadingShow("手机号不能为空");
            return;
        }
        if (!(/^1[3|4|5|8][0-9]\d{4,8}$/.test(phone))) {
            loadingShow("请输入正确的手机号");
            return;
        }
        if (codeBut) {
            codeBut = false;
            $.post("${ctx}/m/verification?phone=" + phone, function (ret) {//验证手机是否已经被绑定过
                if (ret.code == "1") {//号码没有绑定过。
                    countDown();
                    $.post("${ctx}/getPhoneCode?phone=" + phone, function (ret) {
                        var data = JSON.parse(ret.data);
                        phoneCode = data.obj;//短信验证码
                    })
                } else {
                    loadingShow(ret.msg);
                }
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
</html>
