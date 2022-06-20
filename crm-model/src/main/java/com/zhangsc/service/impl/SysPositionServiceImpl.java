package com.zhangsc.service.impl;

import com.zhangsc.dao.sys.TSysPositionMapper;
import com.zhangsc.pojo.sys.TSysPosition;
import com.zhangsc.pojo.sys.TSysPositionExample;
import com.zhangsc.service.SysPositionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * <p>Title: </p>
 * <p>Description: 岗位接口实现</p>
 * <p>Company: </p>
 * @param
 * @return
 * @author weil
 * @date 2019-03-11
 */
@Service
public class SysPositionServiceImpl implements SysPositionService {
    @Autowired
    private TSysPositionMapper mapper;

    @Override
    public List<TSysPosition> query(TSysPosition position) {
        TSysPositionExample example = new TSysPositionExample();
//        TSysPositionExample.Criteria criteria = example.createCriteria();

        List<TSysPosition> tSysPositions = mapper.selectByExample(example);
        return tSysPositions;
    }

    @Override
    public TSysPosition queryById(Long id) {
        TSysPosition tSysPosition = mapper.selectByPrimaryKey(id);
        return tSysPosition;
    }

    @Override
    public void save(TSysPosition position) {
        mapper.insert(position);
    }

    @Override
    public void update(TSysPosition position) {
        mapper.updateByPrimaryKeySelective(position);
    }

    @Override
    public void delete(Long id) {
        mapper.deleteByPrimaryKey(id);
    }
}
