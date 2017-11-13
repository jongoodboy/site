package com.thinkgem.jeesite.mother.m.service;

import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.mother.m.dao.ShoppingCatDao;
import com.thinkgem.jeesite.mother.m.entity.ShoppingCat;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

/**
 * Created by wangJH on 2017/11/3.
 */
@Service
@Transactional(readOnly = false)
public class ShoppingCatService extends CrudService<ShoppingCatDao, ShoppingCat> {
    @Resource
    ShoppingCatDao shoppingCatDao;

    //查看个人购物车列表
    public List<Map<String, Object>> findShoppingCatByUserId(String userId) {
        return shoppingCatDao.findShoppingCatByUserId(userId);
    }

    //生成订单后把原来在购物车的商品标记删除
    public int delShoppingCatByCommodityId(Map<String,Object> map) {
        return shoppingCatDao.delShoppingCatByCommodityId(map);
    }
}
