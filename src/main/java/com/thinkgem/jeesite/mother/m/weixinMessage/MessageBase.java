package com.thinkgem.jeesite.mother.m.weixinMessage;

import com.thinkgem.jeesite.mother.m.weixin.ConfigUtil;
import org.activiti.engine.impl.util.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.net.ssl.HttpsURLConnection;
import javax.servlet.http.HttpServletRequest;
import java.io.*;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;

/**
 * Created by wangJH on 2017/12/15.
 * 微信客服
 */
@Controller
@RequestMapping(value = "${frontPath}/weixinMsg")
public class MessageBase {
    /**
     * 向指定 URL 发送POST方法的请求
     *
     * @param url   发送请求的 URL
     * @param param 请求参数，请求参数应该是 name1=value1&name2=value2 的形式。
     * @return 所代表远程资源的响应结果
     */
    public static String sendPost(String url, String param) {
        PrintWriter out = null;
        BufferedReader in = null;
        String result = "";
        try {
            URL realUrl = new URL(url);
            // 打开和URL之间的连接
            URLConnection conn = realUrl.openConnection();
            //设置通用的请求属性
            conn.setRequestProperty("user-agent", "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:21.0) Gecko/20100101 Firefox/21.0)");
            // 发送POST请求必须设置如下两行
            conn.setDoOutput(true);
            conn.setDoInput(true);
            // 获取URLConnection对象对应的输出流
            OutputStreamWriter outWriter = new OutputStreamWriter(conn.getOutputStream(), "utf-8");
            out = new PrintWriter(outWriter);
            // 发送请求参数
            out.print(param);
            // flush输出流的缓冲
            out.flush();
            // 定义BufferedReader输入流来读取URL的响应
            in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String line;
            while ((line = in.readLine()) != null) {
                in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
                result += line;
            }
        } catch (Exception e) {
            System.out.println("发送 POST 请求出现异常！" + e);
            e.printStackTrace();
        }
        //使用finally块来关闭输出流、输入流
        finally {
            try {
                if (out != null) {
                    out.close();
                }
                if (in != null) {
                    in.close();
                }
            } catch (IOException ex) {
                ex.printStackTrace();
            }
        }
        return result;
    }

    /**
     * 普通文本消息，需用户在48h与公共帐号有互动
     * 微信公共账号发送给账号
     *
     * @param content        文本内容
     * @param toUser(OPENID) 微信用户
     * @return
     */
    @RequestMapping("/testMsg")
    @ResponseBody
    public String sendTextMessageToUser(String content, String toUser) {
        //String json = "{\"touser\": \"" + toUser + "\",\"msgtype\": \"text\", \"text\": {\"content\": \"" + content + "\"}}";


        //发送模版消息给指定用户
       // String action = "https://api.weixin.qq.com/cgi-bin/message/custom/send?access_token=" + accessToken;
        String json = "{\"kf_account\":\"kf2002@gh_8072d491de1f\",\"openid\": \""+toUser+"\"}}";

        //获取access_token
        String accessToken = getAccessToken();

        //发送模版消息给指定用户开会话
        String action = "https://api.weixin.qq.com/customservice/kfsession/create?access_token=" + accessToken;

        System.out.println("json:" + json);
        try {
            String result = sendPost(action, json);
            System.out.println(result);
            return result;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    //获取access_token
    public static String getAccessToken() {
        String getAccessTokenSrc = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=" + ConfigUtil.APPID + "&secret=" + ConfigUtil.APP_SECRECT;
        String retAccessToken = null;
        try {
            URL getaccessToken = new URL(getAccessTokenSrc);
            HttpsURLConnection httpsConn1 = (HttpsURLConnection) getaccessToken.openConnection();//获取微信个人头像的昵称
            BufferedReader reader1 = new BufferedReader(new InputStreamReader(httpsConn1.getInputStream(), "utf-8"));//设置编码,否则中文乱码
            String lines1;
            while ((lines1 = reader1.readLine()) != null) {
                JSONObject jb = new JSONObject(lines1);
                System.out.print(lines1 + "==============================");
                retAccessToken = jb.getString("access_token");
            }
            reader1.close();
            httpsConn1.disconnect();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return retAccessToken;
    }
}
