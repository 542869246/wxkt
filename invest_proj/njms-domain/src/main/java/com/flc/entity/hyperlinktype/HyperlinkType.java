package com.flc.entity.hyperlinktype;

import java.util.List;

/** 
 * 说明：链接类别 实体类
 * 创建人：FLC
 * 创建时间：2017-03-14
 */
public class HyperlinkType{ 
	
	private String HYPERLINKTYPE_ID;	//主键
	private String NAME;					//名称
	private String PARENT_ID;				//父类ID
	private String target;
	private HyperlinkType hyperlinktype;
	private List<HyperlinkType> subHyperlinkType;
	private boolean hasHyperlinkType = false;
	private String treeurl;
	
	private String HYPERLINKTYPE_CODE;			//链接类型编码
	public String getFHYPERLINKTYPE_CODE() {
		return HYPERLINKTYPE_CODE;
	}
	public void setFHYPERLINKTYPE_CODE(String HYPERLINKTYPE_CODE) {
		this.HYPERLINKTYPE_CODE = HYPERLINKTYPE_CODE;
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
	private int IS_DEL;				//是否删除
	public int getFIS_DEL() {
		return IS_DEL;
	}
	public void setFIS_DEL(int IS_DEL) {
		this.IS_DEL = IS_DEL;
	}

	public String getHYPERLINKTYPE_ID() {
		return HYPERLINKTYPE_ID;
	}
	public void setHYPERLINKTYPE_ID(String HYPERLINKTYPE_ID) {
		this.HYPERLINKTYPE_ID = HYPERLINKTYPE_ID;
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
	public HyperlinkType getHyperlinkType() {
		return hyperlinktype;
	}
	public void setHyperlinkType(HyperlinkType hyperlinktype) {
		this.hyperlinktype = hyperlinktype;
	}
	public List<HyperlinkType> getSubHyperlinkType() {
		return subHyperlinkType;
	}
	public void setSubHyperlinkType(List<HyperlinkType> subHyperlinkType) {
		this.subHyperlinkType = subHyperlinkType;
	}
	public boolean isHasHyperlinkType() {
		return hasHyperlinkType;
	}
	public void setHasHyperlinkType(boolean hasHyperlinkType) {
		this.hasHyperlinkType = hasHyperlinkType;
	}
	public String getTreeurl() {
		return treeurl;
	}
	public void setTreeurl(String treeurl) {
		this.treeurl = treeurl;
	}
	
}
