package com.flc.entity.merchants;

public class MerchantsGoods {
	//商品ID
	private String goods_id;
	//合作商家ID
	private String merchants_id;
	//商品图片
	private String logo;
	//商品名称
	private String name;
	//商品规格
	private String specifications;
	//商品保质期
	private String shelf_life;
	//商品单价
	private String unit_price;
	//商品保存方式
	private String save_mode;
	
	public String getGoods_id() {
		return goods_id;
	}
	public void setGoods_id(String goods_id) {
		this.goods_id = goods_id;
	}
	public String getMerchants_id() {
		return merchants_id;
	}
	public void setMerchants_id(String merchants_id) {
		this.merchants_id = merchants_id;
	}
	public String getLogo() {
		return logo;
	}
	public void setLogo(String logo) {
		this.logo = logo;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getSpecifications() {
		return specifications;
	}
	public void setSpecifications(String specifications) {
		this.specifications = specifications;
	}
	public String getShelf_life() {
		return shelf_life;
	}
	public void setShelf_life(String shelf_life) {
		this.shelf_life = shelf_life;
	}
	public String getUnit_price() {
		return unit_price;
	}
	public void setUnit_price(String unit_price) {
		this.unit_price = unit_price;
	}
	public String getSave_mode() {
		return save_mode;
	}
	public void setSave_mode(String save_mode) {
		this.save_mode = save_mode;
	}
}
