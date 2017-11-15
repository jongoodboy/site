<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="description" content="">
<meta name="keywords" content="">
<meta name="viewport"
      content="width=device-width, initial-scale=1">
<title>母亲云商城</title>
<!-- Set render engine for 360 browser -->
<meta name="renderer" content="webkit">
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0;" name="viewport"/>
<!-- No Baidu Siteapp-->
<meta http-equiv="Cache-Control" content="no-siteapp"/>
<!-- Add to homescreen for Chrome on Android -->
<meta name="mobile-web-app-capable" content="yes">
<!-- Add to homescreen for Safari on iOS -->
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="apple-mobile-web-app-title" content="Amaze UI"/>
<!-- Tile icon for Win8 (144x144 + tile color) -->
<meta name="msapplication-TileColor" content="#0e90d2">
<script src="${ctxStatic}/jquery/jquery-1.8.3.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/m/amaze/js/amazeui.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/m/amaze/js/jquery.lazyload.min.js" type="text/javascript"></script>
<script src="http://res.wx.qq.com/open/js/jweixin-1.2.0.js"></script>
<link href="${ctxStatic}/m/amaze/css/amazeui.min.css" rel="stylesheet"/>
<link href="${ctxStatic}/m/amaze/css/app.css?${version}" rel="stylesheet"/>
<style>
    #loading {
        z-index: 1111;
    }
</style>
<script>
    $(document).ready(function () {
                $("img.lazy").lazyload();//图片懒加载
                $('.am-slider-manual').flexslider({//手动轮播图片之后,启动自动轮播
                    slideshowSpeed: 2000,
                    animationSpeed: 700,
                    directionNav: false,
                    slideshow: false,
                    before: function (slider) {
                        if (slider._pausedTimer) {
                            window.clearTimeout(slider._pausedTimer);
                            slider._pausedTimer = null;
                        }
                    },
                    after: function (slider) {
                        var pauseTime = slider.vars.playAfterPaused;
                        if (pauseTime && !isNaN(pauseTime) && !slider.playing) {
                            if (!slider.manualPause && !slider.manualPlay && !slider.stopped) {
                                slider._pausedTimer = window.setTimeout(function () {
                                    slider.play();
                                }, pauseTime);
                            }
                        }
                    }
                    // 设置其他参数
                });
            }
    )
    //打开消息提示
    function loadingShow(msg, closeTime, icon) {
        $("#loading").modal('open');
        if (msg != undefined && msg != '') {
            $(".loading-titel").html(msg);
        }
        if (closeTime == undefined) {
            closeTime = 1000;
        }
        if(msg != undefined){
            setTimeout(loadingClose, closeTime)
        }
    }
    //关闭信息提示
    function loadingClose() {
        $("#loading").modal('close')
    }
    //微信分享
    wx.config({
        debug: true, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
        appId: '${appid}', // 必填，公众号的唯一标识
        timestamp: '${timestamp}', // 必填，生成签名的时间戳
        nonceStr: '${nonceStr}', // 必填，生成签名的随机串
        signature: '${paySign}',// 必填，签名，见附录1
        jsApiList: ["onMenuShareTimeline","onMenuShareAppMessage"] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
    });
    wx.ready(function(){
        // config信息验证后会执行ready方法，所有接口调用都必须在config接口获得结果之后，config是一个客户端的异步操作，所以如果需要在页面加载时就调用相关接口，则须把相关接口放在ready函数中调用来确保正确执行。对于用户触发时才调用的接口，则可以直接调用，不需要放在ready函数中。
        wx.onMenuShareTimeline({
            title: '测试的', // 分享标题
            link: 'www.muqinonline.com/${ctx}/m', // 分享链接，该链接域名或路径必须与当前页面对应的公众号JS安全域名一致
            imgUrl: '', // 分享图标
            success: function () {
                // 用户确认分享后执行的回调函数
                alert("分享成功");
            },
            cancel: function () {
                // 用户取消分享后执行的回调函数
            }
        });
    });
</script>
<!-- loading-->
<div class="am-modal am-modal-loading am-modal-no-btn" tabindex="-1" id="loading">
    <div class="am-modal-dialog">
        <div class="am-modal-hd loading-titel">
            <span class="am-icon-spinner am-icon-spin"></span>
            数据加载中....
        </div>
    </div>
</div>

