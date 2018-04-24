package com.flc.controller.web.collect;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

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
import com.flc.service.web.collect.CollectManager;
import com.flc.util.PageData;

/** 
 * 说明：用户收藏
 * 创建人：FLC
 * 创建时间：2017-10-21
 */
@Controller
@RequestMapping(value="/collect")
public class CollectController extends BaseController {
	
	@Resource(name="collectService")
	private CollectManager collectService;
	
	//收藏取消收藏新闻
	@RequestMapping("/saveAndDelete")
	@ResponseBody
	public PageData save()throws Exception{
		logBefore(logger, "新增Collect");
		PageData pd = this.getPageData();
		if(pd.get("COLLECT_ID")==null||"".equals(pd.getString("COLLECT_ID"))){
			pd.put("COLLECT_USER_ID", ((PageData)this.getRequest().getSession().getAttribute("loginuser")).getString("USERINFO_ID"));
			pd.put("COLLECT_ID", this.get32UUID());
			pd.put("COLLECT_CREATETIME", new Date());
			collectService.save(pd);
			return pd;
		}else{
			collectService.delete(pd);
			return null;
		}
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	@ResponseBody
	public PageData list(Page page) throws Exception{
		logBefore(logger, "列表Collect");
		PageData pd = this.getPageData();
		String USERINFO_ID =((PageData)this.getRequest().getSession().getAttribute("loginuser")).getString("USERINFO_ID");//关键词检索条件
		if(null != USERINFO_ID && !"".equals(USERINFO_ID)){
			pd.put("USERINFO_ID", USERINFO_ID.trim());
		}
		page.setShowCount(8);
		page.setPd(pd);
		List<PageData>	varList = collectService.list(page);	//列出Collect列表
		PageData result = new PageData();
		result.put("list", varList);
		result.put("page", page);
		return result;
	}
	
	
	
	@InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
	}
}
