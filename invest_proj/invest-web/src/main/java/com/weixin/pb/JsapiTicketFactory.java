package com.weixin.pb;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.ctt.njms.core.util.JsonUtil;
import com.weixin.util.HttpUtil;

public class JsapiTicketFactory {

	private static Logger log = LoggerFactory.getLogger(JsapiTicketFactory.class);
	private static final long token_expires_in = 7100*1000;  //有效时间为7200秒 为保证 反应时间的有效性 我门设置 快点获取
	private static JsapiTicketFactory ticketFactory =  null;
	private  JsapiTicketFactory(){}
	static{
		ticketFactory = new JsapiTicketFactory();
	}
	
//	//正式环境使用
//	//生成时间
//	private long generateTime＝0;
//	//过期时间
//	private long expiredTime＝0;
//	//api凭证
//	private String ticket;
	
	
	//测试使用 
	//生成时间
	private long generateTime = 1468033534696l;
	//过期时间
	private long expiredTime = 1468040634696l;
	//api凭证
	private String ticket = "kgt8ON7yVITDhtdwci0qecYrtEbmFMKv8-QYdZSb-sthiKHdARU35nUarPv8QcH4bW56xO0DmYNCcT4jwWTiiw";
	//1468033534696|1468040634696|kgt8ON7yVITDhtdwci0qecYrtEbmFMKv8-QYdZSb-sthiKHdARU35nUarPv8QcH4bW56xO0DmYNCcT4jwWTiiw
	
	public static String getTicket(){
		return getTicket(AccessTokenFactory.getToken());
	}
	
	/**
	 * @param token
	 * @return
	 */
	public static String getTicket(String token){
		
		if(token == null || "".equals(token)){
			return "error:token 不能为空";
		}
		if(token.indexOf("error") != -1){
			return token;
		}
		
		//获取当前时间毫秒
		long timenow = System.currentTimeMillis();
		
		//判断token是否有效 
		if(timenow < ticketFactory.expiredTime){
			return ticketFactory.ticket;
		}
		
		String ticket = getHttpTicket(token);
		if(ticket.indexOf("error") != -1){
			return ticket;
		}
		ticketFactory.generateTime = System.currentTimeMillis();
		ticketFactory.expiredTime = ticketFactory.generateTime+token_expires_in;
		ticketFactory.ticket = ticket;
		log.info(ticketFactory.generateTime +"|" + ticketFactory.expiredTime+"|"+ticketFactory.ticket);
		System.out.println(ticketFactory.generateTime +"|" + ticketFactory.expiredTime+"|"+ticketFactory.ticket);
		return ticketFactory.ticket;
	}
	
	private static String getHttpTicket(String token){
		log.info("开始调用apitickate——api接口");
		//token 无效 调用api接口进行查询
		String url ="https://api.weixin.qq.com/cgi-bin/ticket/getticket?access_token="+token+"&type=jsapi";
		log.info(url);
		String result = HttpUtil.httpsRequest(url, "POST", null);
		log.info(result);
		Map<String,Object> map = JsonUtil.listKeyMap(result);
		
		if(map.get("ticket") == null){
			return "error:"+result;
		}
		return map.get("ticket").toString();
	}
	
	public static void main(String[] args) {
		
		System.out.println(getTicket());
		
	}
	
	
}
