package com.thinkgem.jeesite.mother.admin.entity;

import com.thinkgem.jeesite.common.persistence.DataEntity;

import java.math.BigDecimal;
import java.util.zip.Inflater;

/**
 * Created by wangJH on 2017/10/31.
 * 商品基类
 */
public class Commodity extends DataEntity<Commodity> {
    // --> 表示字典表配置
    private String commodityName;//商品名称
    private Integer commodityType;//商品类型 (1.水果2.服装3.其他 -->)
    private String commodityImager;//商品图片 (多张图片用｜分隔)commodityImager
    private Integer commodityState;//商品状态(1.精选商品2.热门商品4.其他状态商品3.必卖商品' -->)
    private String commodityMaker;//商品描述
    private BigDecimal commodityPice;//商品单价
    private Integer commodityNumber;//商品库存量
    private Integer commodityCompany;//商品单位(1.个2.条3.件4.根 -->)
    private Integer commodityRelease;//商品发布状态(0在售,1已下架)
    private BigDecimal costPrice;//商品成本价
    private BigDecimal freight;//运费

    public Integer getCommodityRelease() {
        return commodityRelease;
    }
    public void setCommodityRelease(Integer commodityRelease) {
        this.commodityRelease = commodityRelease;
    }
    public String getCommodityName() {
        return commodityName;
    }

    public void setCommodityName(String commodityName) {
        this.commodityName = commodityName;
    }

    public Integer getCommodityType() {
        return commodityType;
    }

    public void setCommodityType(Integer commodityType) {
        this.commodityType = commodityType;
    }

    public String getCommodityImager() {
        return commodityImager;
    }

    public void setCommodityImager(String commodityImager) {
        this.commodityImager = commodityImager;
    }

    public Integer getCommodityState() {
        return commodityState;
    }

    public void setCommodityState(Integer commodityState) {
        this.commodityState = commodityState;
    }

    public String getCommodityMaker() {
        return commodityMaker;
    }

    public void setCommodityMaker(String commodityMaker) {
        this.commodityMaker = commodityMaker;
    }

    public BigDecimal getCommodityPice() {
        return commodityPice;
    }

    public void setCommodityPice(BigDecimal commodityPice) {
        this.commodityPice = commodityPice;
    }

    public Integer getCommodityNumber() {
        return commodityNumber;
    }

    public void setCommodityNumber(Integer commodityNumber) {
        this.commodityNumber = commodityNumber;
    }

    public BigDecimal getCostPrice() {
        return costPrice;
    }

    public void setCostPrice(BigDecimal costPrice) {
        this.costPrice = costPrice;
    }

    public BigDecimal getFreight() {
        return freight;
    }

    public void setFreight(BigDecimal freight) {
        this.freight = freight;
    }

    public Integer getCommodityCompany() {
        return commodityCompany;
    }

    public void setCommodityCompany(Integer commodityCompany) {
        this.commodityCompany = commodityCompany;
    }
}
