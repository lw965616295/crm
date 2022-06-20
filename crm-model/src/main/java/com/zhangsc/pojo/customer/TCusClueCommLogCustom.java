package com.zhangsc.pojo.customer;

/**
 * <p>Title: </p>
 * <p>Description: 自定义线索沟通日志</p>
 * <p>Company: </p>
 *
 * @author weil
 * @date 2019-04-05
 */
public class TCusClueCommLogCustom extends TCusClueCommLog{
    /**创建人名*/
    private String createrName;
    /**创建人头像*/
    private String iconUrl;

    public String getCreaterName() {
        return createrName;
    }

    public void setCreaterName(String createrName) {
        this.createrName = createrName;
    }

    public String getIconUrl() {
        return iconUrl;
    }

    public void setIconUrl(String iconUrl) {
        this.iconUrl = iconUrl;
    }
}
