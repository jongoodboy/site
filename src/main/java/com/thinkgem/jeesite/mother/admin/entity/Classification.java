package com.thinkgem.jeesite.mother.admin.entity;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;

/**
 * Created by wangJH on 2017/12/21.
 */
@MyBatisDao
public class Classification extends DataEntity<Classification> {
    private String commodityClassificationName;//商品分类名称
    private String commodityClassificationParant;//分类的父级(如贵州地区)
    private String commodityClassificationThumbnail;//地区特产缩略图

    public String getCommodityClassificationThumbnail() {
        return commodityClassificationThumbnail;
    }

    public void setCommodityClassificationThumbnail(String commodityClassificationThumbnail) {
        this.commodityClassificationThumbnail = commodityClassificationThumbnail;
    }

    public String getCommodityClassificationName() {
        return commodityClassificationName;
    }

    public void setCommodityClassificationName(String commodityClassificationName) {
        this.commodityClassificationName = commodityClassificationName;
    }

    public String getCommodityClassificationParant() {
        return commodityClassificationParant;
    }

    public void setCommodityClassificationParant(String commodityClassificationParant) {
        this.commodityClassificationParant = commodityClassificationParant;
    }
}
