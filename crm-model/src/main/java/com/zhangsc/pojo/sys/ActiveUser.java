package com.zhangsc.pojo.sys;

import java.util.List;
import java.util.Map;

/**
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Company: </p>
 *
 * @author weil
 * @date 2019-02-15
 */
public class ActiveUser extends TSysUser{
    /**用户菜单集合*/
    private Map<String, List> menus;

    public Map<String, List> getMenus() {
        return menus;
    }

    public void setMenus(Map<String, List> menus) {
        this.menus = menus;
    }

}
