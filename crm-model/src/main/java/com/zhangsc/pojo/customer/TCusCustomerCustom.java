package com.zhangsc.pojo.customer;

import java.util.Date;

/**
 * <p>Title: </p>
 * <p>Description: 客户自定义</p>
 * <p>Company: </p>
 * @param
 * @return 
 * @author weil
 * @date 2019-04-11
 */
public class TCusCustomerCustom extends TCusCustomer{
    /**开始时间*/
    private Date beginTime;
    /**结束时间*/
    private Date endTime;
    /**客户范围：0：自己；1：下属；2：全部*/
    private Integer cusRange;
    /**负责人名*/
    private String leaderName;
    /**创建人名*/
    private String createrName;
    /**查询字符串*/
    private String queryStr;
    /**联系人名*/
    private String contactName;
    /**联系人电话*/
    private String conPhone;
    /**联系人id*/
    private Long contactId;
    /**联系人角色*/
    private String conRole;
    /**联系人尊称*/
    private String conCall;
    /**联系人职位*/
    private String conPosition;
    /**联系人QQ/MSN*/
    private String conQM;
    /**联系人邮箱*/
    private String conEmail;
    /**联系人邮编*/
    private String conPost;
    /**联系人地址*/
    private String conAddress;
    /**联系人备注*/
    private String conRemark;
    /**模糊下属职位id*/
    private String subPositionId;
    /**剩余到期天数*/
    private Integer dueDay;
    /**是否置顶*/
    private Boolean topStatus;
    /**下次联系内容*/
    private String content;
    /**下次联系时间*/
    private Date nextTime;
    /**领用人邮箱*/
    private String leaderEmail;

    public String getLeaderEmail() {
        return leaderEmail;
    }

    public void setLeaderEmail(String leaderEmail) {
        this.leaderEmail = leaderEmail;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getNextTime() {
        return nextTime;
    }

    public void setNextTime(Date nextTime) {
        this.nextTime = nextTime;
    }

    public Boolean getTopStatus() {
        return topStatus;
    }

    public void setTopStatus(Boolean topStatus) {
        this.topStatus = topStatus;
    }

    public Integer getDueDay() {
        return dueDay;
    }

    public void setDueDay(Integer dueDay) {
        this.dueDay = dueDay;
    }

    public String getSubPositionId() {
        return subPositionId;
    }

    public void setSubPositionId(String subPositionId) {
        this.subPositionId = subPositionId;
    }

    public String getConRole() {
        return conRole;
    }

    public void setConRole(String conRole) {
        this.conRole = conRole;
    }

    public String getConCall() {
        return conCall;
    }

    public void setConCall(String conCall) {
        this.conCall = conCall;
    }

    public String getConPosition() {
        return conPosition;
    }

    public void setConPosition(String conPosition) {
        this.conPosition = conPosition;
    }

    public String getConQM() {
        return conQM;
    }

    public void setConQM(String conQM) {
        this.conQM = conQM;
    }

    public String getConEmail() {
        return conEmail;
    }

    public void setConEmail(String conEmail) {
        this.conEmail = conEmail;
    }

    public String getConPost() {
        return conPost;
    }

    public void setConPost(String conPost) {
        this.conPost = conPost;
    }

    public String getConAddress() {
        return conAddress;
    }

    public void setConAddress(String conAddress) {
        this.conAddress = conAddress;
    }

    public String getConRemark() {
        return conRemark;
    }

    public void setConRemark(String conRemark) {
        this.conRemark = conRemark;
    }

    public Long getContactId() {
        return contactId;
    }

    public void setContactId(Long contactId) {
        this.contactId = contactId;
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

    public String getQueryStr() {
        return queryStr;
    }

    public void setQueryStr(String queryStr) {
        this.queryStr = queryStr;
    }

    public Date getBeginTime() {
        return beginTime;
    }

    public void setBeginTime(Date beginTime) {
        this.beginTime = beginTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    public Integer getCusRange() {
        return cusRange;
    }

    public void setCusRange(Integer cusRange) {
        this.cusRange = cusRange;
    }

    public String getLeaderName() {
        return leaderName;
    }

    public void setLeaderName(String leaderName) {
        this.leaderName = leaderName;
    }

    public String getCreaterName() {
        return createrName;
    }

    public void setCreaterName(String createrName) {
        this.createrName = createrName;
    }
}
