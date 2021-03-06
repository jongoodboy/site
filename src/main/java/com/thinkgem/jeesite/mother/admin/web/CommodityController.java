package com.thinkgem.jeesite.mother.admin.web;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.mother.admin.entity.Commodity;
import com.thinkgem.jeesite.mother.admin.entity.Express;
import com.thinkgem.jeesite.mother.admin.entity.Specifications;
import com.thinkgem.jeesite.mother.admin.service.CommodityService;
import com.thinkgem.jeesite.mother.admin.service.ExpressService;
import com.thinkgem.jeesite.mother.admin.service.SprcifictionsService;
import org.apache.commons.collections.map.HashedMap;
import org.apache.commons.lang3.StringEscapeUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

/**
 * Created by wangJH on 2017/10/30.
 * 后台商品Controller
 */
@Controller
@RequestMapping(value = "${adminPath}/commodity/")
public class CommodityController extends BaseController {
    @Resource
    private CommodityService commodityService;
    @Resource
    private ExpressService expressService;
    @Resource
    private SprcifictionsService sprcifictionsService;

    //所有调用这个controller都会先调用这个方法
    @ModelAttribute
    private Commodity get(@RequestParam(required = false) String id) {
        if (StringUtils.isNotBlank(id)) {
            return commodityService.get(id);
        } else {
            return new Commodity();
        }
    }

    //商品列表
    @RequestMapping("list")
    public String list(Commodity commodity, Model model, @RequestParam(required = false, defaultValue = "1") Integer pageNo,
                       @RequestParam(required = false, defaultValue = "10") Integer pageSize) {
        Page<Commodity> page = new Page<Commodity>(pageNo, pageSize);//分页查询
        page = commodityService.findPage(page, commodity);
        model.addAttribute("page", page);
        model.addAttribute("commodity", commodity);
        return "mqds/admin/commodity/list";
    }

    //添加商品页面
    @RequestMapping("from")
    public String from(Commodity commodity, Model model) {
        List<Express> list = expressService.findList(new Express());//快递列表
        List<Specifications> specificationsList = sprcifictionsService.findSprcifictionsList(commodity.getId());//商品规格
        model.addAttribute("commodity", commodity);
        model.addAttribute("expressList", list);
        model.addAttribute("specificationsList", specificationsList);
        return "mqds/admin/commodity/from";
    }

    //添加商品

    /**
     * @param commodity                   商品实体
     * @param redirectAttributes          提示信息
     * @param specificationsParameter     规格
     * @param specificationsCommodityPice 规格对应的价格
     * @param specificationsId            规格表的ID 用于修改
     * @return
     */
    @RequestMapping("save")
    public String save(Commodity commodity, String commodityFlavors,  RedirectAttributes redirectAttributes, String specificationsId, String specificationsParameter, String specificationsCommodityPice) {
        try {
            commodity.setCommodityMaker(StringEscapeUtils.unescapeHtml4(
                    commodity.getCommodityMaker()));//设置转换富文本格式
            commodity.setCommodityFlavor(commodityFlavors);
            commodityService.save(commodity);//商品基本信息
            sprcifictionsService.insertAll(specificationsId, specificationsParameter, specificationsCommodityPice,commodity.getId());//规格信息
            addMessage(redirectAttributes, "商品添加成功");
        } catch (Exception e) {
            e.printStackTrace();
            addMessage(redirectAttributes, "商品添加失败了！请与管理员联系");
        }
        return "redirect:" + adminPath + "/commodity/from/";
    }

}
