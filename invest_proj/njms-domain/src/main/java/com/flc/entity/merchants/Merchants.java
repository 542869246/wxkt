package com.flc.entity.merchants;

public class Merchants {
	//合作商家ID
	private String merchants_id;
	//轮播图
	private String image_ids;
	//商家经度坐标
	private String longitude;
	//商家纬度坐标
	private String latitude;
	//商家地址
	private String address;
	//商家电话1
	private String tel_first;
	//商家电话2
	private String tel_second;
	//营业时间
	private String business_hours;
	//配送时间
	private String delivery_time;
	//配送范围
	private String delivery_range;
	//区县id
	private String region_id;
	//区县名称
	private String region_name;
	//合作商家名称
	private String merchants_name; 
	
	public String getMerchants_name() {
		return merchants_name;
	}
	public void setMerchants_name(String merchants_name) {
		this.merchants_name = merchants_name;
	}
	public String getMerchants_id() {
		return merchants_id;
	}
	public void setMerchants_id(String merchants_id) {
		this.merchants_id = merchants_id;
	}
	public String getImage_ids() {
		return image_ids;
	}
	public void setImage_ids(String image_ids) {
		this.image_ids = image_ids;
	}
	public String getLongitude() {
		return longitude;
	}
	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}
	public String getLatitude() {
		return latitude;
	}
	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getTel_first() {
		return tel_first;
	}
	public void setTel_first(String tel_first) {
		this.tel_first = tel_first;
	}
	public String getTel_second() {
		return tel_second;
	}
	public void setTel_second(String tel_second) {
		this.tel_second = tel_second;
	}
	public String getBusiness_hours() {
		return business_hours;
	}
	public void setBusiness_hours(String business_hours) {
		this.business_hours = business_hours;
	}
	public String getDelivery_time() {
		return delivery_time;
	}
	public void setDelivery_time(String delivery_time) {
		this.delivery_time = delivery_time;
	}
	public String getDelivery_range() {
		return delivery_range;
	}
	public void setDelivery_range(String delivery_range) {
		this.delivery_range = delivery_range;
	}
	public String getRegion_id() {
		return region_id;
	}
	public void setRegion_id(String region_id) {
		this.region_id = region_id;
	}
	public String getRegion_name() {
		return region_name;
	}
	public void setRegion_name(String region_name) {
		this.region_name = region_name;
	}
}
