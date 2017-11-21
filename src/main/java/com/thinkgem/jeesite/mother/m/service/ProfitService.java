package com.thinkgem.jeesite.mother.m.service;

import com.thinkgem.jeesite.common.service.CrudService;
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

    public List<Map<String, Object>> findProfit(Map<String, Object> map) {
        String date = (String) map.get("toMonthFormat");
        List<Map<String, Object>> listDate = new ArrayList<Map<String, Object>>();//分周查询
        try {
            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM");
            Date date1 = dateFormat.parse(date);
            Calendar calendar = new GregorianCalendar();
            calendar.setTime(date1);
            int days = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);
            System.out.println("days:" + days);
            int count = 0;
            for (int i = 1; i <= days; i++) {
                Map<String, Object> mapDate = new HashedMap();
                DateFormat dateFormat1 = new SimpleDateFormat("yyyy-MM-dd");
                Date date2 = dateFormat1.parse(date + "-" + i);
                calendar.clear();
                calendar.setTime(date2);
                int k = new Integer(calendar.get(Calendar.DAY_OF_WEEK));
                if (k == 1) {// 若当天是周日
                    count++;
                    System.out.println("-----------------------------------");
                    System.out.println("第" + count + "周");
                    if (i - 6 <= 1) {
                        System.out.println("本周开始日期:" + date + "-" + 1);
                        mapDate.put("stateDate", date + "-" + 1);
                    } else {
                        System.out.println("本周开始日期:" + date + "-" + (i - 6));
                        mapDate.put("stateDate", date + "-" + (i - 7));
                    }
                    System.out.println("本周结束日期:" + date + "-" + i);
                    mapDate.put("endDate", date + "-" + (i+1));
                    System.out.println("-----------------------------------");
                }
                if (k != 1 && i == days) {// 若是本月最好一天，且不是周日
                    count++;
                    System.out.println("-----------------------------------");
                    System.out.println("第" + count + "周");
                    System.out.println("本周开始日期:" + date + "-" + (i - k + 2));
                    mapDate.put("stateDate", date + "-" + (i - k + 2));
                    System.out.println("本周结束日期:" + date + "-" + i);
                    mapDate.put("endDate", date + "-" + i);
                    System.out.println("-----------------------------------");
                }
                if (mapDate.size() > 0) {
                    listDate.add(mapDate);//分周查询所收益
                }
            }
            map.put("list", listDate);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return profitDao.findProfit(map);
    }
}
