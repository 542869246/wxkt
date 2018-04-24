package com.flc.util.mail;
import java.util.List;
import java.util.TimerTask;

import org.springframework.web.context.WebApplicationContext;

import com.flc.service.schedule.schedule.impl.ScheduleService;
import com.flc.service.school.school_email.impl.School_emailService;
import com.flc.util.PageData;
import com.flc.util.aLiYunSmsUtil;
/**
 * 定时处理的发送课表的任务
 * @author liyang
 *
 */
public class TimerTaskTest extends TimerTask {  
/*	@Resource(name="scheduleService")
	private ScheduleManager scheduleService;*/
	public TimerTaskTest(){
		// TODO Auto-generated constructor stub
	}
	private PageData pd;
	public PageData getPd() {
		return pd;
	}
	public void setPd(PageData pd) {
		this.pd = pd;
	}
	@Override  
    public void run(){
		ScheduleService scheduleService=(ScheduleService)pd.get("scheduleService");
		School_emailService school_emailService=(School_emailService)pd.get("school_emailService");
		List<PageData> emailList=null; 
		try {
			emailList=school_emailService.listAll(pd);//列出邮箱集合
			if(emailList.size()==0){
				return;
			}
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
    	List<PageData> varList=null;
    	/*String email=pd.getString("EMAIL_ADDRESS"); //获取邮箱
    	String pwd=pd.getString("EMAIL_PWD");*/
    	
    	String toEmail="";
    	String title="学鹿教育，明日课表";
    	String content="";
    	//String txtContent="";0
    	try {
			varList=scheduleService.listAllUserByTime(pd);//列出此第二天有课的老师
			if(varList==null){//此日期的课程没有老师  则return
				return;
			}
			for (int j=0;j< varList.size(); j++) {
				toEmail=varList.get(j).getString("EMAIL");
				content="<h3>亲爱的"+varList.get(j).getString("NAME")+"老师:</h3>";
				content+="&nbsp;&nbsp;&nbsp;&nbsp;您明日的课程:<br/>";
				List<PageData> listSche= scheduleService.listScheByUser(varList.get(j));  //列出老师第二天日期的课表
				if(listSche==null){
					return;
				}
				for (int i=0; i<listSche.size();i++) {//遍历查询出来的课表
					/*txtContent+=listSche.get(i).getString("COURSES_NAME");
					txtContent+=listSche.get(i).getString("LESSON_STARTTIME");
					txtContent+=listSche.get(i).getString("LESSON_ENDTIME");
					txtContent+=listSche.get(i).getString("LESSON_NAME");*/
					content+="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+listSche.get(i).getString("COURSES_NAME");
					content+="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+listSche.get(i).get("LESSON_STARTTIME").toString().substring(11, 16)+" - ";
					content+=listSche.get(i).get("LESSON_ENDTIME").toString().substring(11, 16)+"&nbsp;&nbsp;&nbsp;&nbsp;";
					content+="["+listSche.get(i).getString("SUBJECT_NAME")+"] &nbsp;&nbsp;";
					content+=listSche.get(i).get("LESSON_NAME")+"<br/>";
				}
				if(pd.getString("CHECK_EMAIL_SMS").equals("1") || pd.getString("CHECK_EMAIL_SMS").equals("1,2")){  //判断帐号设置表里选择的是 邮件还是短信发送1代表是邮件
					String email=emailList.get(j%emailList.size()).getString("EMAIL_ADDRESS");//获取邮箱
					String pwd=emailList.get(j%emailList.size()).getString("EMAIL_PWD");	//获取邮箱密码
					String smtp=""; //判断邮箱的类型  邮箱服务器设置
					if(email.substring(email.lastIndexOf("@")+1,email.lastIndexOf(".")).equals("qq")){//如果是QQ邮箱  设置为QQ邮箱的smtp
			    		smtp="smtp.qq.com";
			    	}else if(email.substring(email.lastIndexOf("@")+1,email.lastIndexOf(".")).equals("163")){
			    		smtp="smtp.163.com";
			    	}
					SimpleMailSender.sendEmail(smtp, "25", email, pwd, toEmail, title, content, "2");//循环发送邮件
				}
				if(pd.getString("CHECK_EMAIL_SMS").equals("2") || pd.getString("CHECK_EMAIL_SMS").equals("1,2")){//判断帐号设置表里选择的是 邮件还是短信发送 2代表是短信
					pd.put("phone", varList.get(j).getString("PHONE"));
					pd.put("name",varList.get(j).getString("NAME"));
					pd.put("type", "0");//代表老师短信模版类型
					//pd.put("txtContent", txtContent);
					if(pd.getString("TEACHER_SMS")==null){
						return;
					}
					aLiYunSmsUtil.aliSendSms(pd);//循环发送短信
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
    }  
}
