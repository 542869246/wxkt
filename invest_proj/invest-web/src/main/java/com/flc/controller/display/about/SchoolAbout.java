package com.flc.controller.display.about;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.flc.controller.base.BaseController;
import com.flc.service.school.schoolinfo.SchoolInfoManager;
import com.flc.util.PageData;
@Controller
@RequestMapping(value="/about")
public class SchoolAbout extends BaseController{

	@Resource(name="schoolinfoService")
	private SchoolInfoManager schoolinfoService;
	/**
	 * 跳入关于我们页面
	 * @return
	 */
	@RequestMapping("/goAbout")
	public ModelAndView goAbout(){
		PageData pd=new PageData();
		pd=this.getPageData();
		String type=pd.getString("type");
		ModelAndView mv=new ModelAndView();
		mv.addObject("type",type);
		mv.setViewName("MySchool/about");
		return mv;
	}
	/**
	 * 跳入联系我们页面
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping("/goContent")
	public String goContent(HttpServletRequest request) throws Exception{
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("INFO_ID", "06ac3be6e3094d2a93108520bc06");
		PageData obj = schoolinfoService.findById(pd);
		request.setAttribute("schoolInfo", obj);
		return "MySchool/content";
	}
	
	
	
}
