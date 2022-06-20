package com.zhangsc.service.impl;


import com.zhangsc.dao.customer.ContactMapper;
import com.zhangsc.dao.customer.FileMapper;
import com.zhangsc.pojo.customer.TCusContactCustom;
import com.zhangsc.service.ContactService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * <p>Title: </p>
 * <p>Description: 客户联系人service实现</p>
 * <p>Company: </p>
 *
 * @author yyc
 * @date 2019-04-011
 */

@Service
public class ContactServiceImpl implements ContactService {
    /**
     * 联系人mapper
     */

    @Autowired
    private ContactMapper contactMapper;

    @Autowired
    private FileMapper fileMapper;

    /**
     * 查询全部联系人
     */
    @Override
    public List<TCusContactCustom> query(TCusContactCustom contact) {

        List<TCusContactCustom> query = contactMapper.query(contact);

        return query;

    }

    /**
     * 添加联系人
     */
    @Override
    public void save(TCusContactCustom contactCustom) {

        contactMapper.save(contactCustom);
    }


    @Override
    public TCusContactCustom queryById(Long id) {

        return contactMapper.queryById(id);

    }

    @Override
    public void update(TCusContactCustom contact) {
        contactMapper.update(contact);
    }

    @Override
    public void delete(Long id) {
        contactMapper.delete(id);
    }


    @Override
    public void updateFirstContact(TCusContactCustom contact)
    {contactMapper.updateFirstContact(contact);}

    @Override
    public void updateSet0(TCusContactCustom contact)
    {contactMapper.updateSet0(contact);}

    @Override
    public void updateSet1(TCusContactCustom contact)
    {contactMapper.updateSet1(contact);}


}


