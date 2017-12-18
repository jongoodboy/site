package com.thinkgem.jeesite.mother.m.express;

import org.activiti.engine.impl.util.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by wangJH on 2017/12/18.
 */
@Controller
@RequestMapping(value = "${frontPath}/expressInfo")
public class ExpressIndex {
    public static final String appcode = "7b3a31c487d84743bafb083fc08dbaa1";//阿里云物流的AppCode
    public static final String URL = "http://jisukdcx.market.alicloudapi.com/express/query";//请求地址
    /**
     * 物流信息
     *
     * @param model
     * @param number 物流号
     * @return
     */
    @RequestMapping
    public String findExpress(Model model, String number) {
        String type = "auto";//物流公司默认auto自动识别
        String url = URL + "?number=" + number + "&type=" + type;
        try {
            String result = HttpUtil.sendGet(url, "utf-8", appcode);
            JSONObject jb = new JSONObject(result);
            model.addAttribute("data",jb);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "mqds/m/expressInfo";
    }
}
