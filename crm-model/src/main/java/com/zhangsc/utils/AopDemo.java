package com.zhangsc.utils;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;

import java.lang.reflect.Method;

/**
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Company: </p>
 *
 * @author weil
 * @date 2019-03-21
 */
@Component
@Aspect
public class AopDemo{
    /**
     * <p>Title: </p>
     * <p>Description: 记录登录日志</p>
     * <p>Company: </p>
     * @param
     * @return
     * @author weil
     * @date 2019-03-22
     */
    @AfterReturning(value = "execution(* com.zhangsc.service.impl.SysServiceImpl.*(..))",returning = "keys")
    public void loginLog(JoinPoint jp,Object keys){
        if(keys != null){

        }
        System.out.println("=============>");
        System.out.println(jp.getSignature().getName());
        System.out.println(jp.getArgs()[0]);
        System.out.println("=============>");

    }

    /**
     * <p>Title: </p>
     * <p>Description: 线索日志</p>
     * <p>Company: </p>
     * @param
     * @return
     * @author weil
     * @date 2019-03-22
     */
//    @AfterReturning(value = "execution(* com.zhangsc.service.impl.Clue*(..))", returning = "keys")
    public void clueLog(JoinPoint jp, Object keys){

    }


    public String optionContent(Object[] args, String mName) {
        if (args == null) {
            return null;
        }
        StringBuffer rs = new StringBuffer();
        rs.append(mName);
        String className = null;
        int index = 1;
        // 遍历参数对象
        for (Object info : args) {
            // 获取对象类型
            className = info.getClass().getName();
            className = className.substring(className.lastIndexOf(".") + 1);
            rs.append("[参数" + index + "，类型:" + className + "，值:");
            // 获取对象的所有方法
            Method[] methods = info.getClass().getDeclaredMethods();
            // 遍历方法，判断get方法
            for (Method method : methods) {
                String methodName = method.getName();
                // 判断是不是get方法
                if (methodName.indexOf("get") == -1) {// 不是get方法
                    continue;// 不处理
                }
                Object rsValue = null;
                try {
                    // 调用get方法，获取返回值
                    rsValue = method.invoke(info);
                } catch (Exception e) {
                    continue;
                }
                // 将值加入内容中
                rs.append("(" + methodName + ":" + rsValue + ")");
            }
            rs.append("]");
            index++;
        }
        return rs.toString();
    }
}
