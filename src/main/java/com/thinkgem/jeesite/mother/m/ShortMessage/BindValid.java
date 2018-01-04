package com.thinkgem.jeesite.mother.m.ShortMessage;

import org.apache.http.HttpResponse;
import org.apache.http.util.EntityUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.*;

/**
 * Created by wangJH on 2018/1/2.
 * 银行卡验证
 */
@Controller
@RequestMapping(value = "${frontPath}/bindVaildCard")
public class BindValid {
    private static final String host = "https://ali-bankcard4.showapi.com";
    private static final String path = "/bank4";
    private static final String method = "GET";
    private static final String appcode = "7b3a31c487d84743bafb083fc08dbaa1";//购买的接口code

    @RequestMapping
    @ResponseBody
    public Map<String, Object> bindVaildCard(String acctName, String acctPan, String certId, String phoneNum) {
        Map<String, Object> retMap = new HashMap<String, Object>();
        Map<String, String> headers = new HashMap<String, String>();
        //最后在header中的格式(中间是英文空格)为Authorization:APPCODE 83359fd73fe94948385f570e3c139105
        headers.put("Authorization", "APPCODE " + appcode);
        Map<String, String> querys = new HashMap<String, String>();
        querys.put("acct_name", acctName);//持卡人姓名
        querys.put("acct_pan", acctPan);//卡号
        querys.put("cert_id", certId);//身份证号
        querys.put("cert_type", "01");//01表示身份证。目前只支持身份证
        querys.put("needBelongArea", "true");//是否返回详细信息
        querys.put("phone_num", phoneNum);//银行预留手机号
        try {
            /**
             * 重要提示如下:
             * HttpUtils请从
             * https://github.com/aliyun/api-gateway-demo-sign-java/blob/master/src/main/java/com/aliyun/api/gateway/demo/util/HttpUtils.java
             * 下载
             *
             * 相应的依赖请参照
             * https://github.com/aliyun/api-gateway-demo-sign-java/blob/master/pom.xml
             */
            HttpResponse response = HttpUtils.doGet(host, path, method, headers, querys);
            retMap.put("data", EntityUtils.toString(response.getEntity(), "utf-8"));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return retMap;
    }
}
