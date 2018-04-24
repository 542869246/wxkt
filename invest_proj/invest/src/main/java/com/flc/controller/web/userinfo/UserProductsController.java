package com.flc.controller.web.userinfo;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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
import com.flc.entity.system.User;
import com.flc.service.system.dictionaries.DictionariesManager;
import com.flc.service.system.products.productsinfo.ProductsinfoManager;
import com.flc.service.web.userinfo.UserinfoManager;
import com.flc.util.AppUtil;
import com.flc.util.Const;
import com.flc.util.Jurisdiction;
import com.flc.util.ObjectExcelView;
import com.flc.util.PageData;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/** 
 * 说明：产品管理
 * 创建人：FLC
 * 创建时间：2017-10-24
 */
@Controller
@RequestMapping(value="/userProduct")
public class UserProductsController extends BaseController {
	
	String menuUrl = "userProduct/list.do"; //菜单地址(权限用)
	@Resource(name="productsinfoService")
	private ProductsinfoManager productsinfoService;
	
	@Resource(name="dictionariesService")
	private DictionariesManager dictionariesService;
	
	@Resource(name="userinfoService")
	private UserinfoManager userinfoService;
	
	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	@ResponseBody
	public String save(HttpSession session) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增Productsinfo");
//		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		User user = (User) session.getAttribute(Const.SESSION_USER);
		String INVEST_CREATEBY=""; 
		if(null==user){
			return "no";
		}
		INVEST_CREATEBY = user.getUSER_ID(); //获取创建这条信息的管理员ID
		
		String USERINFO_ID = (String) session.getAttribute("USERINFO_ID");
		USERINFO_ID = null==USERINFO_ID?"":USERINFO_ID;
		
		String PRODUCTSINFO_ID = pd.getString("PRODUCTSINFO_ID");
		PRODUCTSINFO_ID = null==PRODUCTSINFO_ID?"":PRODUCTSINFO_ID;
		
		String INVEST_ID = this.get32UUID();	//生成一条产品ID
		String INVEST_CREATETIME = this.getTime(); //获取创建时间
		
		pd.put("PRODUCTSINFO_ID", PRODUCTSINFO_ID); //获得被用户购买的产品ID
		pd.put("INVEST_ID", INVEST_ID);
		pd.put("USERINFO_ID", USERINFO_ID);
		pd.put("INVEST_CREATEBY", INVEST_CREATEBY);
		pd.put("INVEST_CREATETIME", INVEST_CREATETIME);
		
		userinfoService.saveUserInvest(pd);
		
		return "yes";
	}
	
	
	
	
	/** 批量保存用户购买产品
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/batchSave")
	@ResponseBody
	public String batchSave() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"批量新增 user_invest");
		PageData pd = new PageData();
		pd = this.getPageData();
		String select_checkbox = pd.getString("select_checkbox");
		select_checkbox = select_checkbox.substring(0, select_checkbox.lastIndexOf(","));
		String[] INVEST_PRODICTS_ID = select_checkbox.split(",");    // 产品ID
		
		String INVEST_USER_ID = (String) this.getRequest().getSession().getAttribute("USERINFO_ID");	// 获得这个用户的ID
		User user = (User) this.getRequest().getSession().getAttribute(Const.SESSION_USER); //获得当前管理员
		
		pd.put("INVEST_DICTIONARIESID", "");
		pd.put("INVEST_CREATEBY", user.getUSER_ID());
		pd.put("INVEST_CREATETIME", this.getTime());
		pd.put("INVEST_USER_ID", null==INVEST_USER_ID?"":INVEST_USER_ID);
		
		if(INVEST_PRODICTS_ID.length==0)return "no";
		for (String proid : INVEST_PRODICTS_ID) {
			pd.put("INVEST_ID", this.get32UUID());
			pd.put("INVEST_PRODICTS_ID", proid);
			userinfoService.batchSave(pd);
		}
		return "yes";
		
	}
	
	
	
	
	
	
	
	
	/**
	 * 返回系统当前时间
	 * @return
	 */
	public String getTime(){
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
		return df.format(new Date());
	}
	/**
	 * 显示列表ztree
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/listAllDict")
	public ModelAndView listAllDict(Model model)throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try{
			JSONArray arr = JSONArray.fromObject(dictionariesService.listAllDict1("50b463cdb2df11e7bfc600163e1a9d37"));
			String json = arr.toString();
			json = json.replaceAll("DICTIONARIES_ID", "id")
					.replaceAll("PARENT_ID", "pId")
					.replaceAll("NAME", "name")
					.replaceAll("subDict", "nodes")
					.replaceAll("hasDict", "checked")
					.replaceAll("treeurl", "url")
					.replaceAll("productsinfo/list.do", "userProduct/list.do");
			model.addAttribute("zTreeNodes", json);
			this.getRequest().getSession().setAttribute("prodictsIds", pd.getString("prodictsIds"));
			mv.addObject("pd", pd);	
			mv.setViewName("web/userinfo/userMsg_ztree");
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}
	
	/**系统续存 调用
	 * 显示列表
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/listAllMess")
	public ModelAndView listAllMess(Model model,String DICTIONARIES_ID)throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		boolean flag = true;
		try{
			JSONArray arr = JSONArray.fromObject(dictionariesService.listAllDict2("50b463cdb2df11e7bfc600163e1a9d37"));
			String json = arr.toString();
			
			json = json.replaceAll("DICTIONARIES_ID", "id")
					.replaceAll("PARENT_ID", "pId")
					.replaceAll("NAME", "name")
					.replaceAll("subDict", "nodes")
					.replaceAll("hasDict", "checked")
					.replaceAll("treeurl", "url");
			
			model.addAttribute("zTreeNodes", json);
			
			mv.addObject("DICTIONARIES_ID",DICTIONARIES_ID);
			mv.addObject("pd", pd);	
			mv.setViewName("dep/messageinfo/messageinfo_ztree");
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}
	/** 读取并展示产品列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/listMess")
	public ModelAndView listMess(Model model,Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表Productsinfo");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");				//关键词检索条件
		String ATTR_TYPEID = pd.getString("ATTR_TYPEID");
		if(null != ATTR_TYPEID && !"".equals(ATTR_TYPEID)){
			pd.put("ATTR_TYPEID", ATTR_TYPEID.trim());
		}
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		List<PageData>	varList = productsinfoService.list(page);	//列出Attribute列表
		
		String USERINFO_ID = (String) this.getRequest().getSession().getAttribute("USERINFO_ID");
		USERINFO_ID = null==USERINFO_ID?"":USERINFO_ID; //取得用户ID
		
		pd.put("USERINFO_ID",USERINFO_ID);
		List<PageData> purchasedList = userinfoService.findProdictsByUserIdToAll(pd); // 取得当前用户所购买的产品信息
		
		for (PageData var : varList) {
			for (PageData purchase : purchasedList) {
				if(purchase.getString("INVEST_PRODICTS_ID").equals(var.getString("PRODUCTSINFO_ID"))){
					var.put("iscz", "iscz");
					break;
				}else{
					var.put("iscz", "notcz");
				}
			}
		}
		
		JzZtree(model);//调用JzZtree方法
		mv.setViewName("web/userinfo/userMsgProducts_list");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		return mv;
	}
	
	
	
	//加载ztree数据
	public void JzZtree(Model model){
		try{
			//获取下拉列表
			JSONArray arr = JSONArray.fromObject(dictionariesService.listAllDictForAttr("50b463cdb2df11e7bfc600163e1a9d37"));
			String json = arr.toString();
			model.addAttribute("zTreeNodes", json);
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(Model model,Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表Productsinfo");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
//		Object obj = this.getRequest().getSession().getAttribute("prodictsIds");
//		String[] prodictsId=null;
//		if(obj!=null){
//			String  prodictsIds=(String)obj;
//			prodictsId = prodictsIds.split(";");
//		}
		//String attrType = pd.getString("attrType");
		String keywords = pd.getString("keywords");				//关键词检索条件
		String ATTR_TYPEID = pd.getString("ATTR_TYPEID");
		if(null != ATTR_TYPEID && !"".equals(ATTR_TYPEID)){
			pd.put("ATTR_TYPEID", ATTR_TYPEID.trim());
		}
//		if(null == attrType || "".equals(attrType)){
//			pd.put("ATTR_TYPEID", null);
//		}
		
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		
		page.setPd(pd);
		List<PageData>	varList = productsinfoService.list(page);	//列出Attribute列表
		String USERINFO_ID = (String) this.getRequest().getSession().getAttribute("USERINFO_ID");
		USERINFO_ID = null==USERINFO_ID?"":USERINFO_ID; //取得用户ID
		
		pd.put("USERINFO_ID",USERINFO_ID);
		List<PageData> purchasedList = userinfoService.findProdictsByUserIdToAll(pd); // 取得当前用户所购买的产品信息
		
		for (PageData var : varList) {
			for (PageData purchase : purchasedList) {
				if(purchase.getString("INVEST_PRODICTS_ID").equals(var.getString("PRODUCTSINFO_ID"))){
					var.put("iscz", "iscz");
					break;
				}else{
					var.put("iscz", "notcz");
				}
			}
		}
		
		
//		if(prodictsId!=null&&prodictsId.length>0){
//			for (int i = 0; i < varList.size(); i++) {
//				for (int j = 0; j < prodictsId.length; j++) {
//					String str = varList.get(i).getString("PRODUCTSINFO_ID");
//					if(str.equals(prodictsId[j])){
//						varList.get(i).put("iscz", "iscz");
//						break;
//					}else{
//						varList.get(i).put("iscz", "notcz");
//					}
//				}
//			}
//		}
//		
		
		JzZtree(model);//调用JzZtree方法
		mv.setViewName("web/userinfo/userMsgProducts_list");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		return mv;
	}
	

	
	@InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
	}
}
