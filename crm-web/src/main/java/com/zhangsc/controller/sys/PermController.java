package com.zhangsc.controller.sys;

import com.zhangsc.controller.BaseController;
import com.zhangsc.controller.BaseInterface;
import com.zhangsc.pojo.sys.TSysPermission;
import com.zhangsc.service.SysPermService;
import com.zhangsc.utils.Constants;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * <p>Title: </p>
 * <p>Description: 权限资源Controller</p>
 * <p>Company: </p>
 *
 * @author weil
 * @date 2019-03-07
 */
@Controller
@RequestMapping("perm")
public class PermController extends BaseController implements BaseInterface<TSysPermission> {
    @Autowired
    private SysPermService sysPermService;
    /**
     * <p>Title: </p>
     * <p>Description: 权限资源页面</p>
     * <p>Company: </p>
     * @param
     * @return
     * @author weil
     * @date 2019-03-07
     */
    @RequestMapping("page")
    public String page() {
        return "sys/perm";
    }

    /**
     * <p>Title: </p>
     * <p>Description: 查询权限资源功能</p>
     * <p>Company: </p>
     * @param
     * @return
     * @author weil
     * @date 2019-03-07
     */
    @RequestMapping("query")
    @ResponseBody
    public String query(TSysPermission permission) {
        startPagination();
        try {
            List<TSysPermission> query = sysPermService.query(permission);
            return getResultJsonStr(Constants.RETURN_SUCCESS, "返回成功！", query);
        } catch (Exception e) {
            return getResultJsonStr(Constants.RETRUN_FAILURE, e.getMessage());
        }
    }

    /**
     * <p>Title: </p>
     * <p>Description: 保存权限资源</p>
     * <p>Company: </p>
     * @param
     * @return
     * @author weil
     * @date 2019-03-07
     */
    @RequestMapping("save")
    @ResponseBody
    public String save(TSysPermission permission) {
        try {
            sysPermService.save(permission);
            return getResultJsonStr(Constants.RETURN_SUCCESS, "操作成功！");
        } catch (Exception e) {
            return getResultJsonStr(Constants.RETRUN_FAILURE, e.getMessage());
        }
    }

    /**
     * <p>Title: </p>
     * <p>Description: 更新权限资源</p>
     * <p>Company: </p>
     * @param
     * @return
     * @author weil
     * @date 2019-03-07
     */
    @RequestMapping("update")
    @ResponseBody
    public String update(TSysPermission permission) {
        try {
            sysPermService.update(permission);
            return getResultJsonStr(Constants.RETURN_SUCCESS, "操作成功！");
        } catch (Exception e) {
            return getResultJsonStr(Constants.RETRUN_FAILURE, e.getMessage());
        }
    }

    /**
     * <p>Title: </p>
     * <p>Description: 批量删除权限资源</p>
     * <p>Company: </p>
     * @param
     * @return
     * @author weil
     * @date 2019-03-07
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
                sysPermService.delete(id);
            } catch (Exception e) {
                return getResultJsonStr(Constants.RETRUN_FAILURE, "删除失败！");
            }
        }
        return getResultJsonStr(Constants.RETURN_SUCCESS, "操作成功！");
    }

    /**
     * <p>Title: </p>
     * <p>Description: 打开新增页面</p>
     * <p>Company: </p>
     * @param
     * @return
     * @author weil
     * @date 2019-03-07
     */
    @RequestMapping("addPage")
    public String addPage(){
        return "sys/perm-detail";
    }

    /**
     * <p>Title: </p>
     * <p>Description: 打开更新页面</p>
     * <p>Company: </p>
     * @param
     * @return
     * @author weil
     * @date 2019-03-07
     */
    @RequestMapping("updatePage")
    public String updatePage(Long id){
        TSysPermission permission = sysPermService.queryById(id);
        getRequest().setAttribute("permission", permission);
        return "sys/perm-detail";
    }
}
