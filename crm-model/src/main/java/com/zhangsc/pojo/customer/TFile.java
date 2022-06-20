package com.zhangsc.pojo.customer;

import com.zhangsc.pojo.Vo;

import java.util.Date;

public class TFile extends Vo{
    private Long id;

    private String fileName;

    private String url;

    private String size;

    private Long uploader;

    private Date uploadTime;

    private String fileBelong;

    private Long belongId;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName == null ? null : fileName.trim();
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url == null ? null : url.trim();
    }

    public String getSize() {
        return size;
    }

    public void setSize(String size) {
        this.size = size == null ? null : size.trim();
    }

    public Long getUploader() {
        return uploader;
    }

    public void setUploader(Long uploader) {
        this.uploader = uploader;
    }

    public Date getUploadTime() {
        return uploadTime;
    }

    public void setUploadTime(Date uploadTime) {
        this.uploadTime = uploadTime;
    }

    public String getFileBelong() {
        return fileBelong;
    }

    public void setFileBelong(String fileBelong) {
        this.fileBelong = fileBelong == null ? null : fileBelong.trim();
    }

    public Long getBelongId() {
        return belongId;
    }

    public void setBelongId(Long belongId) {
        this.belongId = belongId;
    }
}