package com.flc.util;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Properties;
import java.util.Set;


public class Config {
	private static Properties p = new Properties();
	private static Properties getProperties(){
		try {
			if(p.isEmpty()){
				p.load(GotyeConfig.class.getResourceAsStream("/config.properties")); 
			}
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return p;
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
		System.out.println(properties.getProperty("BEECLOUD_SANDBOX"));
		return properties.getProperty("BEECLOUD_SANDBOX");
	}
	
	public static String getLoginType(){
		Properties properties = getProperties();
		return properties.getProperty("GOTYE_LOGTYE_TYPE");
	}
}
