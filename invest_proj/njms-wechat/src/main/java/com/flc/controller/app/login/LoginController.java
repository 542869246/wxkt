package com.flc.controller.app.login;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.flc.controller.base.BaseController;
import com.flc.enums.ExEnum;

@Controller
@RequestMapping(value="/app/login")
public class LoginController extends BaseController {
	@RequestMapping(value="/test")
	@ResponseBody
	public Object test(){
		
		return getResultMap(ExEnum.EX_SUCCESS, null);
	}
}
