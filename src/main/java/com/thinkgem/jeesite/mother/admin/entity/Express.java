package com.thinkgem.jeesite.mother.admin.entity;

import com.thinkgem.jeesite.common.persistence.DataEntity;

import java.math.BigDecimal;

/**
 * Created by wangJH on 2017/12/13.
 * 快递实体
 */
public class Express extends DataEntity<Express> {
    private String expressName;//快递名称
    private BigDecimal expressProvinceFirst;//省内首重
    private BigDecimal expressProvinceIncreasing;//省内递增
    private BigDecimal expressOutsideFirst;//省外首重
    private BigDecimal expressOutsideIncreasing;//省外递增

    public String getExpressName() {
        return expressName;
    }

    public void setExpressName(String expressName) {
        this.expressName = expressName;
    }

    public BigDecimal getExpressProvinceFirst() {
        return expressProvinceFirst;
    }

    public void setExpressProvinceFirst(BigDecimal expressProvinceFirst) {
        this.expressProvinceFirst = expressProvinceFirst;
    }

    public BigDecimal getExpressProvinceIncreasing() {
        return expressProvinceIncreasing;
    }

    public void setExpressProvinceIncreasing(BigDecimal expressProvinceIncreasing) {
        this.expressProvinceIncreasing = expressProvinceIncreasing;
    }

    public BigDecimal getExpressOutsideFirst() {
        return expressOutsideFirst;
    }

    public void setExpressOutsideFirst(BigDecimal expressOutsideFirst) {
        this.expressOutsideFirst = expressOutsideFirst;
    }

    public BigDecimal getExpressOutsideIncreasing() {
        return expressOutsideIncreasing;
    }

    public void setExpressOutsideIncreasing(BigDecimal expressOutsideIncreasing) {
        this.expressOutsideIncreasing = expressOutsideIncreasing;
    }
}
