package com.weixin.util;

import java.util.Random;
import java.util.regex.Pattern;

public class StringUtil {
	/**
	 * 获得时间戳，精确到毫秒
	 * 
	 * @return
	 */
	public static long getTimestampByMs() {
		return System.currentTimeMillis();
	}

	private static Random randGen = null;
	private static char[] numbersAndLetters = ("0123456789abcdefghijklmnopqrstuvwxyz"
			+ "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ").toCharArray();

	/**
	 * 获取一个随机字符串
	 * 
	 * @param length
	 * @return
	 */
	public static final String getRandomString(int length) {
		if (length < 1) {
			return null;
		}
		if (randGen == null) {
			randGen = new Random();
		}
		char[] randBuffer = new char[length];
		for (int i = 0; i < randBuffer.length; i++) {
			randBuffer[i] = numbersAndLetters[randGen.nextInt(71)];
		}
		return new String(randBuffer);
	}

	
	public static boolean isEmpty(String str){
		if(str==null)return true;
		if(str.trim().equals(""))return true;
		return false;
	}
	
	/**
	 * 获得时间戳精确到秒
	 * 
	 * @return
	 */
	public static long getTimestampBySs() {
		return System.currentTimeMillis() / 1000;
	}
	
	/**
	 * 整形数字判断
	 * @param str
	 * @return
	 */
	 public static boolean isInteger(String str){
		  if(str==null )
		   return false;
		  Pattern pattern = Pattern.compile("[0-9]+");
		  return pattern.matcher(str).matches();
	 }
	 
	//浮点型判断
	 public static boolean isDecimal(String str) {
	  if(str==null || "".equals(str))
	   return false;  
	  Pattern pattern = Pattern.compile("[0-9]*(\\.?)[0-9]*");
	  return pattern.matcher(str).matches();
	 }
	 
}
