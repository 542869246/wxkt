package com.flc.controller.web.about;

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
import com.flc.util.AppUtil;
import com.flc.util.ObjectExcelView;
import com.flc.util.PageData;
import com.flc.util.Tools;
import com.flc.service.web.about.AboutManager;

/** 
 * 说明：关于我们页面信息展示
 * 创建人：FLC
 * 创建时间：2017-10-19
 */
@Controller
@RequestMapping(value="/about")
public class AboutController extends BaseController {
	
	String menuUrl = "about/list.do"; //菜单地址(权限用)
	@Resource(name="aboutService")
	private AboutManager aboutService;
	
	
	/**获取关于我们数据
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/about")
	public ModelAndView list() throws Exception{
		logBefore(logger,"列表About");
		ModelAndView mv = this.getModelAndView();
		PageData pd = aboutService.findAll();	//列出About信息
		mv.setViewName("aboutus/about_us");
		//mv.addObject("varList", pd);
		mv.addObject("pd", pd);
		return mv;
	}
	
	@InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
	}
}
