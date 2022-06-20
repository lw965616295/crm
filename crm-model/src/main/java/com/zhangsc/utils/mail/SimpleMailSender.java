package com.zhangsc.utils.mail;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import java.util.Date;

/**
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Company: </p>
 *
 * @author weil
 * @date 2019-04-19
 */
public class SimpleMailSender {
    //文本类型邮件
    public Integer textMail = 1;
    //网页类型邮件
    public Integer htmlMail = 2;


    public void sendMail(MailSenderInfo info, Integer type) throws Exception{
        //获得邮件发送session
        Session session = Session.getDefaultInstance(info.getProperties(), new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {

                return new PasswordAuthentication(info.getUserName(), info.getPassword());
            }
        });
        //获得邮件发送消息
        MimeMessage mailMessage = new MimeMessage(session);
        //发送者地址
        InternetAddress from = new InternetAddress(info.getFromAddress());
        mailMessage.setFrom(from);
        //接收者地址
        InternetAddress to = new InternetAddress(info.getToAddress());
        mailMessage.setRecipient(Message.RecipientType.TO, to);
        //邮件主题
        mailMessage.setSubject(info.getSubject());
        //发送时间
        mailMessage.setSentDate(new Date());
        //邮件内容
        if(textMail.equals(type)){
            //文本内容
            mailMessage.setText(info.getContent());
        }else if (htmlMail.equals(type)){
            //网页内容

            // MiniMultipart类是一个容器类，包含MimeBodyPart类型的对象
            Multipart mainPart = new MimeMultipart();
            // 创建一个包含HTML内容的MimeBodyPart
            BodyPart html = new MimeBodyPart();
            // 设置HTML内容
            html.setContent(info.getContent(), "text/html; charset=utf-8");
            mainPart.addBodyPart(html);
            // 将MiniMultipart对象设置为邮件内容
            mailMessage.setContent(mainPart);
        }

        //发送
        Transport.send(mailMessage);
    }

    public static void main(String[] args) throws Exception {
        // 这个类主要是设置邮件
        MailSenderInfo mailInfo = new MailSenderInfo();
        mailInfo.setMailServerHost("smtp.exmail.qq.com");
        mailInfo.setMailServerPort("25");
        mailInfo.setValidate(true);
        mailInfo.setUserName("CC56@ruishunwl.com");
        mailInfo.setPassword("Rs123456");
        mailInfo.setFromAddress("CC56@ruishunwl.com");
        mailInfo.setToAddress("");
        mailInfo.setSubject("安静的美男子来电");
        mailInfo.setContent("你好啊");

        System.out.println("start mail");
        SimpleMailSender simpleMailSender = new SimpleMailSender();
        simpleMailSender.sendMail(mailInfo, simpleMailSender.textMail);
        System.out.println("end mail");
    }
}
