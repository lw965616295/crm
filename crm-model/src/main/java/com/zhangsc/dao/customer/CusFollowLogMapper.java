package com.zhangsc.dao.customer;

import com.zhangsc.pojo.customer.TCusFollowLog;
import com.zhangsc.pojo.customer.TCusFollowLogCustom;

import java.util.List;

/**
 * <p>Title: </p>
 * <p>Description: 客户跟进日志mapper</p>
 * <p>Company: </p>
 *
 * @author weil
 * @date 2019-04-05
 */
public interface CusFollowLogMapper {
    /*查询日志*/
    public List<TCusFollowLogCustom> query(TCusFollowLog followLog);
    /*添加日志*/
    public void save(TCusFollowLog followLog);
    /*删除日志*/
    public void delete(Long id);
    /*删除过时的日程*/
    public void cusPlanDel(TCusFollowLog followLog);
}
