package com.zhangsc.utils;

/**
 * <p>Title: Constants</p>
 * <p>Description: 定义基本常量</p>
 * @author weil
 * @date 2017年12月29日
 */
public interface Constants {
	String USER_IS_NULL = "用户名或密码为空";
	String USER_NOT_EXIST = "用户不存在";
	String USER_ERROR = "用户名或密码错误";
	String AUTHENTICATION_ERROR = "认证失败！";
	String LOCALPATH = "D:/APPPHOTO/Clue/";
	String NETWORKPATH = "http://p.ruishunwl.com/Warehouse/";
	/**返回结果集成功*/
	Integer RETURN_SUCCESS = 1;
	/**返回结果集失败*/
	Integer RETRUN_FAILURE = 0;
	/**分页属性：第1页*/
	Integer PAGINATION_PAGE = 1;
	/**分页属性：一页10行*/
	Integer PAGINATION_ROWS = 15;
}
