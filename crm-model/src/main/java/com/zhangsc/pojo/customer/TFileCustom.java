package com.zhangsc.pojo.customer;

/**
 * <p>Title: </p>
 * <p>Description: 自定义文件上传</p>
 * <p>Company: </p>
 *
 * @author weil
 * @date 2019-04-06
 */
public class TFileCustom extends TFile {
    /**上传者名*/
    private String uploaderName;

    public String getUploaderName() {
        return uploaderName;
    }

    public void setUploaderName(String uploaderName) {
        this.uploaderName = uploaderName;
    }
}
