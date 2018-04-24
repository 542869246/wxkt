package com.flc.util;

import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;

import javax.servlet.ServletOutputStream;

import org.apache.commons.io.IOUtils;
/**
 * 
 * @author yhj
 *
 */
public class DowenLoadUtil {
	/**
	 * 
	 * @param 远程资源url
	 * @param 输出流
	 * @throws Exception
	 */
	public static void dowenLoad(String path,ServletOutputStream out) throws Exception{
		System.gc();
		HttpURLConnection conn = null;
		InputStream inputStream = null;
		try{
		URL url=new URL(path);
		conn=(HttpURLConnection) url.openConnection();
		conn.connect();
		inputStream = conn.getInputStream();  
		IOUtils.copy(inputStream, out);
		out.flush();
		out.close();
		inputStream.close();
		
		}catch(Exception e){
			
		}finally{
			if(null != out){
				out.close();
			}
			if(null != inputStream){
				inputStream.close();
			}
			conn.disconnect();
			
		}
	}
}
