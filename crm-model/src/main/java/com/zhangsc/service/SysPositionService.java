package com.zhangsc.service;

import com.zhangsc.pojo.sys.TSysPosition;

import java.util.List;

/**
 * <p>Title: </p>
 * <p>Description: 岗位service</p>
 * <p>Company: </p>
 * @param
 * @return
 * @author weil
 * @date 2019-03-11
 */
public interface SysPositionService {

    public List<TSysPosition> query(TSysPosition position);

    public TSysPosition queryById(Long id);

    public void save(TSysPosition position);

    public void update(TSysPosition position);

    public void delete(Long id);
}
