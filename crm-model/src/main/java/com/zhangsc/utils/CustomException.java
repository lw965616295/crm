package com.zhangsc.utils;

/**
 * <p>Title: CustomException</p>
 * <p>Description: 自定义异常</p>
 * @author weil
 * @date 2017年12月29日
 */
@SuppressWarnings("serial")
public class CustomException extends RuntimeException{
	//异常信息
	private String message;
	
	public CustomException(String message) {
		super(message);
		setMessage(message);
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}

}
