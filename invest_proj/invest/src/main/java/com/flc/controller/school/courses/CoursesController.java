package com.flc.controller.school.courses;

import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.flc.controller.base.BaseController;
import com.flc.entity.Page;
import com.flc.entity.system.Dictionaries;
import com.flc.entity.system.User;
import com.flc.service.arrange.arrange.ArrangeManager;
import com.flc.service.arrange.school_ref.School_refManager;
import com.flc.service.backstage.backstage.BackstageManager;
import com.flc.service.school.courses.CoursesManager;
import com.flc.service.school.subject.SubjectManager;
import com.flc.service.system.dictionaries.DictionariesManager;
import com.flc.service.system.user.UserManager;
import com.flc.service.webschedule.webschedule.WebscheduleManager;
import com.flc.util.AppUtil;
import com.flc.util.Const;
import com.flc.util.Jurisdiction;
import com.flc.util.ObjectExcelView;
import com.flc.util.PageData;
import com.flc.util.aLiYunSmsUtil;

/** 
 * 说明：课程模块
 * 创建人：FLC
 * 创建时间：2017-12-02
 */
@Controller
@RequestMapping(value="/courses")
public class CoursesController extends BaseController {
	
	String menuUrl = "courses/list.do"; //菜单地址(权限用)
	@Resource(name="coursesService")
	private CoursesManager coursesService;
	
	@Resource(name="subjectService")
	private SubjectManager subjectService;
	
	@Resource(name="dictionariesService")
	private DictionariesManager dictionariesService;
	
	@Resource(name="school_refService")
	private School_refManager school_refService;
	
	@Resource(name="arrangeService")
	private ArrangeManager arrangeService;
	
	@Resource(name="webscheduleService")
	private WebscheduleManager webscheduleService;
	
	@Resource(name="backstageService")
	private BackstageManager backstageService;
	
	@Resource(name="userService")
	private UserManager userService;
	
	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增Courses");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("COURSES_ID", this.get32UUID());	//主键
		if (pd.getString("user_id").equals("") && pd.getString("user_id")==null) {
			pd.put("user_id", pd.getString("user_id"));
		}
		
		System.out.println();
 		coursesService.save(pd);
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
		logBefore(logger, Jurisdiction.getUsername()+"删除Courses");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		coursesService.delete(pd);
		out.write("success");
		out.close();
	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改Courses");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		coursesService.edit(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**
	 * 根据课程ID查询课程下的学生
	 */
	@RequestMapping("/listStuById")
	@ResponseBody
	public Object listStuById()throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		List<PageData> listStu=arrangeService.listStuById(pd);
		if(listStu.size()==0){
			pd.put("status", "1"); //如果状态为1  代表此课程没有学生
			return pd;
		}
		List<PageData> listUsers=new ArrayList<PageData>();//新建一个集合保存  没有查看学生日程的家长集合
 		for (PageData pageData : listStu) {//遍历学生集合查询
			List<PageData> listU= webscheduleService.findLookByStu(pageData);//根据学生ID查询学生的学习日程是否被查看   如果没查看返回此学生的家长集合
			if(listU.size()==0 || listU == null){
				continue;
			}
			listUsers.addAll(listU);
		}
		pd.put("status", "0");
		pd.put("listUsers", listUsers);
		return pd;
	}
	/**
	 * 给没有查看的家长发送短信
	 */
	@RequestMapping("/sendSMS")
	@ResponseBody
	public String sendSMS()throws Exception{
		PageData pd=this.getPageData();
		//获取帐号设置表里的数据
		PageData p=backstageService.listAll(pd).get(0);
		String str=pd.getString("listUsers");
		
		
		pd.putAll(p);
		JSONArray json=JSONArray.parseArray(str);
		for (Object object : json) {
			JSONObject jso = JSONObject.parseObject(object.toString());
			String USERS_PHONE=jso.getString("USERS_PHONE");
			String USERS_NAME=jso.getString("USERS_NAME");
			pd.put("phone", USERS_PHONE);
			pd.put("name", USERS_NAME);
			pd.put("type", "1");//代表给家长发送短信
			aLiYunSmsUtil.aliSendSms(pd);
		}
		String message="";
		Map<String, Object> map=new HashMap<String, Object>();
		if(p.getString("STUDENT_SMS")==null){
			message="请在帐号设置里设置短信模版";
		}else{
			message="已经发送了"+json.size()+"条短信";
		}
		map.put("message", message);
		return JSON.toJSONString(map);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表Courses");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		//session中获取管理员ID  通过ID查询此管理员下的课程
		User user=(User)getRequest().getSession().getAttribute(Const.SESSION_USER);
		//判断角色 （老师）
		if(!user.getROLE_ID().equals("1")){
			String user_id=user.getUSER_ID();
			pd.put("USER_ID", user_id);
		}
		
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords);
		}
		String SUBJECT_ID=pd.getString("SUBJECT_ID");
		if(null != SUBJECT_ID && !"".equals(SUBJECT_ID)){
			pd.put("SUBJECT_ID", SUBJECT_ID);
		}
		String STATUS_ID=pd.getString("STATUS_ID");
		if(null != STATUS_ID && !"".equals(STATUS_ID)){
			pd.put("STATUS_ID", STATUS_ID);
		}
		page.setPd(pd);
		List<PageData>	SUBJECT_LIST = subjectService.listAll(pd);	//列出Subject列表
		List<PageData>	COURSES_LIST = coursesService.list(page);	//列出Courses列表
		
		String lastStart = pd.getString("lastStart");
		if (null != lastStart && !"".equals(lastStart)) {
			pd.put("lastStart", lastStart);
		}
		
		String lastEnd = pd.getString("lastEnd");
		if (null != lastEnd && !"".equals(lastEnd)) {
			pd.put("lastEnd", lastEnd);
		}
		//列出课程状态列表
		List<Dictionaries> STATUS_LIST=dictionariesService.listSubDictByParentId("5d9ff84ba3b344979d6194678caff932");
		
		mv.setViewName("school/courses/courses_list");
		mv.addObject("SUBJECT_LIST", SUBJECT_LIST);
		mv.addObject("varList", COURSES_LIST);
		mv.addObject("STATUS_LIST", STATUS_LIST);
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		return mv;
	}
	
	/**去新增页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goAdd")
	public ModelAndView goAdd(Page page)throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		List<PageData>	SUBJECT_LIST = subjectService.list(page);	//列出Subject列表
		//列出课程状态列表
		List<Dictionaries> STATUS_LIST=dictionariesService.listSubDictByParentId("5d9ff84ba3b344979d6194678caff932");
		List<PageData>	userList = userService.listUsers(page);
		mv.setViewName("school/courses/courses_edit");
		mv.addObject("msg", "save");
		mv.addObject("SUBJECT_LIST", SUBJECT_LIST);
		mv.addObject("STATUS_LIST", STATUS_LIST);
		mv.addObject("userList",userList);
		mv.addObject("pd", pd);
		return mv;
	}	
	
	 /**去修改页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goEdit")
	public ModelAndView goEdit(Page page)throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = coursesService.findById(pd);	//根据ID读取
		List<PageData>	SUBJECT_LIST = subjectService.list(page);	//列出Subject列表
		//列出课程状态列表
		List<Dictionaries> STATUS_LIST=dictionariesService.listSubDictByParentId("5d9ff84ba3b344979d6194678caff932");
		List<PageData>	userList = userService.listUsers(page);
		mv.setViewName("school/courses/courses_edit");
		mv.addObject("SUBJECT_LIST", SUBJECT_LIST);
		mv.addObject("STATUS_LIST", STATUS_LIST);
		mv.addObject("userList",userList);
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
		logBefore(logger, Jurisdiction.getUsername()+"批量删除Courses");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			coursesService.deleteAll(ArrayDATA_IDS);
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
		logBefore(logger, Jurisdiction.getUsername()+"导出Courses到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("备注1");	//1
		titles.add("科目");	//2
		titles.add("开始时间");	//3
		titles.add("结束时间");	//4
		titles.add("课程状态");	//5
		titles.add("备注6");	//6
		titles.add("备注7");	//7
		titles.add("备注8");	//8
		titles.add("备注9");	//9
		dataMap.put("titles", titles);
		List<PageData> varOList = coursesService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("COURSE_ID"));	    //1
			vpd.put("var2", varOList.get(i).getString("SUBJECT_ID"));	    //2
			vpd.put("var3", varOList.get(i).getString("ARRANGE_STARTTIME"));	    //3
			vpd.put("var4", varOList.get(i).getString("ARRANGE_ENDTIME"));	    //4
			vpd.put("var5", varOList.get(i).get("COURSE_STATUS").toString());	//5
			vpd.put("var6", varOList.get(i).getString("CREATEBY"));	    //6
			vpd.put("var7", varOList.get(i).getString("CREATEDATE"));	    //7
			vpd.put("var8", varOList.get(i).getString("MODIFYBY"));	    //8
			vpd.put("var9", varOList.get(i).getString("MODIFYDATE"));	    //9
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
