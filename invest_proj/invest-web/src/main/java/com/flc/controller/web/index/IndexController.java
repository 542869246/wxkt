package com.flc.controller.web.index;

import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.OutputStream;
import java.util.List;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.patchca.ImageCodeFactory;
import org.patchca.service.Captcha;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.flc.controller.base.BaseController;
import com.flc.service.system.dictionaries.DictionariesManager;
import com.flc.service.web.userinfo.UserinfoManager;
import com.flc.typeEnums.TypeEnums;
import com.flc.util.PageData;

@Controller
@RequestMapping("/index")
public class IndexController extends BaseController {
	
	@Resource(name="userinfoService")
	private UserinfoManager userinfoService;
	
	@Value("${uploadfPath}")
	private String uploadfPath;
	
	@Resource(name="dictionariesService")
	private DictionariesManager dictionariesService;
	
//	@RequestMapping("/toRegister")
//	public String toRegister()throws Exception{
//		return "login/register";
//	}
	
	//获得图形验证码
	@RequestMapping("/getCode")
	public void getCode(HttpServletResponse response,HttpSession session) throws IOException{
		ServletOutputStream out = response.getOutputStream();
		//设置response头信息
        //禁止缓存
        response.setHeader("Pragma", "No-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setDateHeader("Expires", 0);
//        ValidateCode vc=new ValidateCode(80,30,4,100);
        OutputStream outputStream = response.getOutputStream(); 
        Captcha captcha = ImageCodeFactory.getInstance().setCodeParams(120,45).getCaptcha(); 
        System.out.println("code:"+captcha.getChallenge()); 
        BufferedImage bufferedImage = captcha.getImage(); 
        ImageIO.write(bufferedImage, "png", outputStream); 
        outputStream.flush(); 
        outputStream.close();
        String code = captcha.getChallenge();
        session.setAttribute("validateCode", code);
//        vc.write(out);
	}
	
	//校验图形验证码
	@RequestMapping("/validateCode")
	@ResponseBody
	public Object validateCode(HttpSession session){
		Object object = session.getAttribute("validateCode");
		return object;
	}
	
	//登录成功跳转首页
	@RequestMapping("/toindex")
	public ModelAndView toindex() throws Exception{
/*		HttpServletRequest request = this.getRequest();
		HttpSession session = request.getSession();
		ModelAndView view = this.getModelAndView();
		Object obj = session.getServletContext().getAttribute("uploadfPath");
		
		if(obj==null){
			session.getServletContext().setAttribute("uploadfPath", uploadfPath);
		}
		PageData pd=this.getPageData();
		pd.put("PARENT_ID", TypeEnums.NEWS_TYPE.getCode());
		List<PageData> list= dictionariesService.listAll(pd);
		view.addObject("newstype",list);
		
		if(session.getAttribute("loginuser")==null){
//			PageData p=new PageData();
//			p.put("USERINFO_ID", "bef491106b1b44018290feb98ce0f02b");
//			session.setAttribute("loginuser", userinfoService.findById(p));
//			view.setViewName("index/index");
			view.setViewName("error");
		}
		String paramString = request.getQueryString();
		if(!StringUtils.isEmpty(paramString)){
			view.setViewName("redirect:/index/toindex");
		}else{
			view.setViewName("index/index");
		}*/
		PageData pd = this.getPageData();
		ModelAndView view = this.getModelAndView();
		view.addObject("ACTIVITY_ID", pd.get("ACTIVITY_ID"));
		view.setViewName("myDaily/register");
		return view;
		
		
		
	}
}
