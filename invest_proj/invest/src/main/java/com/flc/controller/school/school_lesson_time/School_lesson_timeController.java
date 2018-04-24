package com.flc.controller.school.school_lesson_time;

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
import com.flc.service.school.school_lesson_time.School_lesson_timeManager;
import com.flc.service.system.dictionaries.DictionariesManager;

/** 
 * 说明：课程表时间模版
 * 创建人：FLC
 * 创建时间：2017-12-26
 */
@Controller
@RequestMapping(value="/school_lesson_time")
public class School_lesson_timeController extends BaseController {
	
	String menuUrl = "school_lesson_time/list.do"; //菜单地址(权限用)
	@Resource(name="school_lesson_timeService")
	private School_lesson_timeManager school_lesson_timeService;
	@Resource(name="dictionariesService")
	private DictionariesManager dictionariesService;
	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增School_lesson_time");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("LESSON_TIME_ID", this.get32UUID());	//主键
		school_lesson_timeService.save(pd);
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
		logBefore(logger, Jurisdiction.getUsername()+"删除School_lesson_time");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		school_lesson_timeService.delete(pd);
		out.write("success");
		out.close();
	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改School_lesson_time");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		school_lesson_timeService.edit(pd);
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
		logBefore(logger, Jurisdiction.getUsername()+"列表School_lesson_time");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		page.setPd(pd);
		//getRequest().getSession().getServletContext().getAttribute("lesson_type").toString();
		String lesson_type=pd.getString("LESSON_TYPE");
		if(lesson_type==null){
			try {
				lesson_type=getRequest().getSession().getServletContext().getAttribute("lesson_type").toString();
			} catch (Exception e) {
				lesson_type="1";
			}
			pd.put("LESSON_TYPE", lesson_type);
		}
		List<PageData>	varList = school_lesson_timeService.list(page);	//列出School_lesson_time列表
		pd.put("NAME", "时间模版个数");
		PageData pp=dictionariesService.findByName(pd);
		List<String> typelist=new ArrayList<String>();
		int num=Integer.parseInt(pp.getString("BIANMA"));
		for (int i = 0; i < num; i++) {
			typelist.add("");
		}
		getRequest().getSession().getServletContext().setAttribute("lesson_type", lesson_type);//把课表时间模版存放到Application里
		mv.setViewName("school/school_lesson_time/school_lesson_time_list");
		mv.addObject("varList", varList);
		mv.addObject("typelist", typelist);
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		return mv;
	}
	
	
	/**
	 * 新增或删除时间模版
	 */
	@RequestMapping("/addTimeType")
	@ResponseBody
	public Object addTimeType()throws Exception{
		PageData pd=this.getPageData();
		pd.put("NAME", "时间模版个数");
		String add=pd.getString("num");
		pd=dictionariesService.findByName(pd);
		int num=Integer.parseInt(pd.getString("BIANMA"));
		if(add.equals("1")){
			num++;
		}else if(add.equals("-1")){
			num--;
		}
		pd.put("BIANMA",num);
		dictionariesService.update(pd);
		return null;
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
		mv.setViewName("school/school_lesson_time/school_lesson_time_edit");
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
		pd = school_lesson_timeService.findById(pd);	//根据ID读取
		mv.setViewName("school/school_lesson_time/school_lesson_time_edit");
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
		logBefore(logger, Jurisdiction.getUsername()+"批量删除School_lesson_time");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			school_lesson_timeService.deleteAll(ArrayDATA_IDS);
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
		logBefore(logger, Jurisdiction.getUsername()+"导出School_lesson_time到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("备注1");	//1
		titles.add("备注2");	//2
		titles.add("备注3");	//3
		titles.add("备注4");	//4
		dataMap.put("titles", titles);
		List<PageData> varOList = school_lesson_timeService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("LESSON_TIME_ID"));	    //1
			vpd.put("var2", varOList.get(i).getString("LESSON_STARTTIME"));	    //2
			vpd.put("var3", varOList.get(i).getString("LESSON_ENDTIME"));	    //3
			vpd.put("var4", varOList.get(i).getString("LESSON_REMARK"));	    //4
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
