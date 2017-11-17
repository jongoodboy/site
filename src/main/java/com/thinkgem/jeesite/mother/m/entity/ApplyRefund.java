package com.thinkgem.jeesite.mother.m.entity;

import com.thinkgem.jeesite.common.persistence.DataEntity;

import java.math.BigDecimal;

/**
 * Created by wangJH on 2017/11/17.
 * 退款申请
 */
public class ApplyRefund extends DataEntity<ApplyRefund> {
    private String applyOrderNumber;//退款申请的订单号
    private BigDecimal applyMoney;//退款申请的金额
    private String refuntState;//申请退款状态(0退款成功,1退款中,-1退款失败)
    private String applyDescribe;//申请退款描述
    private String refundDescribe;//退款处理描述

    public String getApplyOrderNumber() {
        return applyOrderNumber;
    }

    public void setApplyOrderNumber(String applyOrderNumber) {
        this.applyOrderNumber = applyOrderNumber;
    }

    public BigDecimal getApplyMoney() {
        return applyMoney;
    }

    public void setApplyMoney(BigDecimal applyMoney) {
        this.applyMoney = applyMoney;
    }

    public String getRefuntState() {
        return refuntState;
    }

    public void setRefuntState(String refuntState) {
        this.refuntState = refuntState;
    }

    public String getApplyDescribe() {
        return applyDescribe;
    }

    public void setApplyDescribe(String applyDescribe) {
        this.applyDescribe = applyDescribe;
    }

    public String getRefundDescribe() {
        return refundDescribe;
    }

    public void setRefundDescribe(String refundDescribe) {
        this.refundDescribe = refundDescribe;
    }
}
