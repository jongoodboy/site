package com.thinkgem.jeesite.mother.m.weixin.utlis;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.thinkgem.jeesite.mother.m.weixin.ConfigUtil;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.lang.reflect.Type;
import java.util.Date;
import java.util.Map;

/**
 * Created by Jason on 2016/8/2.
 */
public class TokenTicket {
    private static long _AccessTokenlastUpdateTime = 0;
    private static String _accessToken = null;

    private static long _JsApiTicketlastUpdateTime = 0;
    private static String _jsApiTicket = null;    private final static long _intervalTimes = 5400*1000; // 间隔多长时间获取一次token、ticket


    /**
     * 获取接口访问凭证
     *
     * @return
     */
    public static String getAccessToken() {
        long curTime =  new Date().getTime();
        if(_accessToken==null || _accessToken=="" || curTime - _AccessTokenlastUpdateTime >= _intervalTimes) {
            //凭证获取(GET)
            String token_url = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=APPID&secret=APPSECRET";
            String requestUrl = token_url.replace("APPID", ConfigUtil.APPID).replace("APPSECRET", ConfigUtil.APP_SECRECT);
            // 发起GET请求获取凭证
            Map<String, String> jsonMap = httpsRequest(requestUrl);
            if (null != jsonMap) {
                try {
                    _accessToken = jsonMap.get("access_token");
                    _AccessTokenlastUpdateTime = curTime;
                } catch (Exception e) {
                    // 获取token失败
                }
            }
        }
        return _accessToken;
    }

    /**
     * 调用微信JS接口的临时票据
     *
     * @return
     */
    public static String getJsApiTicket() {
        long curTime =  new Date().getTime();
        if(_jsApiTicket==null || _jsApiTicket=="" || curTime -  _JsApiTicketlastUpdateTime >= _intervalTimes) {
            String url = "https://api.weixin.qq.com/cgi-bin/ticket/getticket?access_token=ACCESS_TOKEN&type=jsapi";
            String requestUrl = url.replace("ACCESS_TOKEN", getAccessToken());
            // 发起GET请求获取凭证
            Map<String, String> jsonMap = httpsRequest(requestUrl);
            if (null != jsonMap) {
                try {
                    _jsApiTicket = jsonMap.get("ticket");
                    _JsApiTicketlastUpdateTime = curTime;
                } catch (Exception e) {
                    // 获取token失败
                }
            }
        }
        return _jsApiTicket;
    }

    // 获取token
    public static Map<String, String> httpsRequest(String apiurl)
    {
        try
        {
            // 创建HttpClient实例
            HttpClient httpclient = new DefaultHttpClient();
            // 创建Get方法实例
            HttpGet httpgets = new HttpGet(apiurl);
            HttpResponse response = httpclient.execute(httpgets);
            HttpEntity entity = response.getEntity();
            if (entity != null) {
                InputStream instreams = entity.getContent();
                String str = convertStreamToString(instreams);
                httpgets.abort();

                Gson gson = new Gson();
                Type type = new TypeToken<Map<String, String>>(){}.getType();
                Map<String, String> map = gson.fromJson(str, type);
                return map;
            }
        }
        catch (Exception e)
        {
        }
        return null;
    }

    public static String convertStreamToString(InputStream is) {
        BufferedReader reader = new BufferedReader(new InputStreamReader(is));
        StringBuilder sb = new StringBuilder();

        String line = null;
        try {
            while ((line = reader.readLine()) != null) {
                sb.append(line + "\n");
            }
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                is.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return sb.toString();
    }

}
