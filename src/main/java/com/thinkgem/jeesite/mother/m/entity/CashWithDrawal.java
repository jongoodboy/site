package com.thinkgem.jeesite.mother.m.entity;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.common.utils.excel.annotation.ExcelField;

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
    private BigDecimal balance;//用户余额
    private String remarks;//财务操作描述
    private String bankName;//所属银行
    private String operator;//转账操作人

    public String getOperator() {
        return operator;
    }

    public void setOperator(String operator) {
        this.operator = operator;
    }

    @ExcelField(title = "所属银行", align = 2, sort = 5)
    public String getBankName() {
        return bankName;
    }

    public void setBankName(String bankName) {
        this.bankName = bankName;
    }

    @ExcelField(title = "银行卡号", align = 2, sort = 10)
    public String getBankNumber() {
        return bankNumber;
    }

    public void setBankNumber(String bankNumber) {
        this.bankNumber = bankNumber;
    }

    @ExcelField(title = "银行开户行", align = 2, sort = 20)
    public String getBankAddress() {
        return bankAddress;
    }

    public void setBankAddress(String bankAddress) {
        this.bankAddress = bankAddress;
    }

    @ExcelField(title = "持卡人姓名", align = 2, sort = 30)
    public String getBankNumberName() {
        return bankNumberName;
    }

    public void setBankNumberName(String bankNumberName) {
        this.bankNumberName = bankNumberName;
    }

    @ExcelField(title = "提现金额",align = 2, sort = 9000)
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
