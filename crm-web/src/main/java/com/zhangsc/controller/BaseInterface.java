package com.zhangsc.controller;

/**
 * <p>Title: BaseInterface</p>
 * <p>Description: </p>
 * <p>Company: </p>
 * @author weil
 * @date 2018年11月29日
 */
public interface BaseInterface<E> {

	/**
	 * 
	 * <p>Title: page</p>
	 * <p>Description: </p>
	 * <p>Company: 跳转查询页</p>
	 * @author weil
	 * @date 2018年11月29日
	 * @return
	 */
	public String page();
	/**
	 * 
	 * <p>Title: query</p>
	 * <p>Description: 查询功能</p>
	 * <p>Company: </p>
	 * @author weil
	 * @date 2018年11月29日
	 * @param e
	 * @return
	 */
	public String query(E e);
	/**
	 * 
	 * <p>Title: save</p>
	 * <p>Description: 添加功能</p>
	 * <p>Company: </p>
	 * @author weil
	 * @date 2018年11月29日
	 * @param e
	 * @return
	 */
	public String save(E e);
	/**
	 * 
	 * <p>Title: update</p>
	 * <p>Description: 修改功能</p>
	 * <p>Company: </p>
	 * @author weil
	 * @date 2018年11月29日
	 * @param e
	 * @return
	 */
	public String update(E e);
	/**
	 * 
	 * <p>Title: delete</p>
	 * <p>Description: 作废or删除功能</p>
	 * <p>Company: </p>
	 * @author weil
	 * @date 2018年11月29日
	 * *@param ids
	 * @return
	 */
	public String delete(String ids);
}
