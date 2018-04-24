package com.flc.controller.school.study;

import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
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

import net.sf.json.JSONArray;

import com.flc.service.school.courses.CoursesManager;
import com.flc.service.school.study.StudyManager;
import com.flc.service.school.subject.SubjectManager;

/** 
 * 说明：学生信息反馈
 * 创建人：FLC
 * 创建时间：2017-12-07
 */
@Controller
@RequestMapping(value="/study")
public class StudyController extends BaseController {
	
	String menuUrl = "study/list.do"; //菜单地址(权限用)
	@Resource(name="studyService")
	private StudyManager studyService;
	
	@Resource(name="subjectService")
	private SubjectManager subjectService;
	
	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增Study");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("STUDY_IDS", this.get32UUID());
		if(pd.getString("scheduleList")!=null && !"".equals(pd.getString("scheduleList"))){//循环开始录入
			String scheduleList[]=pd.getString("scheduleList").split(",");
			for (String string : scheduleList) {
				if(string!=null){
					pd.put("STUDY_ID", this.get32UUID());	//主键
					pd.put("SCHEDULE_ID", string);
					studyService.save(pd);
				}
			}
		}else{
			pd.put("STUDY_ID", this.get32UUID());	//主键
			studyService.save(pd);
		}
		mv.addObject("pd", pd);
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
		logBefore(logger, Jurisdiction.getUsername()+"删除Study");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		if(!"".equals(pd.getString("scheduleList"))&&null!=pd.getString("scheduleList")){//当studyID集合不为空时遍历删除
			studyService.delete_pl(pd);
		}else{
			studyService.delete(pd);
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
		logBefore(logger, Jurisdiction.getUsername()+"修改Study");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		if(pd.getString("STUDY_IDS")!=null&&!"".equals(pd.getString("STUDY_IDS"))){
			studyService.edit_pl(pd);//根据自定义列进行修改
		}else{
			studyService.edit(pd);
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
	public ModelAndView list(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表Study");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		List<PageData>	varList =null;
		if(pd.getString("scheduleList")!=null && !"".equals(pd.getString("scheduleList"))){//批量录入显示的学习内容列表
			String s[]=pd.getString("scheduleList").split(",");
			pd.put("string",s);
			varList=studyService.searchStudy(page);
			page.setTotalResult(varList.size());
		}else{
			varList= studyService.list(page);	//列出Study列表
		}
		pd.put("studySize", varList.size());
		mv.setViewName("school/study/study_list");
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
		List<PageData> subjectList=subjectService.listAll(pd);//获取科目的列表
		mv.setViewName("school/study/study_edit");
		mv.addObject("msg", "save");
		mv.addObject("subjectList",subjectList);
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
		String scheduleList=pd.getString("scheduleList");
		if(scheduleList!=null&&!"".equals(scheduleList)){
			pd=studyService.findByUpdate(pd);//根据自定义列进行查询修改
			pd.put("scheduleList",scheduleList);
		}else{
			pd = studyService.findById(pd);	//根据ID读取
		}
		List<PageData> subjectList=subjectService.listAll(pd);//获取科目的列表
		mv.setViewName("school/study/study_edit");
		mv.addObject("msg", "edit");
		mv.addObject("subjectList", subjectList);
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
		logBefore(logger, Jurisdiction.getUsername()+"批量删除Study");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			studyService.deleteAll(ArrayDATA_IDS);
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
		logBefore(logger, Jurisdiction.getUsername()+"导出Study到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("备注1");	//1
		titles.add("学生姓名");	//2
		titles.add("课程名称");	//3
		titles.add("学习时长");	//4
		titles.add("学习内容");	//5
		titles.add("是否可见");	//6
		titles.add("备注7");	//7
		titles.add("备注8");	//8
		titles.add("备注9");	//9
		titles.add("备注10");	//10
		dataMap.put("titles", titles);
		List<PageData> varOList = studyService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("STUDY_ID"));	    //1
			vpd.put("var2", varOList.get(i).getString("SCHEDULE_ID"));	    //2
			vpd.put("var3", varOList.get(i).getString("COURSES_ID"));	    //3
			vpd.put("var4", varOList.get(i).getString("STUDY_TIMEDIFF"));	    //4
			vpd.put("var5", varOList.get(i).getString("STUDY_CONTENT"));	    //5
			vpd.put("var6", varOList.get(i).get("IS_SHOW").toString());	//6
			vpd.put("var7", varOList.get(i).getString("CREATEBY"));	    //7
			vpd.put("var8", varOList.get(i).getString("CREATEDATE"));	    //8
			vpd.put("var9", varOList.get(i).getString("MODIFYBY"));	    //9
			vpd.put("var10", varOList.get(i).getString("MODIFYDATE"));	    //10
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
