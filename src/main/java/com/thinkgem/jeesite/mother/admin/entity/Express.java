package com.thinkgem.jeesite.mother.admin.entity;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * Created by wangJH on 2017/12/13.
 * 快递实体
 */
public class Express extends DataEntity<Express> {
    private String expressName;//快递名称
    private String expressProvinceFirst;//省内首重
    private String expressProvinceIncreasing;//省内递增
    private String expressOutsideFirst;//省外首重
    private String expressOutsideIncreasing;//省外递增

    public String getExpressName() {
        return expressName;
    }

    public void setExpressName(String expressName) {
        this.expressName = expressName;
    }

    public String getExpressProvinceFirst() {
        return expressProvinceFirst;
    }

    public void setExpressProvinceFirst(String expressProvinceFirst) {
        this.expressProvinceFirst = expressProvinceFirst;
    }

    public String getExpressProvinceIncreasing() {
        return expressProvinceIncreasing;
    }

    public void setExpressProvinceIncreasing(String expressProvinceIncreasing) {
        this.expressProvinceIncreasing = expressProvinceIncreasing;
    }

    public String getExpressOutsideFirst() {
        return expressOutsideFirst;
    }

    public void setExpressOutsideFirst(String expressOutsideFirst) {
        this.expressOutsideFirst = expressOutsideFirst;
    }

    public String getExpressOutsideIncreasing() {
        return expressOutsideIncreasing;
    }

    public void setExpressOutsideIncreasing(String expressOutsideIncreasing) {
        this.expressOutsideIncreasing = expressOutsideIncreasing;
    }
}
