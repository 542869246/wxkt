package com.flc.controller.web.newsinfo;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.flc.controller.base.BaseController;
import com.flc.entity.Page;
import com.flc.service.system.dictionaries.DictionariesManager;
import com.flc.service.web.collect.CollectManager;
import com.flc.service.web.comment.CommentManager;
import com.flc.service.web.newsinfo.NewsinfoManager;
import com.flc.typeEnums.TypeEnums;
import com.flc.util.PageData;

/** 
 * 说明：新闻资讯
 * 创建人：FLC
 * 创建时间：2017-10-19
 */
@Controller
@RequestMapping(value="/newsinfo")
public class NewsinfoController extends BaseController {
	
	@Resource(name="newsinfoService")
	private NewsinfoManager newsinfoService;
	@Resource(name="collectService")
	private CollectManager collectService;
	@Resource(name="commentService")
	private CommentManager commentService;
	@Resource(name="dictionariesService")
	private DictionariesManager dictionariesService;
//	@Resource(name="zanService")
//	private ZanManager zanService;
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	@ResponseBody
	public PageData list(Page page) throws Exception{
		logBefore(logger, "列表Newsinfo");
		page.setShowCount(8);
		PageData pd = this.getPageData();
		String NEWINFO_STATE = pd.getString("NEWINFO_STATE");				//过时资讯还是最新资讯
		if(null != NEWINFO_STATE && !"".equals(NEWINFO_STATE)){
			pd.put("NEWINFO_STATE", NEWINFO_STATE.trim());
		}
		page.setPd(pd);
		List<PageData>	varList = newsinfoService.list(page);	//列出Newsinfo列表
		PageData result = new PageData();
		result.put("list", varList);
		result.put("page", page);
		return result;
	}
	
	//搜索收藏
	@RequestMapping("/toNewsList")
	public ModelAndView toNewsList(){

		ModelAndView view = this.getModelAndView();
		PageData pd = this.getPageData();
		if(pd.get("NEWINFO_TITLE")!=null){
			view.addObject("NEWINFO_TITLE", this.getPageData().getString("NEWINFO_TITLE"));
		}
		String whereCome = this.getPageData().getString("whereCome");
		view.addObject("whereCome",whereCome);
		view.setViewName("news/my_collect");
		return view;
	}
	//实时资讯
	@RequestMapping("/toTypeNews")
	public ModelAndView toTypeNews(Page page) throws Exception{
		ModelAndView view = this.getModelAndView();
		PageData pd=this.getPageData();
		pd.put("PARENT_ID",TypeEnums.ZIXUN_TYPE.getCode()); 
		page.setPd(pd);
		List<PageData> list= dictionariesService.list(page);
		view.addObject("newstype",list);
		view.setViewName("news/news");
		return view;
	}
	//资讯详情
	@RequestMapping("/tonews_detail")
	public ModelAndView tonews_detail(Page page) throws Exception{
		ModelAndView view = this.getModelAndView();
		PageData pd=new PageData();
		page.setShowCount(3);
		pd=this.getPageData();
		page.setPd(pd);
		String NEWSINFO_ID=pd.getString("NEWSINFO_ID");
		HttpServletRequest request = this.getRequest();
		PageData user = (PageData) request.getSession().getAttribute("loginuser");
		if(user!=null){
			String USERINFO_ID=(String)user.get("USERINFO_ID");
			PageData cond=new PageData();
			cond.put("COLLECT_USER_ID", USERINFO_ID);
			cond.put("COLLECT_INFO_ID",NEWSINFO_ID);
			PageData mycollect= collectService.findByUserAndNews(cond);
			view.addObject("mycollect", mycollect);
		}
		PageData news = newsinfoService.findById(pd);
		view.addObject("news", news);
		view.setViewName("news/news_detail");
		return view;
	}
	
	@InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
	}
}
