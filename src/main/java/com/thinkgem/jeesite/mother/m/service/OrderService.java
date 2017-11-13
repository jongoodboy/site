package com.thinkgem.jeesite.mother.m.service;

import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.mother.admin.entity.Commodity;
import com.thinkgem.jeesite.mother.admin.service.CommodityService;
import com.thinkgem.jeesite.mother.m.dao.OrderDao;
import com.thinkgem.jeesite.mother.m.entity.Order;
import com.thinkgem.jeesite.mother.m.entity.ReceiptAddress;
import org.apache.commons.collections.map.HashedMap;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Created by wangJH on 2017/11/3.
 */
@Service
@Transactional(readOnly = false)
public class OrderService extends CrudService<OrderDao, Order> {
    @Resource
    OrderDao orderDao;
    @Resource
    CommodityService comodityService;
    @Resource
    AddressService addressService;

    public int addList(List<Order> list) {
        return orderDao.addList(list);
    }

    //所有订单列表
    public List<Map<String, Object>> findOrderList(Map<String, Object> map) {
        List<Map<String, Object>> returnListMap = new ArrayList<Map<String, Object>>();
        try {
            List<String> listOrderNumber = orderDao.findOrderNumber(map);//查询个人订单号分组
            if (listOrderNumber != null && listOrderNumber.size() > 0) {//有下过订单
                for (int i = 0; i < listOrderNumber.size(); i++) {
                    List<String> paramList = new ArrayList<String>();
                    paramList.add(listOrderNumber.get(i));
                    List<Order> listOrder = orderDao.findOrderListByOrderNumber(paramList);//订单号对应的所有商品
                    if (listOrder != null && listOrder.size() > 0) {
                        Map<String, Object> map1 = new HashedMap();
                        List<Commodity> list = new ArrayList<Commodity>();//返回页面订单对应所有商品列表
                        float sumOrderMoney = 0;//每个订单总金额
                        Integer commodityIndex = 0;//每个订单对应的商品数量
                        String orderState = "";
                        for (int j = 0; j < listOrder.size(); j++) {
                            Order o = listOrder.get(j);
                            Commodity com = comodityService.get(o.getCommodityId());//查询得到每个商品
                            orderState = o.getOrderState();
                            commodityIndex += o.getCommodityNumber();
                            list.add(com);//添加每个订单对应的商品
                            sumOrderMoney += (Float.parseFloat(o.getCommodityPrice()) * o.getCommodityNumber());
                        }
                        map1.put("orderState",orderState);//订单状态 0已完成,1待付款,2.待发货,3已发货,4已取消,空为全部)
                        map1.put("commodityIndex",commodityIndex);//订单对应的商品量
                        map1.put("shppingList", list);//订单对应所有商品列表
                        map1.put("sumOrderMoney", sumOrderMoney);//订单对应总金额
                        map1.put("sumOrderNnmber", listOrderNumber.get(i));//订单号
                        returnListMap.add(map1);
                    }
                }
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
        return returnListMap;
    }
    //订单详情
    public Map<String, Object> findOrderDetailByOrderNumber(String orderNumber) {
        Map<String, Object> returnMap = new HashedMap();
        List<String> paramList = new ArrayList<String>();
        paramList.add(orderNumber);
        List<Order> listOrderNumber = orderDao.findOrderListByOrderNumber(paramList);//查找该订单下所有的商品
        try {
            if (listOrderNumber != null && listOrderNumber.size() > 0) {
                List<Commodity> list = new ArrayList<Commodity>();//返回页面订单对应所有商品列表
                for (int j = 0; j < listOrderNumber.size(); j++) {
                    Order o = listOrderNumber.get(j);
                    Commodity com = comodityService.get(o.getCommodityId());//查询得到每个商品
                    com.setCommodityNumber(o.getCommodityNumber());//暂时存放每个商品购买的数量
                    list.add(com);//添加每个订单对应的商品
                }
               ReceiptAddress readdress =  addressService.findListfById(listOrderNumber.get(0).getAddressId());//查询收货地址
                returnMap.put("commidityList", list);//订单对应所有商品列表
                returnMap.put("address",readdress);//订单地址
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return returnMap;
    }
}
