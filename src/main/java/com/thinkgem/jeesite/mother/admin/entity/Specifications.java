package com.thinkgem.jeesite.mother.admin.entity;

import com.thinkgem.jeesite.common.persistence.DataEntity;

import java.math.BigDecimal;

/**
 * Created by wangJH on 2018/1/16.
 * 规格
 */
public class Specifications extends DataEntity<Specifications> {
    private String specificationsParameter;//规格参数
    private BigDecimal specificationsCommodityPice;//参数对应价钱
    private String commodityId;//商品Id

    public String getSpecificationsParameter() {
        return specificationsParameter;
    }

    public void setSpecificationsParameter(String specificationsParameter) {
        this.specificationsParameter = specificationsParameter;
    }

    public BigDecimal getSpecificationsCommodityPice() {
        return specificationsCommodityPice;
    }

    public void setSpecificationsCommodityPice(BigDecimal specificationsCommodityPice) {
        this.specificationsCommodityPice = specificationsCommodityPice;
    }

    public String getCommodityId() {
        return commodityId;
    }

    public void setCommodityId(String commodityId) {
        this.commodityId = commodityId;
    }
}
