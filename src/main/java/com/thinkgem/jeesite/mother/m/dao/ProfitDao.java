package com.thinkgem.jeesite.mother.m.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.mother.m.entity.Profit;

import java.util.List;
import java.util.Map;

/**
 * Created by wangJH on 2017/11/21.
 */
@MyBatisDao
public interface ProfitDao extends CrudDao<Profit> {
    int insertList(List<Profit> list);

    List<Map<String, Object>> findProfit(Map<String, Object> map);

    List<Map<String, Object>> monthProfitDetail(Map<String, Object> map);

    List<Map<String, Object>> findReFundByOrderNumberAndCommodityId(Map<String, Object> map);

    int subtraction(List<Map<String, Object>> list);

    int profitLoss(List<Map<String, Object>> list);

}
