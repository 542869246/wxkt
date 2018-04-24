package com.flc.typeEnums;

import java.io.Serializable;

public enum TypeEnums implements Serializable {
	
	
	
	PRODUCTS_TYPE("50b463cdb2df11e7bfc600163e1a9d37", "产品模块", null),
	NEWS_TYPE("c49cd6dd18444ab7885ebb490c53c21f", "新闻类型", null),
	LEVEL_DEFAULT("2c7d2d83b89d11e794c800163e1a9d37", "默认等级", null),
	LEVEL_HUANGJIN("4707bd5fb3a911e7bfc600163e1a9d37", "黄金等级", null),
	LEVEL_BAIJIN("6d7e15dfb3a911e7bfc600163e1a9d37", "珀金等级", null),
	LEVEL_ZHUANSHI("a732f5b5b3a911e7bfc600163e1a9d37", "钻石等级", null),
	ZIXUN_TYPE("6c44ebb8ad0c4e9eac5f3c5e82ca622a", "资讯类型", null),
	USERGROUP_DEFAULT("0b577b91748748abb42a713a70e223ed", "默认分组", null),
	;
	private final String code;
	private final String des;
	private final Enum parent;
	
	TypeEnums(String code, String des, Enum parent) {
		this.code = code;
		this.des = des;
		this.parent = parent;
	}

	public String getCode() {
		return code;
	}

	public String getDes() {
		return des;
	}

	public Enum getParent() {
		return parent;
	}
	
	/**
	 * 通过枚举<code>des</code>获得枚举
	 * 
	 * @param des
	 * @return 
	 * @return
	 */
	public static TypeEnums getByDescription(String des) {
		if (null==des||"".equals(des)||"".equals(des.trim())) {
			return null;
		}
		for (TypeEnums menum : values()) {
			if (menum.getDes().equals(des)) {
				return menum;
			}
		}
		return null;
	}
	
	/**
	 * 通过code 获取 枚举
	 * @param code
	 * @return
	 */
	public static TypeEnums getByCode(String code) {
		if (null==code||"".equals(code)||"".equals(code.trim())) {
			return null;
		}
		for (TypeEnums menum : values()) {
			if (menum.getCode().equals(code)) {
				return menum;
			}
		}
		return null;
	}
}
