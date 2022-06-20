package com.zhangsc.pojo.customer;

/**
 * <p>Title: 跟进记录自定义</p>
 * <p>Description: </p>
 * <p>Company: </p>
 *
 * @author weil
 * @date 2019-04-13
 */
public class TCusFollowLogCustom extends TCusFollowLog {
    /**创建人名*/
    private String createrName;
    /**创建人头像*/
    private String iconUrl;
    /**联系人名*/
    private String contactName;
    /**联系人电话*/
    private String conPhone;

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

    public String getContactName() {
        return contactName;
    }

    public void setContactName(String contactName) {
        this.contactName = contactName;
    }

    public String getConPhone() {
        return conPhone;
    }

    public void setConPhone(String conPhone) {
        this.conPhone = conPhone;
    }
}
