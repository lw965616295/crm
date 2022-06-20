package com.zhangsc.service;

import com.zhangsc.pojo.sys.TSysPermission;

import java.util.List;

/**
 * <p>Title: SysPermService接口</p>
 * <p>Description: 权限资源信息相关</p>
 * <p>Company: </p>
 *
 * @author weil
 * @date 2019-02-20
 */
public interface SysPermService {

    public List<TSysPermission> query(TSysPermission permission);

    public TSysPermission queryById(Long id);

    public void save(TSysPermission permission);

    public void update(TSysPermission permission);

    public void delete(Long id);
}
