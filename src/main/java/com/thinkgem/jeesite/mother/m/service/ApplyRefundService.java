package com.thinkgem.jeesite.mother.m.service;

import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.mother.m.dao.ApplyRefundDao;
import com.thinkgem.jeesite.mother.m.dao.OrderDao;
import com.thinkgem.jeesite.mother.m.dao.ProfitDao;
import com.thinkgem.jeesite.mother.m.entity.ApplyRefund;
import org.apache.commons.collections.map.HashedMap;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
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
    @Resource
    ProfitDao profitDao;

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
                if (index > 0) {//表示已经状态退款已经成功   实际去扣除收益人的收益 用订单号和商品Id
                    String orderNumber = (String) map.get("orderNumber");//订单号
                    String commodityId = (String) map.get("commodityId");//商品ID
                    Map<String, Object> paramMap = new HashedMap();
                    paramMap.put("orderNumber", orderNumber);
                    paramMap.put("commodityId", commodityId);
                    List<Map<String, Object>> refundUserAndMoney = profitDao.findReFundByOrderNumberAndCommodityId(paramMap);
                    if (refundUserAndMoney != null && refundUserAndMoney.size() > 0) {
                        profitDao.subtraction(refundUserAndMoney);//批量扣除收益人的收益
                        Date d = new Date();
                        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                        String data = format.format(d);
                        for (int i = 0; i < refundUserAndMoney.size(); i++) {
                            refundUserAndMoney.get(i).put("feeDeduction","您的账户于:"+data
                                    +"从账户余额扣除:"+refundUserAndMoney.get(i).get("profitMoney")+"元,扣款原因,商品已经退款!");
                        }
                        profitDao.profitLoss(refundUserAndMoney);//把收益表个人收益修改为异常退款
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return index;
    }
}
