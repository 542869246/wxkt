package com.flc.enums;

import java.io.Serializable;

public enum ExEnum implements Serializable {
	
	EX_CUSTOM("ex555555", "其它", null),
	EX_SYSTEM_ERROR("ex999999", "系统异常", null),
	EX_SYSTEM_FILE("ex888888", "缺少文件", null),
	EX_SYSTEM_FILEUPLOAD_ID("ex777777", "缺少FILEUPLOAD_ID", null),
	EX_SYSTEM_NULL("ex666666", "缺少参数", null),
	EX_SUCCESS("000000", "成功", null),
	EX_INIT_FAILED("ex0000000", "查询异常", null),
	EX_PARAM_NULL("ex0000001", "参数为空", null),
	EX_STRING_IS_EMPTY("ex0000002", "删除失败", null),
	EX_FORMAT_CURRENCIES_FAIL("ex0000003", "删除项不存在", null),
	EX_SOURCE_NULL("ex0000004", "数据不存在", null),
	EX_SOURCE_NOT_ONE("ex0000005", "登录异常", null),
	EX_SOURCE_IS_DEL("ex0000006", "数据已逻辑删除,拒绝操作", null),
	EX_SOURCE_NOT_PUBLISH("ex0000007", "未发布,拒绝操作", null),
	EX_SOURCE_IS_PUBLISH("ex0000008", "已发布,拒绝操作", null),
	EX_PUBLISH_SMALL_HADSOLD("ex0000009", "发布总量小于已领总量,拒绝操作", null),
	EX_PRIMARY_KEY_IS_NOT_NULL("ex0000010", "主键不能为空,拒绝操作", null),
	EX_ORDER_BE_OVERDUE("ex0000011", "修改异常", null),
	EX_ORDER_HAD_EXCHANGE("ex0000012", "删除异常", null),
	EX_IP_ADDRESS_LOCALHOST("ex0000014", "保存数据失败", null),
	EX_IP_FAIL("ex0000015", "用户不存在", null),
	EX_UPLOAD_IMAGE_MAX("ex0000016", "图片超出大小限制", null),
	EX_UPLOAD_FILE_NAME_IS_NOT_CRITERION("ex0000017", "上传文件名称不规范", null),
	;
	private final String code;
	private final String des;
	private final Enum parent;
	
	ExEnum(String code, String des, Enum parent) {
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
	public static ExEnum getByDescription(String des) {
		if (null==des||"".equals(des)||"".equals(des.trim())) {
			return null;
		}
		for (ExEnum menum : values()) {
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
	public static ExEnum getByCode(String code) {
		if (null==code||"".equals(code)||"".equals(code.trim())) {
			return null;
		}
		for (ExEnum menum : values()) {
			if (menum.getCode().equals(code)) {
				return menum;
			}
		}
		return null;
	}
}
