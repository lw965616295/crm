package com.zhangsc.service;

import com.zhangsc.pojo.customer.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

/**
 * <p>Title: </p>
 * <p>Description: 线索service接口</p>
 * <p>Company: </p>
 *
 * @author weil
 * @date 2019-04-03
 */
public interface ClueService {
    /*查询线索*/
    public List<TCusClueCustom> query(TCusClueCustom clue);
    /*通过id查询*/
    public TCusClueCustom queryById(Long id);
    /*更新线索*/
    public void update(TCusClueCustom clue) throws Exception;
    /*删除线索*/
    public void delete(Long id) throws Exception;
    /*添加线索*/
    public void save(TCusClueCustom clue) throws Exception;
    /*查询沟通日志or日程*/
    public List<TCusClueCommLogCustom> query(TCusClueCommLog commlog);
    /*添加沟通日志or日程*/
    public void save(TCusClueCommLog commlog) throws Exception;
    /*删除沟通日志*/
    public void deleteLog(Long id) throws Exception;
    /*查询文件*/
    public List<TFileCustom> query(TFile file);
    /*添加文件*/
    public void save(TFile file) throws Exception;
    /*删除文件*/
    public void deleteFile(Long id) throws Exception;
    /*通过id查询线索*/
    public TFile queryFileById(Long id);

    /*上传文件*/
    public void upload(MultipartFile file, TFile f) throws Exception;
    /*到期自动放回线索池*/
    public void antoBack(Integer remain) throws Exception;

    /*放回线索池*/
    public void toPool(TCusClueCustom clue) throws Exception;
    /*过期线索日程删除*/
    public void cluePlanDel(TCusClueCommLog commlog) throws Exception ;
    /*转换*/
    public List<TCusClueCustom> change(TCusClueCustom clue);

    public void updateStatus(TCusClue clue) throws Exception;
    /*查询需要提醒的线索日程*/
    public List<TCusClueCustom> queryCluePlanRemind() throws Exception;
}
