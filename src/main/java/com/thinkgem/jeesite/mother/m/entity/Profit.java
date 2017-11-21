package com.thinkgem.jeesite.mother.m.entity;

import com.thinkgem.jeesite.common.persistence.DataEntity;

import java.math.BigDecimal;
import java.util.Date;

/**
 * Created by wangJH on 2017/11/21.
 * 收益
 */
public class Profit extends DataEntity<Profit> {
    private String profitOrderNumber;//产生收益的订单号
    private String profitCommodityId;//产生收益的商品id
    private String profitUserId;//收益人的Id
    private BigDecimal profitMoney;//产生收益的金额
    private Date profitDate;//产生收益时间
    private String profitState;//收益状态0正常收益1异常退款扣除收益
    private String profitRemak;//收益描述
    private String feeDeduction;//扣除收益描述
    private String incomeProportion;//所占比例2%或8%

    public String getIncomeProportion() {
        return incomeProportion;
    }

    public void setIncomeProportion(String incomeProportion) {
        this.incomeProportion = incomeProportion;
    }

    public String getProfitOrderNumber() {
        return profitOrderNumber;
    }

    public void setProfitOrderNumber(String profitOrderNumber) {
        this.profitOrderNumber = profitOrderNumber;
    }

    public String getProfitCommodityId() {
        return profitCommodityId;
    }

    public void setProfitCommodityId(String profitCommodityId) {
        this.profitCommodityId = profitCommodityId;
    }

    public String getProfitUserId() {
        return profitUserId;
    }

    public void setProfitUserId(String profitUserId) {
        this.profitUserId = profitUserId;
    }

    public BigDecimal getProfitMoney() {
        return profitMoney;
    }

    public void setProfitMoney(BigDecimal profitMoney) {
        this.profitMoney = profitMoney;
    }

    public Date getProfitDate() {
        return profitDate;
    }

    public void setProfitDate(Date profitDate) {
        this.profitDate = profitDate;
    }

    public String getProfitState() {
        return profitState;
    }

    public void setProfitState(String profitState) {
        this.profitState = profitState;
    }

    public String getProfitRemak() {
        return profitRemak;
    }

    public void setProfitRemak(String profitRemak) {
        this.profitRemak = profitRemak;
    }

    public String getFeeDeduction() {
        return feeDeduction;
    }

    public void setFeeDeduction(String feeDeduction) {
        this.feeDeduction = feeDeduction;
    }
}
