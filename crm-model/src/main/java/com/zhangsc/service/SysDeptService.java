package com.zhangsc.service;

import com.zhangsc.pojo.sys.TSysDept;

import java.util.List;

/**
 * <p>Title: </p>
 * <p>Description: 部门Service</p>
 * <p>Company: </p>
 * @param
 * @return
 * @author weil
 * @date 2019-03-09
 */
public interface SysDeptService {

    public List<TSysDept> query(TSysDept dept);

    public TSysDept queryById(Long id);

    public void save(TSysDept dept);

    public void update(TSysDept dept);

    public void delete(Long id);
}
