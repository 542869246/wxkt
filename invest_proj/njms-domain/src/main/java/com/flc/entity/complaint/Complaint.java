package com.flc.entity.complaint;

public class Complaint {
	//投诉id
	private String complaint_id;
	//投诉主题
	private String title;
	//投诉内容
	private String content;
	//会员ID
	private String member_id;
	//投诉图片
	private String image_ids;
	//投诉类型
	private String type;
	public String getComplaint_id() {
		return complaint_id;
	}
	public void setComplaint_id(String complaint_id) {
		this.complaint_id = complaint_id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getImage_ids() {
		return image_ids;
	}
	public void setImage_ids(String image_ids) {
		this.image_ids = image_ids;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
}