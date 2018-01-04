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
    private Integer commodityState;//商品状态(1.精选商品2.热门商品4.其他状态商品3.会员商品' -->)
    private String commodityMaker;//商品描述
    private BigDecimal commodityPice;//商品单价
    private Integer commodityNumber;//商品库存量
    private Integer commodityCompany;//商品单位(1.个2.条3.件4.根 -->)
    private Integer commodityRelease;//商品发布状态(0在售,1已下架)
    private BigDecimal costPrice;//商品成本价
    private BigDecimal freight;//运费
    private BigDecimal weight;//重量
    private Integer freeShipping;//是否包邮 1包 0不包
    private String defaultExpress;//默认快递
    private String belongRegion;//所属于区域
    private String belongSpecialty;//所属特产
    private String sharingDescription;//分享描述
    private Integer commodityPosition;//商品位置 越小越在前
    private BigDecimal commodityDiscount;//商品折扣
    private Integer commodityDiscountNum;//满足折扣条件，如买两个商品以上开始打折

    public Integer getCommodityPosition() {
        return commodityPosition;
    }

    public void setCommodityPosition(Integer commodityPosition) {
        this.commodityPosition = commodityPosition;
    }

    public BigDecimal getCommodityDiscount() {
        return commodityDiscount;
    }

    public void setCommodityDiscount(BigDecimal commodityDiscount) {
        this.commodityDiscount = commodityDiscount;
    }

    public Integer getCommodityDiscountNum() {
        return commodityDiscountNum;
    }

    public void setCommodityDiscountNum(Integer commodityDiscountNum) {
        this.commodityDiscountNum = commodityDiscountNum;
    }

    public String getSharingDescription() {
        return sharingDescription;
    }

    public void setSharingDescription(String sharingDescription) {
        this.sharingDescription = sharingDescription;
    }

    public String getBelongRegion() {
        return belongRegion;
    }

    public void setBelongRegion(String belongRegion) {
        this.belongRegion = belongRegion;
    }

    public String getBelongSpecialty() {
        return belongSpecialty;
    }

    public void setBelongSpecialty(String belongSpecialty) {
        this.belongSpecialty = belongSpecialty;
    }

    public String getDefaultExpress() {
        return defaultExpress;
    }

    public void setDefaultExpress(String defaultExpress) {
        this.defaultExpress = defaultExpress;
    }

    public BigDecimal getWeight() {
        return weight;
    }

    public void setWeight(BigDecimal weight) {
        this.weight = weight;
    }

    public Integer getFreeShipping() {
        return freeShipping;
    }

    public void setFreeShipping(Integer freeShipping) {
        this.freeShipping = freeShipping;
    }

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
