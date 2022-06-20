package com.zhangsc.controller.sys;

import com.zhangsc.controller.BaseController;
import com.zhangsc.controller.BaseInterface;
import com.zhangsc.pojo.sys.TSysDept;
import com.zhangsc.service.SysDeptService;
import com.zhangsc.utils.Constants;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * <p>Title: </p>
 * <p>Description: 部门Controller</p>
 * <p>Company: </p>
 * @param
 * @return
 * @author weil
 * @date 2019-03-09
 */
@Controller
@RequestMapping("dept")
public class DeptController extends BaseController implements BaseInterface<TSysDept> {
    @Autowired
    private SysDeptService sysDeptService;
    /**
     * <p>Title: </p>
     * <p>Description: 部门设置页面</p>
     * <p>Company: </p>
     * @param
     * @return
     * @author weil
     * @date 2019-03-09
     */
    @RequestMapping("page")
    public String page() {
        return "sys/dept";
    }

    /**
     * <p>Title: </p>
     * <p>Description: 部门查询功能</p>
     * <p>Company: </p>
     * @param
     * @return
     * @author weil
     * @date 2019-03-09
     */
    @RequestMapping("query")
    @ResponseBody
    public String query(TSysDept dept) {
        try {
            List<TSysDept> query = sysDeptService.query(dept);
            return getResultJsonStr(Constants.RETURN_SUCCESS, "返回成功！", query);
        } catch (Exception e) {
            return getResultJsonStr(Constants.RETRUN_FAILURE, e.getMessage());
        }
    }

    /**
     * <p>Title: </p>
     * <p>Description: 保存部门</p>
     * <p>Company: </p>
     * @param
     * @return
     * @author weil
     * @date 2019-03-09
     */
    @RequestMapping("save")
    @ResponseBody
    public String save(TSysDept dept) {
        try {
            dept.setCreateBy(getActiveUser().getId());
            sysDeptService.save(dept);
            return getResultJsonStr(Constants.RETURN_SUCCESS, "操作成功！");
        } catch (Exception e) {
            return getResultJsonStr(Constants.RETRUN_FAILURE, e.getMessage());
        }
    }

    /**
     * <p>Title: </p>
     * <p>Description: 更新部门</p>
     * <p>Company: </p>
     * @param
     * @return
     * @author weil
     * @date 2019-03-09
     */
    @RequestMapping("update")
    @ResponseBody
    public String update(TSysDept dept) {
        try {
            sysDeptService.update(dept);
            return getResultJsonStr(Constants.RETURN_SUCCESS, "操作成功！");
        } catch (Exception e) {
            return getResultJsonStr(Constants.RETRUN_FAILURE, e.getMessage());
        }
    }

    /**
     * <p>Title: </p>
     * <p>Description: 批量删除部门</p>
     * <p>Company: </p>
     * @param
     * @return
     * @author weil
     * @date 2019-03-09
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
                sysDeptService.delete(id);
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
     * @date 2019-03-09
     */
    @RequestMapping("addPage")
    public String addPage(TSysDept dept){
        getRequest().setAttribute("dept", dept);
        return "sys/dept-detail";
    }

    /**
     * <p>Title: </p>
     * <p>Description: 打开更新页面</p>
     * <p>Company: </p>
     * @param
     * @return
     * @author weil
     * @date 2019-03-09
     */
    @RequestMapping("updatePage")
    public String updatePage(Long id){
        TSysDept dept = sysDeptService.queryById(id);
        getRequest().setAttribute("dept", dept);
        return "sys/dept-detail";
    }
}
