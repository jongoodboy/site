package com.thinkgem.jeesite.mother.admin.web;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.mother.admin.entity.Express;
import com.thinkgem.jeesite.mother.admin.service.ExpressService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.annotation.Resource;

/**
 * Created by wangJH on 2017/12/13.
 * 快递
 */
@Controller
@RequestMapping(value = "${adminPath}/express")
public class ExpressController extends BaseController {
    @Resource
    private ExpressService expressService;

    @ModelAttribute
    private Express get(@RequestParam(required = false) String id) {
        if (StringUtils.isNotBlank(id)) {
            return expressService.get(id);
        } else {
            return new Express();
        }
    }

    //快递列表
    @RequestMapping("list")
    public String list(Express express, Model model, @RequestParam(required = false, defaultValue = "1") Integer pageNo,
                       @RequestParam(required = false, defaultValue = "10") Integer pageSize) {
        Page<Express> page = new Page<Express>(pageNo, pageSize);//分页查询
        page = expressService.findPage(page, express);
        model.addAttribute("page", page);
        model.addAttribute("express", express);
        return "mqds/admin/express/list";
    }

    //添加快递页面
    @RequestMapping("from")
    public String from(Express express, Model model) {
        model.addAttribute("express", express);
        return "mqds/admin/express/from";
    }
    //添加修改快递
    @RequestMapping("save")
    public String save(Express express, RedirectAttributes redirectAttributes){
        try {
            expressService.save(express);
            addMessage(redirectAttributes, "添加快递成功");
        } catch (Exception e) {
            e.printStackTrace();
            addMessage(redirectAttributes,"添加快递失败了！请与管理员联系");
        }
        return "redirect:" + adminPath + "/express/from/";
    }
}
