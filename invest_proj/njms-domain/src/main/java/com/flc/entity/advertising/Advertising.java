package com.flc.entity.advertising;
/**
 * 首页广告
 * @author NJMS-FLC
 *
 */
public class Advertising {
	//广告id
	private String ad_id;
	//广告名称
	private String name;
	//广告链接
	private String url;
	//区县id
	private String region_id;
	//区县名称
	private String region_name;
	public String getAd_id() {
		return ad_id;
	}
	public void setAd_id(String ad_id) {
		this.ad_id = ad_id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
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
