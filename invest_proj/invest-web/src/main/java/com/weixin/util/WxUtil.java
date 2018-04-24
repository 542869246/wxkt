package com.weixin.util;

import java.beans.IntrospectionException;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.InvocationTargetException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Formatter;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.SortedMap;
import java.util.TreeMap;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.methods.PostMethod;
import org.jdom.JDOMException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;

import com.ctt.njms.core.util.Md5Util;
import com.flc.dao.DaoSupport;
import com.flc.service.gotyeBackstage.gotyebackstage.GotyeBackstageManager;
import com.flc.util.PageData;
import com.google.gson.Gson;
import com.weixin.WxConfig;
import com.weixin.model.Goods;
import com.weixin.model.OrderQuery;
import com.weixin.model.Unifiedorder;
import com.weixin.pb.JsapiTicketFactory;

/**
 * 支持微信接口的各种参数算法工具方法
 * @author ctt
 *
 */
public class WxUtil {
	
	//加入log4日志
	public static Logger logger = LoggerFactory.getLogger(WxUtil.class);

	//微信支付API接口协议中包含字段nonce_str，主要保证签名不可预测。我们推荐生成随机数算法如下：调用随机数函数生成，将得到的值转换为字符串。
	public synchronized final static String getNonceStr(){
		long l = System.currentTimeMillis();
		StringBuffer sb = new StringBuffer();
		while ( sb.length()<7 ){
			sb.insert(0, "0");
		}
		sb.insert(0,l);
		String rad = Math.random()+"";
		sb.append(rad.substring(rad.length()-5,rad.length()));
		String nonce_str = Md5Util.getMd5(sb.toString());
		return nonce_str.toUpperCase();
	}
	
	
	/**
	 * @author   ctt
	 * @date 
	 * @Description：sign签名
	 * @param characterEncoding 编码格式
	 * @param parameters 请求参数
	 * @return
	 * 		//text code
	 *		Unifiedorder order = new Unifiedorder();
			order.setAppid("OFQERWERWERDDFGER");
			order.setMch_id("123ttjwkdfj");
			order.setDevice_info("是对方空间啊数量的咖啡机");
			order.setBody("test");
			order.setNonce_str(WxUtil.getNonceStr());
			
			SortedMap<Object,Object> map = (SortedMap<Object,Object>)BeanToMapUtil.convertBean(order,new TreeMap<Object,Object>());
			createSign("UTF-8",map); 
	 *
	 */
	public static String createSign(String characterEncoding,SortedMap<Object,Object> parameters){
		StringBuffer sb = new StringBuffer();
		Set es = parameters.entrySet();
		Iterator it = es.iterator();
		while(it.hasNext()) {
			Map.Entry entry = (Map.Entry)it.next();
			String k = (String)entry.getKey();
			Object v = entry.getValue();
			if(null != v && !"".equals(v) 
					&& !"sign".equals(k) && !"key".equals(k)) {
				sb.append(k + "=" + v + "&");
			}
		}
		sb.append("key="+WxConfig.API_KEY);
		String sign = Md5Util.MD5Encode(sb.toString(), characterEncoding).toUpperCase();
		////System.out.println(sb.toString());
		return sign;
	}
	
	
	/**
	 * 元转分
	 * @param y
	 * @return
	 */
	public synchronized final static int yuanToFen(double y){
		int i = (int)(y*100);
		return i;
	}
	
	/**
	 * 生成 商品 字符串
	 * @param gs
	 * @return
	 *  //Test code
	 	Goods good = new Goods("id1", "name1", 1, yuanToFen(10.01));
		Goods good2 = new Goods("id2", "name2", 2, yuanToFen(20.02));
		
		List<Goods> list = new ArrayList<Goods>();
		list.add(good);
		list.add(good2);
		//System.out.println(getGoodsString(list));
	 */
	public static String getGoodsString(List<Goods> gs){
		Map<String,Object> mapList = new HashMap<String,Object>();
		mapList.put("goods_detail", gs);
		String json = new Gson().toJson(mapList);
		//json = "<![CDATA[" + json + "]]>";
		return json;
	}
	
	
	/**
	 * @author 
	 * @date 2014-12-5下午2:32:05
	 * @Description：将请求参数转换为xml格式的string
	 * @param parameters  请求参数
	 * @return
	 */
	public static String getRequestXml(SortedMap<Object,Object> parameters){
		StringBuffer sb = new StringBuffer();
		sb.append("<xml>");
		Set es = parameters.entrySet();
		Iterator it = es.iterator();
		while(it.hasNext()) {
			Map.Entry entry = (Map.Entry)it.next();
			String k = (String)entry.getKey();
			String v = entry.getValue().toString();
			if ( 
					//"attach".equalsIgnoreCase(k)||
					//"body".equalsIgnoreCase(k)||
					//"sign".equalsIgnoreCase(k) ||
					"detail".equalsIgnoreCase(k)
					) {
				sb.append("<"+k+">"+"<![CDATA["+v+"]]></"+k+">");
			}else {
				sb.append("<"+k+">"+v+"</"+k+">");
			}
		}
		sb.append("</xml>");
		return sb.toString();
	}
	
	
	/**
	 * @author   ctt
	 * @Description：返回给微信的参数
	 * @param return_code 返回编码
	 * @param return_msg  返回信息
	 * @return
	 */
	public static String setXML(String return_code, String return_msg) {
		return "<xml><return_code><![CDATA[" + return_code
				+ "]]></return_code><return_msg><![CDATA[" + return_msg
				+ "]]></return_msg></xml>";
	}
	
	
	/**
	 * 验证下单接口请求参数   返回空表示没有错误
	 * @param map
	 * @return
	 */
	public static String validateDownOrder(SortedMap<Object,Object> map,String trade_type){
		StringBuffer sb = new StringBuffer();
		if(map == null ){
			sb.append("参数列表为空");
		}
		String[] str = new String[]{"appid","mch_id","nonce_str","sign","body","out_trade_no","spbill_create_ip","notify_url","trade_type"};
		for(String s:str){
			if(map.get(s) == null || "".equals(map.get(s).toString())){
				sb.append("-["+s+"]参数必须");
			}
		}
		
		if("NATIVE".equals(trade_type)){
			if(map.get("product_id") == null || "".equals(map.get("product_id").toString())){
				sb.append("-[product_id]参数必须");
			}
		}
		
		if("JSAPI".equals(trade_type)){
			if(map.get("openid") == null || "".equals(map.get("openid").toString())){
				sb.append("-[openid]参数必须");
			}
		}
		
		//检测 金额
		int total_fee = Integer.parseInt(map.get("total_fee").toString());
		if(total_fee<1){
			sb.append("-[total_fee]小于1");
		}
		return sb.toString().trim();
	}
	
	/**
	 * 验证查询接口请求参数   返回空表示没有错误
	 * @param map
	 * @return
	 */
	public static String validateQuery(SortedMap<Object,Object> map){
		StringBuffer sb = new StringBuffer();
		if(map == null ){
			sb.append("参数列表为空");
		}
		String[] str = new String[]{"appid","mch_id","nonce_str","sign"};
		for(String s:str){
			if(map.get(s) == null || "".equals(map.get(s).toString())){
				sb.append("-["+s+"]参数必须");
			}
		}
		
		Object transaction_id = map.get("transaction_id");
		Object out_trade_no = map.get("out_trade_no");
		if((transaction_id == null || "".equals(transaction_id.toString())) && (out_trade_no == null || "".equals(out_trade_no.toString())) ){
			sb.append("-[transaction_id and out_trade_no]选填一个");
		}
		return sb.toString().trim();
	}
	
	/**
	 * 
	 * 微信生成 签名  和支付二维码
	 * 
	 * @param args
	 * @throws IllegalAccessException
	 * @throws InvocationTargetException
	 * @throws IntrospectionException
	 * @throws JDOMException
	 * @throws IOException
	 * 
	 * 
	 * 
	 * 
	 */
	public static Map<String,Object> wxDownOrder(Unifiedorder order) throws IllegalAccessException, InvocationTargetException, IntrospectionException, JDOMException, IOException {
		
		
		Map<String,Object> returnMap = new HashMap<String,Object>(); 
		returnMap.put("success", false);
		returnMap.put("msg", "");
		returnMap.put("data", "");
		
		if(order == null ){
			returnMap.put("success", false);
			returnMap.put("msg","下单对象不能为null");
			return returnMap;
		}
		logger.info("开始生成下单签名");
		
		
		//将参数对象生成 map
		SortedMap<Object,Object> map = (SortedMap<Object,Object>)BeanToMapUtil.convertBean(order,new TreeMap<Object,Object>(),false);
		//生成签名
		String sign = createSign("UTF-8",map);
		logger.info(sign);
		//将签名加入参数列表                                           
		map.put("sign", sign);
		
		logger.info("验证参数可靠性");
		String error = validateDownOrder(map,map.get("trade_type").toString());
		if(!"".equals(error)){
			logger.info(error);
			returnMap.put("success", false);
			returnMap.put("msg",error);
			return returnMap;
		}
		//将参数进行xml格式封装
		String requestXML = getRequestXml(map);
		logger.info(requestXML);
		////System.out.println(requestXML);
		
		logger.info("开始吊用接口进行请求");
		
		//进行http请求
		String result = HttpUtil.httpsRequest(WxConfig.UNIFIED_ORDER_URL, "POST", requestXML);
		
		logger.info(result);
		if(result == null || "".equals(result)){
			returnMap.put("success", false);
			returnMap.put("msg","下单接口用返回错误");
			return returnMap;
		}
		//对返回的参数进行处理
		Map<String, String> resmap = XMLUtil.doXMLParse(result);
		returnMap.put("success", true);
		returnMap.put("msg", "数据处理成功");
		returnMap.put("data", resmap);
		
		//{result_code=SUCCESS, sign=39215AF21066B3E62B4EC93F1BC6AF79, mch_id=1353700302, prepay_id=wx2016070718222554858b00700603682559, return_msg=OK, appid=wx8270788d248cb48f, code_url=weixin://wxpay/bizpayurl?pr=iqbO6eA, nonce_str=DqH3i45qFfMk4gqt, return_code=SUCCESS, device_info=咖啡机8, trade_type=NATIVE}
		
//      InputStream is = ImageCode.getImageStream(ImageCode.create(codeUrl));
//      ImageCode.witeImage(is);
		return returnMap;
	}
	
	
	
	
	
	/**
	 * 
	 * @param args
	 * @throws IntrospectionException 
	 * @throws InvocationTargetException 
	 * @throws IllegalAccessException 
	 * @throws IOException 
	 * @throws JDOMException 
	 * 
	 * @author ctt
	 * @exception 返回xml
	   <xml><return_code><![CDATA[SUCCESS]]></return_code><return_msg><![CDATA[OK]]></return_msg><appid><![CDATA[wx8270788d248cb48f]]></appid><mch_id><![CDATA[1353700302]]></mch_id><device_info><![CDATA[咖啡机7]]></device_info><nonce_str><![CDATA[gVHWqHln1Szk2zPX]]></nonce_str><sign><![CDATA[24FEBE6872BE9E7BD187B1A67AF0B83F]]></sign><result_code><![CDATA[SUCCESS]]></result_code><openid><![CDATA[oQ8hav3P_jSzdtZjS9Xyuz7LF7Zw]]></openid><is_subscribe><![CDATA[N]]></is_subscribe><trade_type><![CDATA[NATIVE]]></trade_type><bank_type><![CDATA[CMB_DEBIT]]></bank_type><total_fee>1</total_fee><fee_type><![CDATA[CNY]]></fee_type><transaction_id><![CDATA[4008742001201607078526728204]]></transaction_id><out_trade_no><![CDATA[ORDER1314237]]></out_trade_no><attach><![CDATA[]]></attach><time_end><![CDATA[20160707154019]]></time_end><trade_state><![CDATA[SUCCESS]]></trade_state><cash_fee>1</cash_fee></xml>
		
		参数集群
		trade_state  SUCCESS
		return_msg  OK
		is_subscribe  N
		appid  wx8270788d248cb48f
		fee_type  CNY
		out_trade_no  ORDER1314237
		nonce_str  gVHWqHln1Szk2zPX
		device_info  咖啡机7
		transaction_id  4008742001201607078526728204
		trade_type  NATIVE
		sign  24FEBE6872BE9E7BD187B1A67AF0B83F
		result_code  SUCCESS
		mch_id  1353700302
		attach  
		total_fee  1
		time_end  20160707154019
		openid  oQ8hav3P_jSzdtZjS9Xyuz7LF7Zw
		return_code  SUCCESS
		bank_type  CMB_DEBIT
		cash_fee  1
	 * 
	 * 
	 */
	public static Map<String,Object> queryOrder(OrderQuery order) throws IllegalAccessException, InvocationTargetException, IntrospectionException, JDOMException, IOException {
		
		
		Map<String,Object> returnMap = new HashMap<String,Object>(); 
		returnMap.put("success", false);
		returnMap.put("msg", "");
		returnMap.put("data", "");
		
		if(order == null ){
			returnMap.put("success", false);
			returnMap.put("msg","查询对象不能为null");
			return returnMap;
		}
		logger.info("开始生成查询签名");
		//将参数对象生成 map
		SortedMap<Object,Object> map = (SortedMap<Object,Object>)BeanToMapUtil.convertBean(order,new TreeMap<Object,Object>(),false);
		
		//生成签名
		String sign = createSign("UTF-8",map);
		logger.info(sign);
		//将签名加入参数列表                                           
		map.put("sign", sign);
		
		logger.info("验证参数可靠性");
		String error = validateQuery(map);
		if(!"".equals(error)){
			logger.info(error);
			returnMap.put("success", false);
			returnMap.put("msg",error);
			return returnMap;
		}
		//将参数进行xml格式封装
		String requestXML = getRequestXml(map);
		logger.info(requestXML);
		
		logger.info("开始吊用接口进行请求");
		//进行http请求
		String result = HttpUtil.httpsRequest(WxConfig.CHECK_ORDER_URL, "POST", requestXML);
		logger.info(result);
		if(result == null || "".equals(result)){
			returnMap.put("success", false);
			returnMap.put("msg","订单查询接口用返回错误");
			return returnMap;
		}
		//对返回的参数进行处理
		Map<String, String> resmap = XMLUtil.doXMLParse(result);
		returnMap.put("success", true);
		returnMap.put("msg", "数据处理成功");
		returnMap.put("data", resmap);
		//数据demo
		//<xml><return_code><![CDATA[SUCCESS]]></return_code><return_msg><![CDATA[OK]]></return_msg><appid><![CDATA[wx8270788d248cb48f]]></appid><mch_id><![CDATA[1353700302]]></mch_id><device_info><![CDATA[咖啡机7]]></device_info><nonce_str><![CDATA[ntdoNvkhzoY50SUj]]></nonce_str><sign><![CDATA[628527A1F203E4C13A3027F78198ABC0]]></sign><result_code><![CDATA[SUCCESS]]></result_code><openid><![CDATA[oQ8hav3P_jSzdtZjS9Xyuz7LF7Zw]]></openid><is_subscribe><![CDATA[N]]></is_subscribe><trade_type><![CDATA[NATIVE]]></trade_type><bank_type><![CDATA[CMB_DEBIT]]></bank_type><total_fee>1</total_fee><fee_type><![CDATA[CNY]]></fee_type><transaction_id><![CDATA[4008742001201607078526728204]]></transaction_id><out_trade_no><![CDATA[ORDER1314237]]></out_trade_no><attach><![CDATA[]]></attach><time_end><![CDATA[20160707154019]]></time_end><trade_state><![CDATA[SUCCESS]]></trade_state><cash_fee>1</cash_fee></xml>
		
		return returnMap;
		
	}
	
	private static String byteToHex(final byte[] hash) {
        Formatter formatter = new Formatter();
        for (byte b : hash)
        {
            formatter.format("%02x", b);
        }
        String result = formatter.toString();
        formatter.close();
        return result;
    }
	
	/**
	 * sha1加密
	 * @param decript
	 * @return
	 */
	public static String SHA1(String decript) {
		String signature = "";
		 try{
	            MessageDigest crypt = MessageDigest.getInstance("SHA-1");
	            crypt.reset();
	            crypt.update(decript.getBytes("UTF-8"));
	            signature = byteToHex(crypt.digest());
	        }
	        catch (NoSuchAlgorithmException e)
	        {
	            e.printStackTrace();
	        }
	        catch (UnsupportedEncodingException e)
	        {
	            e.printStackTrace();
	        }
        return signature;
    }
	
	
	//JSAPI
	public static Map<String, Object> getJsperWxConfig(String jsApiTicket,
			String appId, String url) {
		Map<String,Object> map=new HashMap<String, Object>();
		String timestamp = create_timestamp();
		String noncestr= getNonceStr();
		//wxconfig签名 timestamp S小写
		String signStr ="jsapi_ticket="+jsApiTicket+"&noncestr="+noncestr+"&timestamp="+timestamp+"&url="+url;

		logger.debug("signStr : "+signStr);
		String sign = SHA1(signStr);
		map.put("noncestr", noncestr);
		map.put("signature", sign);
		map.put("timestamp", timestamp);
		map.put("appId", appId);
		////System.out.println(signStr);
		////System.out.println(map);
		logger.debug("wxconfig_map:"+map);
		return map;
	}
	
	public static String create_timestamp() {
        return Long.toString(System.currentTimeMillis() / 1000);
    }
	
	
	public static Map<String,Object> getJsperWxPayParam(String packagestr,String characterEncoding) {
		//参与签名的字段 appId, timeStamp, nonceStr, package, signType
		TreeMap<String,Object> map=new TreeMap<String, Object>();
		map.put("appId", WxConfig.APPID);
		map.put("timeStamp", create_timestamp());
		map.put("nonceStr", getNonceStr());
		map.put("package", packagestr);
		map.put("signType", "MD5");
		List<String> list=new ArrayList<String>(map.keySet());
		Collections.sort(list,new Comparator<String>() {
            //升序排序
            public int compare(String o1,
            		String o2) {
                return o1.compareTo(o2);
            }
        });
		StringBuffer sb=new StringBuffer();
		for (String str : list) {
			sb.append(str+"="+map.get(str)+"&");
		}
		String signstr = sb.toString()+"key="+WxConfig.API_KEY;
		//System.out.print("jsperGrantServerImpl.getJsperWxPayParam -->str:"+signstr);
		map.put("paySign", Md5Util.MD5Encode(signstr.toString(), characterEncoding).toUpperCase());
		return map;
	}
	
	public static Map<String,Object> getJsperWxPayParam(String packagestr,String nonceStr,String timeStamp,String characterEncoding) {
		//参与签名的字段 appId, timeStamp, nonceStr, package, signType
		SortedMap<Object,Object> map = new TreeMap<Object,Object>();
		map.put("appId", WxConfig.APPID);
		map.put("timeStamp", timeStamp);
		map.put("nonceStr", nonceStr);
		map.put("package", packagestr);
		map.put("signType", "MD5");
		StringBuffer sb=new StringBuffer();
		TreeMap<String,Object> returnMap=new TreeMap<String, Object>();
		for (Object str : map.keySet()) {
			returnMap.put(str.toString(), map.get(str));
			sb.append(str.toString()+"="+map.get(str).toString()+"&");
		}
		String signstr = sb.toString()+"key="+WxConfig.API_KEY;
		//System.out.print("jsperGrantServerImpl.getJsperWxPayParam -->str:"+signstr);
		returnMap.put("paySign", Md5Util.MD5Encode(signstr.toString(), characterEncoding).toUpperCase());
		return returnMap;
	}
	
	
	public static void main(String[] args) {
		//
		//getJsperWxPayParam("","");
		
		SortedMap<Object,Object> objectMap = new TreeMap<Object,Object>();
		objectMap.put("appId", "wx8270788d248cb48f");
		objectMap.put("timeStamp", "1468459314");
		objectMap.put("nonceStr", "5801B995BE6F48BAB7419AF417D9CB48");
		objectMap.put("package", "prepay_id=wx20160714092144e136d738810625501534");
		objectMap.put("signType", "MD5");
		String sstr = "";
		for(Object s:objectMap.keySet()){
			sstr += s.toString()+"="+objectMap.get(s)+"&";
		}
		sstr += "key="+WxConfig.API_KEY;
		////System.out.println(sstr);
		////System.out.println(MD5.MD5Encode(sstr).toUpperCase());
		//System.out.println(Md5Util.MD5Encode(sstr.toString(), "UTF-8").toUpperCase());
		
		
		TreeMap<String,Object> map=new TreeMap<String, Object>();
		map.put("appId", "wx8270788d248cb48f");
		map.put("timeStamp", "1468459314");
		map.put("nonceStr", "5801B995BE6F48BAB7419AF417D9CB48");
		map.put("package", "prepay_id=wx20160714092144e136d738810625501534");
		map.put("signType", "MD5");
		List<String> list=new ArrayList<String>(map.keySet());
		Collections.sort(list,new Comparator<String>() {
            //升序排序
            public int compare(String o1,
            		String o2) {
                return o1.compareTo(o2);
            }
        });
		StringBuffer sb=new StringBuffer();
		for (String str : list) {
			sb.append(str+"="+map.get(str)+"&");
		}
		String signstr = sb.toString()+"key="+WxConfig.API_KEY;
		//System.out.println(signstr);
		//System.out.print("jsperGrantServerImpl.getJsperWxPayParam -->str:"+signstr);
		////System.out.println(MD5.MD5Encode(signstr).toUpperCase());
		//System.out.println(Md5Util.MD5Encode(signstr.toString(), "UTF-8").toUpperCase());
		
	}
	
	/**
	 * 进行页面授权签名
	 * @param href  页面完整连接
	 * @return
	 * @throws Exception
	 */
	public static Map<String,Object> getWxConfig(String href,String basePath) throws Exception{
		String currentPath=href;
		if(href.indexOf("#")>=0){
			href=href.substring(0,href.indexOf("#"));
		}
		String appid = "";
		try{
			String jsApiTicket = JsapiTicketFactory.getTicket();
			//获取微信appid
			PageData pd=new PageData();
			pd.put("BACKSTAGE_ID", "1");//账号表第一条数据
			
			String result = getHttpRes(basePath+"gotye/getBackstage");
			if(!StringUtils.isEmpty(result)){
				Map<String,Object> map = com.ctt.njms.core.util.JsonUtil.listKeyMap(result);
				appid = String.valueOf(map.get("GOTYE_WX_APPID"));
			}
			
			//String appid = WxConfig.APPID;
			return getJsperWxConfig(jsApiTicket, appid, currentPath);
		}catch (Exception e) {
			logger.error("获取前端页面JSAPI验证出现异常,返回 null",e);
			throw e;
		}
	}
	
	
	public static String getHttpRes(String url){
		String SubmitResult = "";
		HttpClient client = new HttpClient(); 
		PostMethod method = new PostMethod(url); 
		
		client.getParams().setContentCharset("UTF-8");
		method.setRequestHeader("ContentType","application/x-www-form-urlencoded;charset=UTF-8");
		try {
			client.executeMethod(method);
			SubmitResult =method.getResponseBodyAsString();
		} catch (IOException e) {
			e.printStackTrace();
		}finally{
			client = null;
			method = null;
		}
		
		return SubmitResult;
	}
	

	
	/**
	 * 生成jsapi支付参数
	 * @param packagestr  预支付生成的prepay_id id
	 * @return
	 * @throws Exception
	 */
	public static Map<String,Object> getWxpayParam(String packagestr) throws Exception{
		try{
			return getJsperWxPayParam(packagestr,"UTF-8");
		}catch (Exception e){
			logger.error("获取前端页面JSAPI调用支付出现异常,返回 null",e);
			throw e;
		}
	}
	public static Map<String,Object> getWxpayParam(String packagestr,String nonceStr,String timeStamp) throws Exception{
		try{
			return getJsperWxPayParam(packagestr,nonceStr,timeStamp,"UTF-8");
		}catch (Exception e){
			logger.error("获取前端页面JSAPI调用支付出现异常,返回 null",e);
			throw e;
		}
	}
	
	
	
	/**
	 * 通过接口获取
	 * @param appId
	 * @param secret
	 * @param code
	 * @return
	 * @throws IOException
	 */
	public static Map<String, Object> getAccessTokenAndOpenIdByCode(String code,String appid,String appSecrect){
		String param ="https://api.weixin.qq.com/sns/oauth2/access_token?appid="+
				appid+"&secret="+appSecrect+"&code="+code+"&grant_type=authorization_code";
		String result = HttpUtil.httpsRequest(param, "POST", null);
		//{ "access_token":"ACCESS_TOKEN", "expires_in":7200, 
		//	"refresh_token":"REFRESH_TOKEN", "openid":"OPENID", 
		//	"scope":"SCOPE", "unionid": "o6_bmasdasdsad6_2sgVt7hMZOPfL" }
		logger.info(result);
		//System.out.println(result);
		Map<String,Object> map = com.ctt.njms.core.util.JsonUtil.listKeyMap(result);
		return map;
	}
	
	/**
	 * 获取用户信息
	 * @param accessToken
	 * @param openid
	 * @return
	 */
	public static Map<String,Object> getGrantWxInfo(String accessToken,String openid){
		String geturl="https://api.weixin.qq.com/sns/userinfo?access_token="+accessToken+"&openid="+openid+"&lang=zh_CN";
		String result = HttpUtil.httpsRequest(geturl, "POST", null);
		logger.info(result);
		//System.out.println(result);
		Map<String,Object> map = com.ctt.njms.core.util.JsonUtil.listKeyMap(result);
		return map;
	}
	
	/**
	 * 判断是否来自微信浏览器 
	 * @return
	 */
	public static boolean isWechatBrowser(HttpServletRequest request){
		 return request.getHeader("user-agent").contains("MicroMessenger");
	} 
}
