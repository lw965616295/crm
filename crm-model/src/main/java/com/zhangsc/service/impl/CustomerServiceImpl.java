package com.zhangsc.service.impl;

import com.zhangsc.dao.customer.CusFollowLogMapper;
import com.zhangsc.dao.customer.CustomerMapper;
import com.zhangsc.pojo.customer.TCusCustomerCustom;
import com.zhangsc.pojo.customer.TCusFollowLog;
import com.zhangsc.pojo.customer.TCusFollowLogCustom;
import com.zhangsc.service.CustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * <p>Title: </p>
 * <p>Description: 客户service实现类</p>
 * <p>Company: </p>
 *
 * @author weil
 * @date 2019-04-11
 */
@Service
public class CustomerServiceImpl implements CustomerService {

    /**客户信息mapper*/
    @Autowired
    private CustomerMapper customerMapper;
    /**客户跟进记录mapper*/
    @Autowired
    private CusFollowLogMapper followLogMapper;

    @Override
    public List<TCusCustomerCustom> query(TCusCustomerCustom cus) {
        return customerMapper.query(cus);
    }

    @Override
    public TCusCustomerCustom queryById(Long id) {
        return customerMapper.queryById(id);
    }

    @Override
    public void update(TCusCustomerCustom cus) throws Exception {
        customerMapper.update(cus);
    }

    @Override
    public void delete(Long id) throws Exception {
        customerMapper.delete(id);
    }

    @Override
    public void save(TCusCustomerCustom cus) throws Exception {
        customerMapper.save(cus);
    }

    @Override
    public String randomCusCode(String preStr) {
        //获取随机客户编码 zsc20190412-1
        /*查询当天创建的客户里最晚的那个编码*/
        Integer cusCount = customerMapper.queryCusCountDay() + 1;
        String dateStr = new SimpleDateFormat("yyyyMMdd").format(new Date());
        return preStr+dateStr+"-"+cusCount;
    }

    @Override
    public List<TCusFollowLogCustom> query(TCusFollowLog followLog) {
        return followLogMapper.query(followLog);
    }

    @Override
    public void save(TCusFollowLog followLog) throws Exception {
        followLogMapper.save(followLog);
    }

    @Override
    public void deleteLog(Long id) throws Exception {
        followLogMapper.delete(id);
    }

    @Override
    public void antoBack(Integer remain) {
        customerMapper.antoBack(remain);
    }

    @Override
    public void toPool(TCusCustomerCustom cus) throws Exception {
        customerMapper.toPool(cus);
    }

    @Override
    public void totop(TCusCustomerCustom cus) {
        customerMapper.totop(cus);
    }

    @Override
    public void cusPlanDel(TCusFollowLog followLog) throws Exception {
        followLogMapper.cusPlanDel(followLog);
    }

    @Override
    public List<TCusCustomerCustom> queryCusPlanRemind() throws Exception {
        return customerMapper.queryCusPlanRemind();
    }
}
