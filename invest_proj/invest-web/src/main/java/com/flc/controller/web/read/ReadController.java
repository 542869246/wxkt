package com.flc.controller.web.read;

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
import com.flc.service.web.read.ReadManager;

/** 
 * 说明：用户阅读系统消息
 * 创建人：FLC
 * 创建时间：2017-10-21
 */
@Controller
@RequestMapping(value="/read")
public class ReadController extends BaseController {
	
	String menuUrl = "read/list.do"; //菜单地址(权限用)
	@Resource(name="readService")
	private ReadManager readService;
	
	/**保存系统消息
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	@ResponseBody
	public String save(HttpSession session) throws Exception{
		logBefore(logger, "新增Read");
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("READ_ID", this.get32UUID());	//主键
		PageData user=(PageData) session.getAttribute("loginuser");
		pd.put("READ_USER_ID", user.get("USERINFO_ID"));
		readService.save(pd);
		return "{res:ok}";
	}
	/**
	 * 新增存续消息
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/cxsave")
	@ResponseBody
	public String cxsave(HttpSession session) throws Exception{
		logBefore(logger, "新增Read");
		PageData pd = new PageData();
		pd = this.getPageData();
		PageData user=(PageData) session.getAttribute("loginuser");
		pd.put("READ_USER_ID", user.get("USERINFO_ID"));
		pd.put("READ_ID", this.get32UUID());	//主键
		readService.save(pd);
		return "{res:ok}";
	}
	@InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
	}
}
