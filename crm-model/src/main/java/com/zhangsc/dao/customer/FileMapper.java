package com.zhangsc.dao.customer;

import com.zhangsc.pojo.customer.TFile;
import com.zhangsc.pojo.customer.TFileCustom;

import java.util.List;

/**
 * <p>Title: </p>
 * <p>Description: 文件mapper</p>
 * <p>Company: </p>
 *
 * @author weil
 * @date 2019-04-05
 */
public interface FileMapper {
    /*查询文件*/
    public List<TFileCustom> query(TFile file);
    /*添加文件*/
    public void save(TFile file);
    /*删除日志*/
    public void delete(Long id);
    /*通过id查询文件*/
    public TFile queryById(Long id);
}
