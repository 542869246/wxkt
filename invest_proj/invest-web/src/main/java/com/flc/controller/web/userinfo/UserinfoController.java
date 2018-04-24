package com.flc.controller.web.userinfo;

import java.io.File;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.flc.controller.base.BaseController;
import com.flc.entity.Page;
import com.flc.service.web.log.LogManager;
import com.flc.service.web.userinfo.UserinfoManager;
import com.flc.typeEnums.TypeEnums;
import com.flc.util.PageData;
import com.flc.wx.pojo.SNSUserInfo;

/** 
 * 说明：用户管理
 * 创建人：FLC
 * 创建时间：2017-10-22
 */
@Controller
@RequestMapping(value="/userinfo")
public class UserinfoController extends BaseController {
	
	@Resource(name="userinfoService")
	private UserinfoManager userinfoService;
	@Resource(name="logService")
	private LogManager logService;
	@Value("${uploadfPath}")
	private String uploadfPath;
	
	//清除缓存
	@RequestMapping("/clearCache")
	public ModelAndView clearCache() throws Exception{
		ModelAndView view = this.getModelAndView();
		HttpSession session = this.getRequest().getSession();
		PageData pd=(PageData)this.getRequest().getSession().getAttribute("loginuser");
		PageData loginuser =(PageData)userinfoService.findById(pd);
		session.setAttribute("loginuser",loginuser);
		session.getServletContext().setAttribute("uploadfPath", uploadfPath);
		view.setViewName("redirect:toUserCentre");
		return view;
		
	}
	
	
	//个人中心
	@RequestMapping(value="/toUserCentre")
	public ModelAndView toUserCentre() throws Exception{
		ModelAndView view = this.getModelAndView();
		PageData user=((PageData)this.getRequest().getSession().getAttribute("loginuser"));
		view.addObject("loginuser",user);
		view.setViewName("user/user");
		return view;
	}
	//个人设置
	@RequestMapping(value="/toSetting")
	public ModelAndView toSetting(){
		ModelAndView view = this.getModelAndView();
		PageData user=((PageData)this.getRequest().getSession().getAttribute("loginuser"));
		view.addObject("loginuser",user);
		view.setViewName("user/setting");
		return view;
	}
	//个人修改头像
	@ResponseBody
	@RequestMapping(value="/setting")
	public PageData setting() throws Exception{
		PageData result = new PageData();
//		String path=session.getServletContext().getRealPath("/static/upload/userphoto");
//		String imgpath=img.getOriginalFilename();
//		imgpath=this.get32UUID()+imgpath.substring(imgpath.lastIndexOf("."));
//		String USER_PHOTO=session.getServletContext().getContextPath()+"/static/upload/userphoto/"+imgpath;
//		System.out.println("USER_PHOTO:"+USER_PHOTO);
//		System.out.println("path:"+path);
//		File mkdir = new File(path);
//		if(!new File(path).exists()){
//			mkdir.mkdirs();
//		}
//		File file=new File(path+"\\"+imgpath);
//		img.transferTo(file);\
		PageData pd = this.getPageData();
		pd.put("USERINFO_ID",((PageData)this.getRequest().getSession().getAttribute("loginuser")).get("USERINFO_ID"));
		userinfoService.edit(pd);
		this.getRequest().getSession().setAttribute("loginuser",userinfoService.findById(pd));
		result.put("msg","保存用户头像成功!");
		return result;
	}
	
	//用户绑定操作
	@RequestMapping("/register")
	@ResponseBody
	public PageData registerUser() throws Exception{
		PageData pd = this.getPageData();
		String dxyzm = pd.getString("dxyzm");
		HttpSession session = this.getRequest().getSession();
		String phone = (String)session.getAttribute("phone");
		PageData result=new PageData();
		SNSUserInfo snsUserInfo = (SNSUserInfo)session.getAttribute("snsUserInfo");
		if(dxyzm !=null && dxyzm.equals(phone)){
			pd.put("USERINFO_ID", this.get32UUID());
			pd.put("USER_ROLE_ID",TypeEnums.LEVEL_DEFAULT.getCode());
			pd.put("USER_CREATETIME", new Date());
			pd.put("USER_NICKNAME",snsUserInfo.getNickname());
			pd.put("USER_PHOTO",snsUserInfo.getHeadImgUrl());
			pd.put("USER_STATE","0");
			pd.put("USER_OPPNID",snsUserInfo.getOpenId());
			pd.put("USER_GROUPID",TypeEnums.USERGROUP_DEFAULT.getCode());
			if(userinfoService.findByUSER_OPPNID(pd)!=null){
				PageData user = userinfoService.findById(pd);
				session.setAttribute("loginuser", user);
				result.put("msg", "ok");
			}else{
				userinfoService.save(pd);
				PageData user = userinfoService.findById(pd);
				session.setAttribute("loginuser", user);
	//			return "redirect:/index/toindex";
				result.put("msg", "ok");
				PageData log=new PageData();
	        	log.put("LOG_ID", this.get32UUID());
	        	log.put("LOG_USER_ID", user.get("USERINFO_ID"));
	        	log.put("LOG_TIME", new Date());
	        	logService.save(log);
			}
		}else{
			result.put("msg","error");
		}
		return result;
	}
	
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(Page page) throws Exception{
		logBefore(logger, "列表Userinfo");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		page.setPd(pd);
		List<PageData>	varList = userinfoService.list(page);	//列出Userinfo列表
		mv.setViewName("web/userinfo/userinfo_list");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		return mv;
	}
	
	public PageData getUserById() throws Exception{
		PageData pd=this.getPageData();
		return userinfoService.findById(pd);
	}

	@InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
	}
}
