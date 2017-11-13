package com.thinkgem.jeesite.mother.m.entity;

import com.thinkgem.jeesite.common.persistence.DataEntity;

import java.math.BigDecimal;

/**
 * Created by wangJH on 2017/11/3.
 * 手机端用户
 */
public class Muser extends DataEntity<Muser> {
    private String phone;//手机号
    private String password;//密码
    private String openId;//验证微信登陆    微信openId
    private String isVip;//是否是会员(0是,1不是)
    private String parent;//我的上线
    private BigDecimal money;//账户余额

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getOpenId() {
        return openId;
    }

    public void setOpenId(String openId) {
        this.openId = openId;
    }

    public String getIsVip() {
        return isVip;
    }

    public void setIsVip(String isVip) {
        this.isVip = isVip;
    }

    public String getParent() {
        return parent;
    }

    public void setParent(String parent) {
        this.parent = parent;
    }

    public BigDecimal getMoney() {
        return money;
    }

    public void setMoney(BigDecimal money) {
        this.money = money;
    }
}
