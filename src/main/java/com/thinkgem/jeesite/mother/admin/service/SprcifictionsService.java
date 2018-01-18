package com.thinkgem.jeesite.mother.admin.service;

import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.common.utils.IdGen;
import com.thinkgem.jeesite.mother.admin.dao.SprcifictionsDao;
import com.thinkgem.jeesite.mother.admin.entity.Specifications;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by wangJH on 2018/1/16.
 */
@Service
public class SprcifictionsService extends CrudService<SprcifictionsDao, Specifications> {
    @Resource
    SprcifictionsDao sprcifictionsDao;

    /**
     * 批量插入规格
     *
     * @param specificationsId            规格Id 用于修改
     * @param specificationsParameter     规格参数
     * @param specificationsCommodityPice 参数对应的价钱
     * @param commodityId                 商品Id
     * @return
     */
    @Transactional(readOnly = false)
    public int insertAll(String specificationsId, String specificationsParameter, String specificationsCommodityPice, String commodityId) {
        sprcifictionsDao.updateByCommodity(commodityId);
        List<Specifications> paramList = new ArrayList<Specifications>();
        String[] specificationsParameters = specificationsParameter.split(",");
        String[] specificationsCommodityPices = specificationsCommodityPice.split(",");
        int spIdsIndex = 0;
        if (specificationsId != null && !specificationsId.equals("")) {
            String[] specificationsIds = specificationsId.split(",");
            spIdsIndex = specificationsIds.length;
        }
        for (int i = spIdsIndex; i < specificationsParameters.length; i++) {
            Specifications s = new Specifications();
            s.setId(IdGen.uuid());
            s.setSpecificationsCommodityPice(new BigDecimal(specificationsCommodityPices[i]));
            s.setSpecificationsParameter(specificationsParameters[i]);
            s.setCommodityId(commodityId);
            paramList.add(s);
        }
        int index = 0;
        if (paramList.size() > 0) {
            index = sprcifictionsDao.insertAll(paramList);//批量插入
        }
        if (specificationsId != null && !specificationsId.equals("")) {
            String[] specificationsIds = specificationsId.split(",");
            List<Specifications> updateParamList = new ArrayList<Specifications>();
            for (int j = 0; j < specificationsIds.length; j++) {
                Specifications s = new Specifications();
                s.setId(specificationsIds[j]);
                s.setSpecificationsCommodityPice(new BigDecimal(specificationsCommodityPices[j]));
                s.setSpecificationsParameter(specificationsParameters[j]);
                s.setCommodityId(commodityId);
                updateParamList.add(s);
            }
            index = sprcifictionsDao.updateAll(updateParamList);//批量更新
        }


        return index;

    }

    //商品对应的所有规格
    public List<Specifications> findSprcifictionsList(String commodityId) {
        return sprcifictionsDao.findSprcifictionsList(commodityId);
    }
}
