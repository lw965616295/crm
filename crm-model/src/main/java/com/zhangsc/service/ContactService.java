package com.zhangsc.service;


import com.zhangsc.pojo.customer.TCusContactCustom;

import java.util.List;

/**
 * <p>Title: </p>
 * <p>Description: 客户联系人接口</p>
 * <p>Company: </p>
 *
 * @author yyc
 * @date 2019-04-10
 */

public interface ContactService {
    /*查询联系人*/
    public List<TCusContactCustom> query(TCusContactCustom contact);

    /*添加联系人*/
    public void save(TCusContactCustom contactCustom) throws Exception;

    /*通过id查询*/
    public TCusContactCustom queryById(Long id);

    /*更新联系人*/
    public void update(TCusContactCustom contact) throws Exception;

    /*删除联系人*/
    public void delete(Long id) throws Exception;

    public void updateFirstContact(TCusContactCustom contact) throws Exception;

    public void updateSet0(TCusContactCustom contact) throws Exception;

    public void updateSet1(TCusContactCustom contact) throws Exception;

}
