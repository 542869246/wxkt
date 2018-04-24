package com.weixin.model;

import com.weixin.WxConfig;
import com.weixin.util.WxUtil;

public class OrderQuery {

	private String appid=WxConfig.APPID; //微信分配的公众账号ID（企业号corpid即为此appId）
	private String mch_id=WxConfig.MCH_ID; //微信支付分配的商户号
	private String transaction_id; //微信的订单号，优先使用
	private String out_trade_no; //商户系统内部的订单号，当没提供transaction_id时需要传这个。
	private String nonce_str=WxUtil.getNonceStr(); //随机字符串，不长于32位。推荐随机数生成算法
	private String sign; //签名
	
	
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
	public String getTransaction_id() {
		return transaction_id;
	}
	public void setTransaction_id(String transaction_id) {
		this.transaction_id = transaction_id;
	}
	public String getOut_trade_no() {
		return out_trade_no;
	}
	public void setOut_trade_no(String out_trade_no) {
		this.out_trade_no = out_trade_no;
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
	
}
