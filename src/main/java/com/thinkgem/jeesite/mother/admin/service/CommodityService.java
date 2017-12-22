package com.thinkgem.jeesite.mother.admin.service;

import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.mother.admin.dao.CommodityDao;
import com.thinkgem.jeesite.mother.admin.entity.Commodity;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

/**
 * Created by wangJH on 2017/10/31.
 */
@Service
public class CommodityService extends CrudService<CommodityDao, Commodity> {
    @Resource
    CommodityDao commodityDao;

    //商城banner和精品推荐
    public List<Commodity> findAdvertising(Map<String, Object> map) {
        return commodityDao.findAdvertising(map);
    }

    //手机端分页查询数据
    public List<Commodity> findPageCommodity(Map<String, Object> map) {
        return commodityDao.findPageCommodity(map);
    }
    //特产列表
    public List<Commodity> specialtyCommodity(Map<String, Object> map) {
        return commodityDao.specialtyCommodity(map);
    }
}
