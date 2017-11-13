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
        padding: 10px 0;
        background: #f9f9f9;
    }

    .add-address-div .am-btn-danger {
        width: 80%;
        margin: auto;
        display: block;
    }

    .am-list h5 {
        margin: 0;
        color: #333;
    }

    .am-divider-default {
        border-top: 1px solid #fdf6f6;
        margin: 0;
        margin: 5px 0;
    }
    .am-ucheck-icons{
        top:3px;
    }
    .am-list-static.am-list-border>li{
        padding-bottom: 0;
    }
    .operation{
        position: absolute;
        right: 10px;
        bottom: 0;
    }
    .operation a{
        margin-left: 10px;
    }
    .bottom-model>.model-title li{
        line-height: 50px;
        border-bottom: 1px solid #eee;
    }
    .bottom-model>.model-title li input{
        height: 50px;
        width: 80%;
        border: none;
        text-align: right;
        overflow: hidden;
        white-space: nowrap;
    }
    .bottom-model>.model-title li input:focus{
        outline: none;
    }

    .bottom-model>.model-title li span{
        height: 50px;
        width: 20%;
        display: inline-block;
        float: left;
    }
</style>
<body>
<div class="content">
    <ul class="am-list am-list-static am-list-border">
        <li>
            <h5>持卡人:蛮吉</h5>
            <span>卡号:693629*****69633</span>
            <hr data-am-widget="divider" style="" class="am-divider am-divider-default"/>
            <div class="operation">
                <a class="update-address">编辑</a>
                <a class="del-address">删除</a>
            </div>
        </li>
        <li>
            <h5>持卡人:蛮小满</h5>
            <span>卡号:693629*****69633</span>
            <hr data-am-widget="divider" style="" class="am-divider am-divider-default"/>
            <div class="operation">
                <a class="update-address">编辑</a>
                <a class="del-address">删除</a>
            </div>
        </li>
    </ul>
    <div class="add-address-div">
        <button type="button" class="am-btn am-btn-danger">+添加卡号</button>
    </div>
</div>
<!--底部弹出新增地址-->
<div class="am-modal-actions" id="open-bottom-model">
    <div class="bottom-model">
        <ul class="am-list model-title">
            <span class="close-model">x</span>
            <li class="am-g am-list-item-dated">
                <span>开户银行</span>
                <input name="consignee" placeholder="请输入持卡人姓名">
            </li>
            <li class="am-g am-list-item-dated">
                <span>银行卡号</span>
                <input  name="bankCard" max="19" placeholder="请输入您的银行卡号">
            </li>
            <li class="am-g am-list-item-dated">
                <span>持卡人</span>
                <input name="consignee" placeholder="请输入持卡人姓名">
            </li>
           <%-- <li class="am-g am-list-item-dated">
                <span>身份证号</span>
                <input  name="IDCard" max="19" placeholder="请输入您的身份证号">
            </li>
            <li class="am-g am-list-item-dated">
                <span>手机号</span>
                <input  name="phone" max="11" placeholder="请输入您的手机号">
            </li>--%>
        </ul>
        <button type="button" class="am-btn am-btn-danger">确定</button>
    </div>
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
    $(".am-btn-danger,.update-address").on("click", function () {
        $("#open-bottom-model").modal('open');
    })
    $(".close-model").on("click", function () {
        $("#open-bottom-model").modal('close');
    })
    $(".del-address").on("click",function () {
        $('#confirm').modal({
            relatedTarget: this,
            onConfirm: function(options) {
                /* var $link = $(this.relatedTarget).prev('a');
                 var msg = $link.length ? '你要删除的链接 ID 为 ' + $link.data('id') :
                 '确定了，但不知道要整哪样';
                 alert(msg);*/
            },
            // closeOnConfirm: false,
            onCancel: function() {
                alert('算求，不弄了');
            }
        });
    })
</script>
</body>
</html>
