package com.thinkgem.jeesite.mother.m.service;

import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.mother.admin.entity.Commodity;
import com.thinkgem.jeesite.mother.admin.service.CommodityService;
import com.thinkgem.jeesite.mother.m.dao.MuserDao;
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
    ReceiptAddressService addressService;
    @Resource
    MuserDao muserDao;

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
                        map1.put("orderState", orderState);//订单状态 (0已完成,1待付款,2.待发货,3已发货,4退款中,5已退款)
                        map1.put("commodityIndex", commodityIndex);//订单对应的商品量
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
                returnMap.put("commidityList", list);//订单对应所有商品列表
                returnMap.put("address", listOrderNumber.get(0).getAddress());//订单地址
                returnMap.put("consignee", listOrderNumber.get(0).getConsignee());//订单收货人
                returnMap.put("consigneePhone", listOrderNumber.get(0).getConsigneePhone());//订单收货人
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return returnMap;
    }

    //修改订单状态并查看有没有购买必卖商品成为会员
    public int updateOrderState(Map<String, Object> map) {
        map.put("commodityState", "3");//查找有没有必卖商品。有的话把该用户设置成为会员
        try {
            String code = (String) map.get("code");//分享码
            if (code != null) {//如果有分享码
                Map<String, Object> muerMap = muserDao.findCode(code);//根据Code分享码查询分享人的Id和他的上线
                if (muerMap != null) {//如是查到数据
                    BigDecimal parentMoney = new BigDecimal(0);//分享人的所提的钱
                    String parentId = (String) muerMap.get("Id");//分享人的Id
                    String grandFather = (String) muerMap.get("ParentId");//分享人的上线
                    BigDecimal grandFatherMoney = new BigDecimal(0);//分享人的上线所提的钱
                    List<String> paramList = new ArrayList<String>();
                    paramList.add(map.get("orderNumber").toString());//根据订单号查询所有的商品
                    List<Order> listOrder = orderDao.findOrderListByOrderNumber(paramList);//订单号对应的所有商品
                    for (int i = 0; i < listOrder.size(); i++) {
                        Order o = listOrder.get(i);
                        Commodity com = comodityService.get(o.getCommodityId());//查询得到每个商品
                     /*   float v = com.getCommodityPice().floatValue() - com.getCostPrice().floatValue();//售价减去成本价等于利润*/
                        float v = com.getCommodityPice().floatValue();//售价于利润
                        BigDecimal parentThisMoney = new BigDecimal(v * 0.08).setScale(2, BigDecimal.ROUND_HALF_UP);//拿8%的利润给分享人
                        parentMoney = parentMoney.add(parentThisMoney);
                        if(grandFather != null && grandFather != ""){//如果分享人还有上线
                            BigDecimal grandFatherThisMoney = new BigDecimal(v * 0.02).setScale(2, BigDecimal.ROUND_HALF_UP);//拿2%的利润给分享人的线
                            grandFatherMoney = grandFatherMoney.add(grandFatherThisMoney);
                        }
                    }
                    //把钱转到分享人的账户上
                    List<Map<String,Object>> list = new ArrayList<Map<String, Object>>();
                    Map<String,Object> parentMap = new HashedMap();
                    parentMap.put("id",parentId);
                    parentMap.put("money",parentMoney);
                    list.add(parentMap);
                    if(grandFather != null && grandFather != ""){//如果分享人还有上线把全转到分享人上线的账号 只有2%
                        Map<String,Object> grandFatherMap = new HashedMap();
                        grandFatherMap.put("id",grandFather);
                        grandFatherMap.put("money",grandFatherMoney);
                        list.add(grandFatherMap);
                    }
                    muserDao.updateMoney(list);
                    String isVip = (String) map.get("isVIP");//0是会员1不是
                    if(isVip != null && isVip.equals("1")){//如果之前还不是会员才他的上线  如果已经是会员就不管。他的上线还是他第一次变成会员时的上线ID
                        map.put("parent",parentId);//设置购买人的上线
                    }
                }
            }
            muserDao.updateUserIsVIP(map);//设置成为会员,如果购买别人分享的店铺设置我的上线
        } catch (Exception e) {
            e.printStackTrace();
        }
        return orderDao.updateOrderState(map);
    }
    //后台发货
    public int delivery(Order order){
        return orderDao.delivery(order);
    }
}
