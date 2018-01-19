package com.thinkgem.jeesite.mother.admin.web;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.DateUtils;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.utils.excel.ExportExcel;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.mother.m.entity.CashWithDrawal;
import com.thinkgem.jeesite.mother.m.service.CashWithDrawalService;
import org.apache.commons.collections.map.HashedMap;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;

/**
 * Created by wangJH on 2018/1/3.
 * 后台提现管理
 */
@Controller
@RequestMapping(value = "${adminPath}/withdrawals")
public class WithdrawalController extends BaseController {
    @Resource
    CashWithDrawalService cashWithDrawalService;

    @ModelAttribute
    private CashWithDrawal get(@RequestParam(required = false) String id) {
        if (StringUtils.isNotBlank(id)) {
            return cashWithDrawalService.get(id);
        } else {
            return new CashWithDrawal();
        }
    }

    //提现列表
    @RequestMapping("list")
    public String list(CashWithDrawal cashWithDrawal, Model model, @RequestParam(required = false, defaultValue = "1") Integer pageNo,
                       @RequestParam(required = false, defaultValue = "10") Integer pageSize) {
        Page<CashWithDrawal> page = new Page<CashWithDrawal>(pageNo, pageSize);//分页查询
        page = cashWithDrawalService.findPage(page, cashWithDrawal);
        model.addAttribute("page", page);
        model.addAttribute("cashWithDrawal", cashWithDrawal);
        return "mqds/admin/cashWithDrawal/list";
    }

    //转账操作
    @RequestMapping("determine")
    @ResponseBody
    public Map<String, Object> determine(CashWithDrawal cashWithDrawal) {
        Map<String, Object> retMap = new HashedMap();
        try {
            cashWithDrawalService.save(cashWithDrawal);
            retMap.put("code", "0");
            retMap.put("msg", "转账成功");
        } catch (Exception e) {
            e.printStackTrace();
            retMap.put("code", "-1");
            retMap.put("msg", "转账失败");
        }
        return retMap;
    }

    /**
     * 导出提现数据
     */
    @RequestMapping(value = "export")
    public String exportFile(CashWithDrawal cashWithDrawal, HttpServletResponse response, RedirectAttributes redirectAttributes) {
        try {
            String name = "";
            if (cashWithDrawal.getDelFlag().equals("0")) {
                name = "提现申请表" + DateUtils.getDate("yyyy-MM-ddHHmmss");
            }else {
                name = "已处理提现申请表" + DateUtils.getDate("yyyy-MM-ddHHmmss");
            }
            String fileName = name + ".xlsx";
            List<CashWithDrawal> list = cashWithDrawalService.findList(cashWithDrawal);
            new ExportExcel("", CashWithDrawal.class).setDataList(list).write(response, fileName).dispose();
            return null;
        } catch (Exception e) {
            addMessage(redirectAttributes, "导出提现失败！失败信息：" + e.getMessage());
        }
        return "redirect:" + adminPath + "/withdrawals/list?list";
    }
}
