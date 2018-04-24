package com.flc.entity.drove;

import java.util.List;

/**
 * 收藏分组
 * @author ZQ
 *
 */
public class Group {

	//分组id
	private String group_id;
	//分组类型   餐饮收藏组0，黄页收藏组1
	private String group_type;
	//分组名称
	private String group_name;
	//会员id
	private String member_id;
	
	private List<Collection> collection_list;
	public List<Collection> getCollection_list() {
		return collection_list;
	}
	public void setCollection_list(List<Collection> collection_list) {
		this.collection_list = collection_list;
	}
	public String getGroup_id() {
		return group_id;
	}
	public void setGroup_id(String group_id) {
		this.group_id = group_id;
	}
	public String getGroup_type() {
		return group_type;
	}
	public void setGroup_type(String group_type) {
		this.group_type = group_type;
	}
	public String getGroup_name() {
		return group_name;
	}
	public void setGroup_name(String group_name) {
		this.group_name = group_name;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	
	
}
