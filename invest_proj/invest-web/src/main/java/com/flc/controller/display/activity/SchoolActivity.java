package com.flc.controller.display.activity;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.flc.controller.base.BaseController;
import com.flc.service.school.schoolactivity.SchoolActivityManager;
import com.flc.util.PageData;
@Controller
@RequestMapping(value="/activity")
public class SchoolActivity extends BaseController {

	@Resource
	private SchoolActivityManager sam;
	/**
	 * 跳入活动页面
	 * @return
	 */   
	
	@RequestMapping("/goActivity")
	public ModelAndView goEnglishActivity(String create){
		PageData pd=new PageData();
		pd=this.getPageData();
		ModelAndView mv=this.getModelAndView();
		//获取页面activity_type_id的值
		mv.addObject("activity_type_id", pd.getString("activity_type_id"));
		mv.addObject("create", create);
		mv.setViewName("MyActivity/active");
		return mv;
	}
	/**
	 * 跳入活动详情 
	 */
	@RequestMapping("/goActivityInfo")
	public ModelAndView goEnglishActivityInfo(){
		PageData pd=new PageData();
		pd=this.getPageData();
		ModelAndView mv=this.getModelAndView();
		//获取页面activity_type_id的值
		mv.addObject("activity_type_id", pd.get("activity_type_id"));
		mv.addObject("activity_id", pd.get("activity_id"));
		mv.setViewName("MyActivity/details");
		return mv;
	}	
	/**
	 * 跳入活动报名
	 */
	@RequestMapping("/goActivitySign")
	public ModelAndView goActivitySign(){
		PageData pd=new PageData();
		pd=this.getPageData();
		ModelAndView mv=this.getModelAndView();
		mv.addObject("ACTIVITY_ID", pd.get("activity_id"));
		mv.setViewName("MyActivity/takein");
		return mv;
	}
	
	}

