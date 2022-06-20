package com.zhangsc.controller.customer;

import com.zhangsc.controller.BaseController;
import com.zhangsc.controller.BaseInterface;
import com.zhangsc.pojo.customer.TCusContactCustom;
import com.zhangsc.service.ContactService;
import com.zhangsc.utils.Constants;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Date;
import java.util.List;

/**
 * <p>Title: 客户联系人Controller</p>
 * <p>Description: </p>
 * <p>Company: </p>
 *
 * @author yyc
 * @date 2019-04-10
 */
@Controller
@RequestMapping("contact")
public class ContactController extends BaseController implements BaseInterface<TCusContactCustom> {

    @Autowired
    private ContactService contactService;

    /**
     * 进入联系人页面
     */
    @RequestMapping("page")
    public String page() {
        return "customer/contact";
    }

    /**
     * 进入添加联系人界面
     */
    @RequestMapping("addPage")
    public String addPage() {
        return "customer/contact_add";
    }

    /**
     * 进入联系人详情页面
     */
    @RequestMapping("frompage")
    public String frompage() {
        return "customer/contact_from";
    }

    /**
     * 查询联系人
     */
    @RequestMapping("query")
    @ResponseBody


    public String query(TCusContactCustom tCusContact) {
        startPagination();



        List<TCusContactCustom> list = contactService.query(tCusContact);

        return getResultJsonStr(Constants.RETURN_SUCCESS, "操作成功", list);
    }

    /**
     * <p>Title: </p>
     * <p>Description: 插入联系人</p>
     * <p>Company: </p>
     *
     * @param
     * @return
     * @author yyc
     * @date 2019-04-11
     */
    @RequestMapping("save")
    @ResponseBody
    public String save(TCusContactCustom tCusContact) {

        try {
            contactService.updateFirstContact(tCusContact);
        } catch (Exception e) {
        }


        tCusContact.setCreateTime(new Date());
        tCusContact.setModifyTime(new Date());

        tCusContact.setCreateBy(getActiveUser().getId());
        try {
            contactService.save(tCusContact);
        } catch (Exception e) {
            return getResultJsonStr(Constants.RETRUN_FAILURE, "添加失败" + e.getMessage());
        }
        return getResultJsonStr(Constants.RETURN_SUCCESS, "添加成功");
    }

    /**
     * <p>Title: </p>
     * <p>Description: 更新联系人页面</p>
     * <p>Company: </p>
     *
     * @param
     * @return
     * @author yyc
     * @date 2019-04-11
     */
    @RequestMapping("updatePage")
    public String updatePage(Long id) {
        TCusContactCustom contact = contactService.queryById(id);
        getRequest().setAttribute("contact", contact);
        return "customer/contact_add";
    }

    /**
     * <p>Title: </p>
     * <p>Description: 根据id查联系人</p>
     * <p>Company: </p>
     *
     * @param
     * @return
     * @author yyc
     * @date 2019-04-11
     */
    @RequestMapping("queryById")
    public String queryById(Long id) {

        TCusContactCustom contact = contactService.queryById(id);
        getRequest().setAttribute("contact", contact);
        return "customer/contact_show";
    }



    /**
     * <p>Title: </p>
     * <p>Description: 编辑联系人</p>
     * <p>Company: </p>
     *
     * @param
     * @return
     * @author yyc
     * @date 2019-04-12
     */
    @RequestMapping("update")
    @ResponseBody
    public String update(TCusContactCustom tCusContact) {
        try {
            contactService.updateFirstContact(tCusContact);
        } catch (Exception e) {
        }

        try {
            contactService.update(tCusContact);
        } catch (Exception e) {
            return getResultJsonStr(Constants.RETRUN_FAILURE, "操作失败" + e.getMessage());
        }
        return getResultJsonStr(Constants.RETURN_SUCCESS, "操作成功");
    }

    /**
     * <p>Title: </p>
     * <p>Description: 添加设为首要联系人</p>
     * <p>Company: </p>
     *
     * @param
     * @return
     * @author yyc
     * @date 2019-04-19
     */
    @RequestMapping("updateFirstContact")
    @ResponseBody
    public String updateFirstContact(TCusContactCustom tCusContact){

        try {

            contactService.updateFirstContact(tCusContact);
        } catch (Exception e) {
            return getResultJsonStr(Constants.RETRUN_FAILURE, "操作失败" + e.getMessage());
        }
        return getResultJsonStr(Constants.RETURN_SUCCESS, "操作成功");
    }


    /**
     * <p>Title: </p>
     * <p>Description: 设为首要联系人</p>
     * <p>Company: </p>
     *
     * @param
     * @return
     * @author yyc
     * @date 2019-04-19
     */

    @RequestMapping("updateSet1")
    @ResponseBody
    public String updateFirstContact1(TCusContactCustom tCusContact){
        try {
        contactService.updateSet0(tCusContact);
        } catch (Exception e) {

        }

        try {

            contactService.updateSet1(tCusContact);
        } catch (Exception e) {
            return getResultJsonStr(Constants.RETRUN_FAILURE, "操作失败" + e.getMessage());
        }
        return getResultJsonStr(Constants.RETURN_SUCCESS, "操作成功");
    }
    /**
     * <p>Title: </p>
     * <p>Description: 联系人删除</p>
     * <p>Company: </p>
     *
     * @param
     * @return
     * @author yyc
     * @date 2019-04-13
     */

    @RequestMapping("delete")
    @ResponseBody
    public String delete(String ids) {
        if (StringUtils.isEmpty(ids)) {
            return getResultJsonStr(Constants.RETRUN_FAILURE, "需要删除的id不存在");

        }
        String[] split = ids.split(",");
        for (String s : split) {
            try {
                long id = Long.parseLong(s);
                contactService.delete(id);
            } catch (Exception e) {
                return getResultJsonStr(Constants.RETRUN_FAILURE, "删除失败");

            }
        }
        return getResultJsonStr(Constants.RETURN_SUCCESS, "操作成功");
    }

    /**
     * <p>Title: </p>
     * <p>Description: 页面跳转</p>
     * <p>Company: </p>
     *
     * @param
     * @return
     * @author yyc
     * @date 2019-04-16
     */
    @RequestMapping("createrPage")
        public String createrPage(){

        return "customer/contact_from";
    }

    @RequestMapping("contactPage")
    public String contactPage(Long cusId){

        getRequest().setAttribute("cusId",cusId);

        return "customer/follow_from";
    }
    /**
     * 跳转地图页面
     */
    @RequestMapping("map")
    public String map(String address) {
        String addr = decode(address);
        getRequest().setAttribute("map", addr);
        return "customer/map";
    }


}
