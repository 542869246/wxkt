package com.flc.util;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Properties;
import java.util.Set;


public class GotyeConfig {
	private static Properties p = new Properties();
	private static Properties getProperties(){
		try {
			if(p.isEmpty()){
				p.load(GotyeConfig.class.getResourceAsStream("/gotyeconfig.properties"));
			}
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return p;
	}

	public static String getEmail(){
		Properties properties = getProperties();
		return properties.getProperty("GOTYE_EMAIL");
	}
	
	public static String getPassword(){
		Properties properties = getProperties();
		return properties.getProperty("GOTYE_PASSWORD");
	}
	
	public static String getAccessSecret(){
		Properties properties = getProperties();
		return properties.getProperty("GOTYE_ACCESS_SECRET");
	}
	
	public static String getWxJsApiAppId(){
		Properties properties = getProperties();
		return properties.getProperty("GOTYE_WX_JSAPI_APPID");
	}
	
	public static String getWxJsApiSecret(){
		Properties properties = getProperties();
		return properties.getProperty("GOTYE_WX_JSAPI_SECRET");
	}
	
	public static String getBeeCloudAppId(){
		Properties properties = getProperties();
		return properties.getProperty("BEECLOUD_APPID");
	}
	
	public static String getBeeCloudTestSecret(){
		Properties properties = getProperties();
		return properties.getProperty("BEECLOUD_TEST_SECRET");
	}
	
	public static String getBeeCloudAppSecret(){
		Properties properties = getProperties();
		return properties.getProperty("BEECLOUD_APP_SECRET");
	}
	
	public static String getBeeCloudMasterSecret(){
		Properties properties = getProperties();
		return properties.getProperty("BEECLOUD_MASTER_SECRET");
	}
	
	public static String getBeeCloudSandbox(){
		Properties properties = getProperties();
		return properties.getProperty("BEECLOUD_SANDBOX");
	}
	
	public static String getLoginType(){
		Properties properties = getProperties();
		return properties.getProperty("GOTYE_LOGTYE_TYPE");
	}
	public static void main(String[] args) {
		Properties pro = GotyeConfig.getProperties();
		Set<Object> set = pro.keySet();
		for (Object object : set) {
			System.out.println(object+"----------------------------------------------------------------value="+pro.getProperty(object.toString()));
		}
	}
}
