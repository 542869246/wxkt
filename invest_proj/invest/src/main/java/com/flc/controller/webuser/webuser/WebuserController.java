package com.flc.controller.webuser.webuser;

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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.flc.controller.base.BaseController;
import com.flc.entity.Page;
import com.flc.service.student.student.StudentManager;
import com.flc.service.users.users.UsersManager;
import com.flc.service.webuser.webuser.WebuserManager;
import com.flc.util.AppUtil;
import com.flc.util.Jurisdiction;
import com.flc.util.ObjectExcelView;
import com.flc.util.PageData;

/** 
 * 说明：家长和学生的关联表
 * 创建人：FLC
 * 创建时间：2017-12-01
 */
@Controller
@RequestMapping(value="/webuser")
public class WebuserController extends BaseController {
	
	String menuUrl = "webuser/list.do"; //菜单地址(权限用)
	@Resource(name="webuserService")
	private WebuserManager webuserService;
	@Resource(name="studentService")
	private StudentManager studentService;
	@Resource(name="usersService")
	private UsersManager usersService;
	
	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增Webuser");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("WEBUSER_ID", this.get32UUID());	//主键
		webuserService.save(pd);
		mv.addObject("msg","success");
		mv.addObject("pd", pd);
		mv.setViewName("save_result");
		return mv;
	}
	
	/**删除
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value="/delete")
	public void delete(PrintWriter out) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"删除Webuser");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		webuserService.delete(pd);
		out.write("success");
		out.close();
	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改Webuser");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		webuserService.edit(pd);
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
		logBefore(logger, Jurisdiction.getUsername()+"列表Webuser");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
//		System.err.println( "STUDENT_ID:" + pd.getString("STUDENT_ID"));
		String stuid = pd.getString("STUDENT_ID");
		if(stuid != null && !"".equals(stuid)){
			pd.put("stuid", stuid);
		}
		
//		System.out.println(zhangy);
		page.setPd(pd);
		List<PageData>	varList = webuserService.list(page);	//列出Webuser列表
		//当webuser集合大于0  修改用户是会员  =0时修改用户不是会员
		if(varList.size()>0){
			pd.put("ismember", "0");
			webuserService.updateUsers_ismember(pd);
		}else if(varList.size()==0){
			pd.put("ismember", "1");
			webuserService.updateUsers_ismember(pd);
		}
		mv.setViewName("webuser/webuser/webuser_list");
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
	public ModelAndView goAdd(Page page)throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String addUserOrStudent=pd.getString("toAddUserOrStudent");
		List<PageData> varList=null;
		page.setPd(pd);
		if("addStudent".equals(addUserOrStudent)){
			varList=studentService.list(page);//获取学生列表
			pd=webuserService.findByUsersId(pd);//获取当前用户
			mv.setViewName("webuser/webuser/webuser_edit");
		}else if("addUser".equals(addUserOrStudent)){
			varList=usersService.list(page);//获取家长列表
			pd=studentService.findById(pd);//获取当前用户
			mv.setViewName("webuser/webuser/webuser_edit2");
		}
		mv.addObject("varList", varList);
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
		pd = webuserService.findByUsersId(pd);	//根据ID读取
		mv.setViewName("webuser/webuser/webuser_edit");
		mv.addObject("msg", "edit");
		mv.addObject("pd", pd);
		return mv;
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
			if(pd.getString("USERS_ID")!=null && !"".equals(pd.getString("USERS_ID"))){
				for (String s : ArrayDATA_IDS) {
					pd.put("STUDENT_ID", s);
					pd.put("WEBUSER_ID", this.get32UUID());	//主键
					webuserService.save(pd);
				}
			}else if(pd.getString("STUDENT_ID")!=null && !"".equals(pd.getString("STUDENT_ID"))){
				for (String s : ArrayDATA_IDS) {
					pd.put("USERS_ID", s);
					pd.put("WEBUSER_ID", this.get32UUID());	//主键
					webuserService.save(pd);
				}
			}
			pd.put("msg", "ok");
		}else{
			pd.put("msg", "no");
		}
		return pd;
	}
	
	 /**批量删除
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/deleteAll")
	@ResponseBody
	public Object deleteAll() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"批量删除Webuser");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			webuserService.deleteAll(ArrayDATA_IDS);
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
		logBefore(logger, Jurisdiction.getUsername()+"导出Webuser到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("关联表的主键");	//1
		titles.add("学生ID");	//2
		titles.add("用户ID");	//3
		titles.add("修改人");	//4
		titles.add("修改日期");	//5
		titles.add("创建人");	//6
		titles.add("创建日期");	//7
		dataMap.put("titles", titles);
		List<PageData> varOList = webuserService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("WEBUSER_ID"));	    //1
			vpd.put("var2", varOList.get(i).getString("STUDENT_ID"));	    //2
			vpd.put("var3", varOList.get(i).getString("USERS_ID"));	    //3
			vpd.put("var4", varOList.get(i).getString("MODIFYBY"));	    //4
			vpd.put("var5", varOList.get(i).getString("MODIFYDATE"));	    //5
			vpd.put("var6", varOList.get(i).getString("CREATEBY"));	    //6
			vpd.put("var7", varOList.get(i).getString("CREATEDATE"));	    //7
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
