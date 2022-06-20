package com.zhangsc.pojo.customer;

import java.util.Date;

/**
 * <p>Title: </p>
 * <p>Description: 线索custom</p>
 * <p>Company: </p>
 *
 * @author weil
 * @date 2019-04-02
 */
public class TCusClueCustom extends TCusClue {
    /**
     * 开始时间
     */
    private Date beginTime;
    /**
     * 结束时间
     */
    private Date endTime;
    /**
     * 线索范围：0：自己；1：下属；2：全部
     */
    private Integer clueRange;
    /**
     * 负责人名
     */
    private String leaderName;
    /**
     * 创建人名
     */
    private String createrName;
    /**
     * 剩余到期天数
     */
    private Integer dueDay;
    /**
     * 模糊下属职位id
     */
    private String subPositionId;
    /**
     * 下次联系内容
     */
    private String content;
    /**
     * 下次联系时间
     */
    private Date nextTime;
    /**
     * 领用人邮箱
     */
    private String leaderEmail;


    private String queryStr;

    public String getQueryStr() {
        return queryStr;
    }

    public void setQueryStr(String queryStr) {
        this.queryStr = queryStr;
    }

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

    public String getSubPositionId() {
        return subPositionId;
    }

    public void setSubPositionId(String subPositionId) {
        this.subPositionId = subPositionId;
    }

    public Integer getDueDay() {
        return dueDay;
    }

    public void setDueDay(Integer dueDay) {
        this.dueDay = dueDay;
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

    public Integer getClueRange() {
        return clueRange;
    }

    public void setClueRange(Integer clueRange) {
        this.clueRange = clueRange;
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
}
