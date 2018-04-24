package com.flc.enums;

import java.io.Serializable;

/**
 * 状态枚举
 * @author tanglunhong
 *
 */
public enum DefaultStatusEnum implements Serializable {
	
	/**
	 * 无效
	 */
	INVALID("0", "无效", null),
	/**
	 * 有效
	 */
	VALIDATE("1", "有效", null),
	;
	private final String code;
	private final String des;
	private final Enum parent;
	
	DefaultStatusEnum(String code, String des, Enum parent) {
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
	public static DefaultStatusEnum getByDescription(String des) {
		if (null==des||"".equals(des)||"".equals(des.trim())) {
			return null;
		}
		for (DefaultStatusEnum menum : values()) {
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
	public static DefaultStatusEnum getByCode(String code) {
		if (null==code||"".equals(code)||"".equals(code.trim())) {
			return null;
		}
		for (DefaultStatusEnum menum : values()) {
			if (menum.getCode().equals(code)) {
				return menum;
			}
		}
		return null;
	}
	/**
	 * 是否存在CODE
	 * false->不存在;true->存在
	 * @return
	 */
	public static boolean isNotExists(String CODE){
		for (DefaultStatusEnum menum : values()) {
			if (menum.getCode().equals(CODE)) {
				return true;
			}
		}
		return false;
	}
}
