package com.zhangsc.service.impl;

import com.zhangsc.dao.sys.TSysDeptMapper;
import com.zhangsc.pojo.sys.TSysDept;
import com.zhangsc.pojo.sys.TSysDeptExample;
import com.zhangsc.service.SysDeptService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * <p>Title: </p>
 * <p>Description: 部门接口实现</p>
 * <p>Company: </p>
 * @param
 * @return
 * @author weil
 * @date 2019-03-09
 */
@Service
public class SysDeptServiceImpl implements SysDeptService {
    @Autowired
    private TSysDeptMapper mapper;

    @Override
    public List<TSysDept> query(TSysDept dept) {
        TSysDeptExample example = new TSysDeptExample();
//        TSysDeptExample.Criteria criteria = example.createCriteria();

        List<TSysDept> tSysDepts = mapper.selectByExample(example);
        return tSysDepts;
    }

    @Override
    public TSysDept queryById(Long id) {
        TSysDept tSysDept = mapper.selectByPrimaryKey(id);
        return tSysDept;
    }

    @Override
    public void save(TSysDept dept) {
        mapper.insert(dept);
    }

    @Override
    public void update(TSysDept dept) {
        mapper.updateByPrimaryKeySelective(dept);
    }

    @Override
    public void delete(Long id) {
        mapper.deleteByPrimaryKey(id);
    }
}
