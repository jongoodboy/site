package com.thinkgem.jeesite.mother.admin.service;

import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.mother.admin.dao.InstructionsDao;
import com.thinkgem.jeesite.mother.admin.entity.Instructions;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by wangJH on 2018/1/11.
 */
@Service
public class InstructionsService extends CrudService<InstructionsDao, Instructions> {
    @Resource
    InstructionsDao instructionsDao;

    public List<Instructions> findByInstructionsType(String instructionsType) {
        return instructionsDao.findByInstructionsType(instructionsType);
    }
}
