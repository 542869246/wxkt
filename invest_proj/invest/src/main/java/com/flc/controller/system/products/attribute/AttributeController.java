package com.flc.controller.system.products.attribute;

import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
import net.sf.json.JSONObject;

import com.flc.service.system.dictionaries.DictionariesManager;
import com.flc.service.system.products.attribute.AttributeManager;

/** 
 * 说明：产品属性详细信息
 * 创建人：FLC
 * 创建时间：2017-10-20
 */
@Controller
@RequestMapping(value="/attribute")
public class AttributeController extends BaseController {
	
	String menuUrl = "attribute/list.do"; //菜单地址(权限用)
	@Resource(name="attributeService")
	private AttributeManager attributeService;
	@Resource(name="dictionariesService")
	private DictionariesManager dictionariesService;
	
	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增Attribute");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("ATTRIBUTE_ID", this.get32UUID());	//主键
		//pd.put("ATTRIBUTE_ID", "");	//编号
		//pd.put("typeId", attributeService.findTypeByName(pd).get("DICTIONARIES_ID"));//通过类型名称获取ID
		attributeService.save(pd);
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
		logBefore(logger, Jurisdiction.getUsername()+"删除Attribute");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		attributeService.delete(pd);
		out.write("success");
		out.close();
	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改Attribute");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		attributeService.edit(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**ajax  修改
	 * @param
	 * @throws Exception
	 */
	/*@RequestMapping(value="/ajaxEdit")
	@ResponseBody
	public PageData ajaxEdit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改Attribute");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		String ATTRIBUTE_ID = pd.getString("ATTRIBUTE_ID");				//关键词检索条件
		if(null != ATTRIBUTE_ID && !"".equals(ATTRIBUTE_ID)){
			pd.put("PRODUCTATTR_ATTR_TYPEID", ATTRIBUTE_ID.trim());
		}else{
			pd.put("PRODUCTATTR_ATTR_TYPEID","");
		}
		String PRODUCTSINFO_ID = pd.getString("PRODUCTSINFO_ID");				//关键词检索条件
		if(null != PRODUCTSINFO_ID && !"".equals(PRODUCTSINFO_ID)){
			pd.put("PRODUCTATTR_PRODUCT_ID", PRODUCTSINFO_ID.trim());
		}
		attributeService.ajaxEdit(pd);
		return pd;
	}*/
	
	
	
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/editVal")
	public ModelAndView editVal() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改Attribute");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		HttpServletRequest request = this.getRequest();
		String[] attrvalue = request.getParameterValues("ATTRVALUE");
		String[] productattr_attr_typeid = request.getParameterValues("PRODUCTATTR_ATTR_TYPEID");
		String[] attr_asc = request.getParameterValues("ATTR_ASC");
		//批量修改属性默认值
		for (int i = 0; i < attrvalue.length; i++) {
			pd.put("ATTRVALUE", attrvalue[i]);
			pd.put("PRODUCTATTR_ATTR_TYPEID", productattr_attr_typeid[i]);
			pd.put("ATTR_ASC", attr_asc[i]);
			attributeService.editVal(pd);
		}
		List<PageData> attrList = attributeService.findAttrByProid(pd); //通过产品ID查询属性
		//JzZtree(model);//调用JzZtree方法
		mv.addObject("msg", "goShowAttr");
		mv.addObject("attrList", attrList);
		mv.addObject("pd", pd);
		mv.setViewName("system/attribute/attribute_edit");
		return mv;
	}
	
	
	public void JzZtree(Model model){
		try{
			//获取下拉列表
			JSONArray arr = JSONArray.fromObject(dictionariesService.listAllDictForAttr("943e53d418784a5094a5e67ef6838587"));
			String json = arr.toString();
			model.addAttribute("zTreeNodes", json);
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
	}
	
	
	
	/**列表+ztree
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(Model model, Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表Attribute");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		String ATTR_TYPEID = pd.getString("ATTR_TYPEID");				//关键词检索条件
		if(null != ATTR_TYPEID && !"".equals(ATTR_TYPEID)){
			pd.put("ATTR_TYPEID", ATTR_TYPEID.trim());
		}
		page.setPd(pd);
		
		List<PageData>	varList = attributeService.list(page);	//列出Attribute列表
		JzZtree(model);//调用JzZtree方法
		mv.setViewName("system/attribute/attribute_list");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		return mv;
	}
	/**
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/guanlianAttrlist")
	public ModelAndView guanlianAttrlist(Model model, Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表Attribute");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		String ATTR_TYPEID = pd.getString("ATTR_TYPEID");				//关键词检索条件
		if(null != ATTR_TYPEID && !"".equals(ATTR_TYPEID)){
			pd.put("ATTR_TYPEID", ATTR_TYPEID.trim());
		}
		String PRODUCTSINFO_ID = pd.getString("PRODUCTSINFO_ID");				//关键词检索条件
		if(null != PRODUCTSINFO_ID && !"".equals(PRODUCTSINFO_ID)){
			pd.put("PRODUCTSINFO_ID", PRODUCTSINFO_ID.trim());
		}
		
		/*HttpServletRequest request = this.getRequest();
		String[] oldarrs = request.getParameterValues("PRODUCTATTR_ATTR_TYPEID");
		for (int i = 0; i < oldarrs.length; i++) {
			System.out.println(oldarrs[i]);
		}
		*/
		List<PageData> findAttrByProid = attributeService.findAttrByProid(pd);
		String oldAttr = "";
		for (PageData pageData : findAttrByProid) {
			oldAttr+= pageData.getString("ATTRIBUTE_ID")+",";
		}
		if (oldAttr != null && oldAttr != "") {
			oldAttr=oldAttr.substring(0, oldAttr.length()-1);
		}
		//System.out.println(oldAttr);
		
		JSONArray attrList = JSONArray.fromObject(findAttrByProid);//通过产品ID查询属性
		
		
		pd.put("attrList", attrList);
		page.setPd(pd);
		List<PageData>	varList = attributeService.list(page);	//列出Attribute列表
		JzZtree(model);//调用JzZtree方法
		mv.setViewName("system/productsinfo/attribute_list");
		mv.addObject("varList", varList);
		mv.addObject("oldAttr",oldAttr);
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		return mv;
	}
	/**
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/glEdit")
	public ModelAndView glEdit(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表Attribute");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		/*String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		String ATTR_TYPEID = pd.getString("ATTR_TYPEID");				//关键词检索条件
		if(null != ATTR_TYPEID && !"".equals(ATTR_TYPEID)){
			pd.put("ATTR_TYPEID", ATTR_TYPEID.trim());
		}*/
		//PageData ppd= JSONObject.fromObject(pd.getString("pdd"));
		String PRODUCTSINFO_ID = pd.getString("PRODUCTSINFO_ID");				//关键词检索条件
		if(null != PRODUCTSINFO_ID && !"".equals(PRODUCTSINFO_ID)){
			pd.put("PRODUCTSINFO_ID", PRODUCTSINFO_ID.trim());
		}
		
		
		String atrs = pd.getString("atrs");
		//System.out.println(atrs);
		//如果勾选不为空
		if (!atrs.equals("")) {
			atrs = atrs.substring(0, atrs.length()-1);
			String[] newar = atrs.split(",");
			System.out.println(newar);
			//如果之前属性不为空
			String oldstr = pd.getString("oldAttr");
			if (oldstr!=null && oldstr!="") {
				String[] oldar = oldstr.split(",");
				//遍历原来的属性ID
				for (int i = 0; i < oldar.length; i++) {
					//如果原来的属性还存在
					if (new ArrayList(Arrays.asList(newar)).contains(oldar[i])) {
						continue;
					}else{
						//否则删除
						pd.put("PRODUCTATTR_ATTR_TYPEID", oldar[i]);
						attributeService.deleteGuanxi(pd);
					}
				}
				//遍历现在的属性
				for (int i = 0; i < newar.length; i++) {
					//判断属性之前是否存在
					if (!new ArrayList(Arrays.asList(oldar)).contains(newar[i])) {
						pd.put("PRODUCTATTR_ID", this.get32UUID());
						//不存在 则新增属性并赋予默认值ATTRIBUTE_ID
						pd.put("PRODUCTATTR_ATTR_TYPEID", newar[i]);
						PageData paged = attributeService.findAttrValue(pd);
						
						try {
							pd.put("ATTRSS",paged.getString("ATTR_VALUE"));
						} catch (NullPointerException e) {
							pd.put("ATTRSS","");
						}finally{
							attributeService.saveGuanxi(pd);
						}
						
					}else{
						continue;
					}
				}
			}
		}
		
		
	
		mv.setViewName("system/productsinfo/attribute_list");
		mv.addObject("success", "Y");
		mv.addObject("pd",pd);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		return mv;
	}
	 /**去显示单个产品属性页面
		 * @param
		 * @throws Exception
		 */
		@RequestMapping(value="/goShowAttr")
		public ModelAndView goShowAttr()throws Exception{
			ModelAndView mv = this.getModelAndView();
			PageData pd = new PageData();
			pd = this.getPageData();
			List<PageData> attrList = attributeService.findAttrByProid(pd); //通过产品ID查询属性
			//JzZtree(model);//调用JzZtree方法
			mv.setViewName("system/attribute/attribute_edit");
			mv.addObject("msg", "goShowAttr");
			mv.addObject("attrList", attrList);
			mv.addObject("pd", pd);
			return mv;
		}	
//	/**列表
//	 * @param page
//	 * @throws Exception
//	 */
//	@RequestMapping(value="/list1")
//	public ModelAndView list1(Page page) throws Exception{
//		logBefore(logger, Jurisdiction.getUsername()+"列表Attribute");
//		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
//		ModelAndView mv = this.getModelAndView();
//		PageData pd = new PageData();
//		pd = this.getPageData();
//		String keywords = pd.getString("keywords");				//关键词检索条件
//		if(null != keywords && !"".equals(keywords)){
//			pd.put("keywords", keywords.trim());
//		}
//		page.setPd(pd);
//		List<PageData>	varList = attributeService.listMoreTable(page);	//列出Attribute列表
//		
//		mv.setViewName("system/attribute/attribute_list");
//		mv.addObject("varList", varList);
//		mv.addObject("pd", pd);
//		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
//		return mv;
//	}
	
	/**去新增页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goAdd")
	public ModelAndView goAdd(Model model)throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		JzZtree(model);//调用JzZtree方法
		mv.setViewName("system/attribute/attribute_edit");
		mv.addObject("msg", "save");
		mv.addObject("pd", pd);
		return mv;
	}	
	
	 /**去修改页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goEdit")
	public ModelAndView goEdit(Model model)throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = attributeService.findById(pd);	//根据ID读取
		JzZtree(model);//调用JzZtree方法
		mv.setViewName("system/attribute/attribute_edit");
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
		logBefore(logger, Jurisdiction.getUsername()+"批量删除Attribute");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			attributeService.deleteAll(ArrayDATA_IDS);
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
		logBefore(logger, Jurisdiction.getUsername()+"导出Attribute到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("编号");	//1
		titles.add("属性名");	//2
		titles.add("默认值");	//3
		titles.add("类型");	//4
		dataMap.put("titles", titles);
		List<PageData> varOList = attributeService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("ATTRIBUTE_ID"));	    //1
			vpd.put("var2", varOList.get(i).getString("ATTR_NAME"));	    //2
			vpd.put("var3", varOList.get(i).getString("ATTR_VALUE"));	    //3
			vpd.put("var4", varOList.get(i).getString("ATTR_TYPEID"));	    //4
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
