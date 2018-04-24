package com.flc.enums;

import java.io.Serializable;

/**
 * Map KEY值 枚举
 * @author tlh
 *
 */
public enum KEYEnum implements Serializable {
	
	HTML5_COOKIE_BY_WECHAT_USER_KEY("_n_j_m_s_c_o_o_k_i_e", "微信端用户缓存KEY值", null),
	ANYFILE_PATH("/anyfile/", "非图片上传保存路径", null),
	MOVIE_PATH("/movie/", "视频文件保存路径", null),
	;
	private final String code;
	private final String des;
	private final Enum parent;
	
	KEYEnum(String code, String des, Enum parent) {
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
	public static KEYEnum getByDescription(String des) {
		if (null==des||"".equals(des)||"".equals(des.trim())) {
			return null;
		}
		for (KEYEnum menum : values()) {
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
	public static KEYEnum getByCode(String code) {
		if (null==code||"".equals(code)||"".equals(code.trim())) {
			return null;
		}
		for (KEYEnum menum : values()) {
			if (menum.getCode().equals(code)) {
				return menum;
			}
		}
		return null;
	}
}
