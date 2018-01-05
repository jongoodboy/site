package com.thinkgem.jeesite.mother.m.weixin;

public class ConfigUtil {
    /**
     * 服务号相关信息
     */
//    public final static String APPID = "wx7c91b62b01094c48";//服务号的appid
//    public final static String APP_SECRECT = "6ba76ce9dd7ff4b9dec3248f62a3f64d";//服务号的appSecrect
//    public final static String TOKEN = "wjh_2017";//服务号的配置token
//    public final static String MCH_ID = "1379351502";//开通微信支付分配的商户号
//    public final static String API_KEY = "motherXx201711101027wangjihua001";//商户API密钥 自行去商户平台设置
//    public final static String SIGN_TYPE = "MD5";//签名加密方式
//    public final static String NOTIFY_URL = "http://www.muqinonline.com/front/m/payCallBack"; //用于告知微信服务器 支付成功回调
//    public final static String REDIRECT_URI = "http://www.muqinonline.com/site/weixin/getCode"; //微信获取code回调页面
    //正式库
    public final static String APPID = "wx3af84b813875ee31";//服务号的appid
    public final static String APP_SECRECT = "928d58f74a6e2f37ecd059049d8262ac";//服务号的appSecrect
    public final static String TOKEN = "wjh_2017";//服务号的配置token
    public final static String MCH_ID = "1446007402";//开通微信支付分配的商户号
    public final static String API_KEY = "motherXx201711101027wangjihua001";//商户API密钥 自行去商户平台设置
    public final static String SIGN_TYPE = "MD5";//签名加密方式
    public final static String NOTIFY_URL = "http://www.muqinyun.com/site/front/m/payCallBack"; //用于告知微信服务器 支付成功回调
    public final static String REDIRECT_URI = "http://www.muqinyun.com/site/weixin/getCode"; //微信获取code回调页面

/**
 * 微信基础接口地址
 */
    /**
     * 微信支付接口地址
     */
//微信支付统一接口(POST)
    public final static String UNIFIED_ORDER_URL = "https://api.mch.weixin.qq.com/pay/unifiedorder";
    public final static String GET_CODE = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=" + APPID + "&redirect_uri=" + REDIRECT_URI + "&response_type=code&scope=snsapi_userinfo&state=STATE&connect_redirect=1#wechat_redirect";
}