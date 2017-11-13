/**
 * Created by wangJH on 2017/1/4.
 *微信支付
 */


var weiXinPay = {
    init:function(data){
        ajaxPayConfig(data)
    }
};

//发起配置支付请求！
function closeModal(resetFlag){
    myModel.modal("hide");
    if(resetFlag === true){
        $('.money-from')[0].reset();
    }
    loadingStop();
}
function ajaxPayConfig(data){
    $.ajax({
        type: 'POST',
        url: data.url,
        dataType: 'json',
        data: data,
        cache: false,
        error: function () {
            closeModal();
            msgOpen('支付失败，请稍后重试！',3000);
            return false;
        },
        success: function (retData) {
            if (parseInt(retData[0].agent) < 5) {
                closeModal();
                msgOpen( '您的微信版本低于5.0无法使用微信支付。',3000);
                return;
            }
            //JSSDK支付所需的配置参数，首先会检查signature是否合法。
            wx.config({
                //debug: true, //开启debug模式，测试的时候会有alert提示
                appId: retData[0].appId, //公众平台中-开发者中心-appid
                timestamp: retData[0].config_timestamp, //时间戳
                nonceStr: retData[0].config_nonceStr, //随机字符串,不长于32位
                signature: retData[0].config_sign, //这里的signature是后台使用SHA1签名算法得出，不是MD5，与下面的wx.chooseWXPay中的paySign不同，下面的paySign是后台使用MD5加密得出
                jsApiList: ['chooseWXPay'] //指定哪些JS接口有权限访问
            });
            weixinReoe(retData, data);//声明支付方法进行支付
            wx.error(function(res) {
                if (res.errMsg === "config:invalid url domain") {
                    closeModal();
                    msgOpen('微信支付(测试)授权目录设置有误。',3000);
                } else {
                    closeModal();
                    msgOpen('检测出问题:'+res.errMsg,3000);
                }
            });
        }
    })
}
function weixinReoe(retData, data){
    wx.ready(function() {
        wx.chooseWXPay({
            timestamp : retData[0].timeStamp, // 支付签名时间戳。前端js中指定的timestamp字段均为小写。后台生成签名使用的timeStamp字段需大写其中的S字符，即：timeStamp
            nonceStr : retData[0].nonceStr, // 支付签名随机串，不长于 32 位
            package : "prepay_id="+retData[0].packageValue, // 统一支付接口返回的prepay_id参数值，格式：prepay_id=***）
            signType : "MD5", // 签名方式MD5，不是SHA1，后台使用MD5加密，与上面的wx.config中的signature不同。
            paySign : retData[0].paySign, // 后台生成的支付签名串

            //该complete回调函数，相当于try{}catch(){}异常捕捉中的finally，无论支付成功与否，都会执行complete回调函数。即使wx.error执行了，也会执行该回调函数.
            complete : function(res) {
                pushHistory();
                window.addEventListener("popstate",function(e){
                    closeModal();
                },false);
                function pushHistory(){
                    var state={
                        title:"title",
                        url:"#"
                    };
                    window.history.pushState(state,"title","#");
                }

                var monMater =$(".mon-mater-btn");
                if(monMater.attr("onclick") === "moneySave()"){
                    monMater.removeAttr("disabled");
                }
                /*注意：res对象的errMsg属性名称，是没有下划线的，与WeixinJSBridge支付里面的err_msg是不一样的。而且，值也是不同的。*/
                if (res.errMsg === "chooseWXPay:ok") {
                    closeModal(true);
                    window.location.href = data.sendUrl;
                    msgOpen('支付成功',3000);
                } else if (res.errMsg === "chooseWXPay:cancel") {
                    closeModal();
                    msgOpen('你手动取消支付',3000);

                } else if (res.errMsg === "chooseWXPay:fail") {
                    closeModal();
                    msgOpen('支付失败',3000);
                } else if (res.errMsg === "config:invalid signature") {
                    closeModal();
                    msgOpen( '支付签名验证错误，请检查签名正确与否 or 支付授权目录正确与否等',3000);
                }else{
                    closeModal();
                }
            },
            fail:function(res){
                closeModal();
            },
            cancel:function(res){
                closeModal();
            }
        });
    });
}

