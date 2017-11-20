package com.thinkgem.jeesite.mother.m.service;

import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.mother.m.dao.ApplyRefundDao;
import com.thinkgem.jeesite.mother.m.dao.OrderDao;
import com.thinkgem.jeesite.mother.m.entity.ApplyRefund;
import org.apache.commons.collections.map.HashedMap;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.Map;

/**
 * Created by wangJH on 2017/11/17.
 */
@Service
public class ApplyRefundService extends CrudService<ApplyRefundDao, ApplyRefund> {
    @Resource
    ApplyRefundDao applyRefundDao;
    @Resource
    OrderDao orderDao;

    @Transactional(readOnly = false)
    public int updateFund(Map<String, Object> map) {
        int index = 0;
        try {
            index = applyRefundDao.updateFund(map);//更改退款状态
            if (index > 0) {//表示成功
                Map<String, Object> orderMap = new HashedMap();
                String refundState = (String) map.get("refundState");//退款状态
                if (refundState.equals("0")) {
                    refundState = "5";//退款成功
                } else {
                    refundState = "6";//退款失败
                }
                String orderId = (String) map.get("orderId");//订单Id
                orderMap.put("id", orderId);
                orderMap.put("orderState", refundState);
                index = orderDao.updateRefund(orderMap);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return index;
    }
}
