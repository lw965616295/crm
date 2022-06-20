package com.zhangsc.dao.sys;

import com.zhangsc.pojo.sys.TSysPosition;
import com.zhangsc.pojo.sys.TSysPositionExample;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface TSysPositionMapper {
    int countByExample(TSysPositionExample example);

    int deleteByExample(TSysPositionExample example);

    int deleteByPrimaryKey(Long id);

    int insert(TSysPosition record);

    int insertSelective(TSysPosition record);

    List<TSysPosition> selectByExample(TSysPositionExample example);

    TSysPosition selectByPrimaryKey(Long id);

    int updateByExampleSelective(@Param("record") TSysPosition record, @Param("example") TSysPositionExample example);

    int updateByExample(@Param("record") TSysPosition record, @Param("example") TSysPositionExample example);

    int updateByPrimaryKeySelective(TSysPosition record);

    int updateByPrimaryKey(TSysPosition record);
}