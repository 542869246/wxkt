package com.weixin.util;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

/**
 * xml解析工具
 * @author sundhu
 *
 */
public class XmlParseUtil {
	
	public static Map<String,String> getMap(InputStream in) throws DocumentException {
		SAXReader reader=new SAXReader();
		try{
			Document doc = reader.read(in);
			Element root = doc.getRootElement();
			@SuppressWarnings("unchecked")
			List<Element> elements = root.elements();
			Map<String,String> map =new HashMap<String,String>();
			for (Element e : elements) {
				map.put(e.getName(), e.getTextTrim());
			}
			return map;
		}finally{
			try{
				in.close();
			}catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	public static Map<String,String> getMap(String xmlstr) throws DocumentException{
		ByteArrayInputStream bis=null;
		try{
			bis=new ByteArrayInputStream(xmlstr.getBytes("UTF-8"));
		}catch (Exception e) {
			e.printStackTrace();
		}
		return getMap(bis);
	}
	
	
	
}
