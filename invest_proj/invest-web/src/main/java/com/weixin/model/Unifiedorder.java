package com.weixin.model;

import com.weixin.WxConfig;
import com.weixin.util.WxUtil;

/**
 * 参数详细文档路径  https://pay.weixin.qq.com/wiki/doc/api/native.php?chapter=9_1
 * @author ctt
 *
 */
public class Unifiedorder {

	private String appid=WxConfig.APPID;//	微信分配的公众账号ID（企业号corpid即为此appId）
	private String mch_id=WxConfig.MCH_ID; //微信支付分配的商户号
	private String nonce_str=WxUtil.getNonceStr(); //随机字符串，不长于32位。
	private String sign; //签名
	/**
	 * 商品描述交易字段格式根据不同的应用场景按照以下格式：
	（1）PC网站——传入浏览器打开的网站主页title名-实际商品名称，例如：腾讯充值中心-QQ会员充值；
	（2） 公众号——传入公众号名称-实际商品名称，例如：腾讯形象店- image-QQ公仔；
	（3） H5——应用在浏览器网页上的场景，传入浏览器打开的移动网页的主页title名-实际商品名称，例如：腾讯充值中心-QQ会员充值；
	（4） 线下门店——门店品牌名-城市分店名-实际商品名称，例如： image形象店-深圳腾大- QQ公仔）
	（5） APP——需传入应用市场上的APP名字-实际商品名称，天天爱消除-游戏充值。
	 */
	private String body;
	private String out_trade_no; //商户系统内部的订单号,32个字符内、可包含字母, 其他说明见商户订单号
	private int total_fee; //订单总金额，单位为分，详见支付金额
	private String spbill_create_ip="127.0.0.1"; //APP和网页支付提交用户端ip，Native支付填调用微信支付API的机器IP。
	private String notify_url=WxConfig.NOTIFY_URL; //接收微信支付异步通知回调地址，通知url必须为直接可访问的url，不能携带参数。
	private String trade_type="NATIVE"; //JSAPI--公众号支付、NATIVE--原生扫码支付、APP--app支付，统一下单接口trade_type的传参可参考这里 MICROPAY--刷卡支付，刷卡支付有单独的支付接口，不调用统一下单接口
	
	//此处上方为必填参数   下方为 选填参数
	
	private String device_info; //终端设备号(门店号或收银设备ID)，注意：PC网页或公众号内支付请传"WEB"
	private String detail; //商品详细列表，使用Json格式    Goods对象
	private String attach; //附加数据，在查询API和支付通知中原样返回，该字段主要用于商户携带订单的自定义数据
	private String fee_type; //符合ISO 4217标准的三位字母代码，默认人民币：CNY，其他值列表详见货币类型
	private String time_start; //订单生成时间，格式为yyyyMMddHHmmss，如2009年12月25日9点10分10秒表示为20091225091010。其他详见时间规则
	private String time_expire; //订单失效时间，格式为yyyyMMddHHmmss，如2009年12月27日9点10分10秒表示为20091227091010。其他详见时间规则 注意：最短失效时间间隔必须大于5分钟
	private String goods_tag;//订单失效时间，格式为yyyyMMddHHmmss，如2009年12月27日9点10分10秒表示为20091227091010。其他详见时间规则 注意：最短失效时间间隔必须大于5分钟
	private String product_id; //trade_type=NATIVE，此参数必传。此id为二维码中包含的商品ID，商户自行定义。
	private String limit_pay; //取值如下：JSAPI，NATIVE，APP，详细说明见参数规定
	private String openid; //trade_type=NATIVE，此参数必传。此id为二维码中包含的商品ID，商户自行定义。
	
	public Unifiedorder() {
		super();
	}
	public Unifiedorder(String appid, String mch_id, String nonce_str, String body, String out_trade_no, int total_fee,
			String spbill_create_ip, String notify_url, String trade_type) {
		super();
		this.appid = appid;
		this.mch_id = mch_id;
		this.nonce_str = nonce_str;
		this.body = body;
		this.out_trade_no = out_trade_no;
		this.total_fee = total_fee;
		this.spbill_create_ip = spbill_create_ip;
		this.notify_url = notify_url;
		this.trade_type = trade_type;
	}
	
	
	public String getAppid() {
		return appid;
	}
	public void setAppid(String appid) {
		this.appid = appid;
	}
	public String getMch_id() {
		return mch_id;
	}
	public void setMch_id(String mch_id) {
		this.mch_id = mch_id;
	}
	public String getNonce_str() {
		return nonce_str;
	}
	public void setNonce_str(String nonce_str) {
		this.nonce_str = nonce_str;
	}
	public String getSign() {
		return sign;
	}
	public void setSign(String sign) {
		this.sign = sign;
	}
	public String getBody() {
		return body;
	}
	public void setBody(String body) {
		this.body = body;
	}
	public String getOut_trade_no() {
		return out_trade_no;
	}
	public void setOut_trade_no(String out_trade_no) {
		this.out_trade_no = out_trade_no;
	}
	public int getTotal_fee() {
		return total_fee;
	}
	public void setTotal_fee(int total_fee) {
		this.total_fee = total_fee;
	}
	public String getSpbill_create_ip() {
		return spbill_create_ip;
	}
	public void setSpbill_create_ip(String spbill_create_ip) {
		this.spbill_create_ip = spbill_create_ip;
	}
	public String getNotify_url() {
		return notify_url;
	}
	public void setNotify_url(String notify_url) {
		this.notify_url = notify_url;
	}
	public String getTrade_type() {
		return trade_type;
	}
	public void setTrade_type(String trade_type) {
		this.trade_type = trade_type;
	}
	public String getDevice_info() {
		return device_info;
	}
	public void setDevice_info(String device_info) {
		this.device_info = device_info;
	}
	public String getDetail() {
		return detail;
	}
	public void setDetail(String detail) {
		this.detail = detail;
	}
	public String getAttach() {
		return attach;
	}
	public void setAttach(String attach) {
		this.attach = attach;
	}
	public String getFee_type() {
		return fee_type;
	}
	public void setFee_type(String fee_type) {
		this.fee_type = fee_type;
	}
	public String getTime_start() {
		return time_start;
	}
	public void setTime_start(String time_start) {
		this.time_start = time_start;
	}
	public String getTime_expire() {
		return time_expire;
	}
	public void setTime_expire(String time_expire) {
		this.time_expire = time_expire;
	}
	public String getGoods_tag() {
		return goods_tag;
	}
	public void setGoods_tag(String goods_tag) {
		this.goods_tag = goods_tag;
	}
	public String getProduct_id() {
		return product_id;
	}
	public void setProduct_id(String product_id) {
		this.product_id = product_id;
	}
	public String getLimit_pay() {
		return limit_pay;
	}
	public void setLimit_pay(String limit_pay) {
		this.limit_pay = limit_pay;
	}
	public String getOpenid() {
		return openid;
	}
	public void setOpenid(String openid) {
		this.openid = openid;
	}
}
