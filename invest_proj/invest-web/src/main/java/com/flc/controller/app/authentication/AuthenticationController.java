package com.flc.controller.app.authentication;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONObject;
import com.flc.controller.base.BaseController;
import com.flc.enums.KEYEnum;
import com.flc.enums.DefaultStatusEnum;
import com.flc.service.member.MemberManager;
import com.flc.service.web.log.LogManager;
import com.flc.service.web.userinfo.UserinfoManager;
import com.flc.service.web.webusers.WebUsersManager;
import com.flc.util.CookieUtil;
import com.flc.util.EmojiUtil;
import com.flc.util.PageData;
import com.flc.util.URLHandleUtil;
import com.flc.util.UuidUtil;
import com.flc.wx.pojo.SNSUserInfo;
import com.weixin.util.WxUtil;

/**
 * 鉴权控制
 * @author tanglunhong
 * @date 2017年8月18日
 */
@Controller
@RequestMapping(value="/authentication")
public class AuthenticationController extends BaseController{
	/**
	 * 此字段由配置文件中读取出来，为true表示上线，false表示未上线
	 */
//	@Value("${system.publish}")
//	private String isPublish;//是否已上线
	
/*	@Resource(name="userinfoService")
	private UserinfoManager userinfoService;*/
	@Resource(name="logService")
	private LogManager logService;
	@Resource(name = "webusersService")
	private WebUsersManager webusersService;
	/**
	 * 获取微信用户微信
	 * <br/>注册或微信自动登陆
	 * @param redirectUrl
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/security/{urlPath}")
	public ModelAndView index(@PathVariable String urlPath,HttpServletResponse response)
			throws Exception {
		logger.info("--===开始微信鉴权逻辑===--");
		urlPath = urlPath.replace("|", "/");
		ModelAndView mv = null;
		SNSUserInfo snsUserInfo = new SNSUserInfo();
		HttpServletRequest request = this.getRequest();
		
		String contextPath = request.getContextPath();
		String requestUrl = request.getRequestURI();
		
		//将要跳转的路径
		//String redirectPath = URLHandleUtil.recover(redirectUrl.replace("|", "/"));
//		if(!StringUtils.isEmpty(redirectPath)){
//			logger.info("判断将要跳转的路径是否带参数。");
////			if(redirectPath.indexOf("$")>-1){
////				logger.info("路径带参,将参数去掉。去掉前的路径为："+redirectPath);
////				redirectPath = redirectPath.substring(0, redirectPath.indexOf("$"));
////				logger.info("去掉后的路径为："+redirectPath);
////			}
//			mv = new ModelAndView("redirect:/activity/goActivity");
//			logger.info("鉴权后要发转到的路径：/activity/goActivity");
//		}else{
			mv = new ModelAndView("redirect:/activity/goActivity");
			logger.info("鉴权后要发转到的路径：/activity/goActivity");
//		}
		
		PageData pd = this.getPageData();
		
		String code = null;
		if(pd.containsKey("code")){
			code = pd.getString("code");
		}else{
			code = getRequest().getParameter("code");
		}
		//System.out.println("-------code-------"+code);
		if(StringUtils.isEmpty(code)){
			logger.info("未得到code，微信鉴权失败.");
			mv.setViewName("../../security_fail");
			return mv;
		}
		
		String path = request.getContextPath();
		String basePath = request.getScheme()+"://"+request.getServerName()+path+"/";
		
		String appid = "";
		String appSecrect = "";
		Map<String, Object> map = null;
		String result = WxUtil.getHttpRes(basePath+"gotye/getBackstage");
		if(!StringUtils.isEmpty(result)){
			Map<String,Object> wxMap = com.ctt.njms.core.util.JsonUtil.listKeyMap(result);
			appid = String.valueOf(wxMap.get("GOTYE_WX_APPID"));
			appSecrect = String.valueOf(wxMap.get("GOTYE_WX_SECRET"));
			map = WxUtil.getAccessTokenAndOpenIdByCode(code,appid,appSecrect);
		}
		
		// 通过微信传过来的code,获取微信用户的openid信息
		if (null == map) {
			logger.info("通过code[" + code + "]获取map失败.");
			//获取用户信息失败/
			mv.setViewName("../../security_fail");
			return mv;
		}
		/**
		 * 获取公众号对应用户生成的唯一标识
		 */
		String openid = (String) map.get("openid");
		
		//System.out.println("-------openid-------"+openid);
		
		if (null == openid || "".equals(openid.trim())) {
			logger.info("返回的map中没有openid");
			mv.setViewName("../../security_fail");
			return mv;
		}
		
		PageData seachMemberPd = new PageData();
		seachMemberPd.put("OPEN_ID", openid);
		
		
		PageData pd1=new PageData();
        pd1.put("USERS_OPENID", openid);
        seachMemberPd = webusersService.findByUSER_OPPNID(pd1);
        
		//根据openid匹配到用户,生成socket并缓存到cookie
		if(null!=seachMemberPd){
			request.getSession().setAttribute("loginuser", seachMemberPd);
        	
        	PageData log=new PageData();
        	log.put("LOG_ID", this.get32UUID());
        	log.put("LOG_USER_ID", seachMemberPd.get("USERINFO_ID"));
        	log.put("LOG_TIME", new Date());
        	logService.save(log);
        	mv = new ModelAndView("redirect:"+urlPath);
        	
        	PageData member = new PageData();
			member.put("STATUS", DefaultStatusEnum.VALIDATE.getCode());
			member.put("SOCKET", UuidUtil.get32UUID());
			member.put("OPEN_ID", openid);
			member.put("PHOTO", seachMemberPd.getString("USER_PHOTO"));
			member.put("SEX", "0");
			member.put("NICK_NAME", seachMemberPd.getString("USER_NICKNAME"));
			member.put("SCHOOL_ID", null);
			member.put("MOBILE", null);
			member.put("BALANCE", 0);
			member.put("MEMMBER_NO", null);
			member.put("CARD_UP_IMAGE", null);
			member.put("CARD_DOWN_IMAGE", null);
			member.put("UPDATE_TIME", null);
			
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			member.put("CREATE_TIME", df.format(new Date()));
			member.put("MEMBER_ID", get32UUID());
			
			request.getSession().setAttribute("loginuser", seachMemberPd);
        	
        	//缓存到cookie
			CookieUtil.addCookie(response, "wxUserCookie", JSONObject.toJSONString(member).toString(), 0);
        	return mv;
		}
		else{
			
			//根据openid未在数据库中匹配到用户，则说明该用户未在系统中注册
			//通过微信接口获取用户信息
			String accessToken = (String) map.get("access_token");
			Map<String, Object> map_user = WxUtil.getGrantWxInfo(accessToken, openid);
			if (null == map_user) {
				logger.error("通过access_token[" + accessToken + "],和openid[" + openid + "]获取微信用户信息失败");
				//获取用户信息失败
				mv.setViewName("../../security_fail");
				return mv;
			}
			
			String headImage = map_user.get("headimgurl").toString();
			String nickName = map_user.get("nickname").toString();
			if (EmojiUtil.containsEmoji(nickName)) {
				nickName = EmojiUtil.filterEmoji(nickName);
			}
			String sex = map_user.get("sex").toString();
			if(StringUtils.isEmpty(sex)){sex=null;}
			switch (new BigDecimal(sex).intValue()) {
			case 0:
				sex = null;//为0性别为未知
				break;
			case 1:
				sex = "1";
			case 2:
				sex = "0";
			default:
				sex = null;
				break;
			}
			PageData member = new PageData();
			member.put("STATUS", DefaultStatusEnum.VALIDATE.getCode());
			member.put("SOCKET", UuidUtil.get32UUID());
			member.put("OPEN_ID", openid);
			member.put("PHOTO", headImage);
			member.put("SEX", sex);
			member.put("NICK_NAME", nickName);
			member.put("SCHOOL_ID", null);
			member.put("MOBILE", null);
			member.put("BALANCE", 0);
			member.put("MEMMBER_NO", null);
			member.put("CARD_UP_IMAGE", null);
			member.put("CARD_DOWN_IMAGE", null);
			member.put("UPDATE_TIME", null);
			
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			member.put("CREATE_TIME", df.format(new Date()));
			member.put("MEMBER_ID", get32UUID());
			
			
			snsUserInfo = new SNSUserInfo();
            snsUserInfo.setOpenId(openid);
            snsUserInfo.setNickname(nickName);
            //snsUserInfo.setCountry(jsonObject.getString("country"));
//            snsUserInfo.setProvince(jsonObject.getString("province"));
//            snsUserInfo.setCity(jsonObject.getString("city"));
            snsUserInfo.setHeadImgUrl(headImage);
			
            request.getSession().setAttribute("snsUserInfo", snsUserInfo);
			mv.setViewName("myDaily/register");
			
			//memberService.save(member);
			//logger.info("新注册微信用户："+JSONObject.toJSONString(member));
			
			//缓存到cookie
			CookieUtil.addCookie(response, "wxUserCookie", JSONObject.toJSONString(member).toString(), 0);
		}
		
		return mv;
	}
	
	@RequestMapping(value="/security/member_info/")
	public ModelAndView memberInfo(HttpServletResponse response){
		ModelAndView mv = new ModelAndView();
		
//		PageData pp = getMemberByCookie();
////		System.out.println(pp.toString());
//		System.out.println(getMemberIdByLoginCache());
//		
//		PageData pd = new PageData();
//		pd.put("MEMBER_ID", "fa0f8efd302f4735a5906fce429bbd2e");
//		try {
//			pd = memberService.findById(pd);
//			CookieUtil.addCookie(response, KEYEnum.HTML5_COOKIE_BY_WECHAT_USER_KEY.getCode(), JSONObject.toJSONString(pd).toString(), 0);
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
		
		return mv;
	}
}
