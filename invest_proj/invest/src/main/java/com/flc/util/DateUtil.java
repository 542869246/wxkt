package com.flc.util;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

/** 
 * 说明：日期处理
 * 创建人：FLC
 * 修改时间：2015年11月24日
 * @version
 */
public class DateUtil {
	
	private final static SimpleDateFormat sdfYear = new SimpleDateFormat("yyyy");
	private final static SimpleDateFormat sdfDay = new SimpleDateFormat("yyyy-MM-dd");
	private final static SimpleDateFormat sdfDays = new SimpleDateFormat("yyyyMMdd");
	private final static SimpleDateFormat sdfTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	private final static SimpleDateFormat sdfTimes = new SimpleDateFormat("yyyyMMddHHmmss");
	private static final int FIRST_DAY = Calendar.MONDAY; 

	/**
	 * 获取YYYY格式
	 * @return
	 */
	public static String getSdfTimes() {
		return sdfTimes.format(new Date());
	}
	
	/**
	 * 获取YYYY格式
	 * @return
	 */
	public static String getYear() {
		return sdfYear.format(new Date());
	}

	/**
	 * 获取YYYY-MM-DD格式
	 * @return
	 */
	public static String getDay() {
		return sdfDay.format(new Date());
	}
	
	/**
	 * 获取YYYYMMDD格式
	 * @return
	 */
	public static String getDays(){
		return sdfDays.format(new Date());
	}

	/**
	 * 获取YYYY-MM-DD HH:mm:ss格式
	 * @return
	 */
	public static String getTime() {
		return sdfTime.format(new Date());
	}

	/**
	* @Title: compareDate
	* @Description: TODO(日期比较，如果s>=e 返回true 否则返回false)
	* @param s
	* @param e
	* @return boolean  
	* @throws
	* @author fh
	 */
	public static boolean compareDate(String s, String e) {
		if(fomatDate(s)==null||fomatDate(e)==null){
			return false;
		}
		return fomatDate(s).getTime() >=fomatDate(e).getTime();
	}

	/**
	 * 格式化日期
	 * @return
	 */
	public static Date fomatDate(String date) {
		DateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
		try {
			return fmt.parse(date);
		} catch (ParseException e) {
			e.printStackTrace();
			return null;
		}
	}

	/**
	 * 校验日期是否合法
	 * @return
	 */
	public static boolean isValidDate(String s) {
		DateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
		try {
			fmt.parse(s);
			return true;
		} catch (Exception e) {
			// 如果throw java.text.ParseException或者NullPointerException，就说明格式不对
			return false;
		}
	}
	
	/**
	 * @param startTime
	 * @param endTime
	 * @return
	 */
	public static int getDiffYear(String startTime,String endTime) {
		DateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
		try {
			//long aa=0;
			int years=(int) (((fmt.parse(endTime).getTime()-fmt.parse(startTime).getTime())/ (1000 * 60 * 60 * 24))/365);
			return years;
		} catch (Exception e) {
			// 如果throw java.text.ParseException或者NullPointerException，就说明格式不对
			return 0;
		}
	}
	 
	/**
     * <li>功能描述：时间相减得到天数
     * @param beginDateStr
     * @param endDateStr
     * @return
     * long 
     * @author Administrator
     */
    public static long getDaySub(String beginDateStr,String endDateStr){
        long day=0;
        java.text.SimpleDateFormat format = new java.text.SimpleDateFormat("yyyy-MM-dd");
        java.util.Date beginDate = null;
        java.util.Date endDate = null;
        
            try {
				beginDate = format.parse(beginDateStr);
				endDate= format.parse(endDateStr);
			} catch (ParseException e) {
				e.printStackTrace();
			}
            day=(endDate.getTime()-beginDate.getTime())/(24*60*60*1000);
            //System.out.println("相隔的天数="+day);
      
        return day;
    }
    
    /**
     * 得到n天之后的日期
     * @param days
     * @return
     */
    public static String getAfterDayDate(String days) {
    	int daysInt = Integer.parseInt(days);
    	
        Calendar canlendar = Calendar.getInstance(); // java.util包
        canlendar.add(Calendar.DATE, daysInt); // 日期减 如果不够减会将月变动
        Date date = canlendar.getTime();
        
        SimpleDateFormat sdfd = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String dateStr = sdfd.format(date);
        
        return dateStr;
    }
    
    
    /**
     * 得到指定日期n天之后的日期
     * @param days
     * @return
     */
    public static Date getDateAfterDayDate(String days,Date date) {
    	int daysInt = Integer.parseInt(days);
    	
        Calendar canlendar = Calendar.getInstance(); // java.util包
        canlendar.setTime(date);
        canlendar.add(Calendar.DATE, daysInt); // 日期减 如果不够减会将月变动
        Date d = canlendar.getTime();
        
        return d;
    }
    
    /**
     * 得到n天之后是周几
     * @param days
     * @return
     */
    public static String getAfterDayWeek(String days) {
    	int daysInt = Integer.parseInt(days);
        Calendar canlendar = Calendar.getInstance(); // java.util包
        canlendar.add(Calendar.DATE, daysInt); // 日期减 如果不够减会将月变动
        Date date = canlendar.getTime();
        SimpleDateFormat sdf = new SimpleDateFormat("E");
        String dateStr = sdf.format(date);
        return dateStr;
    }
    
    /**
     * 根据当前日期获取本周所有日期
     * @return
     */
    public static ArrayList<String> dateList(Date time) {
    Calendar cal = Calendar.getInstance(); 
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); 
    Date d;
	try {
		d = sdf.parse("2017-12-1");
		cal.setTime(d);
	} catch (ParseException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
    ArrayList<String> list = new  ArrayList<String>();
    int date = cal.get(Calendar.DAY_OF_MONTH); 
    int n = cal.get(Calendar.DAY_OF_WEEK);

    if (n == 1) { n = 7; } else { n = n - 1; } 
    for (int i = 1; i <= 7; i++) {
    cal.set(Calendar.DAY_OF_MONTH, date + i - n); 
    list.add(i-1, sdf.format(cal.getTime()));
    System.out.println(cal.getTime());
    } 
    return  list;
    }
    private static void setToFirstDay(Calendar calendar) {  
        while (calendar.get(Calendar.DAY_OF_WEEK) != FIRST_DAY) {  
            calendar.add(Calendar.DATE, -1);  
        }  
    }
    private static String  printDay(Calendar calendar) {  
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");  
        return dateFormat.format(calendar.getTime());  
    } 
    public static List<String> getAllweekDays(Date d) {//根据日期来获取其所在周的每一天  
        Calendar c = Calendar.getInstance();  
       List<String> lst=new ArrayList<String>();  
        c.setTime(d);  
        setToFirstDay(c);  
        for (int i = 0; i < 7; i++) {  
            String day = printDay(c);  
            lst.add(day);  
            c.add(Calendar.DATE, 1);  
        }  
        return lst;  
    }
    public static String getWeekStartDay(Date d) {//根据日期来获取一周的第一天  
        Calendar c = Calendar.getInstance();  
       List <String>lst=new ArrayList<String>();  
        c.setTime(d);  
        setToFirstDay(c);  
        for (int i = 0; i < 7; i++) {  
            String day = printDay(c);  
            lst.add(day);  
            c.add(Calendar.DATE, 1);  
        }  
        return lst.get(0);  
    }
    public static String getWeekEndtDay(Date d) {//根据日期来获取一周的最后一天  
        Calendar c = Calendar.getInstance();  
       List <String>lst=new ArrayList<String>();  
        c.setTime(d);  
        setToFirstDay(c);  
        for (int i = 0; i < 7; i++) {  
            String day = printDay(c);  
            lst.add(day);  
            c.add(Calendar.DATE, 1);  
        }  
        return lst.get(6);  
    } 
    
    public static void main(String[] args) {
    	System.out.println(getDays());
    	System.out.println(getAfterDayWeek("0"));
    }

}
