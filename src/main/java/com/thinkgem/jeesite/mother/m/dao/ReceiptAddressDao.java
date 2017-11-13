package com.thinkgem.jeesite.mother.m.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.mother.m.entity.ReceiptAddress;

import java.util.List;
import java.util.Map;

/**
 * Created by wangJH on 2017/11/3.
 */
@MyBatisDao
public interface ReceiptAddressDao extends CrudDao<ReceiptAddress> {
    List<ReceiptAddress> findListfByUserId(String userId);

    int updateDefault(Map<String, Object> map);

    int removeAllByUserId(Map<String, Object> map);

    int delDelAddress(String adddressId);

    ReceiptAddress findListfById(String id);

    ReceiptAddress findAddressByUserId(String userId);
}
