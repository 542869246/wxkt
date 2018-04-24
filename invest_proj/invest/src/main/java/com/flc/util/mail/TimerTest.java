package com.flc.util.mail;
import java.util.Calendar;
import java.util.Date;
import java.util.Timer;

import com.flc.util.PageData;
/**
 * 触发器  配置时间   每天的某时间触发
 * @author liyang
 *
 */
public class TimerTest {  
    Timer timer;  
      
    public TimerTest(PageData pd){ 
    	timer = new Timer();
    	if(pd.getString("CHECK_EMAIL_SMS")==null){
    		return;
    	}
    	if(pd.get("EMAIL_SCHEDULE_TIME")!=null &&!"".equals(pd.get("EMAIL_SCHEDULE_TIME"))){
    		Date time = getTime(pd.get("EMAIL_SCHEDULE_TIME").toString()); 
    		System.out.println("指定时间time=" + time);  
    		TimerTaskTest tt=new TimerTaskTest();//创建执行发送课表的任务对象
    		tt.setPd(pd);
    		timer.schedule(tt,time,24*60*60*1000);  //启动发送课表的定时任务
    	}
    	if(pd.get("EMAIL_WEB_SCHEDULE_TIME")!=null &&!"".equals(pd.get("EMAIL_WEB_SCHEDULE_TIME"))){
    		Date time = getTime(pd.get("EMAIL_WEB_SCHEDULE_TIME").toString()); 
    		System.out.println("指定时间time=" + time);  
    		TimerTaskTest2 tt=new TimerTaskTest2();//创建执行发送未评价课程的任务对象
    		tt.setPd(pd);
    		timer.schedule(tt,time,24*60*60*1000);  //启动发送未评价课程的定时任务
    	}
    	return;
    }  
      
    public Date getTime(String date){  
        Calendar calendar = Calendar.getInstance();
        String str[]=date.split(":");//把传过来的时间拆分出来小时和分钟
        calendar.set(Calendar.HOUR_OF_DAY, Integer.parseInt(str[0]));  //小时
        calendar.set(Calendar.MINUTE, Integer.parseInt(str[1]));  	//分钟
        calendar.set(Calendar.SECOND, Integer.parseInt(str[2]));  	//秒 
        Date time = calendar.getTime();  
        return time;  
    }  
    public TimerTest(){
    	
    }
    public static void main(String[] args) {  
        new TimerTest();  
    }  
}  
  
