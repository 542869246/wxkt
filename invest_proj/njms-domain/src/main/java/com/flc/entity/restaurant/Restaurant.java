package com.flc.entity.restaurant;

public class Restaurant {
	//店铺 ID
	private String restaurant_id;
	//餐厅名称
	private String restaurant_name;
	//餐厅描述
	private String description;
	//客服电话号码
	private String phone;
	//门店电话号码
	private String standby_tel;
	//是否品牌餐厅（老字号）（0，否；1，是）
	private String is_premium;
	//人均消费(元）
	private String avg_price;
	//营业时间(7:00-9:00,11:30-19:00门店营业时间
	private String serving_time;
	//星级评分，5.0代表五星，4.5代表四星半，依此类推
	private String num_ratings;
	//餐厅logo地址
	private String image_url;
	//所属分类信息列表，如[宁波菜，婚宴酒店]
	private String categories;
	//纬度坐标
	private String latitude;
	//经度坐标
	private String longitude;
	//促销信息（优惠信息）
	private String promotion_info;
	//区县（方便区县查询）
	private String region;
	public String getRestaurant_id() {
		return restaurant_id;
	}
	public void setRestaurant_id(String restaurant_id) {
		this.restaurant_id = restaurant_id;
	}
	public String getRestaurant_name() {
		return restaurant_name;
	}
	public void setRestaurant_name(String restaurant_name) {
		this.restaurant_name = restaurant_name;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getStandby_tel() {
		return standby_tel;
	}
	public void setStandby_tel(String standby_tel) {
		this.standby_tel = standby_tel;
	}
	public String getIs_premium() {
		return is_premium;
	}
	public void setIs_premium(String is_premium) {
		this.is_premium = is_premium;
	}
	public String getAvg_price() {
		return avg_price;
	}
	public void setAvg_price(String avg_price) {
		this.avg_price = avg_price;
	}
	public String getServing_time() {
		return serving_time;
	}
	public void setServing_time(String serving_time) {
		this.serving_time = serving_time;
	}
	public String getNum_ratings() {
		return num_ratings;
	}
	public void setNum_ratings(String num_ratings) {
		this.num_ratings = num_ratings;
	}
	public String getImage_url() {
		return image_url;
	}
	public void setImage_url(String image_url) {
		this.image_url = image_url;
	}
	public String getCategories() {
		return categories;
	}
	public void setCategories(String categories) {
		this.categories = categories;
	}
	public String getLatitude() {
		return latitude;
	}
	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}
	public String getLongitude() {
		return longitude;
	}
	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}
	public String getPromotion_info() {
		return promotion_info;
	}
	public void setPromotion_info(String promotion_info) {
		this.promotion_info = promotion_info;
	}
	public String getRegion() {
		return region;
	}
	public void setRegion(String region) {
		this.region = region;
	}
}