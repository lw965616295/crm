package com.zhangsc.service;

import com.zhangsc.pojo.sys.TSysRole;
import com.zhangsc.pojo.sys.TSysRolePermission;

import java.util.List;

/**
 * <p>Title: SysRoleService接口</p>
 * <p>Description: 角色信息相关</p>
 * <p>Company: </p>
 *
 * @author weil
 * @date 2019-02-20
 */
public interface SysRoleService {

    public List<TSysRole> query(TSysRole role);

    public TSysRole queryById(Long id);

    public void save(TSysRole role);

    public void update(TSysRole role);

    public void delete(Long id);

    public List<TSysRolePermission> getPermIdsByRoleId(Long roleId);

    public void delByRoleId(Long roleId);

    public void save(TSysRolePermission sysRolePermission);
}
