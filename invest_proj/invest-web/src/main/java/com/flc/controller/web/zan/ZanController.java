package com.flc.controller.web.zan;

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
import com.flc.service.web.zan.ZanManager;
import com.flc.util.PageData;

/** 
 * 说明：用户点赞表
 * 创建人：FLC
 * 创建时间：2017-10-21
 */
@Controller
@RequestMapping(value="/zan")
public class ZanController extends BaseController {
	
	@Resource(name="zanService")
	private ZanManager zanService;
	
	@RequestMapping(value="/save")
	@ResponseBody
	public PageData save() throws Exception{
		PageData pd=this.getPageData();
//		ZAN_ID,	
//		ZAN_USER_ID,	
//		ZAN_COMMENT_ID,	
//		ZAN_CREATETIME
		pd.put("ZAN_ID", this.get32UUID());
		pd.put("ZAN_USER_ID", ((PageData)this.getRequest().getSession().getAttribute("loginuser")).getString("USERINFO_ID"));
		pd.put("ZAN_CREATETIME", new Date());
		zanService.save(pd);
		int count = zanService.getCount(pd);
		pd.put("zancount", count);
		return pd;
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(Page page) throws Exception{
		logBefore(logger, "列表Zan");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		List<PageData>	varList = zanService.list(page);	//列出Zan列表
		mv.setViewName("web/zan/zan_list");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		return mv;
	}
	
	@InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
	}
}
