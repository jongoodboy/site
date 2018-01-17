package com.thinkgem.jeesite.mother.m.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.mother.m.entity.ShoppingCat;

import java.util.List;
import java.util.Map;

/**
 * Created by wangJH on 2017/11/3.
 */
@MyBatisDao
public interface ShoppingCatDao extends CrudDao<ShoppingCat> {
    List<Map<String, Object>> findShoppingCatByUserId(String userId);

    int delShoppingCatByCommodityId(Map<String, Object> map);

    int delShoppingCar(List<String> list);
}
