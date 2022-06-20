package com.zhangsc.service.impl;

import com.zhangsc.dao.sys.TSysRoleMapper;
import com.zhangsc.dao.sys.TSysRolePermissionMapper;
import com.zhangsc.pojo.sys.TSysRole;
import com.zhangsc.pojo.sys.TSysRoleExample;
import com.zhangsc.pojo.sys.TSysRolePermission;
import com.zhangsc.pojo.sys.TSysRolePermissionExample;
import com.zhangsc.service.SysRoleService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * <p>Title: </p>
 * <p>Description: 角色接口实现</p>
 * <p>Company: </p>
 *
 * @author weil
 * @date 2019-02-20
 */
@Service
public class SysRoleServiceImpl implements SysRoleService{

    @Autowired
    private TSysRoleMapper roleMapper;
    @Autowired
    private TSysRolePermissionMapper rolePermissionMapper;
    @Override
    public List<TSysRole> query(TSysRole role) {
        TSysRoleExample example = new TSysRoleExample();
        TSysRoleExample.Criteria criteria = example.createCriteria();
        //名称查询
        if(StringUtils.isNotEmpty(role.getName())){
            criteria.andNameLike(role.getName());
        }
        //描述查询
        if(StringUtils.isNotEmpty(role.getDescription())){
            criteria.andDescriptionLike(role.getDescription());
        }
        List<TSysRole> tSysRoles = roleMapper.selectByExample(example);
        return tSysRoles;
    }

    @Override
    public TSysRole queryById(Long id) {
        TSysRole tSysRole = roleMapper.selectByPrimaryKey(id);
        return tSysRole;
    }

    @Override
    public void save(TSysRole role) {
        roleMapper.insert(role);
    }

    @Override
    public void update(TSysRole role) {
        roleMapper.updateByPrimaryKeySelective(role);
    }

    @Override
    public void delete(Long id) {
        roleMapper.deleteByPrimaryKey(id);
    }

    @Override
    public List<TSysRolePermission> getPermIdsByRoleId(Long roleId) {
        TSysRolePermissionExample example = new TSysRolePermissionExample();
        TSysRolePermissionExample.Criteria criteria = example.createCriteria();
        criteria.andRoleIdEqualTo(roleId);
        List<TSysRolePermission> list = rolePermissionMapper.selectByExample(example);
        return list;
    }

    @Override
    public void delByRoleId(Long roleId) {
        TSysRolePermissionExample example = new TSysRolePermissionExample();
        TSysRolePermissionExample.Criteria criteria = example.createCriteria();
        criteria.andRoleIdEqualTo(roleId);
        rolePermissionMapper.deleteByExample(example);
    }

    @Override
    public void save(TSysRolePermission sysRolePermission) {
        rolePermissionMapper.insert(sysRolePermission);
    }
}
