package com.thinkgem.jeesite.mother.m.weixin.servlet;


import com.thinkgem.jeesite.mother.m.weixin.ConfigUtil;
import com.thinkgem.jeesite.mother.m.weixin.utlis.SHA1;

import javax.servlet.*;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

/**
 * Created by Jason on 2016/8/1.
 */
public class Handler extends HttpServlet {

    @Override
    public void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        resp.setContentType("text/html");
        resp.setCharacterEncoding("utf-8");

        PrintWriter out = resp.getWriter();
        String token = ConfigUtil.TOKEN;
        //验证URL真实性
        String signature = req.getParameter("signature");// 微信加密签名
        String timestamp = req.getParameter("timestamp");// 时间戳
        String nonce = req.getParameter("nonce");// 随机数
        String echostr = req.getParameter("echostr");//随机字符串

        if (signature == null || timestamp == null || nonce == null) {
            out.write("参数不正确+signature" + signature + "===timestamp===" + timestamp + "===nonce===" + nonce);
            System.out.println("--参数不正确");
        } else {
            List<String> params = new ArrayList<String>();
            params.add(token);
            params.add(timestamp);
            params.add(nonce);
            //1. 将token、timestamp、nonce三个参数进行字典序排序
            Collections.sort(params, new Comparator<String>() {
                public int compare(String o1, String o2) {
                    return o1.compareTo(o2);
                }
            });
            //2. 将三个参数字符串拼接成一个字符串进行sha1加密
            String localSignature = SHA1.encode(params.get(0) + params.get(1) + params.get(2));
            if (localSignature.equals(signature)) {
                System.out.println("--bingo" + echostr);
                out.write(echostr);
            } else {
                out.write("签名不正确");
                System.out.println("--签名不正确");
            }
        }
        out.flush();
        out.close();
    }

}
