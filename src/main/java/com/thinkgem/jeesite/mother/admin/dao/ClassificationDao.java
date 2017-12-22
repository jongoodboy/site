package com.thinkgem.jeesite.mother.admin.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.mother.admin.entity.Classification;

/**
 * Created by wangJH on 2017/12/21.
 */
@MyBatisDao
public interface ClassificationDao extends CrudDao<Classification> {
}
