package com.weixin.util;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;

public class HttpRequestUtil {
	/*************** http请求工具方法 ***********************/
	/**
	 * 封装http请求，返回的是API中actionName对应的json字符串
	 * 
	 * @param actionName
	 * @return
	 * @throws IOException
	 */
	public String httpResultHasHeader(String urlAction,
			String requestParams) throws IOException {
		// 构造请求头
		URL url = new URL(urlAction);// "https://api.huobi.com/apiv2.php"
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setRequestMethod("POST");
		conn.setDoInput(true);
		conn.setDoOutput(true);
		conn.setRequestProperty("Content-Type",
				"application/x-www-form-urlencoded");
		conn.setUseCaches(false);
		conn.setInstanceFollowRedirects(true);
		// 构造参数
		if (requestParams != null && !requestParams.trim().equals("")) {
			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(
					conn.getOutputStream(), "utf-8"));
			bw.write(requestParams);
			bw.flush();
			bw.close();
		}
		BufferedReader br = new BufferedReader(new InputStreamReader(
				conn.getInputStream(), "utf-8"));
		StringBuffer jsonStr = new StringBuffer();
		for (String line = br.readLine(); line != null;) {
			jsonStr.append(line);
			line = br.readLine();
		}
		br.close();

		return jsonStr.toString();
	}

	public InputStream httpResultHasHeaderForStream(String urlAction,
			String requestParams) throws IOException {
		// 构造请求头
		URL url = new URL(urlAction);// "https://api.huobi.com/apiv2.php"
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setRequestMethod("POST");
		conn.setDoInput(true);
		conn.setDoOutput(true);
		conn.setRequestProperty("Content-Type",
				"application/x-www-form-urlencoded");
		conn.setUseCaches(false);
		conn.setInstanceFollowRedirects(true);
		// 构造参数
		if (requestParams != null && !requestParams.trim().equals("")) {
			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(
					conn.getOutputStream(), "utf-8"));
			bw.write(requestParams);
			bw.flush();
			bw.close();
		}
		return conn.getInputStream();
	}
	
	
	/**
	 * 无请求头的httprequest
	 * 
	 * @param urlAction
	 * @param requestParams
	 * @return
	 * @throws IOException
	 */
	public  String httpResultNoHeader(String urlAction,
			String requestParams) throws IOException {
		// 构造请求头
		URL url = new URL(urlAction);
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		// 构造参数
		if (requestParams != null && !requestParams.trim().equals("")) {
			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(
					conn.getOutputStream(), "utf-8"));
			bw.write(requestParams);
			bw.flush();
			bw.close();
		}
		BufferedReader br = new BufferedReader(new InputStreamReader(
				conn.getInputStream(), "utf-8"));
		StringBuffer jsonStr = new StringBuffer();
		for (String line = br.readLine(); line != null;) {
			jsonStr.append(line);
			line = br.readLine();
		}
		br.close();
		return jsonStr.toString();
	}

	
}
