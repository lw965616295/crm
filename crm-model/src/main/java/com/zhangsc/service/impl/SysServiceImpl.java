package com.zhangsc.service.impl;

import com.zhangsc.dao.sys.SysMapper;
import com.zhangsc.dao.sys.TSysUserMapper;
import com.zhangsc.pojo.sys.TSysPermission;
import com.zhangsc.pojo.sys.TSysUser;
import com.zhangsc.pojo.sys.TSysUserExample;
import com.zhangsc.service.SysService;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Company: </p>
 *
 * @author weil
 * @date 2019-02-15
 */
@Service
public class SysServiceImpl implements SysService {
    Logger logger = Logger.getLogger(this.getClass());
    /**系统mapper*/
    @Autowired
    private SysMapper sysMapper;
    /**用户mapper*/
    @Autowired
    private TSysUserMapper tSysUserMapper;
    @Override
    public List<TSysPermission> getMenusById(Long id) throws Exception {
        List<TSysPermission> menus = sysMapper.getMenusById(id);
        return menus;
    }

    @Override
    public List<TSysPermission> getPermsById(Long id) throws Exception {
        return sysMapper.getPermsById(id);
    }

    @Override
    public TSysUser getUserByAccount(String account) throws Exception {
        TSysUserExample example = new TSysUserExample();
        TSysUserExample.Criteria criteria = example.createCriteria();
        criteria.andAccountEqualTo(account);
        criteria.andStatusEqualTo(1);
        List<TSysUser> list = tSysUserMapper.selectByExample(example);
        if(list != null && list.size() == 1){
            return list.get(0);
        }
        return null;
    }
}
