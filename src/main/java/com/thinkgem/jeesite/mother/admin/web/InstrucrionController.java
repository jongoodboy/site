package com.thinkgem.jeesite.mother.admin.web;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.mother.admin.entity.Instructions;
import com.thinkgem.jeesite.mother.admin.service.InstructionsService;
import org.apache.commons.lang3.StringEscapeUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.annotation.Resource;

/**
 * Created by wangJH on 2018/1/11.
 */
@Controller
@RequestMapping(value = "${adminPath}/instructions")
public class InstrucrionController extends BaseController {
    @Resource
    InstructionsService instructionsService;

    //所有调用这个controller都会先调用这个方法
    @ModelAttribute
    private Instructions get(@RequestParam(required = false) String id) {
        if (StringUtils.isNotBlank(id)) {
            return instructionsService.get(id);
        } else {
            return new Instructions();
        }
    }

    //使用说明列表
    @RequestMapping("list")
    public String list(Instructions instructions, Model model, @RequestParam(required = false, defaultValue = "1") Integer pageNo,
                       @RequestParam(required = false, defaultValue = "10") Integer pageSize) {
        Page<Instructions> page = new Page<Instructions>(pageNo, pageSize);//分页查询
        page = instructionsService.findPage(page, instructions);
        model.addAttribute("page", page);
        model.addAttribute("instructions", instructions);
        return "mqds/admin/instructions/list";
    }

    //添加使用说明页面
    @RequestMapping("from")
    public String from(Instructions instructions, Model model) {
        model.addAttribute("instructions", instructions);
        return "mqds/admin/instructions/from";
    }

    //添加使用说明
    @RequestMapping("save")
    public String save(Instructions instructions, RedirectAttributes redirectAttributes) {
        try {
            instructions.setInstructionsContent(StringEscapeUtils.unescapeHtml4(
                    instructions.getInstructionsContent()));//设置转换富文本格式
            instructionsService.save(instructions);
            addMessage(redirectAttributes, "商品添加成功");
        } catch (Exception e) {
            e.printStackTrace();
            addMessage(redirectAttributes, "商品添加失败了！请与管理员联系");
        }
        return "redirect:" + adminPath + "/instructions/from/";
    }
}
