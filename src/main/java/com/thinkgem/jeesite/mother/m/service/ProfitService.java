package com.thinkgem.jeesite.mother.m.service;

import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.mother.m.DateUtils;
import com.thinkgem.jeesite.mother.m.dao.ProfitDao;
import com.thinkgem.jeesite.mother.m.entity.Profit;
import org.apache.commons.collections.map.HashedMap;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by wangJH on 2017/11/21.
 */
@Service
public class ProfitService extends CrudService<ProfitDao, Profit> {
    @Resource
    ProfitDao profitDao;

    //店铺收益
    public List<Map<String, Object>> findProfit(Map<String, Object> map) {
        String date = (String) map.get("toMonthFormat");
        List<Map<String, Object>> listWeek = DateUtils.getWeek(date);
        map.put("list", listWeek);
        return profitDao.findProfit(map);
    }

    //本月收益详情
    public List<List<Map<String, Object>>> monthProfitDetail(String userId) {
        List<List<Map<String, Object>>> returnList = new ArrayList<List<Map<String, Object>>>();
        Date dateProfit = new Date();
        SimpleDateFormat toMonthFormat = new SimpleDateFormat("yyyy-MM");//当月收益
        String toMonthProfit = toMonthFormat.format(dateProfit);
        List<Map<String, Object>> listWeek = DateUtils.getWeek(toMonthProfit);
        if (listWeek != null && listWeek.size() > 0) {
            for (int i = 0; i < listWeek.size(); i++) {
                Map<String, Object> paramMap = new HashedMap();
                paramMap.put("stateDate", listWeek.get(i).get("stateDate"));
                paramMap.put("endDate", listWeek.get(i).get("endDate"));
                paramMap.put("userId",userId);
                returnList.add(profitDao.monthProfitDetail(paramMap));
            }
        }
        return returnList;
    }
}
