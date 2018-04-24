package com.flc.controller.school.schoolactivity;

import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.patchca.ImageCodeFactory;
import org.patchca.service.Captcha;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.flc.controller.base.BaseController;
import com.flc.service.school.schoolbrandjoiner.SchoolBrandJoinerManager;
import com.flc.util.AppUtil;
import com.flc.util.Const;
import com.flc.util.PageData;
import com.flc.util.Tools;

@Controller
@RequestMapping(value="/schoolBrand")
public class SchoolBrandJoinerController extends BaseController {

	
	@Resource(name = "schoolbrandjoinerService")
	private SchoolBrandJoinerManager schoolbrandjoinerService;
	
	/**
	 * 返回一个图片验证码给页面 并将验证码所带信息放入session
	 * 
	 * @param response
	 * @param request
	 * @throws IOException 
	 */
	@ResponseBody
	@RequestMapping(value = "/vcodeimg")
	public void generate(HttpServletResponse response, HttpServletRequest request) throws IOException {
		ByteArrayOutputStream output = new ByteArrayOutputStream();
		OutputStream outputStream = response.getOutputStream(); 
		Captcha captcha = ImageCodeFactory.getInstance().setCodeParams(120,45).getCaptcha(); 
		BufferedImage bufferedImage = captcha.getImage(); 
		ImageIO.write(bufferedImage, "png", outputStream); 
		outputStream.flush(); 
		outputStream.close();
		String code = captcha.getChallenge();

		HttpSession session = request.getSession();
		session.setAttribute(Const.SESSION_SECURITY_CODE, code);
		try {
			ServletOutputStream out = response.getOutputStream();
			output.writeTo(out);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	
	/**
	 * 验证手机号码
	 * errorinfo ：
	 * numerror  手机号输入错误
	 * success  验证成功
	 * @param mobiles
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/getvalidphone")
	public Object checkMobileNumber() throws Exception {
		Map<String, String> map = new HashMap<String, String>();
		PageData pd = new PageData();
		pd = this.getPageData();
		String errInfo = "";
		String USERS_PHONE = pd.getString("USERS_PHONE");
		if (null == USERS_PHONE || "".equals(USERS_PHONE)) { // 判断手机号
			errInfo = "nullnum"; // 手机号为空
		} else {
			if (valiphone(USERS_PHONE)) { // 判断手机号是否符合规则、
				errInfo = "ok";
			}
			else {
				errInfo = "numerror"; // 手机号输入有误
			}
		}
		map.put("result", errInfo);
		return AppUtil.returnObject(new PageData(), map);
	}

	/**
	 * 用来手机号的正则验证
	 * 
	 * @param mobileNumber
	 * @return
	 */
	private boolean valiphone(String mobileNumber) {
		boolean flag = false;
		try {
			Pattern regex = Pattern.compile("^(13[0-9]|14[579]|15[0-3,5-9]|17[0135678]|18[0-9])\\d{8}$");
			Matcher matcher = regex.matcher(mobileNumber);
			flag = matcher.matches();
		} catch (Exception e) {
			flag = false;
		}
		return flag;
	}


	/**
	 * 判断图片验证码
	 * errinfo
	 * nullcode  没有验证码传入
	 * codeerror  验证码输入错误
	 * success   成功
	 * @param respose
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/getvalidimg")
	public Object getValidImg(HttpServletResponse respose, HttpSession session) throws Exception {
		Map<String, String> map = new HashMap<String, String>();
		PageData pd = new PageData();
		pd = this.getPageData();
		String errInfo = "";
		String KEYDATA = pd.getString("KEYDATA");
		if (null != KEYDATA) {
			String sessionCode = (String) session.getAttribute(Const.SESSION_SECURITY_CODE); // 获取session中的验证码
			String code = KEYDATA;
			if (null == code || "".equals(code)) { // 判断效验码
				errInfo = "nullcode"; // 效验码为空
			} else {
				if (Tools.notEmpty(sessionCode) && sessionCode.equalsIgnoreCase(code)) { // 判断验证码
				} else {
					errInfo = "codeerror"; // 验证码输入有误
				}
				if (Tools.isEmpty(errInfo)) {
					errInfo = "success"; // 验证成功
				}
			}
		} else {
			errInfo = "nullcode"; // 效验码为空
		}
		map.put("result", errInfo);
		return AppUtil.returnObject(new PageData(), map);
	}


	
	
	
	

	/**
	 * 加盟
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/getreg")
	public PageData reg() throws Exception {
		PageData pd = this.getPageData();
		PageData result = new PageData();
		if (pd==null) {
			result.put("msg", "error");
			return result;
		}
		String USERS_PHONE = pd.getString("USERS_PHONE");
		String USERS_NAME = pd.getString("USERS_NAME");
		//可选字段
		String  DESCRIPTION= null;
		
		if (null != pd.get("DESCRIPTION")&& !"".equals(pd.get("DESCRIPTION"))) {
			DESCRIPTION=(String) pd.get("DESCRIPTION");
		}
		
//		//必须获取活动类型
//		if (ACTIVITY_ID==null || "".equals(ACTIVITY_ID)) {
//			result.put("msg", "error");
//			return result;
//		}
		
		PageData joiner = new PageData();
//		takeinuser.put("ACTIVITY_ID", ACTIVITY_ID);
		
		
		joiner.put("JOINER_PHONE", USERS_PHONE);
		if(null !=schoolbrandjoinerService.findUser(joiner)){
			result.put("msg", "hasuser");
			return result;
		}
		joiner.put("JOINER_ID", this.get32UUID());
		joiner.put("JOINER_NAME", USERS_NAME);
		
		joiner.put("JOINER_DESCRIPTION", DESCRIPTION);

		schoolbrandjoinerService.save(joiner);
		result.put("msg", "ok");
		return result;
	}

	
	
	
	
	
	
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format, true));
	}
}
