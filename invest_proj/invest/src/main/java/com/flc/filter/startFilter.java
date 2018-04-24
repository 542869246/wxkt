package com.flc.filter;

import java.io.IOException;
import java.net.UnknownHostException;
import java.util.List;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

import org.java_websocket.WebSocketImpl;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.flc.controller.base.BaseController;
import com.flc.plugin.websocketInstantMsg.ChatServer;
import com.flc.plugin.websocketOnline.OnlineChatServer;
import com.flc.service.arrange.arrange.impl.ArrangeService;
import com.flc.service.backstage.backstage.impl.BackstageService;
import com.flc.service.schedule.schedule.impl.ScheduleService;
import com.flc.service.school.school_email.impl.School_emailService;
import com.flc.service.webschedule.webschedule.impl.WebscheduleService;
import com.flc.util.Const;
import com.flc.util.PageData;
import com.flc.util.Tools;
import com.flc.util.mail.TimerTaskTest;
import com.flc.util.mail.TimerTest;

/**
 * 启动tomcat时运行此类
 * 创建人：FH FH QQ 313596790[青苔]
 * 创建时间：2014年2月17日
 * @version
 */
public class startFilter extends BaseController implements Filter{
	
	private BackstageService backstageService;
	
	

	public BackstageService getBackstageService() {
		return backstageService;
	}

	public void setBackstageService(BackstageService backstageService) {
		this.backstageService = backstageService;
	}

	/**
	 * 初始化
	 */
	public void init(FilterConfig fc) throws ServletException {
		this.startWebsocketInstantMsg();
		this.startWebsocketOnline();
		this.reductionDbBackupQuartzState();
		 //获得Spring容器
        WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(fc.getServletContext());
        //setScheduleService();
        PageData pd=new PageData();
       // pd=ctx.getBean(arg0);
        backstageService=ctx.getBean(BackstageService.class);
        try {
			pd= backstageService.listAll(pd).get(0);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        pd.put("scheduleService", ctx.getBean(ScheduleService.class));
        pd.put("arrangeService", ctx.getBean(ArrangeService.class));
        pd.put("webscheduleService", ctx.getBean(WebscheduleService.class));
        pd.put("school_emailService", ctx.getBean(School_emailService.class));
        this.timer(pd);//启动或关闭定时器
	}
	
	/**
	 * 启动即时聊天服务
	 */
	public void startWebsocketInstantMsg(){
		WebSocketImpl.DEBUG = false;
		ChatServer s;
		try {
			String strWEBSOCKET = Tools.readTxtFile(Const.WEBSOCKET);//读取WEBSOCKET配置,获取端口配置
			if(null != strWEBSOCKET && !"".equals(strWEBSOCKET)){
				String strIW[] = strWEBSOCKET.split(",fh,");
				if(strIW.length == 5){
					s = new ChatServer(Integer.parseInt(strIW[1]));
					s.start();
				}
			}
			//System.out.println( "websocket服务器启动,端口" + s.getPort() );
		} catch (UnknownHostException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 启动在线管理服务
	 */
	public void startWebsocketOnline(){
		WebSocketImpl.DEBUG = false;
		OnlineChatServer s;
		try {
			String strWEBSOCKET = Tools.readTxtFile(Const.WEBSOCKET);//读取WEBSOCKET配置,获取端口配置
			if(null != strWEBSOCKET && !"".equals(strWEBSOCKET)){
				String strIW[] = strWEBSOCKET.split(",fh,");
				if(strIW.length == 5){
					s = new OnlineChatServer(Integer.parseInt(strIW[3]));
					s.start();
				}
			}
			//System.out.println( "websocket服务器启动,端口" + s.getPort() );
		} catch (UnknownHostException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * web容器重启时，所有定时备份状态关闭
	 */
	public void reductionDbBackupQuartzState(){
		/*try {
			DbFH.executeUpdateFH("update DB_TIMINGBACKUP set STATUS = '2'");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}*/
	}
	
	/**
	 * 计时器(废弃)用quartz代替
	 * @param scheduleService 
	 */
	public void timer(PageData pd) {
		/*Calendar calendar = Calendar.getInstance();
		calendar.set(Calendar.HOUR_OF_DAY, 9); // 控制时
		calendar.set(Calendar.MINUTE, 0); 		// 控制分
		calendar.set(Calendar.SECOND, 0); 		// 控制秒
		Date time = calendar.getTime(); 		// 得出执行任务的时间
		Timer timer = new Timer();
		timer.scheduleAtFixedRate(new TimerTask() {
			public void run() {
				//PersonService personService = (PersonService)ApplicationContext.getBean("personService");
				//System.out.println("-------设定要指定任务--------");
			}
		}, time, 1000*60*60*24);// 这里设定将延时每天固定执行
		*/
		new TimerTest(pd);
	}
	
	public void destroy() {
		// TODO Auto-generated method stub
	}
	
	public void doFilter(ServletRequest arg0, ServletResponse arg1,
			FilterChain arg2) throws IOException, ServletException {
		// TODO Auto-generated method stub
	}
	
}
