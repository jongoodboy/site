package com.thinkgem.jeesite.mother.admin.web;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.mother.m.entity.CashWithDrawal;
import com.thinkgem.jeesite.mother.m.service.CashWithDrawalService;
import org.apache.commons.collections.map.HashedMap;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.Map;

/**
 * Created by wangJH on 2018/1/3.
 * 后台提现管理
 */
@Controller
@RequestMapping(value = "${adminPath}/withdrawals")
public class WithdrawalController {
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
        model.addAttribute("cashWithDrawal",cashWithDrawal);
        return "mqds/admin/cashWithDrawal/list";
    }

    //转账操作
    @RequestMapping("determine")
    @ResponseBody
    public Map<String, Object> determine(CashWithDrawal cashWithDrawal) {
        Map<String, Object> retMap = new HashedMap();
        try {
            cashWithDrawalService.save(cashWithDrawal);
            retMap.put("code","0");
            retMap.put("msg","转账成功");
        } catch (Exception e) {
            e.printStackTrace();
            retMap.put("code","-1");
            retMap.put("msg","转账失败");
        }
        return retMap;
    }
}
