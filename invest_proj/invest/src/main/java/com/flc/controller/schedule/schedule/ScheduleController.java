package com.flc.controller.schedule.schedule;

import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.flc.controller.base.BaseController;
import com.flc.entity.Page;
import com.flc.service.schedule.schedule.ScheduleManager;
import com.flc.service.school.classroom.ClassroomManager;
import com.flc.service.school.courses.CoursesManager;
import com.flc.service.school.courses_subject.Courses_subjectManager;
import com.flc.service.school.school_lesson_time.School_lesson_timeManager;
import com.flc.service.school.subject.SubjectManager;
import com.flc.service.system.user.UserManager;
import com.flc.util.AppUtil;
import com.flc.util.DateUtil;
import com.flc.util.Jurisdiction;
import com.flc.util.ObjectExcelView;
import com.flc.util.PageData;

/** 
 * 说明：课表(老师)
 * 创建人：FLC
 * 创建时间：2017-12-05
 */
@Controller
@RequestMapping(value="/schedule")
public class ScheduleController extends BaseController {
	
	String menuUrl = "schedule/list.do"; //菜单地址(权限用)
	@Resource(name="scheduleService")
	private ScheduleManager scheduleService;
	@Resource(name="userService")
	private UserManager userService;
	
	@Resource(name="coursesService")
	private CoursesManager coursesService;
	@Resource(name="subjectService")
	private SubjectManager subjectService;
	
	@Resource(name="classroomService")
	private ClassroomManager classroomService;
	@Resource(name="courses_subjectService")
	private Courses_subjectManager courses_subjectService;
	@Resource(name="school_lesson_timeService")
	private School_lesson_timeManager school_lesson_timeService;
	
	
	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save") 
	public ModelAndView save() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增Schedule");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("LESSONS_ID", this.get32UUID());	//主键
		scheduleService.save(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**删除
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value="/delete")
	public void delete(PrintWriter out) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"删除Schedule");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		scheduleService.delete(pd);
		out.write("success");
		out.close();
	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改Schedule");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		if(pd.get("LESSONS_ID")==null || ("").equals(pd.get("LESSONS_ID"))){//如果没有主键  就给一个主键  进行修改操作（当作是新增）
			pd.put("LESSONS_ID", this.get32UUID());	//主键
			scheduleService.save(pd);
		}else{
			scheduleService.edit(pd);
		}
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(HttpServletRequest request,Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表Schedule");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords);
		}
		List<PageData>	varList=null;//列出Schedule列表
		if(pd.getString("COURSES_ID")!=null && !("").equals(pd.getString("COURSES_ID"))){  //表格形式展现课表
		//获取现在时间
		Date date=null;
				if(pd.get("nowDate")==null){
					date=new Date();
					pd.put("nowDate", date);
				}else{
					date=new SimpleDateFormat("yyyy-MM-dd").parse(pd.get("nowDate").toString());
					pd.put("nowDate", date);
				}
		//获取本周开始时间
		String lastStart=DateUtil.getWeekStartDay(date);
		//获取本周结束时间
		String lastEnd=DateUtil.getWeekEndtDay(date);
		pd.put("lastStart", lastStart);
		pd.put("lastEnd", lastEnd);
		varList = scheduleService.listAll(pd);	//列出Schedule列表
		/*//判断如果集合数量为0   把上一周的数据复制给这一周
		if(varList.size()==0){
			date=DateUtil.getDateAfterDayDate("-7", date);
			lastStart=DateUtil.getWeekStartDay(date);
			lastEnd=DateUtil.getWeekEndtDay(date);
			pd.put("lastStart", lastStart);
			pd.put("lastEnd", lastEnd);
			List<PageData> prevList=scheduleService.listAll(pd);
			for (PageData pageData : prevList) {
				PageData p=pageData;
				p.put("LESSON_STARTTIME",DateUtil.getDateAfterDayDate("7",new SimpleDateFormat("yyyy-M-dd HH:mm:ss").parse(p.get("LESSON_STARTTIME").toString())));
				p.put("LESSON_ENDTIME",DateUtil.getDateAfterDayDate("7",new SimpleDateFormat("yyyy-M-dd HH:mm:ss").parse(p.get("LESSON_ENDTIME").toString())));
				p.put("LESSONS_ID", this.get32UUID());
				scheduleService.save(p);
				varList.add(p);
			}
		}*/
		/*if(pd.getString("lastStart")==null && pd.getString("lastEnd")==null){
			pd.put("lastStart",DateUtil.getDay()); 
		}*/
		
		//获取集合中第一列数据的时间模版
		String lesson_time_type=null;
		if(varList.size()!=0){
			lesson_time_type=varList.get(0).get("LESSON_TIME_TYPE").toString();
		}
		//时间模版类型
		String lesson_type=null;
		
		if(lesson_time_type!=null){
			lesson_type=lesson_time_type;
		}else{
			try {
				lesson_type = request.getSession().getServletContext().getAttribute("lesson_type").toString();
			} catch (Exception e) {
				lesson_type="1";//如果Application里没有时间模块类型  默认为1
			}
		}
		
			pd.put("LESSON_TIME_TYPE", lesson_type);
		//时间模版集合
		List<PageData> lessontimeList= school_lesson_timeService.listAll(pd);
		//获取本周一周的日期
		List<String> weekList=DateUtil.getAllweekDays(date);
		//放一个tr背景颜色的集合
		//List<String> colorList=new ArrayList<String>(){{add("#FFBBFF");add("#FFEFDB");add("#FFF68F");add("#FFE1FF");add("#E0FFFF");add("#C1FFC1");add("#FFC0CB");add("#EAEAEA");}};
		
		//mv.addObject("colorList", colorList);
		mv.addObject("lessontimeList", lessontimeList);
		mv.addObject("weekList", weekList);
		}
		else{   //默认形式展现
			String lastStart=pd.getString("lastStart");
			if(lastStart==null || lastStart .equals("")){
				lastStart=DateUtil.getDay();
			}
			String lastEnd=pd.getString("lastEnd");
			pd.put("lastStart", lastStart);
			pd.put("lastEnd", lastEnd);
			page.setPd(pd);
			varList = scheduleService.list(page);	//列出Schedule列表
		}
		mv.setViewName("schedule/schedule/schedule_list");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		return mv;
	}
	
	/**
	 * 复制上一周课表数据
	 */
	@RequestMapping("/copyschedule")
	@ResponseBody
	public String copyschedule(HttpServletRequest request)throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		String nowDate=pd.getString("nowDate");
		Date date=new SimpleDateFormat("yyyy-MM-dd").parse(nowDate);//转换日期类型
		String resust="";
		String lesson_type="";
		if(nowDate!=null&&!nowDate.equals("")){
			//获取本周开始时间
			String	lastStart=DateUtil.getWeekStartDay(date);
				//获取本周结束时间
			String	lastEnd=DateUtil.getWeekEndtDay(date);

			pd.put("lastStart", lastStart);
			pd.put("lastEnd", lastEnd);
			List<PageData> varList = scheduleService.listAll(pd);	//列出Schedule列表
			if (varList.size()>0) {   //如果当前一周时间内有课表就删除掉
				for (PageData pageData : varList) {
					scheduleService.delete(pageData);
				}
			}
			
			//开始复制上一周课表数据
			Date prevdate=DateUtil.getDateAfterDayDate("-7", date);
			lastStart=DateUtil.getWeekStartDay(prevdate);
			lastEnd=DateUtil.getWeekEndtDay(prevdate);
			pd.put("lastStart", lastStart);
			pd.put("lastEnd", lastEnd);
			List<PageData> prevList=scheduleService.listAll(pd);//获取上一周的课表数据
			if(prevList.size()==0){
				return "false";
			}
			String lesson_time_type=prevList.get(0).get("LESSON_TIME_TYPE").toString();
			if(request.getSession().getServletContext().getAttribute("lesson_type")==null){//如果时间模版session里没有  默认取1模版
				lesson_type="1";
			}else{
				lesson_type = request.getSession().getServletContext().getAttribute("lesson_type").toString();
			}
			if(!lesson_time_type.equals(lesson_type)){
				resust= "false";
			}
			if(prevList.size()==0){
				resust="false";
			}else{
				for (PageData pageData : prevList) {
					PageData p=pageData;
					p.put("LESSON_TIME_TYPE", lesson_type);//复制上一周的时间模版
					p.put("LESSON_STARTTIME",DateUtil.getDateAfterDayDate("7",new SimpleDateFormat("yyyy-M-dd HH:mm:ss").parse(p.get("LESSON_STARTTIME").toString())));
					p.put("LESSON_ENDTIME",DateUtil.getDateAfterDayDate("7",new SimpleDateFormat("yyyy-M-dd HH:mm:ss").parse(p.get("LESSON_ENDTIME").toString())));
					p.put("LESSON_NAME", "");
					p.put("LESSONS_ID", this.get32UUID());
					scheduleService.save(p);
					//varList.add(p);
				}
				resust="true";
			}
		}
		return resust;
	}
	
	/**根据科目查找教师列表  以及教室列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/listBySubjectId")
	@ResponseBody
	public Object listBySubjectId(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表Schedule");
		PageData pd = new PageData();
		pd = this.getPageData();
		//String id=request.getParameter("COURSE_ID");
		//pd.put("COURSE_ID", id);
 		page.setPd(pd);
		Map<String, Object> map=new HashMap<String, Object>();
		PageData teachpd=userService.findById(pd);//当老师不为空时
		List<PageData>	teachList = userService.listAllBySubjectid(pd);	//列出老师列表
		if(teachpd!=null){
		teachList.add(teachpd);//把当前老师也加到要选择的老师列表中
		}
		/*if(teachList.contains(userService.findById(pd))){
			teachList=null;
		}*/
		PageData pp=classroomService.findById(pd);//获取教室ID不为空时进行修改
		List<PageData> classroomList=classroomService.listByTime(pd);
		if(pp!=null){
		classroomList.add(pp);  //修改时要把当前的教室也要包括进去
		}
		/*if(pp!=null){
			classroomList=null;
		}*/
	/*	if(classroomList.contains(classroomService.findById(pd))){
			classroomList=null;
		}*/
		map.put("classroomList", classroomList);
		map.put("teachList", teachList);
		return map;
	}
	
	/**
	 * 根据课程和时间段查询  此时间段的其他课程  是否有学生冲突
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/checkStudent")
	@ResponseBody
	public Object checkStudent(Page page) throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		page.setPd(pd);
		List<PageData> stuList=scheduleService.checkStudent(page);
		return stuList;
	} 
	
	/**去新增页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goAdd")
	public ModelAndView goAdd()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		mv.setViewName("schedule/schedule/schedule_edit");
		
		List<PageData>	teachList = userService.listAllUser(pd);	//列出老师列表
		List<PageData>	coursesList = coursesService.listAll(pd);	//列出课程列表
		List<PageData>	classList = classroomService.listAll(pd);	//教室列表
		mv.addObject("classList",classList);
		mv.addObject("teachList",teachList);
		mv.addObject("coursesList",coursesList);
		
		mv.addObject("msg", "save");
		mv.addObject("pd", pd);
		return mv;
	}	
	
	 /**去修改页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goEdit")
	public ModelAndView goEdit()throws Exception{
		ModelAndView mv = this.getModelAndView();
 		PageData pd = new PageData();
		pd = this.getPageData();
		String LESSON_STARTTIME=pd.getString("LESSON_STARTTIME");//获取开始时间
		String LESSON_ENDTIME=pd.getString("LESSON_ENDTIME");//获取结束时间
		String COURSE_ID=pd.getString("COURSES_ID");
		String LESSON_TIME_TYPE=pd.getString("LESSON_TIME_TYPE");//获取时间模版类型
		pd = scheduleService.findById(pd);	//根据ID读取
		if(pd==null){//如果课程的开始时间为空  代表新增  要把时间存入
			pd=new PageData();
			pd.put("LESSON_STARTTIME", LESSON_STARTTIME); 
			pd.put("LESSON_ENDTIME", LESSON_ENDTIME);
			pd.put("COURSE_ID", COURSE_ID);
			pd.put("LESSON_TIME_TYPE", LESSON_TIME_TYPE);
		}
		List<PageData>	teachList = userService.listAllUser(pd);	//列出老师列表
/*		List<PageData>	coursesList = coursesService.listAll(pd);	//列出课程列表*/
		List<PageData> subjectList=courses_subjectService.ListByCoursesId(pd);//根据课程id查询科目列表
		for (PageData pageData : subjectList) {
			PageData subject = subjectService.findById(pageData);
			if(subject==null){
				continue;
			}
			pageData.put("SUBJECT_NAME", subject.get("SUBJECT_NAME"));
		}
		List<PageData>	classList = classroomService.listAll(pd);	//教室列表
		mv.addObject("subjectList", subjectList);//显示该课程下面的科目
		mv.addObject("teachList",teachList);
		/*mv.addObject("coursesList",coursesList);*/
		mv.addObject("classList",classList);
		
		mv.setViewName("schedule/schedule/schedule_edit");
				
		mv.addObject("msg", "edit");
		mv.addObject("pd", pd);
		return mv;
	}	
	
	 /**批量删除
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/deleteAll")
	@ResponseBody
	public Object deleteAll() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"批量删除Schedule");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			scheduleService.deleteAll(ArrayDATA_IDS);
			pd.put("msg", "ok");
		}else{
			pd.put("msg", "no");
		}
		pdList.add(pd);
		map.put("list", pdList);
		return AppUtil.returnObject(pd, map);
	}
	
	 /**导出到excel
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/excel")
	public ModelAndView exportExcel(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"导出Schedule到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		//时间格式
		DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
		titles.add("开始时间");	//5
		titles.add("结束时间");	//6
		titles.add("课程");	//3
		titles.add("老师");	//2
		titles.add("教室");	//4
		titles.add("备注");	//1
		dataMap.put("titles", titles);
		page.setPd(pd);
		List<PageData>	varList = scheduleService.list(page);	//列出Schedule列表
		List<PageData> varOList = new ArrayList<PageData>();
		try {
			for(int i=0;i<varList.size();i++){
				PageData vpd = new PageData();
				vpd.put("var1",sdf.format(varList.get(i).get("LESSON_STARTTIME")).toString());	    //5
				vpd.put("var2",sdf.format(varList.get(i).get("LESSON_ENDTIME")).toString());	    //6
				vpd.put("var3", varList.get(i).getString("coursesname"));	    //3
				vpd.put("var4", varList.get(i).getString("teachername"));	    //2
				vpd.put("var5", varList.get(i).getString("classname"));	    //4
				vpd.put("var6", varList.get(i).getString("LESSON_NAME"));	    //1
				varOList.add(vpd);
			}
		} catch (Exception e) {
			
		}
		
		dataMap.put("varList", varOList);
		ObjectExcelView erv = new ObjectExcelView();
		mv = new ModelAndView(erv,dataMap);
		return mv;
	}
	
	@InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
	}
}
