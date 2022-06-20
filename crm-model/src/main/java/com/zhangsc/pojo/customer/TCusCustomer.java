package com.zhangsc.pojo.customer;

import com.zhangsc.pojo.Vo;

import java.util.Date;

public class TCusCustomer extends Vo {
    private Long id;

    private String cusCode;

    private String cusName;

    private Long leader;

    private String cusStatus;

    private String cusBelong;

    private String address;

    private String infoFrom;

    private Integer cusGrade;

    private String staffNum;

    private String remark;

    private Long createBy;

    private Date createTime;

    private Date modifyTime;

    private Integer status;

    private Boolean islocked;

    private Date totop;

    private String ch1;

    private String ch2;

    private String ch3;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getCusCode() {
        return cusCode;
    }

    public void setCusCode(String cusCode) {
        this.cusCode = cusCode == null ? null : cusCode.trim();
    }

    public String getCusName() {
        return cusName;
    }

    public void setCusName(String cusName) {
        this.cusName = cusName == null ? null : cusName.trim();
    }

    public Long getLeader() {
        return leader;
    }

    public void setLeader(Long leader) {
        this.leader = leader;
    }

    public String getCusStatus() {
        return cusStatus;
    }

    public void setCusStatus(String cusStatus) {
        this.cusStatus = cusStatus == null ? null : cusStatus.trim();
    }

    public String getCusBelong() {
        return cusBelong;
    }

    public void setCusBelong(String cusBelong) {
        this.cusBelong = cusBelong == null ? null : cusBelong.trim();
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address == null ? null : address.trim();
    }

    public String getInfoFrom() {
        return infoFrom;
    }

    public void setInfoFrom(String infoFrom) {
        this.infoFrom = infoFrom == null ? null : infoFrom.trim();
    }

    public Integer getCusGrade() {
        return cusGrade;
    }

    public void setCusGrade(Integer cusGrade) {
        this.cusGrade = cusGrade;
    }

    public String getStaffNum() {
        return staffNum;
    }

    public void setStaffNum(String staffNum) {
        this.staffNum = staffNum;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark == null ? null : remark.trim();
    }

    public Long getCreateBy() {
        return createBy;
    }

    public void setCreateBy(Long createBy) {
        this.createBy = createBy;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getModifyTime() {
        return modifyTime;
    }

    public void setModifyTime(Date modifyTime) {
        this.modifyTime = modifyTime;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Boolean getIslocked() {
        return islocked;
    }

    public void setIslocked(Boolean islocked) {
        this.islocked = islocked;
    }

    public Date getTotop() {
        return totop;
    }

    public void setTotop(Date totop) {
        this.totop = totop;
    }

    public String getCh1() {
        return ch1;
    }

    public void setCh1(String ch1) {
        this.ch1 = ch1 == null ? null : ch1.trim();
    }

    public String getCh2() {
        return ch2;
    }

    public void setCh2(String ch2) {
        this.ch2 = ch2 == null ? null : ch2.trim();
    }

    public String getCh3() {
        return ch3;
    }

    public void setCh3(String ch3) {
        this.ch3 = ch3 == null ? null : ch3.trim();
    }
}