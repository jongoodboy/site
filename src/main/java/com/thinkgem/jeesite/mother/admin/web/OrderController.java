package com.thinkgem.jeesite.mother.admin.web;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.mother.m.entity.Order;
import com.thinkgem.jeesite.mother.m.service.OrderService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.annotation.Resource;

/**
 * Created by wangJH on 2017/11/17.
 */
@Controller
@RequestMapping(value = "${adminPath}/order")
public class OrderController {
    @Resource
    private OrderService orderService;
    //所有调用这个controller都会先调用这个方法
    @ModelAttribute
    private Order get(@RequestParam(required = false) String id){
        if (StringUtils.isNotBlank(id)){
            return orderService.get(id);
        }else{
            return new Order();
        }
    }
    @RequestMapping("/orderList")
    public String orderList(Order order, Model model, @RequestParam(required = false,defaultValue = "1") Integer pageNo,
                            @RequestParam(required = false,defaultValue = "10") Integer pageSize) {
        Page<Order> page = new Page<Order>(pageNo,pageSize);//分页查询
        page =  orderService.findPage(page,order);
        model.addAttribute("page",page);
        return "mqds/admin/order/orderList";
    }
}
