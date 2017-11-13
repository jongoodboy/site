package com.thinkgem.jeesite.mother.m.entity;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * Created by wangJH on 2017/11/3.
 * 收货地址
 */
public class ReceiptAddress extends DataEntity<ReceiptAddress> {
    private String address;//详情收货地址
    private String isDefault;//默认地址(0是,1不是)
    private String consignee;//收货人姓名
    private String consigneePhone;//收货人电话
    private String province;//省
    private String city;//市
    private String county;//区，县

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getIsDefault() {
        return isDefault;
    }

    public void setIsDefault(String isDefault) {
        this.isDefault = isDefault;
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

    public String getProvince() {
        return province;
    }

    public void setProvince(String province) {
        this.province = province;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getCounty() {
        return county;
    }

    public void setCounty(String county) {
        this.county = county;
    }
}
