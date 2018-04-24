package com.weixin.model;

/**
 * 商品详细列表，使用Json格式，传输签名前请务必使用CDATA标签将JSON文本串保护起来。
 * 
 * @author ctt
 *
 */
public class Goods {

	private String goods_id; 	//goods_id String 必填 32 商品的编号
	private String goods_name; 	//必填 256 商品名称
	private int goods_num; 		//必填 商品数量
	private int price;			//商品单价，单位为分
	
	//上方属性必填
	//下方选填
	
	private String wxpay_goods_id; //可选 32 微信支付定义的统一商品编号
	private String goods_category; //可选 32 商品类目ID
	private String body; //可选 1000 商品描述信息
	
	
	public Goods() {
		super();
	}
	public Goods(String goods_id, String goods_name, int goods_num, int price) {
		super();
		this.goods_id = goods_id;
		this.goods_name = goods_name;
		this.goods_num = goods_num;
		this.price = price;
	}
	public Goods(String goods_id, String goods_name, int goods_num, int price, String wxpay_goods_id,
			String goods_category, String body) {
		super();
		this.goods_id = goods_id;
		this.goods_name = goods_name;
		this.goods_num = goods_num;
		this.price = price;
		this.wxpay_goods_id = wxpay_goods_id;
		this.goods_category = goods_category;
		this.body = body;
	}
	public String getGoods_id() {
		return goods_id;
	}
	public void setGoods_id(String goods_id) {
		this.goods_id = goods_id;
	}
	public String getGoods_name() {
		return goods_name;
	}
	public void setGoods_name(String goods_name) {
		this.goods_name = goods_name;
	}
	public int getGoods_num() {
		return goods_num;
	}
	public void setGoods_num(int goods_num) {
		this.goods_num = goods_num;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getWxpay_goods_id() {
		return wxpay_goods_id;
	}
	public void setWxpay_goods_id(String wxpay_goods_id) {
		this.wxpay_goods_id = wxpay_goods_id;
	}
	public String getGoods_category() {
		return goods_category;
	}
	public void setGoods_category(String goods_category) {
		this.goods_category = goods_category;
	}
	public String getBody() {
		return body;
	}
	public void setBody(String body) {
		this.body = body;
	}
	
}


/**
{
"goods_detail":[
{
"goods_id":"iphone6s_16G",
"wxpay_goods_id":"1001",
"goods_name":"iPhone6s 16G",
"goods_num":1,
"price":528800,
"goods_category":"123456",
"body":"苹果手机"
},
{
"goods_id":"iphone6s_32G",
"wxpay_goods_id":"1002",
"goods_name":"iPhone6s 32G",
"quantity":1,
"price":608800,
"goods_category":"123789",
"body":"苹果手机"
}
]
} 
 */
