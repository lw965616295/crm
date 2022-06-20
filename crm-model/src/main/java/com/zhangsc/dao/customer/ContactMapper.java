package com.zhangsc.dao.customer;

import com.zhangsc.pojo.customer.TCusContact;
import com.zhangsc.pojo.customer.TCusContactCustom;

import java.util.List;

/**
 * <p>Title: </p>
 * <p>Description: 客户联系人操作</p>
 * <p>Company: </p>
 *
 * @author yyc
 * @date 2019-04-10
 */

public interface ContactMapper {
    //查询客户联系人
    public List<TCusContactCustom> query(TCusContactCustom contact);

    //插入客户联系人
    public void save(TCusContact contact);

    //根据id查询客户联系人
    public TCusContactCustom queryById(Long id);

    //更新客户联系人
    public void update(TCusContact contact);

    //删除客户联系人
    public void delete(long id);
    //添加时设为首要
    public  void updateFirstContact(TCusContactCustom contact);
    //设为首要先置为0
    public  void updateSet0(TCusContactCustom contact);
    //设为首要置为
    public  void updateSet1(TCusContactCustom contact);
}
