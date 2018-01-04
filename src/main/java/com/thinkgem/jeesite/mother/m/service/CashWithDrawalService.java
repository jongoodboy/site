package com.thinkgem.jeesite.mother.m.service;

import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.mother.m.dao.CashWithDrawalDao;
import com.thinkgem.jeesite.mother.m.entity.CashWithDrawal;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.Map;

/**
 * Created by wangJH on 2017/11/3.
 */
@Service
public class CashWithDrawalService extends CrudService<CashWithDrawalDao, CashWithDrawal> {
    @Resource
    CashWithDrawalDao cashWithDrawalDao;

    @Transactional(readOnly = false)
    public int updateByBalance(Map<String, Object> map) {
        return cashWithDrawalDao.upByBalance(map);
    }
}
