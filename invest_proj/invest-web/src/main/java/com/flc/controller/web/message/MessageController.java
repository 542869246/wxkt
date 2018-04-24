package com.flc.controller.web.message;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.flc.controller.base.BaseController;
import com.flc.entity.Page;
import com.flc.service.web.message.MessageManager;
import com.flc.service.web.read.ReadManager;
import com.flc.service.web.userinfo.UserinfoManager;
import com.flc.util.PageData;

/** 
 * 说明：系统消息页面展示
 * 创建人：FLC
 * 创建时间：2017-10-20
 */
@Controller
@RequestMapping(value="/message")
public class MessageController extends BaseController {
	
	String menuUrl = "message/list.do"; //菜单地址(权限用)
	@Resource(name="messageService")
	private MessageManager messageService;
	@Resource(name="readService")
	private ReadManager readService;
	
	@Value("${uploadfPath}")
	private String uploadfPath;
	@Resource(name="userinfoService")
	private UserinfoManager userinfoService;
	
	
	/**
	 * 跳转到message.jsp页面
	 * @param page
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/xianshi")
	public ModelAndView xianshi(Page page,HttpSession session) throws Exception{
		ModelAndView mv= this.getModelAndView();
		logBefore(logger,"列表Message");
		mv.setViewName("message/message");
		//mv.addObject("varList", varList);
		return mv;
	}
	@RequestMapping("/getuserrenzheng")
	@ResponseBody
	public PageData getuserrenzheng(HttpSession session) throws Exception{
		
		PageData pd1=(PageData)this.getRequest().getSession().getAttribute("loginuser");
		PageData loginuser =(PageData)userinfoService.findById(pd1);
		session.setAttribute("loginuser",loginuser);
		session.getServletContext().setAttribute("uploadfPath", uploadfPath);
		PageData pd = loginuser;
		return pd;
	}
	@RequestMapping("/tospace")
	public ModelAndView tospace() throws Exception{
		ModelAndView view = this.getModelAndView();
		view.setViewName("message/space_list2");
		return view;
	}
	/**分页查询系统消息
	 * 
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	@ResponseBody
	public PageData list(Page page,HttpSession session) throws Exception{
		logBefore(logger,"列表Message");
		PageData pd = new PageData();
		pd = this.getPageData();
		//查询用户下的阅读新闻
		PageData user=(PageData) session.getAttribute("loginuser");
		pd.put("READ_USER_ID", user.get("USERINFO_ID"));
		//总记录赋值同时获取  总页数
		page.setTotalResult(messageService.getTotalRTesult());
		page.setPd(pd);
		//查询出所有系统消息
		List<PageData>	varList = messageService.listAll(page);	//列出Message列表
		PageData result=new PageData();
		result.put("page", page);
		result.put("varList", varList);
		return result;
	}
	/**
	 * 根据ID查询消息详细信息  跳转到详细信息页面
	 * @param pd
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/single")
	public ModelAndView findById(HttpSession session) throws Exception{
		logBefore(logger,"一个详细Message");
		//获取传过来的参数
		PageData pd= new PageData();
		pd=this.getPageData();
		if(pd.getString("READ_MESSAGE_ID")!=null && pd.getString("READ_MESSAGE_ID")!=""){
			pd.put("READ_ID", this.get32UUID());	//主键
			PageData user=(PageData) session.getAttribute("loginuser");
			pd.put("READ_USER_ID", user.get("USERINFO_ID"));
			readService.save(pd);
		}
		//获取值
		PageData data= messageService.findById(pd);
		//将值放进modelandview
		ModelAndView mv= this.getModelAndView();
		mv.addObject("message", data);
		mv.setViewName("message/message_details");
		return mv;
	}
	@InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
	}
}
