package com.zhangsc.controller;

import com.zhangsc.pojo.sys.ActiveUser;
import com.zhangsc.utils.Constants;
import com.zhangsc.utils.CustomException;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by Administrator on 2019-01-22.
 */
@Controller
public class MainController extends BaseController {

    @RequestMapping("login")
    public String login(){
        //认证成功进入主页home
        Subject subject = SecurityUtils.getSubject();
        if(subject.isAuthenticated()){
            return "forward:home";
        }
        //获取shiro认证失败异常信息
        String exceptionStr = (String) getRequest().getAttribute("shiroLoginFailure");
        if(exceptionStr != null) {
            if(UnknownAccountException.class.getName().equals(exceptionStr)) {
                throw new CustomException(Constants.USER_NOT_EXIST);
            }else if(IncorrectCredentialsException.class.getName().equals(exceptionStr)) {
                throw new CustomException(Constants.USER_ERROR);
            }else {
                throw new CustomException(Constants.AUTHENTICATION_ERROR);
            }
        }
        //没有认证跳转认证界面
        return "login";
    }

    @RequestMapping("home")
    public String home() {
        ActiveUser activeUser = getActiveUser();
        //如果主体不存在，跳转登录界面重新登录
        if(activeUser == null) {
            return "login";
        }
        getRequest().getSession().setAttribute("activeUser",activeUser);
        logger.info(activeUser);
        return "home";
    }
}
