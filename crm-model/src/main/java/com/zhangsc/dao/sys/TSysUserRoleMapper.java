package com.zhangsc.dao.sys;

import com.zhangsc.pojo.sys.TSysUserRole;
import com.zhangsc.pojo.sys.TSysUserRoleExample;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface TSysUserRoleMapper {
    int countByExample(TSysUserRoleExample example);

    int deleteByExample(TSysUserRoleExample example);

    int deleteByPrimaryKey(Long id);

    int insert(TSysUserRole record);

    int insertSelective(TSysUserRole record);

    List<TSysUserRole> selectByExample(TSysUserRoleExample example);

    TSysUserRole selectByPrimaryKey(Long id);

    int updateByExampleSelective(@Param("record") TSysUserRole record, @Param("example") TSysUserRoleExample example);

    int updateByExample(@Param("record") TSysUserRole record, @Param("example") TSysUserRoleExample example);

    int updateByPrimaryKeySelective(TSysUserRole record);

    int updateByPrimaryKey(TSysUserRole record);
}