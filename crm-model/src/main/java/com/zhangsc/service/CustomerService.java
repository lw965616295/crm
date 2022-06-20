package com.zhangsc.service;

import com.zhangsc.pojo.customer.TCusCustomerCustom;
import com.zhangsc.pojo.customer.TCusFollowLog;
import com.zhangsc.pojo.customer.TCusFollowLogCustom;

import java.util.List;

/**
 * <p>Title: </p>
 * <p>Description: 客户service接口</p>
 * <p>Company: </p>
 * @param
 * @return
 * @author weil
 * @date 2019-04-11
 */
public interface CustomerService {
    /*查询客户*/
    public List<TCusCustomerCustom> query(TCusCustomerCustom cus);
    /*通过id查询*/
    public TCusCustomerCustom queryById(Long id);
    /*更新客户*/
    public void update(TCusCustomerCustom cus) throws Exception;
    /*删除客户*/
    public void delete(Long id) throws Exception;
    /*添加客户*/
    public void save(TCusCustomerCustom cus) throws Exception;
    /*获取随机客户编码*/
    public String randomCusCode(String preStr);
    /*查询跟进日志or日程*/
    public List<TCusFollowLogCustom> query(TCusFollowLog followLog);
    /*添加跟进日志or日程*/
    public void save(TCusFollowLog followLog) throws Exception;
    /*删除跟进日志*/
    public void deleteLog(Long id) throws Exception;

    /*客户到期自动放回客户池*/
    public void antoBack(Integer remain);
    /*放回客户池*/
    public void toPool(TCusCustomerCustom cus) throws Exception;
    /*置顶操作*/
    public void totop(TCusCustomerCustom cus);
    /*过期客户日程删除*/
    public void cusPlanDel(TCusFollowLog followLog) throws Exception;
    /*查询需要提醒的客户日程*/
    public List<TCusCustomerCustom> queryCusPlanRemind()throws Exception;
}
