package com.thinkgem.jeesite.mother.m;

import org.apache.commons.collections.map.HashedMap;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by wangJH on 2017/11/23.
 */
public class DateUtils {
    /**
     * 获取当前月所有的周数和每周几号到几号
     *
     * @param thisDate
     * @return
     */
    public static List<Map<String, Object>> getWeek(String thisDate) {
        List<Map<String, Object>> listDateWeek = new ArrayList<Map<String, Object>>();
        try {
            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM");
            Date date1 = dateFormat.parse(thisDate);
            Calendar calendar = new GregorianCalendar();
            calendar.setTime(date1);
            int days = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);
            System.out.println("days:" + days);
            int count = 0;
            for (int i = 1; i <= days; i++) {
                Map<String, Object> mapDate = new HashedMap();
                DateFormat dateFormat1 = new SimpleDateFormat("yyyy-MM-dd");
                Date date2 = dateFormat1.parse(thisDate + "-" + i);
                calendar.clear();
                calendar.setTime(date2);
                int k = new Integer(calendar.get(Calendar.DAY_OF_WEEK));
                if (k == 1) {// 若当天是周日
                    count++;
                    System.out.println("-----------------------------------");
                    System.out.println("第" + count + "周");
                    if (i - 6 <= 1) {
                        System.out.println("本周开始日期:" + thisDate + "-" + 1);
                        mapDate.put("stateDate", thisDate + "-" + 1);
                    } else {
                        System.out.println("本周开始日期:" + thisDate + "-" + (i - 6));
                        mapDate.put("stateDate", thisDate + "-" + (i - 6));
                    }
                    System.out.println("本周结束日期:" + thisDate + "-" + i);
                    mapDate.put("endDate", thisDate + "-" + (i + 1));
                    System.out.println("-----------------------------------");
                }
                if (k != 1 && i == days) {// 若是本月最好一天，且不是周日
                    count++;
                    System.out.println("-----------------------------------");
                    System.out.println("第" + count + "周");
                    System.out.println("本周开始日期:" + thisDate + "-" + (i - k + 2));
                    mapDate.put("stateDate", thisDate + "-" + (i - k + 2));
                    System.out.println("本周结束日期:" + thisDate + "-" + i);
                    mapDate.put("endDate", thisDate + "-" + (i + 1));
                    System.out.println("-----------------------------------");
                }
                if (mapDate.size() > 0) {
                    listDateWeek.add(mapDate);//分周查询所收益
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return listDateWeek;
    }
}

