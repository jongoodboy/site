package com.thinkgem.jeesite.mother.m.service;

import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.mother.m.dao.MuserDao;
import com.thinkgem.jeesite.mother.m.entity.Muser;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.Map;

/**
 * Created by wangJH on 2017/11/3.
 */
@Service
public class MuserService extends CrudService<MuserDao,Muser> {
    @Resource
    MuserDao muserDao;
    public Muser findUser(Map<String,Object> map){
       return muserDao.findUser(map);
    }
    public Muser verification(String phone){
        return muserDao.verification(phone);
    }
    //注销登录或二次登录
    @Transactional(readOnly = false)
    public int loginOutOrLogin(Map<String,Object> map){
        return muserDao.loginOutOrLogin(map);
    };
}
