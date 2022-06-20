package com.zhangsc.utils;

import java.util.UUID;

/**
 * <p>Title: UuidUtil</p>
 * <p>Description: uuid工具</p>
 * <p>Company: </p>
 * @author weil
 * @date 2018年9月28日
 */
public class UuidUtil {
	/**
	 * 
	 * <p>Title: getUuid</p>
	 * <p>Description: 获取32位uuid值,去除“-”</p>
	 * <p>Company: </p>
	 * @author weil
	 * @date 2018年9月28日
	 * @return
	 */
	public static String getUuid() {
		String string = UUID.randomUUID().toString().trim().replace("-", "");
		return string;
	}
	
	public static void main(String[] args) {
		System.err.println(getUuid());
	}
	
}
