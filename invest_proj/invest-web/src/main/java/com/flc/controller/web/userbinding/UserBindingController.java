package com.flc.controller.web.userbinding;

import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
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
import org.springframework.web.servlet.ModelAndView;

import com.aliyuncs.dysmsapi.model.v20170525.SendSmsResponse;
import com.aliyuncs.exceptions.ClientException;
import com.flc.controller.base.BaseController;
import com.flc.service.gotyeBackstage.gotyebackstage.GotyeBackstageManager;
import com.flc.service.system.dictionaries.DictionariesManager;
import com.flc.service.web.validation.ValidationManager;
import com.flc.service.web.webstudent.WebStudentManager;
import com.flc.service.web.webstuwebuser.WebStuWebuserManager;
import com.flc.service.web.webusers.WebUsersManager;
//import com.flc.entity.system.User;
import com.flc.util.AppUtil;
import com.flc.util.Const;
import com.flc.util.PageData;
//import com.flc.util.Jurisdiction;
import com.flc.util.Tools;
import com.flc.util.aliyunsms.util.SmsUtil;
import com.flc.wx.pojo.SNSUserInfo;

/**
 * 说明：用户绑定 创建人：于江东 创建时间：2017-11-30
 */
@Controller
@RequestMapping(value = "/userbinding")
public class UserBindingController extends BaseController {
	String menuUrl = "userbinding/list.do"; // 菜单地址(权限用)
	
	@Resource(name = "webusersService")
	private WebUsersManager webusersService;
	@Resource(name = "dictionariesService")
	private DictionariesManager dictionariesService;
	@Resource(name = "validationService")
	private ValidationManager validationService;
	@Resource(name = "webstudentService")
	private WebStudentManager webstudentService;
	@Resource(name = "webstuwebuserService")
	private WebStuWebuserManager webstuwebuserService;
	@Resource
	private GotyeBackstageManager gotyeBackstageService;
	@RequestMapping("/toIndex")
	public ModelAndView toindex() throws Exception{
		ModelAndView view = this.getModelAndView();
		PageData pd = this.getPageData();
		view.addObject("ACTIVITY_ID", pd.get("ACTIVITY_ID"));
		view.setViewName("myDaily/register");
		return view;
	}


	/**
	 * 从验证码记录表中检查最新一条验证码将它与传来的比对
	 * errorinfo:
	 * timeout  验证码超时
	 * empty    无此手机号的验证码
	 * error       验证码输入有误
	 * ok           验证码输入正确
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/checkphonecodetext")
	public PageData checkphonecodetext() throws Exception {
		PageData pd = this.getPageData();
		PageData result = new PageData();
		//通过手机号从数据库中查出该手机的最新一条验证码的信息
		PageData data = validationService.findByPhone(pd);
		String VALIDATION_CODE=null;
		if (data != null) {
			Date oldtime = (Date) data.get("VALIDATION_TIME");
			long min = getDatePoor(new Date(), oldtime);
			VALIDATION_CODE = data.getString("VALIDATION_CODE");
			if (min > 15) {
				result.put("msg", "短信验证码已过期,请重新获取!");
				result.put("errorinfo", "timeout");
				return result;
			}
			String phonecodetext = pd.getString("VALIDATION_CODE");
			if (null != VALIDATION_CODE && !"".equals(VALIDATION_CODE)) {
				if (VALIDATION_CODE.equals(phonecodetext)) {
					result.put("errorinfo", "ok");
				} else {
					result.put("errorinfo", "error");
					result.put("msg", "验证码不匹配");
				}
			}

		} else {
			result.put("msg", "无该手机号的验证码记录!");
			result.put("errorinfo", "empty");
		}
		return result;
	}

	// 验证用户信息并判断是否绑定手机号
	// 已经绑定的跳转到关于我们
	/**
	 * 首先从session中拿手机号，防止用户刷绑定
	 * 用户绑定方法 如果已经有openid记录  直接登录
	 * 没有openid记录，从用户表查手机号，有就拒绝绑定
	 * 从学生表中查手机号，有就在关系表中插入信息，设置用户为会员
	 * 没有就不是会员，保存用户
	 * 
	 * msg：
	 * wait   用户发送验证码后退出，需要等待15分钟才能再次操作
	 * login 发现有openid，直接让用户进入默认页面
	 * hasphone  用户表已经有一个手机号，防止刷数据
	 * error   session中没有手机号，或者未知错误
	 * ok			成功绑定
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/getreg")
	public PageData reg() throws Exception {
		PageData pd = this.getPageData();
		String VALIDATION_PHONE = pd.getString("VALIDATION_PHONE");
		HttpSession session = this.getRequest().getSession();
		PageData result = new PageData();
		if (webusersService.findByUSER_OPPNID(pd) != null) {
			PageData user = webusersService.findByUSER_OPPNID(pd);
			session.setAttribute("loginuser", user);
			result.put("msg", "login");
			return result;
		}
		SNSUserInfo snsUserInfo =(SNSUserInfo)session.getAttribute("snsUserInfo");
		String phone = (String)session.getAttribute("phone"); 
		if (null == phone || "".equals(phone)) {
			result.put("msg", "wait");
			return result;
		}
		if(VALIDATION_PHONE !=null && VALIDATION_PHONE.equals(phone)){
			PageData userphone = new PageData();
			userphone.put("USERS_PHONE", VALIDATION_PHONE);

			if (null == webusersService.findByphone(userphone)) {
				pd.put("USERS_ID", this.get32UUID());
				///////////////////////////////////////////////////////////////////////////////////////////////
				String USERS_WECHAT_NICKNAME = pd.getString("USERS_WECHAT_NICKNAME");
				if (null ==USERS_WECHAT_NICKNAME) {
					USERS_WECHAT_NICKNAME = snsUserInfo.getNickname();
				}
				
				pd.put("USERS_WECHAT_NICKNAME",USERS_WECHAT_NICKNAME);
				pd.put("USERS_PHOTO",snsUserInfo.getHeadImgUrl());
				pd.put("USERS_OPENID",snsUserInfo.getOpenId());
				pd.put("CREATEDATE", new Date());
				pd.put("USERS_PHONE", VALIDATION_PHONE);
				PageData stupd = new PageData();
				stupd.put("PHONE", VALIDATION_PHONE);
				PageData student = webstudentService.findByPhone(stupd);
				
				List<PageData> students = webstudentService.findListByPhone(stupd);
				
				if (null != student && !"".equals(student)) {
					String stuphone = student.getString("PHONE");
					if (stuphone.equals(VALIDATION_PHONE)) {
						
						if (null != students) {
							for (int i = 0; i < students.size(); i++) {
								PageData userpd = new PageData();
								userpd.put("STUDENT_ID", students.get(i).getString("STUDENT_ID"));
								userpd.put("USERS_ID", pd.getString("USERS_ID"));
								userpd.put("WEBUSER_ID", this.get32UUID());
								userpd.put("CREATEDATE", new Date());
								webstuwebuserService.save(userpd);
							}
						}
						pd.put("USERS_ISMEMBER", 1);
						pd.put("STUDENT_ID", student.getString("STUDENT_ID"));
					} else {
						pd.put("USERS_ISMEMBER", 0);
					}
				} else {
					pd.put("USERS_ISMEMBER", 0);
				}
				webusersService.save(pd);
				PageData user = webusersService.findById(pd);
				session.setAttribute("loginuser", user);
				result.put("msg", "ok");
			}else {
				PageData hasphone = webusersService.findByphone(userphone);
				if (null != hasphone.getString("users_phone") && !"".equals(hasphone.getString("users_phone"))) {
					result.put("msg", "hasphone"); // 手机已经有啦
				} else {
					result.put("msg", "error"); 
				}

			}
		}else{ result.put("msg","error"); }
		return result;
	}

	/**
	 * 验证手机号码
	 * 
	 * errorinfo ：
	 * hasphone  用户表已经有这个手机号，拒绝发送短信
	 * numerror  短信验证码输入错误
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
		String USERS_PHONE = pd.getString("VALIDATION_PHONE");
		HttpSession session = this.getRequest().getSession();
		SNSUserInfo snsUserInfo =(SNSUserInfo)session.getAttribute("snsUserInfo");
		if (null !=snsUserInfo) {
			pd.put("USERS_OPENID", snsUserInfo.getOpenId());
			if (webusersService.findByUSER_OPPNID(pd) != null) {
				PageData user = webusersService.findByUSER_OPPNID(pd);
				session.setAttribute("loginuser", user);
				errInfo= "login";
			}else {
				pd.remove("USERS_OPENID");
				PageData userphone = new PageData();
				userphone.put("USERS_PHONE", USERS_PHONE);
				if (null == USERS_PHONE || "".equals(USERS_PHONE)) { // 判断手机号
					errInfo = "nullnum"; // 手机号为空
				} else {
					if (valiphone(USERS_PHONE)) { // 判断手机号是否符合规则
						session.setAttribute("phone", USERS_PHONE);
						PageData hasphone = webusersService.findByphone(userphone);
						if (null != hasphone) {
							String usersphonenum = hasphone.getString("users_phone");			
							if (usersphonenum.equals(USERS_PHONE)) {
								errInfo = "hasphone"; // 
							} else {
								errInfo = "success"; // 验证成功
							}
						} else {
							errInfo = "success";
						}
					} else {
						errInfo = "numerror"; // 验证码输入有误
					}
				}
			}
		}else{
			errInfo = "notwechat";
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

	public long getDatePoor(Date endDate, Date nowDate) {
		long diff = endDate.getTime() - nowDate.getTime();
		long min = diff / 60000;
		return min;
	}

	/**
	 * 发送阿里短信
	 * 同一个手机号验证码15分钟允许发送一次
	 * errorinfo：
	 * error  短信发送被拒绝
	 * ok  短信发送成功
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/getsmsvaild")
	public PageData getsmsvaild() throws Exception {
		// 发短信
		PageData result = new PageData();
		HttpSession session = this.getRequest().getSession();
		if (null ==session.getAttribute("phone")) {
			result.put("msg", "请从我们的页面进入,谢谢!");
			result.put("errorinfo", "error");
			return result;
		}
		PageData pd = new PageData();
		pd = this.getPageData();
		String phone = pd.getString("VALIDATION_PHONE");
		PageData data = validationService.findByPhone(pd);
		
		if (data != null) {
			Date oldtime = (Date) data.get("VALIDATION_TIME");
			long min = getDatePoor(new Date(), oldtime);
			if (min < 15) {
				result.put("msg", "验证码15分钟都有效哦!");
				result.put("errorinfo", "hassms");
				return result;
			}
		}
		session.setAttribute("phone", phone);
		PageData back = getGoPageData();// GOTYE_WX_APPID
		String signName = null;
		String tecode = null;
		String accessKeyId = null;
		String accessKeySecret = null;
		if (null != back) {
			signName = back.getString("ALI_SIGN_NAME");
			tecode = back.getString("ALI_TECODE");
			accessKeyId = back.getString("ALI_DX_APPID");
			accessKeySecret = back.getString("ALI_DX_SECRET");
		}

		Random r = new Random();
		String str = "";
		for (int i = 0; i < 4; i++) {
			str += r.nextInt(10);
		}
		String teparam = "{\"code\":\"" + str + "\"}";

		SendSmsResponse response = null;
		try {
			response = SmsUtil.sendSms(phone, signName, tecode, teparam, accessKeyId, accessKeySecret);
			if (response.getCode() != null && response.getCode().equals("OK")) {
				pd.put("VALIDATION_ID", this.get32UUID()); // 主键
				pd.put("VALIDATION_PHONE", phone);
				pd.put("VALIDATION_CODE", str);
				pd.put("VALIDATION_TIME", new Date());
				validationService.save(pd);
				result.put("errorinfo", "ok");
				result.put("msg", response.getMessage());
			} else {
				result.put("errorinfo", "error");
				result.put("msg", response.getMessage());
			}
		} catch (ClientException | InterruptedException e) {
			result.put("errorinfo", "error");
			result.put("msg", response.getMessage());
		}
		return result;

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
				if (Tools.notEmpty(sessionCode) && sessionCode.equalsIgnoreCase(code)) { // 判断登录验证码
					// session.removeAttribute(Const.SESSION_SECURITY_CODE);
					// //清除登录验证码的session
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


	//@RequestMapping("/vcodeimg")
	public void getCode(HttpServletResponse response,HttpSession session) throws IOException{
		//设置response头信息
		//禁止缓存
		response.setHeader("Pragma", "No-cache");
		response.setHeader("Cache-Control", "no-cache");
		response.setDateHeader("Expires", 0);
		OutputStream outputStream = response.getOutputStream(); 
		Captcha captcha = ImageCodeFactory.getInstance().setCodeParams(120,45).getCaptcha(); 
		System.out.println("code:"+captcha.getChallenge()); 
		BufferedImage bufferedImage = captcha.getImage(); 
		ImageIO.write(bufferedImage, "png", outputStream); 
		outputStream.flush(); 
		outputStream.close();
		String code = captcha.getChallenge();
		session.setAttribute("validateCode", code);
	}


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
		//String code = drawImg(output);
		OutputStream outputStream = response.getOutputStream(); 
		Captcha captcha = ImageCodeFactory.getInstance().setCodeParams(120,45).getCaptcha(); 
		//  System.out.println("code:"+captcha.getChallenge()); 
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

	 
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format, true));
	}

	private PageData getGoPageData() throws Exception {
		PageData pd = new PageData();
		pd.put("BACKSTAGE_ID", "1");
		return gotyeBackstageService.findById(pd);
	}
}
