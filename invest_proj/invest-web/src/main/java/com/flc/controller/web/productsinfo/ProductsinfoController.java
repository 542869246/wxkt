package com.flc.controller.web.productsinfo;

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
import javax.swing.plaf.synth.SynthSpinnerUI;

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
import com.flc.util.PageData;
import com.flc.util.Tools;
import com.flc.service.system.dictionaries.DictionariesManager;
import com.flc.service.web.attribute.AttributeManager;
import com.flc.service.web.details.DetailsManager;
import com.flc.service.web.groupby.GroupbyManager;
import com.flc.service.web.groupby.impl.GroupbyService;
import com.flc.service.web.invest.InvestManager;
import com.flc.service.web.news.NewsManager;
import com.flc.service.web.productsinfo.ProductsinfoManager;
import com.flc.service.web.userinfo.UserinfoManager;

/** 
 * 说明：产品信息表
 * 创建人：FLC
 * 创建时间：2017-10-20
 */
@Controller
@RequestMapping(value="/productsinfo")
public class ProductsinfoController extends BaseController {

	//String menuUrl = "productsinfo/list.do"; //菜单地址(权限用)
	@Resource(name="productsinfoService")
	private ProductsinfoManager productsinfoService;

	@Resource(name="attributeService")
	private AttributeManager attributeManager;


	@Resource(name="detailsService")
	private DetailsManager detailsService;

	@Resource(name="newsService")
	private NewsManager newsService;

	//权限问题
	@Resource(name="groupbyService")
	private GroupbyManager groupbyService;

	//查询产品下的背景图片
	@Resource(name="dictionariesService")
	private DictionariesManager dictionariesService;
	
	//查询用户是否购买产品
	@Resource(name = "investService")
	private InvestManager investService;
	
	// 查询用户的
	@Resource(name = "userinfoService")
	private UserinfoManager userinfoService;

	//定义一个全局的变量去接受图片的路径
	private String strUrl = "";

	/**
	 *  按照模块查询全部的信息
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/findAll")
	@ResponseBody
	public ModelAndView findAll(Page page) throws Exception{
		logBefore(logger, "模块查询全部的信息");
		ModelAndView mav = new ModelAndView();
		PageData pd = new PageData();
		// 当前每页行数
		page.setShowCount(8);
		pd = this.getPageData();
		// 把当前的参数放入到实体类中去
		page.setPd(pd);
		// 返回当前的集合
		List<PageData> list = productsinfoService.list(page);
		mav.addObject("list", list);
		mav.addObject("page", page);
		strUrl = (String) pd.get("parent_id");
		mav.addObject("strUrl", strUrl);
		mav.setViewName("system/invest_list/invest_list");
		return mav;
	}

	/**
	 *  按照模块查询全部的信息（ajax查询）
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/listAll")
	@ResponseBody
	public PageData listAll(Page page) throws Exception{
		logBefore(logger, "模块查询全部的信息");
		PageData pd = new PageData();
		// 当前每页行数
		page.setShowCount(8);
		pd = this.getPageData();
		// 把当前的参数放入到实体类中去
		page.setPd(pd);
		// 返回当前的集合
		List<PageData> list = productsinfoService.list(page);
		PageData result = new PageData();
		result.put("list", list);
		result.put("page", page);
		result.put("strUrl", strUrl);
		return result;
	}

	/**
	 *  按照模块查询个人信息
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value ="/findById")
	public ModelAndView findById(Page page1,HttpSession session) throws Exception{
		logBefore(logger, "模块查询个人信息");
		// 返回当前的集合
		ModelAndView mav = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		// 循环属性的
		List<PageData> attrList = attributeManager.listAll(pd);
		// 查询个人相信信息
		Object obj = productsinfoService.findById(pd);
		// 当前每页行数
		page1.setShowCount(3);
		// 把当前的参数放入到实体类中去
		page1.setPd(pd);
		// 查询pdf文件信息
		List<PageData> list = detailsService.list(page1);
		Page page2 = new Page();
		page2.setShowCount(3);
		page2.setPd(pd);
		// 查询新闻的信息
		List<PageData> newList = newsService.list(page2);
		mav.addObject("newList", newList);
		mav.addObject("page2", page2);
		mav.addObject("attrList",attrList);
		mav.addObject("obj", obj);
		
		session.setAttribute("obj", obj);
		mav.addObject("pdfObj", list);
		mav.addObject("page1", page1);
		// 权限认证判断
		PageData pdflag =(PageData) session.getAttribute("loginuser");
		
		mav.addObject("pdflag",userinfoService.findById(pdflag)); // USER_ATTESTATION
		//根据用户查询产品信息
		PageData grouppd = groupbyService.findById(pd);
		mav.addObject("grouppd", grouppd);
		//客户购买产品功能
		pd.put("USERINFO_ID", pdflag.get("USERINFO_ID"));
		mav.addObject("INVEST_ID", investService.findById(pd));
		
		mav.setViewName("system/investment/investment");
		// 查询背景图片
		PageData pdimg = dictionariesService.selectfindImgId(pd);
		mav.addObject("img", pdimg);
		return mav;
	}

	/**
	 * 存续信息判断进入
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/flag")
	public ModelAndView flag() throws Exception{
		ModelAndView mav = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		System.out.println(pd.get("PRODUCTSINFO_ID"));
		if(pd.get("PRODUCTSINFO_ID") == null || pd.get("PRODUCTSINFO_ID") == ""){
			mav.setViewName("system/investment/space_list");
		}else{
			// 查询背景图片
			PageData pdimg = dictionariesService.selectfindImgId(pd);
			mav.addObject("img", pdimg);
			mav.setViewName("persistence/persistence");
		}
		return mav;
	}

	
	@InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");

		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
	}

}
