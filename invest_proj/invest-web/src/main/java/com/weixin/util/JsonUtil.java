package com.weixin.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/**
 * 处理json数据的类
 * @author sundhu
 *
 */
public class JsonUtil {
	/**
	 * 根据json对象获得map
	 * 
	 * @param jsonObject
	 * @return
	 * @throws JSONException
	 */
	public static Map<String, Object> getMapByJson(JSONObject jsonObj)
			throws JSONException {
		Iterator it = jsonObj.keys();
		if(!it.hasNext()){return null;}
		Map<String, Object> infoMap = new HashMap<String,Object>();
		while (it.hasNext()) {
			String key = it.next().toString().trim();
			Object value = jsonObj.get(key);
			infoMap.put(key, value);
		}
		return infoMap;
	}

	/**
	 * 根据JSONArray返回list<map>
	 * 
	 * @param jsonArr
	 * @return
	 * @throws JSONException
	 */
	public static List<Map<String, Object>> getListByJson(JSONArray jsonArray)
			throws JSONException {
		int length = jsonArray.length();
		if(length<=0)return null;
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>(
				length);
		for (int i = 0; i < length; i++) {
			JSONObject jsonObj = jsonArray.getJSONObject(i);
			Iterator it = jsonObj.keys();
			if(!it.hasNext()){list.add(null);continue;}
			Map<String, Object> infoMap = new HashMap<String, Object>();
			while (it.hasNext()) {
				String key = it.next().toString().trim();
				Object value = jsonObj.get(key);
				infoMap.put(key, value);
			}
			list.add(infoMap);
		}
		return list;
	}
	
	/**
	 * 根据JSONArray返回l二维数组
	 * 
	 * @param jsonArr
	 * @return
	 * @throws JSONException
	 */
	@SuppressWarnings("unused")
	public static List<List<Object>> getListInListByJson(JSONArray jsonArray)
			throws JSONException {
		int length = jsonArray.length();
		if(length<=0)return null;
		List<List<Object>> list = new ArrayList<List<Object>>(length);
		for (int i = 0; i < length; i++) {
			JSONArray inner = jsonArray.getJSONArray(i);
			int lengtha = inner.length();
			if(lengtha<=0){list.add(null);continue;}
			List<Object> temp=new ArrayList<Object>();
			for(int j=0;j<inner.length();j++){
				temp.add(inner.get(j));
			}
			list.add(temp);
		}
		return list;
	}
}
