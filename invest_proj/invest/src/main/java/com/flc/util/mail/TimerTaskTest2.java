package com.flc.util.mail;
import java.util.List;
import java.util.TimerTask;

import org.springframework.web.context.WebApplicationContext;

import com.flc.service.arrange.arrange.impl.ArrangeService;
import com.flc.service.course.course.impl.CourseService;
import com.flc.service.schedule.schedule.impl.ScheduleService;
import com.flc.service.school.school_email.impl.School_emailService;
import com.flc.service.student.student.impl.StudentService;
import com.flc.service.webschedule.webschedule.impl.WebscheduleService;
import com.flc.util.PageData;
import com.flc.util.aLiYunSmsUtil;
/**
 * 定时处理的发送未评价课程的任务
 * @author liyang
 *
 */
public class TimerTaskTest2 extends TimerTask{  
/*	@Resource(name="scheduleService")
	private ScheduleManager scheduleService;*/
	public TimerTaskTest2() {
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
		ScheduleService scheduleService=(ScheduleService) pd.get("scheduleService");
		ArrangeService arrangeService=(ArrangeService)pd.get("arrangeService");;
		WebscheduleService webscheduleService= (WebscheduleService) pd.get("webscheduleService");
		School_emailService school_emailService=(School_emailService)pd.get("school_emailService");
		
		try {
			List<PageData> emailList=school_emailService.listAll(pd);//列出邮箱集合
			List<PageData> teacherList=scheduleService.listTeacherByTime(pd); //查询今日有课的老师
			/*String email=pd.getString("EMAIL_ADDRESS"); //获取邮箱
	    	String pwd=pd.getString("EMAIL_PWD");*/
	    	/*if(email.substring(email.lastIndexOf("@")+1,email.lastIndexOf(".")).equals("qq")){//如果是QQ邮箱  设置为QQ邮箱的smtp
	    		smtp="smtp.qq.com";
	    	}else if(email.substring(email.lastIndexOf("@")+1,email.lastIndexOf(".")).equals("163")){
	    		smtp="smtp.163.com";
	    	}*/
	    	String toEmail="";
	    	String title="学鹿教育，未评价课程";
	    	String content="";
	    	//String txtContent="";
	    	for (int j=0; j<teacherList.size(); j++) {
				List<PageData> scheList= scheduleService.listScheByTime(pd);//查询今日课表下的课程和老师
				if(scheList==null){
					continue;
				}
				boolean result=false;
				toEmail=teacherList.get(j).getString("EMAIL");
				content="<h3>亲爱的"+teacherList.get(j).getString("NAME")+"老师:</h3>";
				for (PageData sche : scheList) {
					boolean flag=true;
					List<PageData> listStu=arrangeService.listAll(sche);//遍历学生集合
					if(listStu.size()==0){   //如果这个课程下的学生为0    跳出当前循环 继续下一个循环课程
						continue;
					}
					for (PageData pageData2 : listStu) {
						List<PageData> listWebSche=webscheduleService.findSizeByStudent(pageData2);//遍历查询到的学生  根据学生ID查询日程表是否有数据
						if(listWebSche.size()>0){  //查询到学生下面今天有日程记录的话   continue继续查询下一个学生
							flag=false;
							break;
						}
					}
					if(flag){
						result=true;
						content+="&nbsp;&nbsp;&nbsp;&nbsp;您今日的有"+sche.getString("COURSES_NAME")+"未评价，请及时评价此课程。<br/>";
					}
				}
					if(result){
					//txtContent="您今日的有"+scheList.get(j).getString("COURSES_NAME")+"未评价，请及时评价此课程。";
					if(pd.getString("CHECK_EMAIL_SMS").equals("1") || pd.getString("CHECK_EMAIL_SMS").equals("1,2")){ //判断帐号设置表里选择的是 邮件还是短信发送 1代表是邮件
						String email=emailList.get(j%emailList.size()).getString("EMAIL_ADDRESS");//获取邮箱    邮箱的循环发送
						String pwd=emailList.get(j%emailList.size()).getString("EMAIL_PWD");	//获取邮箱密码
						String smtp=""; //判断邮箱的类型  邮箱服务器设置
						if(email.substring(email.lastIndexOf("@")+1,email.lastIndexOf(".")).equals("qq")){//如果是QQ邮箱  设置为QQ邮箱的smtp
				    		smtp="smtp.qq.com";
				    	}else if(email.substring(email.lastIndexOf("@")+1,email.lastIndexOf(".")).equals("163")){
				    		smtp="smtp.163.com";
				    	}
						SimpleMailSender.sendEmail(smtp, "25", email, pwd, toEmail, title, content, "2");
					}
				
					if(pd.getString("CHECK_EMAIL_SMS").equals("2") || pd.getString("CHECK_EMAIL_SMS").equals("1,2")){//判断帐号设置表里选择的是 邮件还是短信发送2代表是短信
						pd.put("phone", teacherList.get(j).getString("PHONE"));
						pd.put("name",teacherList.get(j).getString("NAME")+"1");
						pd.put("type", "0");//代表老师短信模版类型
						//pd.put("txtContent", txtContent);
						if(pd.getString("TEACHER_SMS")==null){
							return;
						}
						aLiYunSmsUtil.aliSendSms(pd);//循环发送短信
					}
				}
	    	}
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }  
}
