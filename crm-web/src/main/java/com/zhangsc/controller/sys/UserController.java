package com.zhangsc.controller.sys;

import com.zhangsc.controller.BaseController;
import com.zhangsc.controller.BaseInterface;
import com.zhangsc.pojo.sys.TSysUser;
import com.zhangsc.pojo.sys.TSysUserCustom;
import com.zhangsc.pojo.sys.TSysUserRole;
import com.zhangsc.service.SysUserService;
import com.zhangsc.utils.Constants;
import com.zhangsc.utils.PropertiesUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.util.Date;
import java.util.List;

/**
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Company: </p>
 *
 * @author weil
 * @date 2019-02-13
 */
@Controller
@RequestMapping("user")
public class UserController extends BaseController implements BaseInterface<TSysUserCustom> {
    @Autowired
    private SysUserService sysUserService;
    /**
     * <p>Title: </p>
     * <p>Description: 跳转用户页面</p>
     * <p>Company: </p>
     * @param
     * @return
     * @author weil
     * @date 2019-02-13
     */
    @RequestMapping("page")
    public String page() {
        return "sys/user";
    }

    /**
     * <p>Title: </p>
     * <p>Description: 查询用户信息LIST</p>
     * <p>Company: </p>
     * @param
     * @return
     * @author weil
     * @date 2019-02-13
     */
    @RequestMapping(value = "query")
    @ResponseBody
    public String query(TSysUserCustom tSysUserCustom) {
        startPagination();
        List<TSysUserCustom> query = sysUserService.query(tSysUserCustom);
        return getResultJsonStr(Constants.RETURN_SUCCESS, "返回成功！", query);
    }

    /**
     * <p>Title: </p>
     * <p>Description: 保存用户信息</p>
     * <p>Company: </p>
     * @param
     * @return
     * @author weil
     * @date 2019-02-25
     */
    @RequestMapping("save")
    @ResponseBody
    public String save(TSysUserCustom tSysUserCustom) {
        //判断账号是否重复
        TSysUser tSysUser = new TSysUser();
        tSysUser.setAccount(tSysUserCustom.getAccount());
        List<TSysUser> users = sysUserService.query(tSysUser);
        if(users != null && users.size()>0){
            return getResultJsonStr(Constants.RETRUN_FAILURE, "该账号已存在！");
        }
        tSysUserCustom.setCreateBy(getActiveUser().getId());
        tSysUserCustom.setPassword("123456");
        tSysUserCustom.setCreateTime(new Date());
        tSysUserCustom.setModiBy(getActiveUser().getId());
        tSysUserCustom.setModiTime(new Date());
        try {
            sysUserService.save(tSysUserCustom);
            return getResultJsonStr(Constants.RETURN_SUCCESS, "操作成功！");
        } catch (Exception e) {
            return getResultJsonStr(Constants.RETRUN_FAILURE, e.getMessage());
        }
    }

    /**
     * <p>Title: </p>
     * <p>Description: 更新用户信息</p>
     * <p>Company: </p>
     * @param
     * @return
     * @author weil
     * @date 2019-02-27
     */
    @RequestMapping("update")
    @ResponseBody
    public String update(TSysUserCustom tSysUserCustom) {
        try {
            tSysUserCustom.setModiBy(getActiveUser().getId());
            tSysUserCustom.setModiTime(new Date());
            sysUserService.update(tSysUserCustom);
            return getResultJsonStr(Constants.RETURN_SUCCESS, "操作成功！");
        } catch (Exception e) {
            return getResultJsonStr(Constants.RETRUN_FAILURE, e.getMessage());
        }
    }

    /**
     * <p>Title: </p>
     * <p>Description: 批量用户信息作废</p>
     * <p>Company: </p>
     * @param
     * @return
     * @author weil
     * @date 2019-02-27
     */
    @RequestMapping("delete")
    @ResponseBody
    public String delete(String ids) {
        if(StringUtils.isEmpty(ids)){
            return getResultJsonStr(Constants.RETRUN_FAILURE, "需要作废的id不存在！");
        }
        String[] split = ids.split(",");
        for (String s : split) {
            try {
                long id = Long.parseLong(s);
                sysUserService.delete(id);
            } catch (Exception e) {
                return getResultJsonStr(Constants.RETRUN_FAILURE, "作废失败！");
            }
        }
        return getResultJsonStr(Constants.RETURN_SUCCESS, "操作成功！");
    }

    /**
     * <p>Title: </p>
     * <p>Description: 添加用户页面打开</p>
     * <p>Company: </p>
     * @param
     * @return
     * @author weil
     * @date 2019-02-23
     */
    @RequestMapping("addPage")
    public String addPage(){
        return "sys/user-detail";
    }
    /**
     * <p>Title: </p>
     * <p>Description: 打开编辑用户信息页面</p>
     * <p>Company: </p>
     * @param
     * @return
     * @author weil
     * @date 2019-03-05
     */
    @RequestMapping("updatePage")
    public String updatePage(Long id){
        TSysUser tSysUser = sysUserService.queryById(id);
        getRequest().setAttribute("user", tSysUser);
        return "sys/user-detail";
    }

    /**
     * <p>Title: </p>
     * <p>Description: 跳转分配页面</p>
     * <p>Company: </p>
     * @param
     * @return
     * @author weil
     * @date 2019-03-15
     */
    @RequestMapping("allotPage")
    public String allotPage(Long id){
        getRequest().setAttribute("userId", id);
        return "sys/user-allot";
    }
    /**
     * <p>Title: </p>
     * <p>Description: 查询用户绑定的角色</p>
     * <p>Company: </p>
     * @param
     * @return
     * @author weil
     * @date 2019-03-15
     */
    @RequestMapping("queryRole")
    @ResponseBody
    public String queryRole(Long userId) {
        List<TSysUserRole> sysUserRoles = sysUserService.getUserRolesByUserId(userId);
        return getResultJsonStr(Constants.RETURN_SUCCESS, "返回成功！", sysUserRoles);
    }
    /**
     * <p>Title: </p>
     * <p>Description: 角色分配</p>
     * <p>Company: </p>
     * @param
     * @return
     * @author weil
     * @date 2019-03-16
     */
    @RequestMapping("allotRoles")
    @ResponseBody
    public String allotRoles(Long userId, String roleIds) {
        String[] split = roleIds.split(",");
        try {
            //根据用户id删除用户对应角色表信息
            sysUserService.delUserRolesByUserId(userId);
            //添加用户对应角色信息
            if(split.length>0 && split[0] != "")
                for (String str : split) {
                    TSysUserRole sysUserRole = new TSysUserRole();
                    sysUserRole.setUserId(userId);
                    sysUserRole.setRoleId(Long.parseLong(str));
                    sysUserService.save(sysUserRole);
                }
        } catch (Exception e) {
            return getResultJsonStr(Constants.RETRUN_FAILURE, "分配角色失败！"+e.getMessage());
        }
        return getResultJsonStr(Constants.RETURN_SUCCESS, "分配角色成功！");
    }

    /**
     * <p>Title: </p>
     * <p>Description: 跳转密码修改页面</p>
     * <p>Company: </p>
     * @param
     * @return
     * @author weil
     * @date 2019-03-27
     */
    @RequestMapping("pwdPage")
    public String pwdPage(){
        return "sys/user-pwd";
    }

    /**
     * <p>Title: </p>
     * <p>Description: 用户修改密码</p>
     * <p>Company: </p>
     * @param
     * @return
     * @author weil
     * @date 2019-03-28
     */
    @RequestMapping("updatePwd")
    @ResponseBody
    public String updatePwd(TSysUserCustom user){
        try {
            user.setId(getActiveUser().getId());
            sysUserService.updatePwd(user);
        } catch (Exception e) {
            return getResultJsonStr(Constants.RETRUN_FAILURE, e.getMessage());
        }
        return getResultJsonStr(Constants.RETURN_SUCCESS, "修改成功！");
    }

    /**
     * <p>Title: </p>
     * <p>Description: 跳转个人信息页面</p>
     * <p>Company: </p>
     * @param
     * @return
     * @author weil
     * @date 2019-03-28
     */
    @RequestMapping("selfPage")
    public String selfPage(){
        TSysUserCustom tSysUserCustom = sysUserService.queryById2(getActiveUser().getId());
        getRequest().setAttribute("user", tSysUserCustom);
        return "sys/self-info";
    }

    /**
     * <p>Title: </p>
     * <p>Description: 用户图片上传</p>
     * <p>Company: </p>
     * @param
     * @return
     * @author weil
     * @date 2019-04-02
     */
    @RequestMapping("iconUpload")
    @ResponseBody
    public String iconUpload(MultipartFile file){
        String filename = file.getOriginalFilename();
        try {
            //后缀
            String suffix = filename.substring(filename.indexOf("."));
            String dirStr = PropertiesUtils.getFileValue("user-icon-dir")+getActiveUser().getId()+"/";
            File fileDir = new File(dirStr);
            if(!fileDir.exists()){
                fileDir.mkdirs();
            }
            String newFileName = System.currentTimeMillis() + suffix;
            file.transferTo(new File(dirStr, newFileName));
            //更新用户头像地址
            TSysUser tSysUser = new TSysUser();
            tSysUser.setId(getActiveUser().getId());
            tSysUser.setIconUrl(newFileName);
            sysUserService.update(tSysUser);
        } catch (Exception e) {
            return getResultJsonStr(Constants.RETRUN_FAILURE, e.getMessage());
        }

        return getResultJsonStr(Constants.RETURN_SUCCESS, "头像上传成功！");
    }

    /**
     * <p>Title: </p>
     * <p>Description: 基本信息页</p>
     * <p>Company: </p>
     * @param
     * @return
     * @author weil
     * @date 2019-04-02
     */
    @RequestMapping("baseInfoPage")
    public String baseInfoPage(Long id){
        TSysUserCustom userCustom = sysUserService.queryById2(id);
        //生成完整图片url
        String iconUrl = null;
        if(StringUtils.isNotEmpty(userCustom.getIconUrl())){
            //图片不为空，则拼接服务器图片地址
            try {
                iconUrl = PropertiesUtils.getFileValue("user-icon-url")+userCustom.getId()+"/"+userCustom.getIconUrl();
            } catch (Exception e) {
                return getResultJsonStr(Constants.RETRUN_FAILURE, "头像地址获取出错！");
            }
        }
        userCustom.setIconUrl(iconUrl);
        getRequest().setAttribute("user", userCustom);
        return "sys/info";
    }
    /**
     * <p>Title: </p>
     * <p>Description: 用户选择器界面</p>
     * <p>Company: </p>
     * @param
     * @return
     * @author weil
     * @date 2019-04-15
     */
    @RequestMapping("selectorPage")
    public String selectorPage(){
        return "sys/user-selector";
    }
}
