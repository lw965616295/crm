package com.zhangsc.dao.sys;

import com.zhangsc.pojo.sys.TSysPermission;
import com.zhangsc.pojo.sys.TSysPermissionExample;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface TSysPermissionMapper {
    int countByExample(TSysPermissionExample example);

    int deleteByExample(TSysPermissionExample example);

    int deleteByPrimaryKey(Long id);

    int insert(TSysPermission record);

    int insertSelective(TSysPermission record);

    List<TSysPermission> selectByExample(TSysPermissionExample example);

    TSysPermission selectByPrimaryKey(Long id);

    int updateByExampleSelective(@Param("record") TSysPermission record, @Param("example") TSysPermissionExample example);

    int updateByExample(@Param("record") TSysPermission record, @Param("example") TSysPermissionExample example);

    int updateByPrimaryKeySelective(TSysPermission record);

    int updateByPrimaryKey(TSysPermission record);
}