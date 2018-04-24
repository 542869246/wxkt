package com.flc.controller.ability.ability;

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
import com.flc.entity.system.Dictionaries;
import com.flc.util.AppUtil;
import com.flc.util.ObjectExcelView;
import com.flc.util.PageData;
import com.flc.util.Jurisdiction;
import com.flc.util.Tools;
import com.flc.service.ability.ability.AbilityManager;
import com.flc.service.arrange.arrange.ArrangeManager;
import com.flc.service.school.courses.CoursesManager;
import com.flc.service.school.subject.SubjectManager;
import com.flc.service.student.student.StudentManager;
import com.flc.service.system.dictionaries.DictionariesManager;

/** 
 * 说明：学生能力积分值
 * 创建人：FLC
 * 创建时间：2017-12-01
 */
@Controller
@RequestMapping(value="/ability")
public class AbilityController extends BaseController {
	
	String menuUrl = "ability/list.do"; //菜单地址(权限用)
	@Resource(name="abilityService")
	private AbilityManager abilityService;
	
	@Resource
	private DictionariesManager dictionariesService;
	
	@Resource
	private StudentManager studentService;
	
	@Resource(name="subjectService")
	private SubjectManager subjectService;
	
	@Resource
	private ArrangeManager arrangeService;
	
	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增Ability");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("COURSE_TIME", new Date());
		pd.put("ABILITY_ID", this.get32UUID());	//主键
		abilityService.save(pd);
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
		logBefore(logger, Jurisdiction.getUsername()+"删除Ability");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		abilityService.delete(pd);
		out.write("success");
		out.close();
	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改Ability");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		//能力类型子级集合
		List<Dictionaries> abilityList = dictionariesService.listSubDictByParentId("e6f62d095964410593593e58470ab234");
		pd.put("COURSE_TIME", new Date());
		abilityService.edit(pd);
		mv.addObject("msg","success");
		mv.addObject("abilityList", abilityList);

		mv.setViewName("save_result");
		return mv;
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(Page page,String STUDENT_ID) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表Ability");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
//		String keywords = pd.getString("keywords");				//关键词检索条件
//		if(null != keywords && !"".equals(keywords)){
//			pd.put("keywords", keywords.trim());
//		}
		page.setPd(pd);
		pd.put("STUDENT_ID", STUDENT_ID);
		PageData varList1 = studentService.findById(pd);//根据学生id得到对应的学生姓名
		List<PageData> var = abilityService.list(page);
		List<PageData> abiliList=abilityService.sumCode(pd);  //根据学生查询此学生的总积分和总能力值
		List<PageData> abili=abilityService.searchAbili(pd);//查询学生的各项能力总值
		pd.put("NAME", "能力类型");
		PageData pp=dictionariesService.findByName(pd);
		List<Dictionaries> abilityList=dictionariesService.listSubDictByParentId(pp.getString("DICTIONARIES_ID"));
		String scores="";
		String abilis="";
		if(abiliList==null){
			scores="0";
			abilis="0";
		}else{
			scores=abiliList.get(0)==null?"0":abiliList.get(0).get("scores").toString();
			if(scores==null){
				scores="0";
			}
			abilis=abiliList.get(0)==null?"0":abiliList.get(0).get("abilitys").toString();
			if(abilis==null){
				abilis="0";
			}
		}
			pd.put("scores",scores);
			pd.put("abilis",abilis);
		
		//能力类型子级集合
		//List<Dictionaries> abilityList = dictionariesService.listSubDictByParentId("e6f62d095964410593593e58470ab234");
		mv.addObject("abilityList", abilityList);
		mv.addObject("abili", abili);
		mv.setViewName("ability/ability/ability_list");
		mv.addObject("varList", var);
		mv.addObject("varList1", varList1);
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
		List<PageData> list = subjectService.listAll(pd);//所有科目
		PageData stuName = studentService.findById(pd);//根据学生id得到对应的学生姓名
		//能力类型子级集合
		List<Dictionaries> abilityList = dictionariesService.listSubDictByParentId("e6f62d095964410593593e58470ab234");
		mv.addObject("abilityList", abilityList);
		mv.addObject("list", list);
		pd.put("stuName", stuName);
		mv.setViewName("ability/ability/ability_edit");
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
		pd = abilityService.findById(pd);	//根据ID读取
		//能力类型子级集合
		List<Dictionaries> abilityList = dictionariesService.listSubDictByParentId("e6f62d095964410593593e58470ab234");
		List<PageData> list = subjectService.listAll(pd);//所有科目
		PageData stuName = studentService.findById(pd);//根据学生id得到对应的学生姓名
		mv.setViewName("ability/ability/ability_edit");
		mv.addObject("abilityList", abilityList);
		mv.addObject("list", list);
		pd.put("stuName", stuName);
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
		logBefore(logger, Jurisdiction.getUsername()+"批量删除Ability");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			abilityService.deleteAll(ArrayDATA_IDS);
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
		logBefore(logger, Jurisdiction.getUsername()+"导出Ability到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("主键");	//1
		titles.add("能力类型");	//2
		titles.add("学生ID");	//3
		titles.add("课程ID");	//4
		titles.add("记录时间");	//5
		titles.add("记录内容");	//6
		titles.add("积分值");	//7
		titles.add("能力值");	//8
		titles.add("创建人");	//9
		titles.add("创建时间");	//10
		titles.add("修改人");	//11
		titles.add("修改时间");	//12
		dataMap.put("titles", titles);
		List<PageData> varOList = abilityService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("ABILITY_ID"));	    //1
			vpd.put("var2", varOList.get(i).getString("ABILITY_TYPE_ID"));	    //2
			vpd.put("var3", varOList.get(i).getString("STUDENT_ID"));	    //3
			vpd.put("var4", varOList.get(i).getString("COURSE_ID"));	    //4
			vpd.put("var5", varOList.get(i).getString("COURSE_TIME"));	    //5
			vpd.put("var6", varOList.get(i).getString("COURSE_CONTENT"));	    //6
			vpd.put("var7", varOList.get(i).get("SCORE_VALUE").toString());	//7
			vpd.put("var8", varOList.get(i).get("ABILITY_VALUE").toString());	//8
			vpd.put("var9", varOList.get(i).getString("CREATEBY"));	    //9
			vpd.put("var10", varOList.get(i).getString("CREATEDATE"));	    //10
			vpd.put("var11", varOList.get(i).getString("MODIFYBY"));	    //11
			vpd.put("var12", varOList.get(i).getString("MODIFYDATE"));	    //12
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
