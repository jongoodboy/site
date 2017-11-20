package com.thinkgem.jeesite.mother.m.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.mother.m.entity.ApplyRefund;

import java.util.Map;

/**
 * Created by wangJH on 2017/11/17.
 */
@MyBatisDao
public interface ApplyRefundDao extends CrudDao<ApplyRefund> {
    int updateFund(Map<String, Object> map);
}
