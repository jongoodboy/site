package com.thinkgem.jeesite.mother.m.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.mother.m.entity.Muser;

import java.util.List;
import java.util.Map;

/**
 * Created by wangJH on 2017/11/3.
 */
@MyBatisDao
public interface MuserDao extends CrudDao<Muser> {
    Muser findUser(Map<String, Object> map);
    int updateUserIsVIP(Map<String, Object> map);
    Muser verification(String phone);
    Map<String,Object> findCode(String code);
    int updateMoney(List<Map<String,Object>> list);
}
