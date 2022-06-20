package com.zhangsc.dao.sys;

import com.zhangsc.pojo.sys.TSysRole;
import com.zhangsc.pojo.sys.TSysRoleExample;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface TSysRoleMapper {
    int countByExample(TSysRoleExample example);

    int deleteByExample(TSysRoleExample example);

    int deleteByPrimaryKey(Long id);

    int insert(TSysRole record);

    int insertSelective(TSysRole record);

    List<TSysRole> selectByExample(TSysRoleExample example);

    TSysRole selectByPrimaryKey(Long id);

    int updateByExampleSelective(@Param("record") TSysRole record, @Param("example") TSysRoleExample example);

    int updateByExample(@Param("record") TSysRole record, @Param("example") TSysRoleExample example);

    int updateByPrimaryKeySelective(TSysRole record);

    int updateByPrimaryKey(TSysRole record);
}