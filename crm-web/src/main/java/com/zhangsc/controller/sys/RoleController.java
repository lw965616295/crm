package com.zhangsc.controller.sys;

import com.zhangsc.controller.BaseController;
import com.zhangsc.controller.BaseInterface;
import com.zhangsc.pojo.sys.TSysPermission;
import com.zhangsc.pojo.sys.TSysRole;
import com.zhangsc.pojo.sys.TSysRolePermission;
import com.zhangsc.service.SysPermService;
import com.zhangsc.service.SysRoleService;
import com.zhangsc.utils.Constants;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * <p>Title: </p>
 * <p>Description: 角色controller</p>
 * <p>Company: </p>
 *
 * @author weil
 * @date 2019-02-20
 */
@Controller
@RequestMapping("role")
public class RoleController extends BaseController implements BaseInterface<TSysRole> {
    @Autowired
    private SysRoleService sysRoleService;
    /**权限资源service*/
    @Autowired
    private SysPermService sysPermService;

    /**
     * <p>Title: </p>
     * <p>Description: 跳转角色页面</p>
     * <p>Company: </p>
     *
     * @param
     * @return
     * @author weil
     * @date 2019-03-05
     */
    @RequestMapping("page")
    public String page() {
        return "sys/role";
    }

    /**
     * <p>Title: </p>
     * <p>Description: 查询角色信息</p>
     * <p>Company: </p>
     *
     * @param
     * @return
     * @author weil
     * @date 2019-03-05
     */
    @RequestMapping("query")
    @ResponseBody
    public String query(TSysRole tSysRole) {
        startPagination();
        try {
            List<TSysRole> query = sysRoleService.query(tSysRole);
            return getResultJsonStr(Constants.RETURN_SUCCESS, "返回成功！", query);
        } catch (Exception e) {
            return getResultJsonStr(Constants.RETRUN_FAILURE, e.getMessage());
        }
    }

    /**
     * <p>Title: </p>
     * <p>Description: 保存角色信息</p>
     * <p>Company: </p>
     * @param
     * @return
     * @author weil
     * @date 2019-03-06
     */
    @RequestMapping("save")
    @ResponseBody
    public String save(TSysRole tSysRole) {
        try {
            sysRoleService.save(tSysRole);
            return getResultJsonStr(Constants.RETURN_SUCCESS, "操作成功！");
        } catch (Exception e) {
            return getResultJsonStr(Constants.RETRUN_FAILURE, e.getMessage());
        }
    }

    /**
     * <p>Title: </p>
     * <p>Description: 更新角色</p>
     * <p>Company: </p>
     * @param
     * @return
     * @author weil
     * @date 2019-03-06
     */
    @RequestMapping("update")
    @ResponseBody
    public String update(TSysRole tSysRole) {
        try {
            sysRoleService.update(tSysRole);
            return getResultJsonStr(Constants.RETURN_SUCCESS, "操作成功！");
        } catch (Exception e) {
            return getResultJsonStr(Constants.RETRUN_FAILURE, e.getMessage());
        }
    }

    /**
     * <p>Title: </p>
     * <p>Description: 删除角色</p>
     * <p>Company: </p>
     * @param
     * @return
     * @author weil
     * @date 2019-03-06
     */
    @RequestMapping("delete")
    @ResponseBody
    public String delete(String ids) {
        if(StringUtils.isEmpty(ids)){
            return getResultJsonStr(Constants.RETRUN_FAILURE, "需要删除的id不存在！");
        }
        String[] split = ids.split(",");
        for (String s : split) {
            try {
                long id = Long.parseLong(s);
                sysRoleService.delete(id);
            } catch (Exception e) {
                return getResultJsonStr(Constants.RETRUN_FAILURE, "删除失败！");
            }
        }
        return getResultJsonStr(Constants.RETURN_SUCCESS, "操作成功！");
    }
    /**
     * <p>Title: </p>
     * <p>Description: 打开新增页</p>
     * <p>Company: </p>
     * @param
     * @return
     * @author weil
     * @date 2019-03-05
     */
    @RequestMapping("addPage")
    public String addPage(){
        return "sys/role-detail";
    }
    /**
     * <p>Title: </p>
     * <p>Description: 打开更新页</p>
     * <p>Company: </p>
     * @param
     * @return
     * @author weil
     * @date 2019-03-05
     */
    @RequestMapping("updatePage")
    public String updatePage(Long id){
        TSysRole tSysRole = sysRoleService.queryById(id);
        getRequest().setAttribute("role", tSysRole);
        return "sys/role-detail";
    }

    /**
     * <p>Title: </p>
     * <p>Description: 跳转授权页</p>
     * <p>Company: </p>
     * @param
     * @return
     * @author weil
     * @date 2019-03-15
     */
    @RequestMapping("authorPage")
    public String authorPage(Long id){
        //获取所有权限资源
        List<TSysPermission> perms = sysPermService.query(new TSysPermission());
        getRequest().setAttribute("perms", getResultJsonStr(Constants.RETURN_SUCCESS, "返回成功！", perms));
        //获取当前角色权限资源
        List<TSysRolePermission> perms2 = sysRoleService.getPermIdsByRoleId(id);
        getRequest().setAttribute("perms2", getResultJsonStr(Constants.RETURN_SUCCESS, "返回成功！", perms2));
        //传入对应角色
        getRequest().setAttribute("roleId", id);
        return "sys/role-author";
    }
    /**
     * <p>Title: </p>
     * <p>Description: 授权功能</p>
     * <p>Company: </p>
     * @param
     * @return
     * @author weil
     * @date 2019-03-15
     */
    @RequestMapping("author")
    @ResponseBody
    public String author(Long roleId, String ids) {
        String[] split = ids.split(",");
        logger.info("split.length---------->"+split.length);
        try {
            //删除该角色在角色资源表中的记录
            sysRoleService.delByRoleId(roleId);
            //重新再插入记录
                for (String id : split) {
                    TSysRolePermission sysRolePermission = new TSysRolePermission();
                    sysRolePermission.setPermId(Long.parseLong(id));
                    sysRolePermission.setRoleId(roleId);
                    //保存
                    sysRoleService.save(sysRolePermission);
                }
        } catch (Exception e) {
            return getResultJsonStr(Constants.RETRUN_FAILURE, "授权失败！"+e.getMessage());
        }
        return getResultJsonStr(Constants.RETURN_SUCCESS, "授权成功！");
    }
}
