package com.zhangsc.service;

import com.zhangsc.pojo.sys.TSysUser;
import com.zhangsc.pojo.sys.TSysUserCustom;
import com.zhangsc.pojo.sys.TSysUserRole;

import java.util.List;

/**
 * <p>Title: SysUserService接口</p>
 * <p>Description: 用户信息相关</p>
 * <p>Company: </p>
 *
 * @author weil
 * @date 2019-02-13
 */
public interface SysUserService {

    public List<TSysUser> query(TSysUser user);
    public List<TSysUserCustom> query(TSysUserCustom userCustom);

    public TSysUser queryById(Long id);
    public TSysUserCustom queryById2(Long id);

    public void save(TSysUser user);

    public void update(TSysUser user);

    public void delete(Long id);

    public List<TSysUserRole> getUserRolesByUserId(Long userId);

    public void delUserRolesByUserId(Long userId);

    public void save(TSysUserRole userRole);

    public void updatePwd(TSysUserCustom userCustom);

}
