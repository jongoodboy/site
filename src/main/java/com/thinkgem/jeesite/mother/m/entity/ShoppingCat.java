package com.thinkgem.jeesite.mother.m.entity;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * Created by wangJH on 2017/11/3.
 * 购物车
 */
public class ShoppingCat extends DataEntity<ShoppingCat> {
    private String commodityId;//商品ID
    private Integer commodityNumber;//加购物车的商品数量
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
