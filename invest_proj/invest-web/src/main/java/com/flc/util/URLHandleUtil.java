package com.flc.util;

import org.apache.commons.lang3.StringUtils;

/**
 * 字符分割处理工具
 * <br/>用于将类似/path/param/?asdf/vale 路径处理为与URL不冲突的|path|param|?asdf|vale路径，并能将其还原
 * @author tanglunhong
 *
 */
public class URLHandleUtil {
	static String REPLACE_STRING = "\\/";
	static String RETRUN_STRING = "\\|";
	
	/**
	 * 将字符串中的 "/" 转为"|"，并去掉?后面的内容
	 * @param request
	 * @return
	 */
	public static String replace(String path){
		if(StringUtils.isEmpty(path)){
			return "";
		}
		String url = path.replaceAll(REPLACE_STRING, RETRUN_STRING);
		if(url.indexOf("$")>-1){//是否存在多余参数
			return url.substring(0, url.indexOf("$"));
		}
		return url;
	}
	public static void main(String[] args) {
//		String url = "http:||www.ww.com|asdf|asdfasdf#asdfasdf";
//		String url1 = "http://www.ww.com/asdf/asdfasdfasf?asdfasdf";
//		System.out.println(replace(url1));
//		System.out.println(recover(url));
	}
	
	/**
	 * 将字符串中的 "|" 转为 "/",并去掉#号后面的内容
	 * @param path
	 * @return
	 */
	public static String recover(String path){
		if(StringUtils.isEmpty(path)){
			return "";
		}
		
		String url = path.replaceAll(RETRUN_STRING,REPLACE_STRING);
		if(url.indexOf("$")>-1){//是否存在多余参数
			return url.substring(0, url.indexOf("$"));
		}
		return url;
	}
}
