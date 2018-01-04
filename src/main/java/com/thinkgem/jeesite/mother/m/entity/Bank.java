package com.thinkgem.jeesite.mother.m.entity;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * Created by wangJH on 2017/11/3.
 * 银行卡
 */
public class Bank extends DataEntity<Bank> {

    private String cardNumber;//银行卡号
    private String bankAddress;//银行卡开户行
    private String idCard;//身份证号
    private String stayBankPhone;//预留在银行电话
    private String cardName;//银行卡号对应姓名
    private String password;//取现密码
    private String bankName;//所属银行
    private String cardType;//银行卡类型 如借记卡，储蓄卡

    public String getCardType() {
        return cardType;
    }

    public void setCardType(String cardType) {
        this.cardType = cardType;
    }

    public String getBankName() {
        return bankName;
    }

    public void setBankName(String bankName) {
        this.bankName = bankName;
    }

    public String getCardNumber() {
        return cardNumber;
    }

    public void setCardNumber(String cardNumber) {
        this.cardNumber = cardNumber;
    }

    public String getBankAddress() {
        return bankAddress;
    }

    public void setBankAddress(String bankAddress) {
        this.bankAddress = bankAddress;
    }

    public String getIdCard() {
        return idCard;
    }

    public void setIdCard(String idCard) {
        this.idCard = idCard;
    }

    public String getStayBankPhone() {
        return stayBankPhone;
    }

    public void setStayBankPhone(String stayBankPhone) {
        this.stayBankPhone = stayBankPhone;
    }

    public String getCardName() {
        return cardName;
    }

    public void setCardName(String cardName) {
        this.cardName = cardName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
