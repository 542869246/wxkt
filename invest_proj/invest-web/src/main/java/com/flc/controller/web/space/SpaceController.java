package com.flc.controller.web.space;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.flc.controller.base.BaseController;
import com.flc.util.PageData;

@Controller
@RequestMapping("/space")
public class SpaceController extends BaseController {
	@RequestMapping("/toSpace")
	public ModelAndView toSpace(){
		PageData pd=this.getPageData();
		ModelAndView view = this.getModelAndView();
		view.addObject("title",pd.getString("title"));
		view.addObject("msg",pd.getString("msg"));
		view.setViewName("space/space_list");
		return view;
	}
	
	/**
	 *  我的投资页面
	 * @return
	 */
	@RequestMapping("/toSpaces")
	public ModelAndView toSpaces(){
		ModelAndView view = this.getModelAndView();
		view.setViewName("system/investment/space_list");
		return view;
	}
}
