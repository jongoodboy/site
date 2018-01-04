package com.thinkgem.jeesite.mother.m.service;

import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.mother.m.dao.BankDao;
import com.thinkgem.jeesite.mother.m.entity.Bank;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

/**
 * Created by wangJH on 2017/11/3.
 */
@Service
public class BankService extends CrudService<BankDao, Bank> {
    @Resource
    private BankDao bankDao;
    public List<Bank> findListByUserId(String userId) {
        return bankDao.findListByUserId( userId);
    }
    @Transactional(readOnly = false)
    public int delBank(Map<String,Object> map){
        return bankDao.delBank(map);
    }
    public Bank findBankOne(Map<String, Object> map){
        return bankDao.findBankOne(map);
    }
}
