package com.zhangsc.utils;

import com.zhangsc.pojo.customer.TCusClueCustom;
import com.zhangsc.pojo.customer.TCusCustomerCustom;
import com.zhangsc.service.ClueService;
import com.zhangsc.service.CustomerService;
import com.zhangsc.utils.mail.MailSenderInfo;
import com.zhangsc.utils.mail.SimpleMailSender;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * <p>Title: </p>
 * <p>Description: 定时器任务</p>
 * <p>Company: </p>
 *
 * @author weil
 * @date 2019-04-15
 */
@Component
public class TaskUtil {
    /**日志log*/
    Logger logger = Logger.getLogger(TaskUtil.class);
    /**线索service*/
    @Autowired
    private ClueService clueService;
    /**客户service*/
    @Autowired
    private CustomerService customerService;

    /**
     * <p>Title: </p>
     * <p>Description: 线索到期自动放回线索池(每天早上三点定时)</p>
     * <p>Company: </p>
     * @param
     * @return
     * @author weil
     * @date 2019-04-15
     */
    @Scheduled(cron = "0 0 3 * * ? ")
    public void clueExpireTask(){
        logger.info("------------->clueExpireTask开始！");
        //到期放回线索池
        try {
            String clueRemain = PropertiesUtils.getCrmPros("date-remain");
            Integer remain = Integer.parseInt(clueRemain);
            clueService.antoBack(remain);
            logger.info("------------->clueExpireTask结束！");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * <p>Title: </p>
     * <p>Description: 客户到期自动放回线索池(每天早上三点定时)</p>
     * <p>Company: </p>
     * @param
     * @return
     * @author weil
     * @date 2019-04-17
     */
    @Scheduled(cron = "0 0 3 * * ? ")
    public void cusExpireTask(){
        logger.info("------------->cusExpireTask开始！");
        //到期放回线索池
        try {
            String clueRemain = PropertiesUtils.getCrmPros("date-remain");
            Integer remain = Integer.parseInt(clueRemain);
            customerService.antoBack(remain);
            logger.info("------------->cusExpireTask结束！");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * <p>Title: </p>
     * <p>Description: 当天线索日程邮件发送</p>
     * <p>Company: </p>
     * @param
     * @return
     * @author weil
     * @date 2019-04-19
     */
    @Scheduled(cron = "0 0 3 * * ? ")
    public void cluePlanRemind(){
        logger.info("------------->cluePlanRemind开始！");
        try {
            //获取所有当天需要拜访的日程信息
            List<TCusClueCustom> tCusClueCustoms = clueService.queryCluePlanRemind();
            for (TCusClueCustom clueCustom : tCusClueCustoms) {
                //通过邮件的方式发送到领用负责人的邮箱
                MailSenderInfo mailInfo = new MailSenderInfo();
                mailInfo.setMailServerHost("smtp.exmail.qq.com");
                mailInfo.setMailServerPort("25");
                mailInfo.setValidate(true);
                mailInfo.setUserName("CC56@ruishunwl.com");
                mailInfo.setPassword("Rs123456");
                mailInfo.setFromAddress("CC56@ruishunwl.com");
                mailInfo.setToAddress(clueCustom.getLeaderEmail());
                mailInfo.setSubject("江苏掌仓CRM邮件提醒");
                mailInfo.setContent(clueCustom.getContent());

                SimpleMailSender simpleMailSender = new SimpleMailSender();
                simpleMailSender.sendMail(mailInfo, simpleMailSender.textMail);
            }
            logger.info("------------->cluePlanRemind结束！");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * <p>Title: </p>
     * <p>Description: 当天客户日程邮件发送</p>
     * <p>Company: </p>
     * @param
     * @return
     * @author weil
     * @date 2019-04-19
     */
    @Scheduled(cron = "0 0 3 * * ? ")
    public void cusPlanRemind(){
        logger.info("------------->cusPlanRemind开始！");
        try {
            //获取所有当天需要拜访的日程信息
            List<TCusCustomerCustom> tCusCustomerCustoms = customerService.queryCusPlanRemind();
            for (TCusCustomerCustom cusCustom : tCusCustomerCustoms) {
                //通过邮件的方式发送到领用负责人的邮箱
                MailSenderInfo mailInfo = new MailSenderInfo();
                mailInfo.setMailServerHost("smtp.exmail.qq.com");
                mailInfo.setMailServerPort("25");
                mailInfo.setValidate(true);
                mailInfo.setUserName("CC56@ruishunwl.com");
                mailInfo.setPassword("Rs123456");
                mailInfo.setFromAddress("CC56@ruishunwl.com");
                mailInfo.setToAddress(cusCustom.getLeaderEmail());
                mailInfo.setSubject("江苏掌仓CRM邮件提醒");
                mailInfo.setContent(cusCustom.getContent());

                SimpleMailSender simpleMailSender = new SimpleMailSender();
                simpleMailSender.sendMail(mailInfo, simpleMailSender.textMail);
            }
            logger.info("------------->cusPlanRemind结束！");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
