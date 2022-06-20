package com.zhangsc.dao.sys;

import com.zhangsc.pojo.sys.TSysDept;
import com.zhangsc.pojo.sys.TSysDeptExample;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface TSysDeptMapper {
    int countByExample(TSysDeptExample example);

    int deleteByExample(TSysDeptExample example);

    int deleteByPrimaryKey(Long id);

    int insert(TSysDept record);

    int insertSelective(TSysDept record);

    List<TSysDept> selectByExample(TSysDeptExample example);

    TSysDept selectByPrimaryKey(Long id);

    int updateByExampleSelective(@Param("record") TSysDept record, @Param("example") TSysDeptExample example);

    int updateByExample(@Param("record") TSysDept record, @Param("example") TSysDeptExample example);

    int updateByPrimaryKeySelective(TSysDept record);

    int updateByPrimaryKey(TSysDept record);
}