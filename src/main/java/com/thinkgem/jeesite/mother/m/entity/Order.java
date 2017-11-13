package com.thinkgem.jeesite.mother.m.entity;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * Created by wangJH on 2017/11/3.
 * 订单
 */
public class Order extends DataEntity<Order> {
    private String orderNumber;//订单号
    private String commodityId;//商品Id
    private String orderState;//订单状态(0已完成,1待付款,2.待发货,3已发货,4已取消)
    private String addressId;//收货地址
    private Integer commodityNumber;//商品购买的数量
    private String commodityPrice;//商品单价

    public String getOrderNumber() {
        return orderNumber;
    }

    public void setOrderNumber(String orderNumber) {
        this.orderNumber = orderNumber;
    }

    public String getCommodityId() {
        return commodityId;
    }

    public void setCommodityId(String commodityId) {
        this.commodityId = commodityId;
    }

    public String getOrderState() {
        return orderState;
    }

    public void setOrderState(String orderState) {
        this.orderState = orderState;
    }

    public String getAddressId() {
        return addressId;
    }

    public void setAddressId(String addressId) {
        this.addressId = addressId;
    }

    public Integer getCommodityNumber() {
        return commodityNumber;
    }

    public void setCommodityNumber(Integer commodityNumber) {
        this.commodityNumber = commodityNumber;
    }

    public String getCommodityPrice() {
        return commodityPrice;
    }

    public void setCommodityPrice(String commodityPrice) {
        this.commodityPrice = commodityPrice;
    }
}
