package com.zhangsc.utils;

import java.util.Properties;

/**
 * <p>Title: </p>
 * <p>Description: 处理pro配置文件</p>
 * <p>Company: </p>
 *
 * @author weil
 * @date 2019-03-30
 */
public class PropertiesUtils {
    /**
     * <p>Title: </p>
     * <p>Description: 获取文件上传目录及下载路径</p>
     * <p>Company: </p>
     * @param
     * @return
     * @author weil
     * @date 2019-03-30
     */
    public static String getFileValue(String name) throws Exception{
        Properties properties = new Properties();
        properties.load(PropertiesUtils.class.getResourceAsStream("/file-path.properties"));
        return properties.getProperty(name);
    }

    /**
     * <p>Title: </p>
     * <p>Description: 获取crm相关配置信息</p>
     * <p>Company: </p>
     * @param
     * @return
     * @author weil
     * @date 2019-04-15
     */
    public static String getCrmPros(String name) throws Exception{
        Properties properties = new Properties();
        properties.load(PropertiesUtils.class.getResourceAsStream("/crm.properties"));
        return properties.getProperty(name);
    }

    public static void main(String[] args){
//        try {
//            String fileValue = getFileValue("user-icon-dir");
//            System.out.println(fileValue);
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
        System.out.println(PropertiesUtils.class.getResource("/"));
    }
}
