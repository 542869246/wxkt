 package com.flc.controller.school.brandadv;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;

import org.apache.shiro.session.Session;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import com.flc.controller.base.BaseController;
import com.flc.entity.system.User;
import com.flc.util.AppUtil;
import com.flc.util.Const;
import com.flc.util.ObjectExcelView;
import com.flc.util.PageData;
import com.flc.util.Jurisdiction;
import com.flc.service.school.brandadv.BrandadvManager;

/** 
 * 说明：品牌入驻
 * 创建人：FLC
 * 创建时间：2017-11-30
 */
@Controller
@RequestMapping(value="/brandadv")
public class BrandadvController extends BaseController {
	
	String menuUrl = "brandadv/goEdit.do"; //菜单地址(权限用)
	@Resource(name="brandadvService")
	private BrandadvManager brandadvService;
	
	/**保存
	 * @param
	 * @throws Exception
	 */
//	@RequestMapping(value="/save")
//	public ModelAndView save() throws Exception{
//		logBefore(logger, Jurisdiction.getUsername()+"新增Brandadv");
//		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
//		ModelAndView mv = this.getModelAndView();
//		PageData pd = new PageData();
//		pd = this.getPageData();
//		pd.put("BRAND_ID", this.get32UUID());	//主键
//		Session session = Jurisdiction.getSession();
//		User user = (User)session.getAttribute(Const.SESSION_USER);	//获取当前用户
//		System.out.println(user.getUSER_ID());
//		pd.put("CREATEBY", user.getUSER_ID());//创建人
//		pd.put("CREATEDATE", new Date()); //创建时间
//		pd.put("MODIFYBY", user.getUSER_ID());//修改人
//		pd.put("MODIFYDATE", new Date()); //修改时间
//		brandadvService.save(pd);
//		mv.addObject("msg","success");
//		mv.setViewName("save_result");
//		return mv;
//	}
	
	/**删除
	 * @param out
	 * @throws Exception
	 */
//	@RequestMapping(value="/delete")
//	public void delete(PrintWriter out) throws Exception{
//		logBefore(logger, Jurisdiction.getUsername()+"删除Brandadv");
//		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
//		PageData pd = new PageData();
//		pd = this.getPageData();
//		brandadvService.delete(pd);
//		out.write("success");
//		out.close();
//	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public String edit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改Brandadv");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		/*Session session = Jurisdiction.getSession();
		User user = (User)session.getAttribute(Const.SESSION_USER);	//获取当前用户
		*/		
		List<PageData> varList=brandadvService.listAll(pd);
		if(varList.size()==0){
			pd.put("BRAND_ID", this.get32UUID());	//主键
			brandadvService.save(pd);
		}else{
			brandadvService.edit(pd);
		}
		return "redirect:goEdit";
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
//	@RequestMapping(value="/list")
//	public ModelAndView list(Page page) throws Exception{
//		logBefore(logger, Jurisdiction.getUsername()+"列表Brandadv");
//		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
//		ModelAndView mv = this.getModelAndView();
//		PageData pd = new PageData();
//		pd = this.getPageData();
//		String keywords = pd.getString("keywords");				//关键词检索条件
//		if(null != keywords && !"".equals(keywords)){
//			pd.put("keywords", keywords.trim());
//		}
//		page.setPd(pd);
//		List<PageData>	varList = brandadvService.list(page);	//列出Brandadv列表
//		mv.setViewName("school/brandadv/brandadv_list");
//		mv.addObject("varList", varList);
//		mv.addObject("pd", pd);
//		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
//		return mv;
//	}
	
	/**去新增页面
	 * @param
	 * @throws Exception
	 */
//	@RequestMapping(value="/goAdd")
//	public ModelAndView goAdd()throws Exception{
//		ModelAndView mv = this.getModelAndView();
//		PageData pd = new PageData();
//		pd = this.getPageData();
//		mv.setViewName("school/brandadv/brandadv_edit");
//		mv.addObject("msg", "save");
//		mv.addObject("pd", pd);
//		return mv;
//	}	
	
	 /**去修改页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goEdit")
	public ModelAndView goEdit()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		List<PageData> varList=brandadvService.listAll(pd);
		if(varList.size()>0){
			pd.put("BRAND_ID", brandadvService.listAll(pd).get(0).getString("BRAND_ID"));
			pd = brandadvService.findById(pd);	//根据ID读取
		}
		mv.setViewName("school/brandadv/brandadv_edit");
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
		logBefore(logger, Jurisdiction.getUsername()+"批量删除Brandadv");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			brandadvService.deleteAll(ArrayDATA_IDS);
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
		logBefore(logger, Jurisdiction.getUsername()+"导出Brandadv到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("主键");	//1
		titles.add("内容");	//2
		titles.add("创建人");	//3
		titles.add("创建时间");	//4
		titles.add("修改人");	//5
		titles.add("修改时间");	//6
		dataMap.put("titles", titles);
		List<PageData> varOList = brandadvService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("BRAND_ID"));	    //1
			vpd.put("var2", varOList.get(i).getString("BRAND_CONTENT"));	    //2
			vpd.put("var3", varOList.get(i).getString("CREATEBY"));	    //3
			vpd.put("var4", varOList.get(i).getString("CREATEDATE"));	    //4
			vpd.put("var5", varOList.get(i).getString("MODIFYBY"));	    //5
			vpd.put("var6", varOList.get(i).getString("MODIFYDATE"));	    //6
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
