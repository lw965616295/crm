package com.zhangsc.controller;

import com.alibaba.druid.util.StringUtils;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.zhangsc.pojo.sys.ActiveUser;
import com.zhangsc.utils.Constants;
import com.zhangsc.utils.CustomException;
import com.zhangsc.utils.UuidUtil;
import org.apache.log4j.Logger;
import org.apache.shiro.SecurityUtils;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.io.UnsupportedEncodingException;
import java.util.List;

/**
 * <p>Title: BaseController</p>
 * <p>Description: 基础controller</p>
 * <p>Company: </p>
 * @author weil
 * @date 2018年9月28日
 */
public class BaseController {
	/**日志对象Logger*/
	protected Logger logger = Logger.getLogger(this.getClass());
	/**开始页*/
	private Integer page = Constants.PAGINATION_PAGE;
	/**每页行数*/
	private Integer rows = Constants.PAGINATION_ROWS;
	
	/**
	 * 
	 * <p>Title: getModeAndView</p>
	 * <p>Description: 获得ModelAndView对象</p>
	 * <p>Company: </p>
	 * @author weil
	 * @date 2018年9月28日
	 * @return
	 */
	public ModelAndView getModeAndView() {
		return new ModelAndView();
	}
	
	/**
	 * 
	 * <p>Title: getRequest</p>
	 * <p>Description: 获得request对象</p>
	 * <p>Company: </p>
	 * @author weil
	 * @date 2018年9月28日
	 * @return
	 */
	public HttpServletRequest getRequest() {
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		return request;
	}
	
	/**
	 * 
	 * <p>Title: getUuid</p>
	 * <p>Description: 获取uuid值</p>
	 * <p>Company: </p>
	 * @author weil
	 * @date 2018年9月28日
	 * @return
	 */
	public String getUuid() {
		String uuid = UuidUtil.getUuid();
		logger.info(">>>>>>>>>>>>>>>>>>>>uuid:"+uuid);
		return uuid;
	}
	
	/**
	 * 
	 * <p>Title: startPagination</p>
	 * <p>Description: 开启分页</p>
	 * <p>Company: </p>
	 * @author weil
	 * @date 2018年9月28日
	 */
	public void startPagination() {
		String pageStr = getRequest().getParameter("page");
		String rowsStr = getRequest().getParameter("rows");
		if(!StringUtils.isEmpty(pageStr) && !StringUtils.isEmpty(rowsStr)) {
			try {
				page = Integer.parseInt(pageStr);
				rows = Integer.parseInt(rowsStr);
			} catch (Exception e) {
				throw new CustomException("分页page与rows必须是正数！");
			}
		}else {
			logger.info(">>>>>>>>>>>>>>>>>>>>page或rows为空，已使用默认值！");
		}

		logger.info(">>>>>>>>>>>>>>>>>>>>page:"+page);
		logger.info(">>>>>>>>>>>>>>>>>>>>rows:"+rows);
		PageHelper.startPage(page, rows);
	}
	/**
	 * 
	 * <p>Title: getResultJsonStr</p>
	 * <p>Description: 封装返回结果集</p>
	 * <p>Company: </p>
	 * @author weil
	 * @date 2018年9月28日
	 * @param code 结果编码
	 * @param msg 结果信息
	 * @param data 结果数据
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public String getResultJsonStr(Integer code, String msg, List data) {
		@SuppressWarnings("unchecked")
		PageInfo pageInfo = new PageInfo<>(data);
		
		JSONObject paginationJson = new JSONObject();
		paginationJson.put("code", code);
		paginationJson.put("msg", msg);
		paginationJson.put("total", pageInfo.getTotal());
		paginationJson.put("rows", data);
		String jstr = JSON.toJSONString(paginationJson);
		logger.info(">>>>>>>>>>>>>>>>>>>>resultJsonStr:"+jstr);
		return jstr;
	}
	
	/**
	 * 
	 * <p>Title: getResultJsonStr</p>
	 * <p>Description: 返回结果集</p>
	 * <p>Company: </p>
	 * @author weil
	 * @date 2018年10月29日
	 * @param code
	 * @param msg
	 * @return
	 */
	public String getResultJsonStr(Integer code, String msg) {
		JSONObject returnJson = new JSONObject();
		returnJson.put("code", code);
		returnJson.put("msg", msg);
		String jstr = JSON.toJSONString(returnJson);
		logger.info(">>>>>>>>>>>>>>>>>>>>returnJson:"+jstr);
		return jstr;
	}

	/**
	 * <p>Title: </p>
	 * <p>Description: 返回结果集</p>
	 * <p>Company: </p>
	 * @param
	 * @return
	 * @author weil
	 * @date 2019-04-20
	 */
	public String getResultJsonStr(Integer code, String msg, Object object) {
		JSONObject returnJson = new JSONObject();
		returnJson.put("code", code);
		returnJson.put("msg", msg);
		returnJson.put("data", object);
		String jstr = JSON.toJSONString(returnJson);
		logger.info(">>>>>>>>>>>>>>>>>>>>returnJson:"+jstr);
		return jstr;
	}

	/**
	 * 
	 * <p>Title: decode</p>
	 * <p>Description: get请求参数乱码解码</p>
	 * <p>Company: </p>
	 * @author weil
	 * @date 2018年9月30日
	 * @param param 请求参数
	 * @return
	 */
	public String decode(String param) {
		if(param == null) {
			return null;
		}
		try {
			String str = new String(param.getBytes("ISO8859-1"),"UTF-8");
			logger.info(">>>>>>>>>>>>>>>>>>>>"+param+"解码:"+str);
			return str;
		} catch (UnsupportedEncodingException e) {
			throw new CustomException("get请求参数解码失败！"+e.getMessage());
		}
		
	}
	/**
	 * <p>Title: </p>
	 * <p>Description: 获取session用户</p>
	 * <p>Company: </p>
	 * @param
	 * @return
	 * @author weil
	 * @date 2019-02-15
	 */
	public ActiveUser getActiveUser(){
		return (ActiveUser) SecurityUtils.getSubject().getPrincipal();
	}
}
