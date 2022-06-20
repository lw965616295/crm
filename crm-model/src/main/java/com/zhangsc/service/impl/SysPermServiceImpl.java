package com.zhangsc.service.impl;

import com.zhangsc.dao.sys.TSysPermissionMapper;
import com.zhangsc.pojo.sys.TSysPermission;
import com.zhangsc.pojo.sys.TSysPermissionExample;
import com.zhangsc.service.SysPermService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * <p>Title: </p>
 * <p>Description: 权限资源接口实现</p>
 * <p>Company: </p>
 *
 * @author weil
 * @date 2019-02-20
 */
@Service
public class SysPermServiceImpl implements SysPermService{
    @Autowired
    private TSysPermissionMapper mapper;

    @Override
    public List<TSysPermission> query(TSysPermission permission) {
        TSysPermissionExample example = new TSysPermissionExample();
        TSysPermissionExample.Criteria criteria = example.createCriteria();
        //权限名称
        if(StringUtils.isNotEmpty(permission.getName())){
            criteria.andNameLike(permission.getName());
        }
        //类型
        if(StringUtils.isNotEmpty(permission.getType())){
            criteria.andTypeLike(permission.getType());
        }
        //pid父id
        if(permission.getpId() != null){
            criteria.andPIdEqualTo(permission.getpId());
        }
        //url
        if(StringUtils.isNotEmpty(permission.getUrl())){
            criteria.andUrlLike(permission.getUrl());
        }
        List<TSysPermission> tSysPermissions = mapper.selectByExample(example);
        return tSysPermissions;
    }

    @Override
    public TSysPermission queryById(Long id) {
        TSysPermission tSysPermission = mapper.selectByPrimaryKey(id);
        return tSysPermission;
    }

    @Override
    public void save(TSysPermission permission) {
        mapper.insert(permission);
    }

    @Override
    public void update(TSysPermission permission) {
        mapper.updateByPrimaryKeySelective(permission);
    }

    @Override
    public void delete(Long id) {
        mapper.deleteByPrimaryKey(id);
    }
}
