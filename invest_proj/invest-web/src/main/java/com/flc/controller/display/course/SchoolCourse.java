package com.flc.controller.display.course;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.flc.controller.base.BaseController;
import com.flc.service.system.dictionaries.DictionariesManager;
import com.flc.service.web.webstudent.WebStudentManager;
import com.flc.service.web.webstuwebuser.WebStuWebuserManager;
import com.flc.service.web.webusers.WebUsersManager;
import com.flc.util.PageData;
@Controller
@RequestMapping("/course")
public class SchoolCourse extends BaseController {

	/**
	 * 跳入今日学习
	 */
	@RequestMapping("/goStudy")
	public String goStudy(){
		return "myDaily/todaylearning";
	}
	
	/**
	 * 跳入家长日报页面
	 * @return
	 */
	@RequestMapping("/goDaily")
	public String goDaily(){
		return "myDaily/daily";
	}
	/**
	 * 跳入我的积分页面
	 */
	@Resource
	private DictionariesManager dm;//词典表 
	@RequestMapping("/goMyCount")
	public ModelAndView goMyCount() throws Exception{
		ModelAndView mv=this.getModelAndView();
		 PageData count = dm.count();
		//心愿值
		 mv.addObject("count",count.get("BZ"));
		 mv.setViewName("myDaily/mycount");
		return mv;
	}
	
	/**
	 * 账号绑定页面
	 */
	@RequestMapping("/goReg")
	public String goReg(){
		return "myDaily/register";
	}
	/**
	 * 中转页面
	 */
	@RequestMapping("/goToReg")
	public String goToReg(){
		return "myDaily/toRegister";
	}
}
