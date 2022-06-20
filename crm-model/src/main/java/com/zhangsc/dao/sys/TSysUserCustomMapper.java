package com.zhangsc.dao.sys;

import com.zhangsc.pojo.sys.TSysUserCustom;

import java.util.List;

/**
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Company: </p>
 *
 * @author weil
 * @date 2019-03-19
 */
public interface TSysUserCustomMapper {
    public List<TSysUserCustom> queryUserCustom(TSysUserCustom userCustom);
    public TSysUserCustom queryUserCustomById(Long id);
}
