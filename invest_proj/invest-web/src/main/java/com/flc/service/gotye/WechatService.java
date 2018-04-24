package com.flc.service.gotye;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.flc.service.gotyeBackstage.gotyebackstage.impl.GotyeBackstageService;
import com.flc.util.HttpUtils;
import com.flc.util.PageData;
import com.flc.wx.pojo.gotye.AccessToken;
import com.flc.wx.pojo.gotye.JsApiAccessToken;
import com.flc.wx.pojo.gotye.JsapiTicket;
import com.flc.wx.pojo.gotye.WeChatUserInfo;

/**
 * 微信公众号
 * @author xunbing
 *
 */
@Service
public class WechatService {
	@Autowired
	private GotyeBackstageService gbs;
	private PageData pd=null;
	
	private ObjectMapper mapper = new ObjectMapper();
	
	public AccessToken getAccessToken(String code) throws JsonParseException, JsonMappingException, IOException {
		try {
			 pd = this.getPageData();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String param = "appid=" + pd.get("GOTYE_WX_APPID") + "&secret=" + pd.get("GOTYE_WX_SECRET") + "&code=" + code + "&grant_type=authorization_code";
		
		String respstr = HttpUtils.sendPost("https://api.weixin.qq.com/sns/oauth2/access_token", param);
		
		AccessToken accessToken = mapper.readValue(respstr, AccessToken.class);
		
		return accessToken;
	}
	
	public WeChatUserInfo getUserInfo(String accessToken, String openId) throws JsonParseException, JsonMappingException, IOException{
		
		String param = "access_token=" + accessToken + "&openid=" + openId + "&lang=zh_CN";
		
		String respstr = HttpUtils.sendPost("https://api.weixin.qq.com/sns/userinfo", param);
		
		WeChatUserInfo userInfo = mapper.readValue(respstr, WeChatUserInfo.class);
		
		return userInfo;	
	}
	
	public JsApiAccessToken getJsApiAccessToken() throws JsonParseException, JsonMappingException, IOException {
		try {
			 pd = this.getPageData();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String param = "grant_type=client_credential&appid="+pd.get("GOTYE_WX_APPID")+"&secret="+pd.get("GOTYE_ACCESS_SECRET");
		
		String respstr = HttpUtils.sendGet("https://api.weixin.qq.com/cgi-bin/token", param);
		
		JsApiAccessToken jsApiAccessToken = mapper.readValue(respstr, JsApiAccessToken.class);
		
		return jsApiAccessToken;
	}
	
	public JsapiTicket getJsapiTicket(String accessToken) throws JsonParseException, JsonMappingException, IOException{
		
		String param = "access_token=" + accessToken + "&type=jsapi";
		
		String respstr = HttpUtils.sendGet("https://api.weixin.qq.com/cgi-bin/ticket/getticket", param);
		
		JsapiTicket jsapiTicket = mapper.readValue(respstr, JsapiTicket.class);
		
		return jsapiTicket;
	}
	private PageData getPageData() throws Exception{
		PageData pd=new PageData();
		pd.put("BACKSTAGE_ID", "1");
		return gbs.findById(pd);
	}
}
