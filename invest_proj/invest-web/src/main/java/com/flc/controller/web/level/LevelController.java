package com.flc.controller.web.level;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.flc.controller.base.BaseController;
import com.flc.service.web.level.LevelManager;
import com.flc.typeEnums.TypeEnums;
import com.flc.util.PageData;

/** 
 * 说明：用户会员等级信息获取
 * 创建人：FLC
 * 创建时间：2017-10-20
 */
@Controller
@RequestMapping(value="/level")
public class LevelController extends BaseController {
	
	String menuUrl = "level/list.do"; //菜单地址(权限用)
	@Resource(name="levelService")
	private LevelManager levelService;
	
	
	/**根据用户登录的信息   查询用户的等级
	 * 判断用户进入的等级页面
	 * @param page
	 * @throws Exception
	 * 
	 * 根据用户微信登录信息  向用户表中获取基本信息    放入session中
	 * 从session拿出   LEVEL_ID当做条件
	 * 
	 *
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(HttpSession session) throws Exception{
		logBefore(logger,"列表Level");
		//从session中获取loginuser
		PageData user=(PageData) session.getAttribute("loginuser");
		ModelAndView mv = this.getModelAndView();
		PageData varList = levelService.findById(user);	//列出Level列表
		//判断跳转页面
		if(TypeEnums.LEVEL_HUANGJIN.getCode().equalsIgnoreCase(user.get("USER_ROLE_ID").toString())){
			mv.setViewName("level/my_grade");
		}else if(TypeEnums.LEVEL_BAIJIN.getCode().equalsIgnoreCase(user.get("USER_ROLE_ID").toString())){
			mv.setViewName("level/my_grade2");
		}else if(TypeEnums.LEVEL_ZHUANSHI.getCode().equalsIgnoreCase(user.get("USER_ROLE_ID").toString())){
			mv.setViewName("level/my_grade3");
		}
		mv.addObject("varList", varList);
		return mv;
	}
	
	
	@InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
	}
}
