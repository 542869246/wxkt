package com.flc.controller.system.invest;

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
import com.flc.entity.system.User;
import com.flc.util.AppUtil;
import com.flc.util.Const;
import com.flc.util.ObjectExcelView;
import com.flc.util.PageData;
import com.flc.util.Jurisdiction;
import com.flc.util.Tools;
import com.flc.service.system.invest.InvestManager;
import com.flc.service.web.userinfo.UserinfoManager;

/** 
 * 说明：产品信息关联表
 * 创建人：FLC
 * 创建时间：2017-10-31
 */
@Controller
@RequestMapping(value="/invest")
public class InvestController extends BaseController {
	
	String menuUrl = "invest/list.do"; //菜单地址(权限用)
	@Resource(name="investService")
	private InvestManager investService;
	
	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增Invest");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("INVEST_ID", this.get32UUID());	//主键
		investService.save(pd);
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
		logBefore(logger, Jurisdiction.getUsername()+"删除Invest");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		investService.delInvestUser(pd);
		out.write("success");
		out.close();
	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改Invest");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		investService.edit(pd);
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
		logBefore(logger, Jurisdiction.getUsername()+"列表Invest");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		List<PageData>	varList = investService.list(page);	//列出Invest列表
		mv.setViewName("system/invest/invest_list");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		return mv;
	}
	/**列表
	 * @param object
	 * @throws Exception
	 */
	@RequestMapping(value="/userList")
	public ModelAndView userList(Page page) throws Exception{
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
		List<PageData> varList1 = investService.list(page);
		List<PageData> varList = investService.findUser(page);	//列出Userinfo分组列表
		mv.setViewName("system/productsinfo/userinfo_list");
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
		mv.setViewName("system/invest/invest_edit");
		mv.addObject("msg", "save");
		mv.addObject("pd", pd);
		return mv;
	}	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/guanlianUesr")
	public ModelAndView guanlianUser() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表Invest");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String PRODUCTSINFO_ID = pd.getString("PRODUCTSINFO_ID");
		PRODUCTSINFO_ID = (null==PRODUCTSINFO_ID?"":PRODUCTSINFO_ID);
		
		//获取创建时间
		Date date = new Date();
		SimpleDateFormat sdf =  new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		//获取创建人id
		User user=(User)this.getRequest().getSession().getAttribute(Const.SESSION_USER);
		pd.put("PRODUCTSINFO_ID", PRODUCTSINFO_ID);
		pd.put("INVEST_CREATEBY", user.getUSER_ID());
		pd.put("INVEST_CREATETIME", sdf.format(date));
		pd.put("INVEST_DICTIONARIESID", "");
		
		String usid = pd.getString("usersid"); 
		
		if (!usid.trim().equals("")) {
			String substring = usid.substring(0, usid.length()-1);
			String[] split = substring.split(",");
			for (int i = 0; i < split.length; i++) {
				//System.out.println(split[i]);
				pd.put("INVEST_ID", this.get32UUID());
				pd.put("INVEST_USER_ID", split[i]);
				investService.guanlianUser(pd);
			}
		}
		mv.setViewName("system/productsinfo/userinfo_list");
		mv.addObject("pd", pd);
		mv.addObject("success", "Y");
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
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
		pd = investService.findById(pd);	//根据ID读取
		mv.setViewName("system/invest/invest_edit");
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
		logBefore(logger, Jurisdiction.getUsername()+"批量删除Invest");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			for (int i = 0; i < ArrayDATA_IDS.length; i++) {
				pd.put("INVEST_ID", ArrayDATA_IDS[i]);
				try {
					investService.delInvestUser(pd);
					pd.put("msg", "ok");
				} catch (Exception e) {
					pd.put("msg", "no");
				}
			}
			//investService.deleteAll(ArrayDATA_IDS);
			
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
		logBefore(logger, Jurisdiction.getUsername()+"导出Invest到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("关联ID");	//1
		titles.add("关联的用户");	//2
		titles.add("关联的产品");	//3
		titles.add("创建时间");	//4
		titles.add("创建人");	//5
		titles.add("备注6");	//6
		titles.add("备注7");	//7
		dataMap.put("titles", titles);
		List<PageData> varOList = investService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("INVEST_ID"));	    //1
			vpd.put("var2", varOList.get(i).getString("INVEST_USER_ID"));	    //2
			vpd.put("var3", varOList.get(i).getString("INVEST_PRODICTS_ID"));	    //3
			vpd.put("var4", varOList.get(i).getString("INVEST_CREATETIME"));	    //4
			vpd.put("var5", varOList.get(i).getString("INVEST_CREATEBY"));	    //5
			vpd.put("var6", varOList.get(i).getString("INVEST_DICTIONARIESID"));	    //6
			vpd.put("var7", varOList.get(i).get("INVEST_STATE").toString());	//7
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
