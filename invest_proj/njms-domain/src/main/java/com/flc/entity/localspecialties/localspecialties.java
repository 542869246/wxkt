package com.flc.entity.localspecialties;
/**
 * 本地特产
 * @author NJMS-FLC
 *
 */
public class localspecialties {
	//本地特产id
	private String specialties_id;
	//特产名称
	private String name;
	//特产图片
	private String image;
	//特产链接
	private String url;
	//区县id
	private String region_id;
	//区县名称
	private String region_name;
	public String getSpecialties_id() {
		return specialties_id;
	}
	public void setSpecialties_id(String specialties_id) {
		this.specialties_id = specialties_id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
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
