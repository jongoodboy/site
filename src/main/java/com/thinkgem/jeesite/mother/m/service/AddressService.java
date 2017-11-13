package com.thinkgem.jeesite.mother.m.service;

import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.mother.m.dao.ReceiptAddressDao;
import com.thinkgem.jeesite.mother.m.entity.ReceiptAddress;
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
public class AddressService extends CrudService<ReceiptAddressDao, ReceiptAddress> {
    @Resource
    ReceiptAddressDao receiptAddressDao;

    public List<ReceiptAddress> findListfByUserId(String userId) {
        return receiptAddressDao.findListfByUserId(userId);
    }

    public int updateDefault(Map<String, Object> map) {
        receiptAddressDao.removeAllByUserId(map);//清空所有默认地址
        return receiptAddressDao.updateDefault(map);
    }

    public int delDelAddress(String adddressId) {
        return receiptAddressDao.delDelAddress(adddressId);
    }

    public ReceiptAddress findListfById(String id) {
        return  receiptAddressDao.findListfById(id);
    }
    //个人默认地址
    public ReceiptAddress  findAddressByUserId(String userId){
        return  receiptAddressDao.findAddressByUserId(userId);
    }
}
