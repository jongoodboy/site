<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="include/taglib.jsp" %>
<html>
<head>
    <%@include file="include/head.jsp" %>
</head>
<style>

    html {
        overflow: hidden;
    }

    body, .am-header-default {
        background: #fff;
    }

    .am-header-default .am-header-title a {
        color: #333;
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
        background: #ca6969;
        padding: 5px;
        top: 10px;
        color: #fff;
        line-height: 30px;
    }

    .am-btn-default {
        width: 70%;
        margin-left: 15%;
    }

    .am-icon-weixin {
        display: block;
        text-align: center;
        font-size: 30px;
        color: green;
        margin-top: 20px;
    }

    .version {
        display: inline-block;
        width: 100%;
        text-align: center;
        position: absolute;
        bottom: 10%;
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
            手机号<input class="am-list-item-hd" maxlength="11" id="phone">
        </li>
        <li class="am-g am-list-item-dated">
            验证码<input class="am-list-item-hd" maxlength="6" id="code">
            <span class="am-list-date">获取验证码</span>
        </li>
    </ul>
    <button type="button" class="am-btn am-btn-default am-radius" onclick="bindPhone()">绑定</button>
    <span class="am-icon-weixin"></span>
    <span class="version">母亲云电商&copy;2017</span>
</div>
</body>
<script>
    var url = '${param.url}';
    if (url == "") {
        url = window.location.href;
    }
    //绑定
    function bindPhone() {
        var phone = $("#phone").val();
        if (phone == "") {
            loadingShow("手机号不能为空");
            return;
        }
        if (!(/^1[3|4|5|8][0-9]\d{4,8}$/.test(phone))) {
            loadingShow("请输入正确的手机号");
            return;
        }
        $.post("${ctx}/m/bind?phone=" + phone, function (data) {
            if (data.code == "0") {
                window.location.href = url;
            }
        })
    }
    //获取验证码
    var index = 59;
    var code = $(".am-list-date");
    var codeBut = true;
    code.on("click", function () {
        if (codeBut) {
            alert(1);
            codeBut = false;
            countDown();
        }
    })

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