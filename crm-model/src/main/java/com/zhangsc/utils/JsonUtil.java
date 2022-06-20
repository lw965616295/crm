package com.zhangsc.utils;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import org.apache.log4j.Logger;

import java.util.List;

public class JsonUtil {
	private static Logger log = Logger.getLogger(JsonUtil.class);
	/**
	 * JSON 转 POJO
	 */
	public static <T> T getObject(String pojo, Class<T> tclass) {
		try {
			return JSONObject.parseObject(pojo, tclass);
		} catch (Exception e) {
			log.error(tclass + "转 JSON 失败");
		}
		return null;
	}
     
	/**
	 * POJO 转 JSON    
	 */
	public static <T> String getJson(T tResponse){
		String pojo = JSONObject.toJSONString(tResponse);
		return pojo;
	}
     
	/**
	 * List<T> 转 json 保存到数据库
	 */
	public static <T> String listToJson(List<T> ts) {
		String jsons = JSON.toJSONString(ts);
		return jsons;
	}

	/**
	 * json 转 List<T>
	 */
	public static <T> List<T> jsonToList(String jsonString, Class<T> clazz) {
		@SuppressWarnings("unchecked")
		List<T> ts = (List<T>) JSONArray.parseArray(jsonString, clazz);
		return ts;
	}
    	
}
