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

