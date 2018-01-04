package com.thinkgem.jeesite.mother.m.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.mother.m.entity.Bank;

import java.util.List;
import java.util.Map;

/**
 * Created by wangJH on 2017/11/3.
 */
@MyBatisDao
public interface BankDao extends CrudDao<Bank> {
    List<Bank> findListByUserId(String userId);

    int delBank(Map<String, Object> map);

    Bank findBankOne(Map<String, Object> map);
}
