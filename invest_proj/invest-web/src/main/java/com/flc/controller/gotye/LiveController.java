package com.flc.controller.gotye;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.flc.controller.base.BaseController;
import com.flc.entity.gotye.AccessTokenReq;
import com.flc.entity.gotye.AccessTokenResp;
import com.flc.entity.gotye.GetRoomPwdReq;
import com.flc.entity.gotye.GetRoomPwdResp;
import com.flc.entity.gotye.GetRoomReq;
import com.flc.entity.gotye.GetRoomResp;
import com.flc.entity.gotye.Room;
import com.flc.service.gotye.WechatService;
import com.flc.service.gotyeBackstage.gotyebackstage.impl.GotyeBackstageService;
import com.flc.util.ApiCall;
import com.flc.util.GotyeConfig;
import com.flc.util.GotyeCookiesUtil;
import com.flc.util.LIVE_ROLE;
import com.flc.util.NameLib;
import com.flc.util.PageData;
import com.flc.wx.pojo.gotye.AccessToken;
import com.flc.wx.pojo.gotye.WeChatUserInfo;

@Controller
public class LiveController extends BaseController{

	private String apiUrl = "https://livevip.com.cn/liveApi";
	private ObjectMapper mapper = new ObjectMapper();
	@Autowired
	private WechatService wechatService;
	@Autowired
	private GotyeBackstageService gbs;
	private static AccessTokenResp appAccessToken=null;
	private PageData pd=null;
	/**
	 * 页面进入
	 * @param req
	 * @param resp
	 * @param map
	 * @return
	 * @throws IOException 
	 */
	@RequestMapping(method = RequestMethod.GET, value = "/live/{roomId}")
	public String liveOnlineEnter(@PathVariable Long roomId,HttpServletRequest req, HttpServletResponse resp, ModelMap map) throws IOException {
		if(roomId==0){//如果等于0则是密码错误不能播放等等
			req.setAttribute("status", 1);
			return "/myDaily/live";
		}
		try {
			 pd = this.getGotyePageData();
		} catch (Exception e) {
			// TODO Auto-generated catch block
		}
		String path = req.getScheme()+"://"+req.getServerName() + ":" + req.getServerPort()+ req.getContextPath();
		req.setAttribute("_path_", path);
		req.setAttribute("roomId", roomId);
		String room = mapper.writeValueAsString(getRoom(roomId));
		req.setAttribute("room", mapper.writeValueAsString(getRoom(roomId)));
		
		//微信appid
		try {
			req.setAttribute("wxJsApiAppId", pd.get("GOTYE_WX_APPID"));
		} catch (Exception e) {
			// TODO Auto-generated catch block
		}
		
		String tokenKey = "room_token_"+roomId;
		//页面通过tokenkey从cookie中获得token
		req.setAttribute("tokenKey",tokenKey);
		String token_key_time = "room_token_" + roomId+"_time";
		String tokenTimeStr = GotyeCookiesUtil.getCookie(req, token_key_time);
		
		String token = GotyeCookiesUtil.getCookie(req, tokenKey);
		
		//如果cookie中已经存在token
		if (StringUtils.isNotEmpty(token) && StringUtils.isNotEmpty(tokenTimeStr)) {
			Long tokenTime = Long.parseLong(tokenTimeStr);
			//如果token未过期
			if((System.currentTimeMillis() - tokenTime) < 24 * 60 * 60 * 1000){
				return "/myDaily/live";
			}
		}
		//如果配置为微信登陆
		if(isWexin(req) && "1".equals(GotyeConfig.getLoginType())){
			//微信登陆授权
			String url = "https://open.weixin.qq.com/connect/oauth2/authorize?appid="+pd.get("GOTYE_WX_APPID")+"&redirect_uri=" + URLEncoder.encode(path.replace(":80","")+"/live/wechat/"+roomId,"UTF-8") + "&response_type=code&scope=snsapi_userinfo&state=weChatState2#wechat_redirect";
			resp.sendRedirect(url);
			return null;
		}
			token = accesstoken("","",roomId);
		GotyeCookiesUtil.setCookie(resp, "room_token_"+roomId, token);
		GotyeCookiesUtil.setCookie(resp, "room_token_" + roomId+"_time", new Date().getTime()+"");
		return "/myDaily/live";
	}
	
	@RequestMapping(method = RequestMethod.GET, value = "/live/wechat/{roomId}")
	public String wechat(@PathVariable Long roomId, HttpServletResponse resp, ModelMap map) throws JsonProcessingException {
		HttpServletRequest req=this.getRequest();
		req.setAttribute("roomId", roomId);//添加房间号
		req.setAttribute("room", mapper.writeValueAsString(getRoom(roomId)));//添加房间信息
		String tokenKey = "room_token_"+roomId;//添加tokenKey
		//页面通过tokenkey从cookie中获得token
		req.setAttribute("tokenKey",tokenKey);
		//设置token_key_time
		try {
			 pd = this.getGotyePageData();
 		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		req.setAttribute("wxJsApiAppId", pd.get("GOTYE_WX_APPID"));
  		String code = req.getParameter("code");
		String nickName ="";
		String openId = "";
   		if (!StringUtils.isEmpty(code)) {
			try {
				AccessToken accessToken = wechatService.getAccessToken(code);
				if (accessToken.getAccess_token() != null) {
					//获取微信用户信息
					WeChatUserInfo userInfo = wechatService.getUserInfo(accessToken.getAccess_token(), accessToken.getOpenid());
					// 确保授权之后不再重复授权
					GotyeCookiesUtil.setCookie(resp, "iswechatauth", "1");
     					GotyeCookiesUtil.setCookie(resp, "weChatOpenId", userInfo.getOpenid());
					GotyeCookiesUtil.setCookie(resp, "headUrl", userInfo.getHeadimgurl());
					nickName = userInfo.getNickname();
					openId = userInfo.getOpenid();
					String token = accesstoken(nickName,openId,roomId);
					GotyeCookiesUtil.setCookie(resp, "tokenKey", tokenKey);
					GotyeCookiesUtil.setCookie(resp, "room_token_"+roomId, token);
					GotyeCookiesUtil.setCookie(resp, "room_token_" + roomId+"_time", new Date().getTime()+"");
					return "/myDaily/live";
				}
			} catch (Exception e) {
				GotyeCookiesUtil.setCookie(resp, "iswechatauth", "2");
				e.printStackTrace();
			}
		} else {
			// 用户取消授权
			GotyeCookiesUtil.setCookie(resp, "iswechatauth", "2");
		}
		return "redirect:/" + "live/"+roomId;
	}
	
	
	/**
	 * 获取token
	 * @return
	 */
	private String accesstoken(String nickName,String account,Long roomId){
		String token = "";
		try {
			String reqJson = "";
			String respStr = "";
			AccessTokenReq req = new AccessTokenReq();
			AccessTokenResp accessTokenResp;
			//获取app级别的token
			accessAppToken();
 			token = appAccessToken.getAccessToken();
			
			//获取房间密码
			String url = apiUrl + "/GetRoomPwd";
			GetRoomPwdReq getRoomPwdReq = new GetRoomPwdReq();
			getRoomPwdReq.setRole(LIVE_ROLE.visitor.getValue());
			getRoomPwdReq.setRoomId(roomId);
			reqJson = mapper.writeValueAsString(getRoomPwdReq);
			Map<String, String> headers = new HashMap<String, String>();
			headers.put("Authorization", token);
			respStr = ApiCall.post(url, reqJson, headers);
 			GetRoomPwdResp getRoomPwdResp = mapper.readValue(respStr, GetRoomPwdResp.class);
			String roomPassword = getRoomPwdResp.getEntity().getUserPwd();
			
			//获取房间级别的token
			url = apiUrl + "/AccessToken";
			req = new AccessTokenReq();
			req.setAccount(StringUtils.isEmpty(account)?UUID.randomUUID().toString().replace("-", ""):account);
			//设置前端用户昵称
			req.setNickName(StringUtils.isEmpty(nickName)?NameLib.generateName():nickName);
			req.setRoomId(roomId);
			req.setPassword(roomPassword);
			req.setScope("room");
			String secretKey = DigestUtils.md5Hex(roomId+roomPassword+pd.get("GOTYE_ACCESS_SECRET"));
			req.setSecretKey(secretKey);
			reqJson = mapper.writeValueAsString(req);
			respStr = ApiCall.post(url, reqJson, null);
			accessTokenResp = mapper.readValue(respStr, AccessTokenResp.class);
			token = accessTokenResp.getAccessToken();
		} catch (Exception e) {
		}
		return token;
	}
	
	/**
	 * 获取app级别的token,并缓存
	 */
	private void accessAppToken(){
		try {
			String url = apiUrl + "/AccessToken";
			String reqJson = "";
			String respStr = "";
			AccessTokenReq req = new AccessTokenReq();
			AccessTokenResp accessTokenResp;
			//获取app级别的token
			if(null == appAccessToken || System.currentTimeMillis() - appAccessToken.getSystime() > appAccessToken.getExpiresIn()*1000){
				req.setScope("app");
				req.setUserName(pd.getString("GOTYE_EMAIL"));
				req.setPassword(pd.getString("GOTYE_PASSWORD"));
				reqJson = mapper.writeValueAsString(req);
				respStr = ApiCall.post(url, reqJson, null);
				accessTokenResp = mapper.readValue(respStr, AccessTokenResp.class);
				appAccessToken = accessTokenResp;
			}
		} catch (Exception e) {
		}
	}
	
	//获取房间信息
	private Room getRoom(Long roomId){
		Room room = new Room();
		try{
			String url = apiUrl + "/GetRoom";
			String reqJson = "";
			String respStr = "";
			accessAppToken();
			String token = appAccessToken.getAccessToken();
			GetRoomReq req = new GetRoomReq();
			req.setRoomId(roomId);
			reqJson = mapper.writeValueAsString(req);
			Map<String, String> headers = new HashMap<String, String>();
			headers.put("Authorization", token);
			respStr = ApiCall.post(url, reqJson, headers);
			GetRoomResp resp = mapper.readValue(respStr, GetRoomResp.class);
			room = resp.getEntity();
		}catch(Exception e){
		}
		return room;
	}
	/**
	 * 微信浏览器
	 * @param req
	 * @return
	 */
	private Boolean isWexin(HttpServletRequest req){
		String ua = req.getHeader("user-agent").toLowerCase();
	    if (ua.indexOf("micromessenger") > 0) {// 是微信浏览器
	        return true; 
	    }else{
	    	return false;
	    }
	}
	private PageData getGotyePageData() throws Exception{
		return gbs.findByOne();
	}
}
