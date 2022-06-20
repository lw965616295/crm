package com.zhangsc.service;

import com.zhangsc.pojo.sys.TSysPermission;
import com.zhangsc.pojo.sys.TSysUser;

import java.util.List;

/**
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Company: </p>
 *
 * @author weil
 * @date 2019-02-15
 */
public interface SysService {
    /**
     * <p>Title: </p>
     * <p>Description: 根据用户id查询菜单</p>
     * <p>Company: </p>
     * @param
     * @return
     * @author weil
     * @date 2019-02-15
     */
    public List<TSysPermission> getMenusById(Long id) throws Exception;
    /**
     * <p>Title: </p>
     * <p>Description: 根据用户id查询权限资源</p>
     * <p>Company: </p>
     * @param
     * @return
     * @author weil
     * @date 2019-02-15
     */
    public List<TSysPermission> getPermsById(Long id) throws Exception;
    /**
     * <p>Title: </p>
     * <p>Description: 根据账号查询用户</p>
     * <p>Company: </p>
     * @param
     * @return
     * @author weil
     * @date 2019-02-15
     */
    public TSysUser getUserByAccount(String account) throws Exception;
}
