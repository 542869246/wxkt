package com.flc.controller.webschedule.webschedule;

import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.flc.controller.base.BaseController;
import com.flc.entity.Page;
import com.flc.entity.system.Dictionaries;
import com.flc.entity.system.User;
import com.flc.service.arrange.arrange.ArrangeManager;
import com.flc.service.school.courses_subject.Courses_subjectManager;
import com.flc.service.student.student.StudentManager;
import com.flc.service.system.dictionaries.DictionariesManager;
import com.flc.service.webschedule.webschedule.WebscheduleManager;
import com.flc.util.AppUtil;
import com.flc.util.Const;
import com.flc.util.Jurisdiction;
import com.flc.util.ObjectExcelView;
import com.flc.util.PageData;

/**  
 * 说明：用户日程表
 * 创建人：FLC
 * 创建时间：2017-12-06 
 */
@Controller
@RequestMapping(value="/webschedule")
public class WebscheduleController extends BaseController {
	
	String menuUrl = "webschedule/list.do"; //菜单地址(权限用)
	@Resource(name="webscheduleService")
	private WebscheduleManager webscheduleService;
	@Resource(name="arrangeService")
	private ArrangeManager arrangeService;
	@Resource
	private StudentManager studentService;
	@Resource(name="courses_subjectService")
	private Courses_subjectManager courses_subjectService;
	
	@Resource
	private DictionariesManager dictionariesService;
	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增Webschedule");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String	 ARRIVELEAVETIME   =(String)pd.get("ARRIVELEAVETIME");//到达时间
		if("".equals(ARRIVELEAVETIME)){
			ARRIVELEAVETIME=null;
		}
		String	 SCHEDULE_ADOPT=(String)pd.get("SCHEDULE_ADOPT");//是否达标
		if("".equals(SCHEDULE_ADOPT)){
			SCHEDULE_ADOPT=null;
		}
		User user = (User) this.getRequest().getSession().getAttribute(Const.SESSION_USER);
		pd.put("CREATEBY", user.getUSER_ID());
		pd.put("CREATEDATE", new Date());
		pd.put("SCHEDULE_ADOPT", SCHEDULE_ADOPT);
		pd.put("ARRIVELEAVETIME", ARRIVELEAVETIME);
		pd.put("SCHEDULE_INPUTTIME", new Date());
		pd.put("SCHEDULE_ID", this.get32UUID());	//主键
		webscheduleService.save(pd);
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
		logBefore(logger, Jurisdiction.getUsername()+"删除Webschedule");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		if(pd.getString("SCHEDULE_IDS")!=null&&!"".equals(pd.getString("SCHEDULE_IDS"))){
			webscheduleService.delete_pl(pd);
		}else{
			webscheduleService.delete(pd);
		}
		out.write("success");
		out.close();
	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改Webschedule");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("CREATEBY", Jurisdiction.getUsername());//创建人
		pd.put("CREATEDATE", new Date());
		pd.put("MODIFYBY", Jurisdiction.getUsername());//修改人
		pd.put("MODIFYDATE", new Date());
		System.out.println(pd);
		webscheduleService.edit(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表Webschedule");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
	//	pd.put("STUDENT_ID", STUDENT_ID);
		page.setPd(pd);
		List<PageData>	varList = webscheduleService.list(page);	//列出Webschedule列表
		List<Dictionaries> schList = dictionariesService.listSubDictByParentId("de839d04c7bf4694934e68a94da6b602");
		mv.addObject("schList", schList);
		mv.setViewName("webschedule/webschedule/webschedule_list");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		return mv;
	}
	
	/**去新增页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goAdd")
	public ModelAndView goAdd(String STUDENT_ID)throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("STUDENT_ID", STUDENT_ID);
		PageData stuName = studentService.findById(pd);//根据学生id得到对应的学生姓名
		//作业类型子级集合
		List<Dictionaries> schList = dictionariesService.listSubDictByParentId("de839d04c7bf4694934e68a94da6b602");
		//获取当前课程下的科目集合
		List<PageData> subjectList=courses_subjectService.listAll(pd);
		//获取此学生的课程列表
		List<PageData> courseslist=arrangeService.listAll(pd);
		pd.put("stuName", stuName);
		mv.addObject("schList", schList);
		mv.addObject("courseslist", courseslist);
		mv.addObject("subjectList", subjectList);
		mv.setViewName("webschedule/webschedule/webschedule_edit");
		mv.addObject("msg", "save");
		mv.addObject("pd", pd);
		return mv;
	}	
	
	/**去批量新增页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goplAdd")
	public ModelAndView goplAdd()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		//作业类型子级集合
		List<Dictionaries> schList = dictionariesService.listSubDictByParentId("de839d04c7bf4694934e68a94da6b602");
		//获取当前课程下的科目集合
		List<PageData> subjectList=courses_subjectService.listAll(pd);
		mv.addObject("schList", schList);
		mv.addObject("subjectList", subjectList);
		mv.setViewName("webschedule/webschedule/webschedule_edit2");
		//mv.addObject("msg", "addAll");
		mv.addObject("pd", pd);
		mv.addObject("msg", "list");
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
		PageData pd2 = new PageData();
		pd = this.getPageData();
		pd.put("STUDENT_ID", pd.getString("STUDENT_ID"));
		pd2 = webscheduleService.findById(pd);	//根据ID读取		
		PageData stuName = studentService.findById(pd);//根据学生id得到对应的学生姓名
		//作业类型子级集合
		List<Dictionaries> schList = dictionariesService.listSubDictByParentId("de839d04c7bf4694934e68a94da6b602");
		//获取当前课程下的科目集合
		List<PageData> subjectList=courses_subjectService.listAll(pd);
		//获取此学生的课程列表
		List<PageData> courseslist=arrangeService.listAll(pd);
		pd.put("stuName", stuName);
		mv.addObject("schList", schList);
		mv.addObject("courseslist", courseslist);
		mv.addObject("subjectList", subjectList);
		mv.setViewName("webschedule/webschedule/webschedule_status");
		mv.addObject("pd", pd);
		mv.addObject("pd2", pd2);
		mv.addObject("msg", "edit");
		
		return mv;
	}	
	
	/**
	 * 去修改状态页面
	 */
	@RequestMapping(value="/states")
	public ModelAndView states(){
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		
		mv.setViewName("webschedule/webschedule/status");
		mv.addObject("msg", "edit");
		mv.addObject("STATE",pd.getString("STATES"));
		mv.addObject("SCHEDULE_ID", pd.getString("SCHEDULE_ID"));
		mv.addObject("pd", pd);
		return mv;
	}
	
	/**
	 * 修改状态
	 * @throws Exception 
	 */
	@RequestMapping(value="/editstates")
	public ModelAndView editStates() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改Webschedule");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("MODIFYBY", Jurisdiction.getUsername());//修改人
		pd.put("MODIFYDATE", new Date());
		pd.put("SCHEDULE_ID", pd.getString("SCHEDULE_ID"));
		pd.put("STATE", pd.getString("STATE"));
		webscheduleService.editStates(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	
	/**
	 * 批量录入保存
	 */
	@RequestMapping("/addAll")
	public ModelAndView addAll()throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"批量保存Webschedule");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();		
		pd = this.getPageData();
		String scheduleList="";
		String stuList = pd.getString("stuList");
		pd.put("SCHEDULE_INPUTTIME", new Date());
		User u= (User)Jurisdiction.getSession().getAttribute(Const.SESSION_USER);
		pd.put("CREATEBY", u.getUSER_ID());
		pd.put("SCHEDULE_IDS", this.get32UUID());
		if(null != stuList && !"".equals(stuList)){//循环遍历给学生录入学习日程
			String ArrayDATA_IDS[] = stuList.split(",");
			for (String string : ArrayDATA_IDS) {
				if(string!=null && !"".equals(string)){
					pd.put("STUDENT_ID", string);
					pd.put("SCHEDULE_ID", this.get32UUID());	//主键
					pd.put("ISLOOK", 0);
					String	 SCHEDULE_ADOPT=(String)pd.get("SCHEDULE_ADOPT");//是否达标
					if("".equals(SCHEDULE_ADOPT)){
						SCHEDULE_ADOPT=null;
					}
					String	 ARRIVELEAVETIME   =(String)pd.get("ARRIVELEAVETIME");//到达时间
					if("".equals(ARRIVELEAVETIME)){
						ARRIVELEAVETIME=null;
					}
					pd.put("SCHEDULE_ADOPT", SCHEDULE_ADOPT);
					pd.put("ARRIVELEAVETIME", ARRIVELEAVETIME);
					scheduleList+=(pd.getString("SCHEDULE_ID")+",");
					webscheduleService.save(pd);
				}
			}
		}
		mv.addObject("scheduleList", scheduleList);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		
		return mv;
	}
	
	
	/**
	 * 批量管理列表
	 */
	@RequestMapping("/pl_list")
	public ModelAndView pl_list(Page page)throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表Webschedule");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		page.setPd(pd);
		
		List<PageData> scheduleList=webscheduleService.pl_list(page);
		page.setTotalResult(scheduleList.size());
		//作业类型子级集合
		List<Dictionaries> schList = dictionariesService.listSubDictByParentId("de839d04c7bf4694934e68a94da6b602");
		mv.addObject("schList", schList);
		mv.setViewName("webschedule/webschedule/webschedule_pllist");
		mv.addObject("scheduleList", scheduleList);
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		return mv;
	}
	
	
	 /**批量操作的批量删除
		 * @param
		 * @throws Exception
		 */
		@RequestMapping(value="/deletepl_All")
		@ResponseBody
		public Object deletepl_All() throws Exception{
			logBefore(logger, Jurisdiction.getUsername()+"批量删除Webschedule");
			if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
			PageData pd = new PageData();		
			Map<String,Object> map = new HashMap<String,Object>();
			pd = this.getPageData();
			List<PageData> pdList = new ArrayList<PageData>();
			String DATA_IDS = pd.getString("DATA_IDS");
			if(null != DATA_IDS && !"".equals(DATA_IDS)){
				String ArrayDATA_IDS[] = DATA_IDS.split(",");
				webscheduleService.deletepl_All(ArrayDATA_IDS);
				pd.put("msg", "ok");
			}else{
				pd.put("msg", "no");
			}
			pdList.add(pd);
			map.put("list", pdList);
			return AppUtil.returnObject(pd, map);
		}
	
	
	
	
	 /**批量删除
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/deleteAll")
	@ResponseBody
	public Object deleteAll() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"批量删除Webschedule");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			webscheduleService.deleteAll(ArrayDATA_IDS);
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
	public ModelAndView exportExcel() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"导出Webschedule到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("主键");	//1
		titles.add("学生");	//2
		titles.add("作业类型");	//3
		titles.add("录入时间");	//4
		titles.add("创建人");	//5
		titles.add("创建时间");	//6
		titles.add("修改人");	//7
		titles.add("修改时间");	//8
		dataMap.put("titles", titles);
		List<PageData> varOList = webscheduleService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("SCHEDULE_ID"));	    //1
			vpd.put("var2", varOList.get(i).getString("STUDENT_ID"));	    //2
			vpd.put("var3", varOList.get(i).getString("SCHEDULE_TASKTYPE"));	    //3
			vpd.put("var4", varOList.get(i).getString("SCHEDULE_INPUTTIME"));	    //4
			vpd.put("var5", varOList.get(i).getString("CREATEBY"));	    //5
			vpd.put("var6", varOList.get(i).getString("CREATEDATE"));	    //6
			vpd.put("var7", varOList.get(i).getString("MODIFYBY"));	    //7
			vpd.put("var8", varOList.get(i).getString("MODIFYDATE"));	    //8
			varList.add(vpd);
		}
		dataMap.put("varList", varList);
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
