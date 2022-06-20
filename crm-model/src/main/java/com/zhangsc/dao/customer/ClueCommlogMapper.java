package com.zhangsc.dao.customer;

import com.zhangsc.pojo.customer.TCusClueCommLog;
import com.zhangsc.pojo.customer.TCusClueCommLogCustom;

import java.util.List;

/**
 * <p>Title: </p>
 * <p>Description: 线索沟通日志mapper</p>
 * <p>Company: </p>
 *
 * @author weil
 * @date 2019-04-05
 */
public interface ClueCommlogMapper {
    /*查询日志*/
    public List<TCusClueCommLogCustom> query(TCusClueCommLog commlog);
    /*添加日志*/
    public void save(TCusClueCommLog commlog);
    /*删除日志*/
    public void delete(Long id);
    /*删除过时的日程*/
    public void cluePlanDel(TCusClueCommLog commlog);

}
