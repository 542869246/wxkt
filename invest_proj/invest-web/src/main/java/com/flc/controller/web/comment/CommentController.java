package com.flc.controller.web.comment;

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
import com.flc.service.web.comment.CommentManager;
import com.flc.service.web.zan.ZanManager;
import com.flc.util.PageData;

/** 
 * 说明：用户评论
 * 创建人：FLC
 * 创建时间：2017-10-21
 */
@Controller
@RequestMapping(value="/comment")
public class CommentController extends BaseController {
	
	@Resource(name="commentService")
	private CommentManager commentService;
	@Resource(name="zanService")
	private ZanManager zanService;
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	@ResponseBody
	public PageData list(Page page) throws Exception{
		logBefore(logger,"列表Comment");
		PageData pd=new PageData();
		page.setShowCount(3);
		pd=this.getPageData();
		page.setPd(pd);
		List<PageData> news_comment = commentService.list(page);
		for (PageData pageData : news_comment) {
			String USER_ID = ((PageData)this.getRequest().getSession().getAttribute("loginuser")).getString("USERINFO_ID");
			String COMMENT_ID = pageData.getString("COMMENT_ID");
			PageData cond=new PageData();
			cond.put("ZAN_USER_ID", USER_ID);
			cond.put("ZAN_COMMENT_ID", COMMENT_ID);
			if(zanService.getZanBycond(cond)!=null){
				pageData.put("iszan",true);
			};
			
		}
		PageData result=new PageData();
		result.put("news_comment", news_comment);
		result.put("page",page);
		return result;
	}
	@RequestMapping(value="/save")
	@ResponseBody
	public String save() throws Exception{
		logBefore(logger, "评论");
		PageData pd=this.getPageData();
//		COMMENT_ID,	
//		COMMENT_NEWS_ID,	
//		COMMENT_CONTENT,	
//		COMMENT_USER_ID,	
//		COMMENT_CREATETIME
		pd.put("COMMENT_ID", this.get32UUID());
		pd.put("COMMENT_CREATETIME",new Date());
		pd.put("COMMENT_STATE",0);
		pd.put("COMMENT_USER_ID", ((PageData)this.getRequest().getSession().getAttribute("loginuser")).getString("USERINFO_ID"));
		commentService.save(pd);
		
		return "ok";
	}
	
	@InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
	}
}
