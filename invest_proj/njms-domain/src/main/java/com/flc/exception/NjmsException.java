package com.flc.exception;

import com.flc.enums.ExEnum;

/**
 * 自定义异常
 * @author tlh
 *
 */
@SuppressWarnings("serial")
public class NjmsException extends Exception {
	
	/**
	 * 异常编码
	 */
	private String code;
	
	/**
	 * 异常信息描述
	 */
	private String msg;
	
	private ExEnum ex;
	
	public ExEnum getEx() {
		return ex;
	}
	public void setEx(ExEnum ex) {
		this.ex = ex;
	}
	/**
	 * 异常编码
	 */
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	
	/**
	 * 异常信息描述
	 */
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	
	/**
	 * <b>自定义异常的有参构造</b>
	 * @param code -><span style="color:red">异常编号</span>
	 * @param msg -><span style="color:red">异常提示信息</span>
	 */
	public NjmsException(String code, String msg) {
		super(msg);
		this.code = code;
		this.msg = msg;
		this.ex = ExEnum.EX_CUSTOM;
	}
	
	/**
	 * <b>自定义异常的有参构造</b>
	 * @param exenum -><span style="color:red">异常枚举</span>
	 */
	public NjmsException(ExEnum exenum) {
		super("编码："+exenum.getCode()+",描述："+exenum.getDes());
		this.code = exenum.getCode();
		this.msg = exenum.getDes();
		this.ex = exenum;
	}
}
