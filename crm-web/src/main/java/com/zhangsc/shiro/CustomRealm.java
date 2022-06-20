package com.zhangsc.shiro;

import com.zhangsc.pojo.sys.ActiveUser;
import com.zhangsc.pojo.sys.TSysPermission;
import com.zhangsc.pojo.sys.TSysUser;
import com.zhangsc.service.SysService;
import com.zhangsc.utils.PropertiesUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2019-01-22.
 */
public class CustomRealm extends AuthorizingRealm {
    /**日志对象Logger*/
    protected Logger logger = Logger.getLogger(this.getClass());

    @Autowired
    private SysService sysService;
    /**
     * <p>Title: </p>
     * <p>Description: 认证</p>
     * <p>Company: </p>
     * @param
     * @return
     * @author weil
     * @date 2019-02-14
     */
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
        //获取用户名
        String username = (String) token.getPrincipal();
        //查询用户是否存在
        TSysUser user = null;
        try {
            user = sysService.getUserByAccount(username);
        } catch (Exception e) {
            e.printStackTrace();
        }
        //用户不存在
        if(user == null){
            throw new UnknownAccountException();
        }
        //生成用户session状态信息
        ActiveUser activeUser = new ActiveUser();
        activeUser.setAccount(user.getAccount());
        activeUser.setId(user.getId());
        activeUser.setPositionId(user.getPositionId());
        if(StringUtils.isNotEmpty(user.getIconUrl())){
            //图片不为空，则拼接服务器图片地址
            String iconUrl = null;
            try {
                iconUrl = PropertiesUtils.getFileValue("user-icon-url")+user.getId()+"/"+user.getIconUrl();
            } catch (Exception e) {
                e.printStackTrace();
            }
            activeUser.setIconUrl(iconUrl);
        }

        //获取菜单，并处理菜单结构
        try {
            List<TSysPermission> list = sysService.getMenusById(user.getId());
            //菜单集合
            Map<String, List> menus = new LinkedHashMap<>();
            for (TSysPermission perm : list) {
                Long id = perm.getId();
                //获取所有一级菜单
                if(id.toString().length() == 2){
                    menus.put(perm.getName(),new ArrayList<String>());
                    for(TSysPermission perm2 : list) {
                        //通过一级菜单获取二级菜单
                        if(id == perm2.getpId()){
                            menus.get(perm.getName()).add(perm2);
                        }
                    }
                }
            }
            activeUser.setMenus(menus);
        } catch (Exception e) {
            e.printStackTrace();
        }
        SimpleAuthenticationInfo info = new SimpleAuthenticationInfo(activeUser,user.getPassword(),this.getName());
        return info;
    }

    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
        ActiveUser activeUser= (ActiveUser)principals.getPrimaryPrincipal();
        List<String> pStrings = new ArrayList<>();
        try {
            List<TSysPermission> permissions = sysService.getPermsById(activeUser.getId());

            for (TSysPermission perm : permissions) {
                pStrings.add(perm.getPercode());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        logger.info("---------------->pStrings:"+pStrings.toString());
        SimpleAuthorizationInfo authorizationInfo = new SimpleAuthorizationInfo();
        authorizationInfo.addStringPermissions(pStrings);
        return authorizationInfo;
    }

}
