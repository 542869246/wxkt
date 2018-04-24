package com.flc.entity.food;

public class Food {
	//id
	private String food_id;
	//商户id
	private String restaurant_id;
	//商户名称
	private String restaurant_name;
	//名称
	private String food_name;
	//描述
	private String description;
	//排序
	private String sort;
	//是否品牌餐厅（老字号）（0，否；1，是）
	private String is_premium;
	//是否是招牌菜（0：否 1：是）
	private String is_featured;
	//原价
	private String original_price;
	//现价
	private String price;
	//图片
	private String image_url;
	public String getFood_id() {
		return food_id;
	}
	public void setFood_id(String food_id) {
		this.food_id = food_id;
	}
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
	public String getFood_name() {
		return food_name;
	}
	public void setFood_name(String food_name) {
		this.food_name = food_name;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getSort() {
		return sort;
	}
	public void setSort(String sort) {
		this.sort = sort;
	}
	public String getIs_premium() {
		return is_premium;
	}
	public void setIs_premium(String is_premium) {
		this.is_premium = is_premium;
	}
	public String getIs_featured() {
		return is_featured;
	}
	public void setIs_featured(String is_featured) {
		this.is_featured = is_featured;
	}
	public String getOriginal_price() {
		return original_price;
	}
	public void setOriginal_price(String original_price) {
		this.original_price = original_price;
	}
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	public String getImage_url() {
		return image_url;
	}
	public void setImage_url(String image_url) {
		this.image_url = image_url;
	}
	
	
}
