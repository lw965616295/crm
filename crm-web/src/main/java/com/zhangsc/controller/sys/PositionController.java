package com.zhangsc.controller.sys;

import com.zhangsc.controller.BaseController;
import com.zhangsc.controller.BaseInterface;
import com.zhangsc.pojo.sys.TSysPosition;
import com.zhangsc.service.SysPositionService;
import com.zhangsc.utils.Constants;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * <p>Title: </p>
 * <p>Description: 岗位Controller</p>
 * <p>Company: </p>
 * @param
 * @return
 * @author weil
 * @date 2019-03-11
 */
@Controller
@RequestMapping("position")
public class PositionController extends BaseController implements BaseInterface<TSysPosition> {
    @Autowired
    private SysPositionService sysPositionService;
    /**
     * <p>Title: </p>
     * <p>Description: 岗位设置页面</p>
     * <p>Company: </p>
     * @param
     * @return
     * @author weil
     * @date 2019-03-11
     */
    @RequestMapping("page")
    public String page() {
        return "sys/position";
    }

    /**
     * <p>Title: </p>
     * <p>Description: 岗位查询功能</p>
     * <p>Company: </p>
     * @param
     * @return
     * @author weil
     * @date 2019-03-11
     */
    @RequestMapping("query")
    @ResponseBody
    public String query(TSysPosition position) {
        try {
            List<TSysPosition> query = sysPositionService.query(position);
            return getResultJsonStr(Constants.RETURN_SUCCESS, "返回成功！", query);
        } catch (Exception e) {
            return getResultJsonStr(Constants.RETRUN_FAILURE, e.getMessage());
        }
    }

    /**
     * <p>Title: </p>
     * <p>Description: 保存岗位</p>
     * <p>Company: </p>
     * @param
     * @return
     * @author weil
     * @date 2019-03-11
     */
    @RequestMapping("save")
    @ResponseBody
    public String save(TSysPosition position) {
        try {
            sysPositionService.save(position);
            return getResultJsonStr(Constants.RETURN_SUCCESS, "操作成功！");
        } catch (Exception e) {
            return getResultJsonStr(Constants.RETRUN_FAILURE, e.getMessage());
        }
    }

    /**
     * <p>Title: </p>
     * <p>Description: 更新岗位</p>
     * <p>Company: </p>
     * @param
     * @return
     * @author weil
     * @date 2019-03-11
     */
    @RequestMapping("update")
    @ResponseBody
    public String update(TSysPosition position) {
        try {
            sysPositionService.update(position);
            return getResultJsonStr(Constants.RETURN_SUCCESS, "操作成功！");
        } catch (Exception e) {
            return getResultJsonStr(Constants.RETRUN_FAILURE, e.getMessage());
        }
    }

    /**
     * <p>Title: </p>
     * <p>Description: 批量删除岗位</p>
     * <p>Company: </p>
     * @param
     * @return
     * @author weil
     * @date 2019-03-11
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
                sysPositionService.delete(id);
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
     * @date 2019-03-11
     */
    @RequestMapping("addPage")
    public String addPage(TSysPosition position){
        getRequest().setAttribute("position", position);
        return "sys/position-detail";
    }

    /**
     * <p>Title: </p>
     * <p>Description: 打开更新页面</p>
     * <p>Company: </p>
     * @param
     * @return
     * @author weil
     * @date 2019-03-11
     */
    @RequestMapping("updatePage")
    public String updatePage(Long id){
        TSysPosition position = sysPositionService.queryById(id);
        getRequest().setAttribute("position", position);
        return "sys/position-detail";
    }
}
