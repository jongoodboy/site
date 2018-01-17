package com.thinkgem.jeesite.mother.admin.web;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.mother.admin.entity.Commodity;
import com.thinkgem.jeesite.mother.admin.entity.Specifications;
import com.thinkgem.jeesite.mother.admin.service.CommodityService;
import com.thinkgem.jeesite.mother.admin.service.SprcifictionsService;
import com.thinkgem.jeesite.mother.m.entity.Order;
import com.thinkgem.jeesite.mother.m.service.OrderService;
import org.apache.commons.collections.map.HashedMap;
import org.apache.shiro.crypto.hash.Hash;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * Created by wangJH on 2017/11/17.
 */
@Controller
@RequestMapping(value = "${adminPath}/order")
public class OrderController {
    @Resource
    private OrderService orderService;
    @Resource
    private CommodityService commodityService;
    @Resource
    private SprcifictionsService sprcifictionsService;

    //所有调用这个controller都会先调用这个方法
    @ModelAttribute
    private Order get(@RequestParam(required = false) String id) {
        if (StringUtils.isNotBlank(id)) {
            return orderService.get(id);
        } else {
            return new Order();
        }
    }

    //后台订单列表
    @RequestMapping("/orderList")
    public String orderList(Order order, Model model, @RequestParam(required = false, defaultValue = "1") Integer pageNo,
                            @RequestParam(required = false, defaultValue = "10") Integer pageSize) {
        Page<Order> page = new Page<Order>(pageNo, pageSize);//分页查询
        List<Map<String, Object>> orderListMap = new ArrayList<Map<String, Object>>();
        try {
            page = orderService.findPage(page, order);
            List<Order> list = page.getList();
            if (list.size() > 0) {
                for (int i = 0; i < list.size(); i++) {//如查有订单
                    Map<String, Object> map = new HashedMap();
                    Order o = list.get(i);
                    map.put("id", o.getId());
                    map.put("address", o.getAddress());
                    map.put("consigneePhone", o.getConsigneePhone());
                    map.put("consignee", o.getConsignee());
                    map.put("commodityNumber", o.getCommodityNumber());
                    map.put("commodityPrice", o.getCommodityPrice().toString());
                    map.put("orderNumber", o.getOrderNumber());
                    map.put("createDate", o.getCreateDate());
                    map.put("orderState", o.getOrderState());
                    map.put("express", o.getExpress());
                    map.put("expressNumber", o.getExpressNumber());
                    map.put("deliveryTime", o.getDeliveryTime());
                    map.put("expressRealHair", o.getExpressRealHair());
                    map.put("deliveryPeolpe", o.getDeliveryPeolpe());
                    Commodity c = commodityService.get(o.getCommodityId());//每一个商品
                    map.put("commodityName", c.getCommodityName());
                    map.put("company", c.getCommodityCompany());
                    map.put("commodityFlavor", o.getCommodityFlavor());
                    Specifications s = sprcifictionsService.get(o.getCommoditySpecifications());//每一个商品的规格
                    map.put("specifications", s);
                    orderListMap.add(map);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        model.addAttribute("orderListMap", orderListMap);
        model.addAttribute("page", page);
        model.addAttribute("order", order);
        return "mqds/admin/order/orderList";
    }

    /**
     * 发货
     *
     * @param order   快递 快递单号
     * @param orderId 订单ID
     * @return
     */
    @RequestMapping("/delivery")
    @ResponseBody
    public Map<String, Object> delivery(Order order, String orderId) {
        Map<String, Object> returnMap = new HashedMap();
        try {
            order.setId(orderId);
            order.setDeliveryTime(new Date());
            orderService.delivery(order);
            returnMap.put("code", "0");
            returnMap.put("msg", "发货成功");
        } catch (Exception e) {
            e.printStackTrace();
            returnMap.put("code", "-1");
            returnMap.put("msg", "发货失败");
        }
        return returnMap;
    }
}
