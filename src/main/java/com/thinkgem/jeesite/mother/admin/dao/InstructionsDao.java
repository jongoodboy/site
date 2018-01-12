package com.thinkgem.jeesite.mother.admin.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.mother.admin.entity.Instructions;

import java.util.List;

/**
 * Created by wangJH on 2018/1/11.
 */

@MyBatisDao
public interface InstructionsDao extends CrudDao<Instructions> {
    List<Instructions> findByInstructionsType(String instructionsType);
}
