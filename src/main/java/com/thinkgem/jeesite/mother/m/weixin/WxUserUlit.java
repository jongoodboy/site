package com.thinkgem.jeesite.mother.m.weixin;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.mother.admin.entity.Commodity;
import com.thinkgem.jeesite.mother.admin.service.CommodityService;
import com.thinkgem.jeesite.mother.m.entity.Muser;
import com.thinkgem.jeesite.mother.m.service.MuserService;
import org.activiti.engine.impl.util.json.JSONObject;
import org.apache.commons.collections.map.HashedMap;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.net.ssl.HttpsURLConnection;
import javax.servlet.http.HttpServletRequest;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.Map;

/**
 * Created by wangJH on 2017/11/10.
 */
@Controller
@RequestMapping(value = "weixin")
public class WxUserUlit {
    //商品
    @Resource
    private CommodityService commodityService;
    @RequestMapping("/getCode")
    public String accessToken(String code, HttpServletRequest request, Model model) {
        String openId = (String) request.getSession().getAttribute("openid");//用户OpenId
        String src = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=";
        if (openId == null) {
            src += ConfigUtil.APPID + "&secret=" + ConfigUtil.APP_SECRECT + "&code=" + code + "&grant_type=authorization_code";
            try {
                URL url = new URL(src);
                HttpsURLConnection httpsConn = (HttpsURLConnection) url.openConnection();
                BufferedReader reader = new BufferedReader(new InputStreamReader(httpsConn.getInputStream(), "utf-8"));//设置编码,否则中文乱码
                System.out.println("=============================");
                System.out.println("Contents of get request");
                System.out.println("=============================");
                String lines;
                while ((lines = reader.readLine()) != null) {
                /*//lines = new String(lines.getBytes(), "utf-8");*/
                    JSONObject jb = new JSONObject(lines);
                    System.out.print(lines);
                    request.getSession().setAttribute("openid", jb.getString("openid"));//用户OpenId
                }
                reader.close();
                // 断开连接
                httpsConn.disconnect();
                System.out.println("=============================");
                System.out.println("Contents of get request ends");
                System.out.println("=============================");

            } catch (MalformedURLException e) {
                e.printStackTrace();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        try {
            Page<Commodity> page = new Page<Commodity>(1, 10);//分页查询
            Commodity commodity = new Commodity();
            page = commodityService.findPage(page, commodity);
            model.addAttribute("page", page);
            model.addAttribute("commodityList", page.getList());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "/mqds/m/index";//首页
    }
}
