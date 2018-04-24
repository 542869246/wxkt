package com.flc.controller.web.invest;

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
import com.flc.util.Tools;
import com.flc.service.system.dictionaries.DictionariesManager;
import com.flc.service.web.invest.InvestManager;
import com.flc.service.web.userinfo.UserinfoManager;
import com.flc.service.web.userinfo.impl.UserinfoService;

/**
 * 说明：产品信息分组信息用户信息关联表 创建人：FLC 创建时间：2017-10-25
 */
@Controller
@RequestMapping(value = "/investMain")
public class InvestController extends BaseController {

	// String menuUrl = "invest/list.do"; //菜单地址(权限用)
	@Resource(name = "investService")
	private InvestManager investService;

	@Resource(name = "dictionariesService")
	private DictionariesManager dictionariesService;

	@Resource(name = "userinfoService")
	private UserinfoManager userinfoService;

	/**
	 * 保存
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/save")
	public ModelAndView save() throws Exception {
		logBefore(logger, "新增Invest");
		// if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;}
		// //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("INVEST_ID", this.get32UUID()); // 主键
		investService.save(pd);
		mv.addObject("msg", "success");
		mv.setViewName("save_result");
		return mv;
	}

	/**
	 * 删除
	 * 
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value = "/delete")
	public void delete(PrintWriter out) throws Exception {
		logBefore(logger, "删除Invest");
		// if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		investService.delete(pd);
		out.write("success");
		out.close();
	}

	/**
	 * 修改
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/edit")
	public ModelAndView edit() throws Exception {
		logBefore(logger, "修改Invest");
		// if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;}
		// //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		investService.edit(pd);
		mv.addObject("msg", "success");
		mv.setViewName("save_result");
		return mv;
	}

	/**
	 * 列表
	 * 
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value = "/list")
	public ModelAndView list(Page page) throws Exception {
		logBefore(logger, "列表Invest");
		// if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		// //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords"); // 关键词检索条件
		if (null != keywords && !"".equals(keywords)) {
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		List<PageData> varList = investService.list(page); // 列出Invest列表
		mv.setViewName("web/invest/invest_list");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		// mv.addObject("QX",Jurisdiction.getHC()); //按钮权限
		return mv;
	}

	/**
	 * 去新增页面
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/goAdd")
	public ModelAndView goAdd() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		mv.setViewName("web/invest/invest_edit");
		mv.addObject("msg", "save");
		mv.addObject("pd", pd);
		return mv;
	}

	/**
	 * 去修改页面
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/goEdit")
	public ModelAndView goEdit() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = investService.findById(pd); // 根据ID读取
		mv.setViewName("web/invest/invest_edit");
		mv.addObject("msg", "edit");
		mv.addObject("pd", pd);
		return mv;
	}

	/**
	 * 批量删除
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/deleteAll")
	@ResponseBody
	public Object deleteAll() throws Exception {
		logBefore(logger, "批量删除Invest");
		// if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;}
		// //校验权限
		PageData pd = new PageData();
		Map<String, Object> map = new HashMap<String, Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if (null != DATA_IDS && !"".equals(DATA_IDS)) {
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			investService.deleteAll(ArrayDATA_IDS);
			pd.put("msg", "ok");
		} else {
			pd.put("msg", "no");
		}
		pdList.add(pd);
		map.put("list", pdList);
		return AppUtil.returnObject(pd, map);
	}

	/**
	 * 导出到excel
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/excel")
	public ModelAndView exportExcel() throws Exception {
		logBefore(logger, "导出Invest到excel");
		// if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String, Object> dataMap = new HashMap<String, Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("关联ID"); // 1
		titles.add("用户ID"); // 2
		titles.add("产品ID"); // 3
		titles.add("创建时间"); // 4
		titles.add("创建人"); // 5
		titles.add("字典表分组ID"); // 6
		dataMap.put("titles", titles);
		List<PageData> varOList = investService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for (int i = 0; i < varOList.size(); i++) {
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("INVEST_ID")); // 1
			vpd.put("var2", varOList.get(i).getString("INVEST_USER_ID")); // 2
			vpd.put("var3", varOList.get(i).getString("INVEST_PRODICTS_ID")); // 3
			vpd.put("var4", varOList.get(i).getString("INVEST_CREATETIME")); // 4
			vpd.put("var5", varOList.get(i).getString("INVEST_CREATEBY")); // 5
			vpd.put("var6", varOList.get(i).getString("INVEST_DICTIONARIESID")); // 6
			varList.add(vpd);
		}
		dataMap.put("varList", varList);
		ObjectExcelView erv = new ObjectExcelView();
		mv = new ModelAndView(erv, dataMap);
		return mv;
	}

	/**
	 * 我的投资列表
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/userProdctsinfoMain")
	public ModelAndView userProdctsinfo(HttpSession session) throws Exception {
		ModelAndView mav = new ModelAndView();
		PageData pd = (PageData) session.getAttribute("loginuser");
		// 产品分组
		List<PageData> list = investService.findByUidGroupBY(pd);
		PageData page = new PageData();
		page.put("PARENT_ID", "4b9e9c84c8a2471eae114b1711c848b4");
		List<PageData> list1 = dictionariesService.listAll(page);
		mav.addObject("list1", list1);
		mav.addObject("pd", userinfoService.findById(pd));
		mav.setViewName("myinvest/my_invest");
		return mav;
	}

	/**
	 * 根据用户和分组信息查询每个人的产品信息
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/findByInvestId")
	public ModelAndView findByInvestId(Page page) throws Exception {
		ModelAndView mav = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		// 当前每页行数
		page.setShowCount(8);
		PageData pdflag =(PageData) getRequest().getSession().getAttribute("loginuser");
		pd.put("INVEST_USER_ID", pdflag.get("USERINFO_ID"));
		// 把当前的参数放入到实体类中去
		page.setPd(pd);
		List<PageData> list = investService.list(page);
		mav.addObject("list", list);
		mav.addObject("page", page);
		mav.setViewName("system/invest_list/invest_userlist");
		return mav;
	}

	/**
	 * 根据用户和分组信息查询每个人的产品信息
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/listAll")
	@ResponseBody
	public PageData listAll(Page page) throws Exception {
		PageData pd = new PageData();
		pd = this.getPageData();
		// 当前每页行数
		page.setShowCount(8);
		// 把当前的参数放入到实体类中去
		page.setPd(pd);
		List<PageData> list = investService.list(page);
		PageData result = new PageData();
		result.put("list", list);
		result.put("page", page);
		return result;
	}

	/**
	 * 查询个人保险信息
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/secure")
	public ModelAndView findBySecure() throws Exception {
		ModelAndView mav = new ModelAndView();
		PageData pds = (PageData) getRequest().getSession().getAttribute("loginuser");
		mav.addObject("secure", userinfoService.findById(pds));
		mav.setViewName("secure/secure");
		return mav;
	}

	@InitBinder
	public void initBinder(WebDataBinder binder) {
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format, true));
	}
}
