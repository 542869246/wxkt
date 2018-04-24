package com.flc.entity.category;

import java.util.List;

/** 
 * 说明：CATEGORY 实体类
 * 创建人：FLC
 * 创建时间：2017-03-09
 */
public class Category{ 
	
	private String CATEGORY_ID;	//主键
	private String NAME;					//名称
	private String PARENT_ID;				//父类ID
	private String target;
	private Category category;
	private List<Category> subCategory;
	private boolean hasCategory = false;
	private String treeurl;
	
	private String CATEGORY_CODE;			//类型编码
	public String getFCATEGORY_CODE() {
		return CATEGORY_CODE;
	}
	public void setFCATEGORY_CODE(String CATEGORY_CODE) {
		this.CATEGORY_CODE = CATEGORY_CODE;
	}
	private int SORT;				//排序
	public int getFSORT() {
		return SORT;
	}
	public void setFSORT(int SORT) {
		this.SORT = SORT;
	}
	private String IMAGE;			//图片路径
	public String getFIMAGE() {
		return IMAGE;
	}
	public void setFIMAGE(String IMAGE) {
		this.IMAGE = IMAGE;
	}
	private String REMARK;			//备注
	public String getFREMARK() {
		return REMARK;
	}
	public void setFREMARK(String REMARK) {
		this.REMARK = REMARK;
	}
	private int IS_DEL;				//是否删除{0:未删除,1:已删除}
	public int getFIS_DEL() {
		return IS_DEL;
	}
	public void setFIS_DEL(int IS_DEL) {
		this.IS_DEL = IS_DEL;
	}

	public String getCATEGORY_ID() {
		return CATEGORY_ID;
	}
	public void setCATEGORY_ID(String CATEGORY_ID) {
		this.CATEGORY_ID = CATEGORY_ID;
	}
	public String getNAME() {
		return NAME;
	}
	public void setNAME(String NAME) {
		this.NAME = NAME;
	}
	public String getPARENT_ID() {
		return PARENT_ID;
	}
	public void setPARENT_ID(String PARENT_ID) {
		this.PARENT_ID = PARENT_ID;
	}
	public String getTarget() {
		return target;
	}
	public void setTarget(String target) {
		this.target = target;
	}
	public Category getCategory() {
		return category;
	}
	public void setCategory(Category category) {
		this.category = category;
	}
	public List<Category> getSubCategory() {
		return subCategory;
	}
	public void setSubCategory(List<Category> subCategory) {
		this.subCategory = subCategory;
	}
	public boolean isHasCategory() {
		return hasCategory;
	}
	public void setHasCategory(boolean hasCategory) {
		this.hasCategory = hasCategory;
	}
	public String getTreeurl() {
		return treeurl;
	}
	public void setTreeurl(String treeurl) {
		this.treeurl = treeurl;
	}
	
}
