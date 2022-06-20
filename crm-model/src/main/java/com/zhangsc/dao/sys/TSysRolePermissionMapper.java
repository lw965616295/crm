package com.zhangsc.dao.sys;

import com.zhangsc.pojo.sys.TSysRolePermission;
import com.zhangsc.pojo.sys.TSysRolePermissionExample;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface TSysRolePermissionMapper {
    int countByExample(TSysRolePermissionExample example);

    int deleteByExample(TSysRolePermissionExample example);

    int deleteByPrimaryKey(Long id);

    int insert(TSysRolePermission record);

    int insertSelective(TSysRolePermission record);

    List<TSysRolePermission> selectByExample(TSysRolePermissionExample example);

    TSysRolePermission selectByPrimaryKey(Long id);

    int updateByExampleSelective(@Param("record") TSysRolePermission record, @Param("example") TSysRolePermissionExample example);

    int updateByExample(@Param("record") TSysRolePermission record, @Param("example") TSysRolePermissionExample example);

    int updateByPrimaryKeySelective(TSysRolePermission record);

    int updateByPrimaryKey(TSysRolePermission record);
}