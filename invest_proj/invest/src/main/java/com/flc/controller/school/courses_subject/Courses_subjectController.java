package com.flc.controller.school.courses_subject;

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
import com.flc.controller.base.BaseController;
import com.flc.entity.Page;
import com.flc.util.AppUtil;
import com.flc.util.ObjectExcelView;
import com.flc.util.PageData;
import com.flc.util.Jurisdiction;
import com.flc.util.Tools;
import com.google.gson.Gson;
import com.flc.service.school.courses.CoursesManager;
import com.flc.service.school.courses_subject.Courses_subjectManager;

/** 
 * 说明：科目和课程关联表
 * 创建人：FLC
 * 创建时间：2018-01-17
 */
@Controller
@RequestMapping(value="/courses_subject")
public class Courses_subjectController extends BaseController {
	
	String menuUrl = "courses_subject/list.do"; //菜单地址(权限用)
	@Resource(name="courses_subjectService")
	private Courses_subjectManager courses_subjectService;
	@Resource(name="coursesService")
	private CoursesManager coursesService;
	
	
	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增Courses_subject");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("COURSES_SUBJECT_ID", this.get32UUID());	//主键
		courses_subjectService.save(pd);
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
		logBefore(logger, Jurisdiction.getUsername()+"删除Courses_subject");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		courses_subjectService.delete(pd);
		out.write("success");
		out.close();
	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改Courses_subject");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		courses_subjectService.edit(pd);
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
		logBefore(logger, Jurisdiction.getUsername()+"列表Courses_subject");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		List<PageData>	varList = courses_subjectService.list(page);	//列出Courses_subject列表
		mv.setViewName("school/courses_subject/courses_subject_list");
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
	public ModelAndView goAdd()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		mv.setViewName("school/courses_subject/courses_subject_edit");
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
		pd = courses_subjectService.findById(pd);	//根据ID读取
		mv.setViewName("school/courses_subject/courses_subject_edit");
		mv.addObject("msg", "edit");
		mv.addObject("pd", pd);
		return mv;
	}	
	
	/**
	 * 根据课程ID查询对应的科目
	 * @throws Exception 
	 */
	@RequestMapping("/listAll")
	@ResponseBody
	public Object listAll() throws Exception{
		PageData pd=this.getPageData();
		List<PageData> sublist= courses_subjectService.listAll(pd);
		return sublist;
	}
	
	/**
	 * 批量添加
	 */
	@RequestMapping("/addall")
	@ResponseBody
	public Object addall() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"批量添加Courses_teacher");
		PageData pd = new PageData();
		pd = this.getPageData();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			if(pd.getString("COURSES_ID")!=null && !"".equals(pd.getString("COURSES_ID"))){
				for (String s : ArrayDATA_IDS) {
					pd.put("SUBJECT_ID", s);
					pd.put("COURSES_SUBJECT_ID", this.get32UUID());	//主键
					courses_subjectService.save(pd);
				}
			}else if(pd.getString("SUBJECT_ID")!=null && !"".equals(pd.getString("SUBJECT_ID"))){
				for (String s : ArrayDATA_IDS) {
					pd.put("COURSES_ID", s);
					pd.put("COURSES_SUBJECT_ID", this.get32UUID());	//主键
					courses_subjectService.save(pd);
				}
			}
			pd.put("msg", "ok");
		}else{
			pd.put("msg", "no");
		}
		return pd;
	}
	
	/**
	 * ajax判断
	 * @throws Exception 
	 */
	@RequestMapping(value="/stats")
	@ResponseBody
	public int stats(Page page) throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		if (pd.getString("COURSES_ID")!=null &&!"".equals(pd.getString("COURSES_ID"))) {
			pd.put("COURSES_ID", pd.getString("COURSES_ID"));
			
		}
		PageData COURSES = coursesService.findByName(pd);
		if (COURSES!=null && !"".equals(COURSES)) {
			return 0;
		}
		
		return 1;
		
	}
	
	 /**批量删除
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/deleteAll")
	@ResponseBody
	public Object deleteAll() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"批量删除Courses_subject");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			courses_subjectService.deleteAll(ArrayDATA_IDS);
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
		logBefore(logger, Jurisdiction.getUsername()+"导出Courses_subject到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("主键");	//1
		titles.add("课程ID");	//2
		titles.add("科目ID");	//3
		titles.add("备注");	//4
		dataMap.put("titles", titles);
		List<PageData> varOList = courses_subjectService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("COURSES_SUBJECT_ID"));	    //1
			vpd.put("var2", varOList.get(i).getString("COURSES_ID"));	    //2
			vpd.put("var3", varOList.get(i).getString("SUBJECT_ID"));	    //3
			vpd.put("var4", varOList.get(i).getString("REAMARK"));	    //4
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
