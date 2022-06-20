package com.zhangsc.dao.customer;

import com.zhangsc.pojo.customer.TCusCustomer;
import com.zhangsc.pojo.customer.TCusCustomerCustom;

import java.util.List;

/**
 * <p>Title: </p>
 * <p>Description: 客户信息mapper</p>
 * <p>Company: </p>
 *
 * @author weil
 * @date 2019-04-03
 */
public interface CustomerMapper {
    public List<TCusCustomerCustom> query(TCusCustomerCustom cus);

    public void save(TCusCustomer cus);

    public TCusCustomerCustom queryById(Long id);

    public void update(TCusCustomer cus);

    public void delete(Long id);

    public Integer queryCusCountDay();

    public void antoBack(Integer remain);

    public void toPool(TCusCustomer cus);

    public void totop(TCusCustomer cus);

    public List<TCusCustomerCustom> queryCusPlanRemind();
}
