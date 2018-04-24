package com.flc.controller.web.userinfo;

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
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.druid.support.json.JSONParser;
import com.flc.controller.base.BaseController;
import com.flc.entity.Page;
import com.flc.entity.system.Dictionaries;
import com.flc.service.system.dictionaries.DictionariesManager;
import com.flc.service.system.dictionaries.impl.DictionariesService;
import com.flc.service.web.userinfo.UserinfoManager;
import com.flc.util.AppUtil;
import com.flc.util.Jurisdiction;
import com.flc.util.Logger;
import com.flc.util.ObjectExcelView;
import com.flc.util.PageData;

import net.sf.json.JSONArray;

/** 
 * 说明：前端用户注册保存
 * 创建人：FLC
 * 创建时间：2017-10-18
 */
@Controller
@RequestMapping(value="/userinfo")
public class UserinfoController extends BaseController {
	
	String menuUrl = "userinfo/list.do"; //菜单地址(权限用)
	@Resource(name="userinfoService")
	private UserinfoManager userinfoService;
	@Resource(name="dictionariesService")
	private DictionariesManager dictionariesService;
	
	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增Userinfo");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("USERINFO_ID", this.get32UUID());	//主键
		userinfoService.save(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		
		return mv;
	}
	
	
	/**'删除'用户购买的产品
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value="/delProducts")
	@ResponseBody
	public void delProducts() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"逻辑删除用户购买产品信息");
		PageData pd = new PageData();
		pd = this.getPageData();
		String userAndProd = pd.getString("userAndProd").replaceAll("`-", "\"");
		Map map = new JSONParser(userAndProd).parseMap();
		if(null != map){
			pd.put("USERINFO_ID", map.get("USERINFO_ID").toString());
			pd.put("INVEST_ID", map.get("INVEST_ID").toString());
		}
		userinfoService.delProducts(pd);
	}
	
	
	/**读取产品类型列表
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/findProducts")
	@ResponseBody
	public String findProducts() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增Userinfo");
		PageData pd = new PageData();
		pd = this.getPageData();
		String parent_id = pd.getString("parent_id") == null?"":pd.getString("parent_id"); 
		List<Dictionaries> varList = userinfoService.findProducts(parent_id);
		String json = JSONArray.fromObject(varList).toString();
		return json;
	}
	
	
	
	/**删除
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value="/delete")
	public void delete(PrintWriter out) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"删除Userinfo");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		userinfoService.delete(pd);
		out.write("success");
		out.close();
	}
	
	
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改Userinfo");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		//pd.put("USER_BAOXIAN", pd.getString("editorValue"));
		userinfoService.edit(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	@RequestMapping(value="/updateEndDict")
	public void updateEndDict()throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改了用户产品关联表的产品类型");
		PageData pd = new PageData();
		pd = this.getPageData();
		userinfoService.updateEndDict(pd);
	}
	
	
	
	/**列表
	 * @param object
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表Userinfo");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		String user_groupid = (null==pd.get("USER_GROUPID")?"":pd.get("USER_GROUPID").toString().trim()); // 获得用户分组信息
		if(null != user_groupid && !"".equals(user_groupid)){
		pd.put("user_groupid", user_groupid);
		}
		String groupType = (null==pd.get("groupType")?"690745a213774651a563f127c6c1ebd9":pd.get("groupType").toString().trim());
		if(null != groupType && !"".equals(groupType)){
			pd.put("groupType", groupType);
		}
		page.setPd(pd);
		List<PageData> varList = userinfoService.list(page);	//列出Userinfo分组列表
		mv.setViewName("web/userinfo/userinfo_list");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		return mv;
	}
	

	
	
	/**去修改页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goAdd")
	public ModelAndView goAdd()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		mv.setViewName("web/userinfo/userinfo_edit");
		mv.addObject("msg", "save");
		mv.addObject("pd", pd);
		return mv;
	}	
	
	
	/**
	 * 查询这个用户所购买的产品
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/findProdictsByUserId")
	public ModelAndView findProdictsByUserId(Page page) throws Exception{
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		
		String USERINFO_ID = (String) this.getRequest().getSession().getAttribute("USERINFO_ID");
		USERINFO_ID = "null".equals(USERINFO_ID)?"":USERINFO_ID;
		
		pd.put("USERINFO_ID", USERINFO_ID);
		
		page.setPd(pd);
		// 查询这个用户购买的产品
		List varList = userinfoService.findProdictsByUserId(page);
		mv.addObject("varList", varList);
		
		// 查询所有产品
		List<Dictionaries> dictList = userinfoService.findProducts("4b9e9c84c8a2471eae114b1711c848b4");
		mv.addObject("dictList",dictList);
		mv.addObject("INVEST_DICTIONARIESID",pd.getString("FindDICTIONARIES_ID"));
		mv.setViewName("web/userinfo/productsinfo_list");
		mv.addObject("msg", "edit");
		mv.addObject("pd", pd);
		return mv;
		
		
	}
	
	
	 /**去修改页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goEdit")
	public ModelAndView goEdit(Model model ,HttpSession session,Page page)throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = userinfoService.findById(pd);	//根据ID读取
		
		// 获取到查看的这个用户ID存放到Session中
		String USERINFO_ID = pd.getString("USERINFO_ID");
		USERINFO_ID = null==USERINFO_ID?"":USERINFO_ID;
		session.setAttribute("USERINFO_ID", USERINFO_ID);
		
		page.setPd(pd);
		// 查询这个用户购买的产品
		List varList = userinfoService.findProdictsByUserId(page);
		mv.addObject("varList", varList);
		
		// 查询所有等级
		List<PageData> levelList = userinfoService.userLevel(null);
		mv.addObject("levelList",levelList);
		
		// 查询所有产品
		List<Dictionaries> dictList = userinfoService.findProducts("4b9e9c84c8a2471eae114b1711c848b4");
		mv.addObject("dictList",dictList);
		
		
		mv.addObject("zTreeNodes",getzTreeNodes(model));
		mv.setViewName("web/userinfo/userinfo_edit");
		mv.addObject("msg", "edit");
		mv.addObject("pd", pd);
		return mv;
	}
	
	
	
	
	
	
	
	
	public String getzTreeNodes(Model model){
		String json = "";
		try{
			//获取下拉列表
			JSONArray arr = JSONArray.fromObject(dictionariesService.listAllDictForAttr("690745a213774651a563f127c6c1ebd9"));
			json = arr.toString();
			model.addAttribute("zTreeNodes", json);
		} catch(Exception e){
			logger.error(e.toString(), e);;
		}
		return json;
	}
	
	 /**批量删除
	 * @param
	 * 
	 * @throws Exception
	 */
	@RequestMapping(value="/deleteAll")
	@ResponseBody
	public Object deleteAll() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"批量删除Userinfo");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			userinfoService.deleteAll(ArrayDATA_IDS);
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
		logBefore(logger, Jurisdiction.getUsername()+"导出Userinfo到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("用户ID");	//1
		titles.add("电话号码");	//2
		titles.add("密码");	//3
		titles.add("等级");	//4
		titles.add("注册时间");	//5
		titles.add("昵称");	//6
		titles.add("头像");	//7
		titles.add("用户状态");	//8
		titles.add("微信号");	//9
		dataMap.put("titles", titles);
		List<PageData> varOList = userinfoService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("USERINFO_ID"));	    //1
			vpd.put("var2", varOList.get(i).getString("USER_PHONE"));	    //2
			vpd.put("var3", varOList.get(i).getString("USER_PASSWORD"));	    //3
			vpd.put("var4", varOList.get(i).getString("USER_ROLE_ID"));	    //4
			vpd.put("var5", varOList.get(i).get("USER_CREATETIME").toString());	    //5
			vpd.put("var6", varOList.get(i).getString("USER_NICKNAME"));	    //6
			vpd.put("var7", varOList.get(i).getString("USER_PHOTO"));	    //7
			vpd.put("var8", varOList.get(i).get("USER_STATE").toString());	//8
			vpd.put("var9", varOList.get(i).getString("USER_OPPNID"));	    //9
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
	
	/**
	 * 显示列表ztree
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/listAllDict")
	public ModelAndView listAllDict(Model model,String DICTIONARIES_ID)throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try{
			JSONArray arr = JSONArray.fromObject(userinfoService.listAllDict("0"));
			String json = arr.toString();
			json = json.replaceAll("PARENT_ID", "pId").replaceAll("NAME", "name").replaceAll("subDict", "nodes").replaceAll("hasDict", "checked").replaceAll("treeurl", "url");
			model.addAttribute("zTreeNodes", json);
			mv.addObject("DICTIONARIES_ID",DICTIONARIES_ID);
			mv.addObject("pd", pd);	
			mv.setViewName("web/userinfo/userinfo_ztree");
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}

}
