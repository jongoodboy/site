package com.thinkgem.jeesite.mother.m.entity;

import com.thinkgem.jeesite.common.persistence.DataEntity;

import javax.xml.crypto.Data;
import java.math.BigDecimal;
import java.util.Date;

/**
 * Created by wangJH on 2017/11/3.
 * 订单
 */
public class Order extends DataEntity<Order> {
    private String orderNumber;//订单号
    private String commodityId;//商品Id
    private String orderState;//订单状态(0已完成,1待付款,2.待发货,3已发货,4退款中,5已退款)
    private String address;//收货地址
    private String consignee;//收货人姓名
    private String consigneePhone;//收货人电话
    private Integer commodityNumber;//商品购买的数量
    private BigDecimal commodityPrice;//商品单价
    private String express;//应发快递
    private String expressRealHair;//实发快递
    private String expressNumber;//快递单号
    private Date deliveryTime;//发货时间
    private String deliveryPeolpe;//发货人
    private String shareCode;//分享码
    private String commodityFlavor;//商品口味
    private String commoditySpecifications;//商品规格Id

    public String getCommodityFlavor() {
        return commodityFlavor;
    }

    public void setCommodityFlavor(String commodityFlavor) {
        this.commodityFlavor = commodityFlavor;
    }

    public String getCommoditySpecifications() {
        return commoditySpecifications;
    }

    public void setCommoditySpecifications(String commoditySpecifications) {
        this.commoditySpecifications = commoditySpecifications;
    }

    public String getExpressRealHair() {
        return expressRealHair;
    }

    public void setExpressRealHair(String expressRealHair) {
        this.expressRealHair = expressRealHair;
    }

    public String getShareCode() {
        return shareCode;
    }

    public void setShareCode(String shareCode) {
        this.shareCode = shareCode;
    }

    public String getExpress() {
        return express;
    }

    public void setExpress(String express) {
        this.express = express;
    }

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

    public String getExpressNumber() {
        return expressNumber;
    }

    public void setExpressNumber(String expressNumber) {
        this.expressNumber = expressNumber;
    }

    public Date getDeliveryTime() {
        return deliveryTime;
    }

    public void setDeliveryTime(Date deliveryTime) {
        this.deliveryTime = deliveryTime;
    }

    public String getDeliveryPeolpe() {
        return deliveryPeolpe;
    }

    public void setDeliveryPeolpe(String deliveryPeolpe) {
        this.deliveryPeolpe = deliveryPeolpe;
    }

    public void setOrderState(String orderState) {
        this.orderState = orderState;
    }

    public Integer getCommodityNumber() {
        return commodityNumber;
    }

    public void setCommodityNumber(Integer commodityNumber) {
        this.commodityNumber = commodityNumber;
    }

    public BigDecimal getCommodityPrice() {
        return commodityPrice;
    }

    public void setCommodityPrice(BigDecimal commodityPrice) {
        this.commodityPrice = commodityPrice;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getConsignee() {
        return consignee;
    }

    public void setConsignee(String consignee) {
        this.consignee = consignee;
    }

    public String getConsigneePhone() {
        return consigneePhone;
    }

    public void setConsigneePhone(String consigneePhone) {
        this.consigneePhone = consigneePhone;
    }
}
