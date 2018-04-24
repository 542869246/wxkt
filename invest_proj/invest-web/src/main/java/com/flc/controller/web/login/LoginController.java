package com.flc.controller.web.login;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.util.EntityUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.flc.controller.base.BaseController;
import com.flc.service.web.log.LogManager;
import com.flc.service.web.userinfo.UserinfoManager;
import com.flc.util.PageData;
import com.flc.wx.pojo.SNSUserInfo;
import com.flc.wx.pojo.WeixinOauth2Token;
import com.flc.wx.util.CommonUtil;
import com.flc.wx.util.GetUserInfos;
import net.sf.json.JSONObject;

/**
* 类名: LoginController </br>
* 描述: 通过网页授权获取的用户信息 </br>
* 开发人员： souvc </br>
* 创建时间：  2015-11-27 </br>
* 发布版本：V1.0  </br>
 */
@Controller
@RequestMapping("/login")
public class LoginController extends BaseController {
	
	@Resource(name="userinfoService")
	private UserinfoManager userinfoService;
	@Value("${appId}")
	private String appId;
	@Value("${appSecret}")
	private String appSecret;
	@Resource(name="logService")
	private LogManager logService;
	//验证用户信息并判断是否第一次关注登录,第一次则跳转用户绑定页面,否则直接跳转首页
	@RequestMapping("/toIndex")
	public ModelAndView toindex() throws Exception{
		ModelAndView view = this.getModelAndView();
		HttpServletRequest request = this.getRequest();
		// 用户同意授权后，能获取到code
        String code = request.getParameter("code");
        String state = request.getParameter("state");
//        System.out.println(code);
//        System.out.println(state);
        SNSUserInfo snsUserInfo=null;
        try{
        	// 用户同意授权
            if (!"authdeny".equals(code)) {
                // 获取网页授权access_token
                WeixinOauth2Token weixinOauth2Token = CommonUtil.getOauth2AccessToken(appId, appSecret, code);
                // 网页授权接口访问凭证
                String accessToken = weixinOauth2Token.getAccessToken();
                // 用户标识
                String openId = weixinOauth2Token.getOpenId();
                // 获取用户信息
                snsUserInfo = GetUserInfos.getSNSUserInfo(accessToken, openId);

//                System.out.println(snsUserInfo);
                // 设置要传递的参数
                view.addObject("snsUserInfo", snsUserInfo);
                view.addObject("state",state);
                request.getSession().setAttribute("snsUserInfo", snsUserInfo);
            }
            PageData pd=new PageData();
            pd.put("USER_OPPNID", snsUserInfo.getOpenId());
            PageData user = userinfoService.findByUSER_OPPNID(pd);
            System.out.println(user);
            if(user!=null){
            	request.getSession().setAttribute("loginuser", user);
            	
            	PageData log=new PageData();
            	log.put("LOG_ID", this.get32UUID());
            	log.put("LOG_USER_ID", user.get("USERINFO_ID"));
            	log.put("LOG_TIME", new Date());
            	logService.save(log);
            	view.setViewName("index/index");
            }else{
            	view.setViewName("login/register");
            }
        }catch(Exception e){
        	String path = request.getContextPath();
        	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
        			+ path + "/";
        	
        	view.addObject("appId", appId);
        	view.addObject("redirect_uri", URLEncoder.encode(basePath,"UTF-8"));
        	
        	view.setViewName("login/toGuanzhu");
        }
        
		return view;
	}
	
	// http客户端
	public static DefaultHttpClient httpclient;
	static {
		httpclient = new DefaultHttpClient();
		httpclient = (DefaultHttpClient) HttpClientConnectionManager.getSSLInstance(httpclient); // 接受任何证书的浏览器客户端
	}
	/**
	 * OAuth2
	 *  code  
	 * @param 公众号 code  
	 *  code
	 *  @author mxy
	 */
	public static String getCode(String appId) throws Exception {
		String url ="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+appId +
		"&redirect_uri="+URLEncoder.encode(URLDecoder.decode("http://ylxhome.com","UTF-8"))+"&response_type=code&scope=snsapi_base&state=1#wechat_redirect";
		
		HttpGet get = HttpClientConnectionManager.getGetMethod(url);
		HttpResponse response = httpclient.execute(get);   
		String jsonStr = EntityUtils.toString(response.getEntity(), "utf-8");
		JSONObject json = JSONObject.fromObject(jsonStr); 
		return "";
	}
}
