package com.thinkgem.jeesite.mother.admin.web;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.mother.admin.entity.Commodity;
import com.thinkgem.jeesite.mother.admin.service.CommodityService;
import com.thinkgem.jeesite.mother.m.entity.ApplyRefund;
import com.thinkgem.jeesite.mother.m.entity.Order;
import com.thinkgem.jeesite.mother.m.service.ApplyRefundService;
import com.thinkgem.jeesite.mother.m.service.OrderService;
import org.apache.commons.collections.map.HashedMap;
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
 * Created by wangJH on 2017/11/20.
 * 后台退款
 */
@Controller
@RequestMapping(value = "${adminPath}/refund")
public class ReFundConteroller {
    @Resource
    ApplyRefundService applyRefundService;
    @Resource
    OrderService orderService;
    @Resource
    CommodityService commodityService;

    //后台退款列表
    @RequestMapping("/reFundList")
    public String orderList(ApplyRefund applyRefund, Model model, @RequestParam(required = false, defaultValue = "1") Integer pageNo,
                            @RequestParam(required = false, defaultValue = "10") Integer pageSize) {
        Page<ApplyRefund> page = new Page<ApplyRefund>(pageNo, pageSize);//分页查询
        List<Map<String, Object>> reFundListMap = new ArrayList<Map<String, Object>>();
        try {
            page = applyRefundService.findPage(page, applyRefund);
            List<ApplyRefund> list = page.getList();
            if (list.size() > 0) {
                for (int i = 0; i < list.size(); i++) {//如果有退款
                    ApplyRefund refund = list.get(i);
                    Order o = orderService.get(refund.getApplyOrderId());
                    Commodity com = commodityService.get(o.getCommodityId());
                    Map<String, Object> map = new HashedMap();
                    map.put("orderNumber", o.getOrderNumber());//订单号
                    map.put("applyDescribe", refund.getApplyDescribe());//申请退款描述
                    map.put("refundDescribe", refund.getRefundDescribe());//退款处理描述
                    map.put("comName", com.getCommodityName());//商品名称
                    map.put("comId", com.getId());//商品Id
                    map.put("ordPrice", o.getCommodityPrice());//生成订单时商品的价格
                    map.put("ordNumber", o.getCommodityNumber());//购买的数量
                    map.put("applyFundMoney", refund.getApplyMoney());//申请退费的金额
                    map.put("applyRefuntState", refund.getRefuntState());//申请退款中
                    map.put("applyRefuntDate", refund.getCreateDate());//申请时间
                    map.put("refundId", refund.getId());//退款ID
                    map.put("orderId", o.getId());//订单Id
                    map.put("applyUpdateDate", refund.getUpdateDate());//操作时间
                    map.put("applyUpdateName", refund.getUserId());//退款操作人
                    reFundListMap.add(map);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        model.addAttribute("reFundListMap", reFundListMap);
        model.addAttribute("applyRefund", applyRefund);
        model.addAttribute("page", page);
        return "mqds/admin/refund/list";
    }
    //退款操作(同意或不同意)

    /**
     * @param refundState    (0已退款，1退款中，-1退款失败）
     * @param refundId       退款ID
     * @param refundPeolpe   退款人
     * @param refundDescribe 退款操作人描述
     * @param orderId        订单的ID
     * @param updateBy       处理退款人的ID
     * @param orderNumber    订单号(用于扣除分成)
     * @param commodityId    商品Id(用于扣除分成)
     * @return
     */
    @RequestMapping("/operation")
    @ResponseBody
    public Map<String, Object> operation(String refundState, String refundId,
                                         String refundPeolpe, String refundDescribe,
                                         String orderId, String updateBy, String orderNumber, String commodityId) {
        Map<String, Object> returnMap = new HashedMap();
        Map<String, Object> paramMap = new HashedMap();
        paramMap.put("refundState", refundState);
        paramMap.put("id", refundId);
        paramMap.put("updateName", refundPeolpe);
        paramMap.put("refundDescribe", refundDescribe);
        paramMap.put("orderId", orderId);
        paramMap.put("updateBy", updateBy);
        paramMap.put("orderNumber", orderNumber);
        paramMap.put("commodityId", commodityId);
        paramMap.put("updateDate", new Date());
        try {
            applyRefundService.updateFund(paramMap);
            returnMap.put("code", "0");
            returnMap.put("msg", "退款操作成功");
        } catch (Exception e) {
            returnMap.put("code", "-1");
            returnMap.put("msg", "退款操作失败");
            e.printStackTrace();
        }
        return returnMap;
    }
}
