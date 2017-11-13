package com.thinkgem.jeesite.mother.m.entity;

import com.thinkgem.jeesite.common.persistence.DataEntity;

import java.math.BigDecimal;

/**
 * Created by wangJH on 2017/11/3.
 * //提现
 */
public class CashWithDrawal extends DataEntity<CashWithDrawal> {
    private String bankNumber;//银行卡号
    private String bankAddress;//银行开户行
    private String bankNumberName;//银行卡号对应的姓名
    private BigDecimal getCash;//提取金额
    private BigDecimal balance;//用户账用余额
    private String remarks;//财务操作描述

    public String getBankNumber() {
        return bankNumber;
    }

    public void setBankNumber(String bankNumber) {
        this.bankNumber = bankNumber;
    }

    public String getBankAddress() {
        return bankAddress;
    }

    public void setBankAddress(String bankAddress) {
        this.bankAddress = bankAddress;
    }

    public String getBankNumberName() {
        return bankNumberName;
    }

    public void setBankNumberName(String bankNumberName) {
        this.bankNumberName = bankNumberName;
    }

    public BigDecimal getGetCash() {
        return getCash;
    }

    public void setGetCash(BigDecimal getCash) {
        this.getCash = getCash;
    }

    public BigDecimal getBalance() {
        return balance;
    }

    public void setBalance(BigDecimal balance) {
        this.balance = balance;
    }

    @Override
    public String getRemarks() {
        return remarks;
    }

    @Override
    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }
}
