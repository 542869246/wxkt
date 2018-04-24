package com.weixin.pb;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.ctt.njms.core.util.JsonUtil;
import com.ctt.njms.core.util.StringUtil;
import com.weixin.WxConfig;
import com.weixin.util.HttpUtil;

public class AccessTokenFactory {

	private static Logger log = LoggerFactory.getLogger(AccessTokenFactory.class);
	private static final long token_expires_in = 7100*1000;  //有效时间为7200秒 为保证 反应时间的有效性 我门设置 快点获取
	private AccessTokenFactory(){};
	private static AccessTokenFactory tokenFactory = null;
	static{
		tokenFactory = new AccessTokenFactory();
	}
	
	
//	//上线使用
//	//生成时间
//	private long generateTime = 0;
//	//过期时间
//	private long expiredTime = 0;
//	//token
//	private String token;
	
	
	//测试使用
	//生成时间
	private long generateTime = 1468032168817l;
	//过期时间
	private long expiredTime = 1468039268817l;
	//token
	private String token="LpdQzilCymApexLIeW5S0EWsCSAZlCXyyBRqEOmyOAodr_AyXc-87Wl-noa69iHz0q7HbwrmLnksTjZ-O4Hr6WmOlhw9FL8OT8nzjK3wnlses2gG_u4dEU4idPbO6hTGPJRcACASMU";
	//1468032168817|1468039268817|dunO8EmRQpXxqjZh_pAajHx4HGAQFCzQMvCY-dUzei5bP7eEbgPL83OhsXMhWSval5w7SSbRpysPsQA89EIdq5tMo_09c-sZvHTGeTqCGglz-Au39Tj7i36xWnHGeof1XKVeABACPA
	/**
	 * 工厂获取token方法 
	 * 1. 判断token是否已经过期
	 * 2. 如果过期调用api接口进行查询生成
	 * @return
	 */
	public static String getToken(){
		
		return getToken(WxConfig.APPID,WxConfig.APP_SECRECT);
	}
	
	public static String getToken(String appid,String secret){
		
		if(appid == ""|| "".equals(appid) || secret == ""|| "".equals(secret) ){
			return "error:appid or  secret不能为空";
		}
		
		//获取当前时间毫秒
		long timenow = System.currentTimeMillis();
		
		//判断token是否有效 
		if(timenow < tokenFactory.expiredTime){
			return tokenFactory.token;
		}
		
		String token = getHttpToken(appid,secret);
		if(token.indexOf("error") != -1){
			return token;
		}
		tokenFactory.generateTime = System.currentTimeMillis();
		tokenFactory.expiredTime = tokenFactory.generateTime+token_expires_in;
		tokenFactory.token = token;
		log.info(tokenFactory.generateTime +"|" + tokenFactory.expiredTime+"|"+tokenFactory.token);
		System.out.println(tokenFactory.generateTime +"|" + tokenFactory.expiredTime+"|"+tokenFactory.token);
		return tokenFactory.token;
	}
	
	private static String getHttpToken(String appid,String secret){
		log.info("开始调用token——api接口");
		//token 无效 调用api接口进行查询
		String url ="https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid="+appid+"&secret="+secret;
		log.info(url);
		String result = HttpUtil.httpsRequest(url, "POST", null);
		log.info(result);
		Map<String,Object> map = JsonUtil.listKeyMap(result);
		
		if(map.get("access_token") == null){
			return "error:"+result;
		}
		return map.get("access_token").toString();
	}
	
	public static void main(String[] args) {
		
		System.out.println(getToken());
		
	}
}
