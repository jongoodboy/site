package com.thinkgem.jeesite.mother.m.entity;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * Created by wangJH on 2017/11/3.
 * 购物车
 */
public class ShoppingCat extends DataEntity<ShoppingCat> {
    private String commodityId;//商品ID
    private Integer commodityNumber;//加购物车的商品数量
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

    public String getCommodityId() {
        return commodityId;
    }

    public void setCommodityId(String commodityId) {
        this.commodityId = commodityId;
    }

    public Integer getCommodityNumber() {
        return commodityNumber;
    }

    public void setCommodityNumber(Integer commodityNumber) {
        this.commodityNumber = commodityNumber;
    }


}
