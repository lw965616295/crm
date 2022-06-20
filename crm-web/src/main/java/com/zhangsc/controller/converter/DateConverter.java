package com.zhangsc.controller.converter;

import org.apache.commons.lang3.StringUtils;
import org.springframework.core.convert.converter.Converter;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * <p>Title: </p>
 * <p>Description: 自定义日期装换器</p>
 * <p>Company: </p>
 *
 * @author weil
 * @date 2019-02-26
 */
public class DateConverter implements Converter<String, Date> {
    @Override
    public Date convert(String s) {
        if(StringUtils.isEmpty(s)){
            return null;
        }
        try {
            /*解析两种日期格式*/
            Date date = null;
            if(s.length() > 10){
                date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(s);
            }else{
                date = new SimpleDateFormat("yyyy-MM-dd").parse(s);
            }
            return date;
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return null;
    }
}
