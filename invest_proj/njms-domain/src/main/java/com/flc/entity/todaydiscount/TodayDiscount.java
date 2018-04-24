package com.flc.entity.todaydiscount;

/**
 * 今日特惠
 * @author NJMS-FLC
 *
 */
public class TodayDiscount {
	//商家id
	private String merchants_id;
	//餐馆名称
	private String name;
	//优惠内容
	private String preferential_content;
	//图片
	private String logo;
	//区县id
	private String region_id;
	//区县名称
	private String region_name;
	//优惠结束时间
	private String preferential_end_time;
	public String getMerchants_id() {
		return merchants_id;
	}
	public void setMerchants_id(String merchants_id) {
		this.merchants_id = merchants_id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPreferential_content() {
		return preferential_content;
	}
	public void setPreferential_content(String preferential_content) {
		this.preferential_content = preferential_content;
	}
	public String getLogo() {
		return logo;
	}
	public void setLogo(String logo) {
		this.logo = logo;
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
	public String getPreferential_end_time() {
		return preferential_end_time;
	}
	public void setPreferential_end_time(String preferential_end_time) {
		this.preferential_end_time = preferential_end_time;
	}
}
