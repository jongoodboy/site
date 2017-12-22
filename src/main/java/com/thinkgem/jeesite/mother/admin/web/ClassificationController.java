package com.thinkgem.jeesite.mother.admin.web;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.mother.admin.entity.Classification;
import com.thinkgem.jeesite.mother.admin.service.ClassificationService;
import org.apache.commons.collections.map.HashedMap;
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
 * Created by wangJH on 2017/12/21.
 * 特产功能
 */
@Controller
@RequestMapping(value = "${adminPath}/commodityClassification/")
public class ClassificationController extends BaseController {
    @Resource
    private ClassificationService classificationService;

    //所有调用这个controller都会先调用这个方法
    @ModelAttribute
    private Classification get(@RequestParam(required = false) String id) {
        if (StringUtils.isNotBlank(id)) {
            return classificationService.get(id);
        } else {
            return new Classification();
        }
    }

    //特产列表
    @RequestMapping("list")
    public String list(Classification classification, Model model, @RequestParam(required = false, defaultValue = "1") Integer pageNo,
                       @RequestParam(required = false, defaultValue = "10") Integer pageSize) {
        Page<Classification> page = new Page<Classification>(pageNo, pageSize);//分页查询
        page = classificationService.findPage(page, classification);
        model.addAttribute("page", page);
        model.addAttribute("classification", classification);
        return "mqds/admin/classification/list";
    }

    //添加特产
    @RequestMapping("from")
    public String from(Classification classification, Model model) {
        model.addAttribute("classification", classification);
        return "mqds/admin/classification/from";
    }

    //保存特产
    @RequestMapping("save")
    public String save(Classification classification, RedirectAttributes redirectAttributes) {
        try {
            classificationService.save(classification);
            addMessage(redirectAttributes, "操作成功");
        } catch (Exception e) {
            e.printStackTrace();
            addMessage(redirectAttributes, "操作失败了！请与管理员联系");
        }
        return "redirect:" + adminPath + "/commodityClassification/from";
    }

    /**
     * 添加商品选择区域查询该区域下所有特产
     * @param classification
     * @return
     */
    @RequestMapping("listData")
    @ResponseBody
    public Map<String, Object> listData(Classification classification) {
        Map<String, Object> retMap = new HashedMap();
        try {
            List<Classification> list = classificationService.findList(classification);
            retMap.put("data",list);
            retMap.put("msg","数据查询成功");
            retMap.put("code","0");
        } catch (Exception e) {
            retMap.put("code","-1");
            retMap.put("msg","数据查询失败");
            e.printStackTrace();
        }
        return retMap;
    }
}
