package com.thinkgem.jeesite.mother.admin.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.mother.admin.entity.Specifications;

import java.util.List;

/**
 * Created by wangJH on 2018/1/16.
 */
@MyBatisDao
public interface SprcifictionsDao extends CrudDao<Specifications> {
    int insertAll(List<Specifications> list);

    int deleteBycommodityId(String commodityId);

    int updateAll(List<Specifications> list);

    List<Specifications> findSprcifictionsList(String commodityId);
}
