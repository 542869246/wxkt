package com.flc.enums;

import java.io.Serializable;

/**
 * 文件上传类型枚举
 * @author tlh
 *
 */
public enum XlsUploadEnum implements Serializable {
	
	PHONE_XLS("phone_xls", "电话薄", null),
	QUARTERS_XLS("quarters_xls", "人员岗位", null),
	KEEP_WATCH_XLS("keep_watch_xls", "值班表", null),
	DEPARTMENT_XLS("department_xls", "部门表", null),
	;
	private final String code;
	private final String des;
	private final Enum parent;
	
	XlsUploadEnum(String code, String des, Enum parent) {
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
	public static XlsUploadEnum getByDescription(String des) {
		if (null==des||"".equals(des)||"".equals(des.trim())) {
			return null;
		}
		for (XlsUploadEnum menum : values()) {
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
	public static XlsUploadEnum getByCode(String code) {
		if (null==code||"".equals(code)||"".equals(code.trim())) {
			return null;
		}
		for (XlsUploadEnum menum : values()) {
			if (menum.getCode().equals(code)) {
				return menum;
			}
		}
		return null;
	}
}
