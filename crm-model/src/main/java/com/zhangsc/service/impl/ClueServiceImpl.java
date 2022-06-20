package com.zhangsc.service.impl;

import com.zhangsc.dao.customer.ClueCommlogMapper;
import com.zhangsc.dao.customer.ClueMapper;
import com.zhangsc.dao.customer.FileMapper;
import com.zhangsc.pojo.customer.*;
import com.zhangsc.service.ClueService;
import com.zhangsc.utils.PropertiesUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.util.Date;
import java.util.List;

/**
 * <p>Title: </p>
 * <p>Description: 线索service实现</p>
 * <p>Company: </p>
 *
 * @author weil
 * @date 2019-04-03
 */
@Service
public class ClueServiceImpl implements ClueService {
    /**线索mapper*/
    @Autowired
    private ClueMapper clueMapper;
    /**沟通日志mapper*/
    @Autowired
    private ClueCommlogMapper clueCommlogMapper;
    /**文件mapper*/
    @Autowired
    private FileMapper fileMapper;

    @Override
    public List<TCusClueCustom> query(TCusClueCustom clue) {
        List<TCusClueCustom> query = clueMapper.query(clue);
        return query;
    }

    @Override
    public TCusClueCustom queryById(Long id) {
        return clueMapper.queryById(id);
    }

    @Override
    public void update(TCusClueCustom clue) {
        clueMapper.update(clue);
    }

    @Override
    public void delete(Long id) {
        clueMapper.delete(id);
    }

    @Override
    public void save(TCusClueCustom clue) {
        clueMapper.save(clue);
    }

    @Override
    public List<TCusClueCommLogCustom> query(TCusClueCommLog commlog) {
        List<TCusClueCommLogCustom> logs = clueCommlogMapper.query(commlog);
        return logs;
    }

    @Override
    public void save(TCusClueCommLog commlog) throws Exception {
        clueCommlogMapper.save(commlog);
    }

    @Override
    public void deleteLog(Long id) throws Exception {
        clueCommlogMapper.delete(id);
    }

    @Override
    public List<TFileCustom> query(TFile file) {
        return fileMapper.query(file);
    }

    @Override
    public void save(TFile file) throws Exception {
        fileMapper.save(file);
    }

    @Override
    public void deleteFile(Long id) throws Exception {
        fileMapper.delete(id);
    }

    @Override
    public TFile queryFileById(Long id) {
        return fileMapper.queryById(id);
    }

    @Override
    public void upload(MultipartFile file, TFile f) throws Exception {
        String filename = file.getOriginalFilename();

        //文件存放目录   主目录+文件所属类型+类型id
        String dirStr = PropertiesUtils.getFileValue("file-dir")+f.getFileBelong()+"/"+f.getBelongId()+"/";
        File fileDir = new File(dirStr);
        //判断主目录是否存在
        if(!fileDir.exists()){
            fileDir.mkdirs();
        }
        //判断文件是否重名
        File newFile = new File(dirStr, filename);
        if (newFile.exists()){
            //后缀
            String suffix = filename.substring(filename.indexOf("."));
            //前缀
            String prefix = filename.substring(0, filename.indexOf("."));
            //文件名加1
            filename = prefix+"1"+suffix;

            newFile = new File(dirStr, filename);
        }
        file.transferTo(newFile);
        //保存文件信息
        f.setFileName(filename);
        f.setSize(Long.toString(file.getSize()));
        f.setUploadTime(new Date());
        f.setUrl(filename);
        fileMapper.save(f);
    }

    @Override
    public void antoBack(Integer remain) throws Exception {
        clueMapper.autoBack(remain);
    }

    @Override
    public void toPool(TCusClueCustom clue) throws Exception {
        clueMapper.toPool(clue);
    }

    @Override
    public void cluePlanDel(TCusClueCommLog commlog) {
        clueCommlogMapper.cluePlanDel(commlog);
    }

    @Override
    public List<TCusClueCustom> queryCluePlanRemind() throws Exception {
        return clueMapper.queryCluePlanRemind();
    }

    @Override
    public List<TCusClueCustom> change(TCusClueCustom clue) {
       List<TCusClueCustom> queryClue =  clueMapper.queryClue(clue);
       return queryClue;
    }

    @Override
    public void updateStatus(TCusClue clue) throws Exception {
        clueMapper.updateStatus(clue);
    }

}
