package com.thinkgem.jeesite.mother.admin.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.mother.admin.entity.Commodity;

/**
 * Created by wangJH on 2017/10/31.
 * 商品Dao
 */
@MyBatisDao
public interface CommodityDao extends CrudDao<Commodity> {
}
