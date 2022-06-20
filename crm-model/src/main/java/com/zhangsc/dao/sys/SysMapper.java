package com.zhangsc.dao.sys;

import com.zhangsc.pojo.sys.TSysPermission;

import java.util.List;

/**
 * <p>Title: </p>
 * <p>Description: 系统用户级别操作</p>
 * <p>Company: </p>
 *
 * @author weil
 * @date 2019-02-15
 */
public interface SysMapper {
    /**
     * <p>Title: </p>
     * <p>Description: 根据用户id获取菜单list</p>
     * <p>Company: </p>
     * @param id 用户id
     * @return
     * @author weil
     * @date 2019-02-15
     */
    public List<TSysPermission> getMenusById(Long id);
    /**
     * <p>Title: </p>
     * <p>Description: 根据用户id获取权限资源list</p>
     * <p>Company: </p>
     * @param id 用户id
     * @return
     * @author weil
     * @date 2019-02-15
     */
    public List<TSysPermission> getPermsById(Long id);
}
