package com.zhangsc.controller.customer;

import com.zhangsc.controller.BaseController;
import com.zhangsc.controller.BaseInterface;
import com.zhangsc.pojo.customer.TCusCustomerCustom;
import com.zhangsc.pojo.customer.TCusFollowLog;
import com.zhangsc.pojo.customer.TCusFollowLogCustom;
import com.zhangsc.service.CustomerService;
import com.zhangsc.utils.Constants;
import com.zhangsc.utils.ImportExcelUntil;
import com.zhangsc.utils.PropertiesUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * <p>Title: </p>
 * <p>Description: 客户功能Controller</p>
 * <p>Company: </p>
 * @param
 * @return
 * @author weil
 * @date 2019-04-11
 */
@Controller
@RequestMapping("customer")
public class CustomerController extends BaseController implements BaseInterface<TCusCustomerCustom> {
    @Autowired
    private CustomerService customerService;

    /**
     * <p>Title: </p>
     * <p>Description: 跳转客户界面</p>
     * <p>Company: </p>
     * @param
     * @return
     * @author weil
     * @date 2019-04-11
     */
    @RequestMapping("page")
    public String page() {
        return "customer/customer";
    }

    /**
     * <p>Title: </p>
     * <p>Description: 查询领用客户</p>
     * <p>Company: </p>
     * @param
     * @return
     * @author weil
     * @date 2019-04-11
     */
    @RequestMapping("query")
    @ResponseBody
    public String query(TCusCustomerCustom cus) {
        startPagination();

        //负责人
        cus.setLeader(getActiveUser().getId());
        //模糊下属职位id
        cus.setSubPositionId(getActiveUser().getPositionId()+"_%");
        //放回周期
        Integer dueDay = 0;
        try {
            String d = PropertiesUtils.getCrmPros("date-remain");
            dueDay = Integer.parseInt(d);
        } catch (Exception e) {
            e.printStackTrace();
        }
        cus.setDueDay(dueDay);
        List<TCusCustomerCustom> list = customerService.query(cus);
        return getResultJsonStr(Constants.RETURN_SUCCESS, "操作成功！", list);
    }

    /**
     * <p>Title: </p>
     * <p>Description: 添加客户</p>
     * <p>Company: </p>
     * @param
     * @return
     * @author weil
     * @date 2019-04-11
     */
    @RequestMapping("save")
    @ResponseBody
    public String save(TCusCustomerCustom cus) {
        //判断客户名是否重复
        TCusCustomerCustom c1 = new TCusCustomerCustom();
        c1.setCusName(cus.getCusName());

        if(StringUtils.isNotEmpty(cus.getCusName())) {
            List<TCusCustomerCustom> cuss = customerService.query(c1);
            if (cuss != null && cuss.size() > 0) {
                return getResultJsonStr(Constants.RETRUN_FAILURE, "客户名已存在！");
            }
        }

       //判断客户编码是否存在
        TCusCustomerCustom c2 = new TCusCustomerCustom();
        c2.setCusCode(cus.getCusCode());
        List<TCusCustomerCustom> cus2 = customerService.query(c2);
        if (cus2 != null && cus2.size() > 0) {
            return getResultJsonStr(Constants.RETRUN_FAILURE, "客户编码已存在！");
        }

        //判断是否领用还是放回线索池
        if (cus.getLeader() == null) {
            //放回线索池
            cus.setStatus(1);
        } else {
            cus.setStatus(2);
        }
        //其他信息添加
        cus.setCreateBy(getActiveUser().getId());
        cus.setCreateTime(new Date());
        cus.setModifyTime(new Date());

        try {
            customerService.save(cus);
        } catch (Exception e) {
            return getResultJsonStr(Constants.RETRUN_FAILURE, "操作失败！" + e.getMessage());
        }
        return getResultJsonStr(Constants.RETURN_SUCCESS, "操作成功",cus.getId());
    }

    /**
     * <p>Title: </p>
     * <p>Description: 更新客户信息</p>
     * <p>Company: </p>
     * @param
     * @return
     * @author weil
     * @date 2019-04-11
     */
    @RequestMapping("update")
    @ResponseBody
    public String update(TCusCustomerCustom cus) {

        TCusCustomerCustom c1 = new TCusCustomerCustom();
        c1.setCusName(cus.getCusName());

        if(StringUtils.isNotEmpty(cus.getCusName())) {
            List<TCusCustomerCustom> cuss = customerService.query(c1);
            for(TCusCustomerCustom cus2 :cuss){

            if (cuss != null && cuss.size() > 1) {
                return getResultJsonStr(Constants.RETRUN_FAILURE, "客户名已存在！");
            }else if (cus.getId().equals(cus2.getId())){

            }else{
                return getResultJsonStr(Constants.RETRUN_FAILURE, "客户名已存在！");
            }
        }
        }
        try {
            customerService.update(cus);
        } catch (Exception e) {
            return getResultJsonStr(Constants.RETRUN_FAILURE, "操作失败！" + e.getMessage());
        }
        return getResultJsonStr(Constants.RETURN_SUCCESS, "操作成功！");
    }

    /**
     * <p>Title: </p>
     * <p>Description: 客户删除</p>
     * <p>Company: </p>
     * @param
     * @return
     * @author weil
     * @date 2019-04-11
     */
    @RequestMapping("delete")
    @ResponseBody
    public String delete(String ids) {
        if (StringUtils.isEmpty(ids)) {
            return getResultJsonStr(Constants.RETRUN_FAILURE, "需要删除的id不存在！");
        }
        String[] split = ids.split(",");
        for (String s : split) {
            try {
                long id = Long.parseLong(s);
                customerService.delete(id);
            } catch (Exception e) {
                return getResultJsonStr(Constants.RETRUN_FAILURE, "删除失败！" + e.getMessage());
            }
        }
        return getResultJsonStr(Constants.RETURN_SUCCESS, "操作成功！");
    }

    /**
     * <p>Title: </p>
     * <p>Description: 跳转添加客户页面</p>
     * <p>Company: </p>
     * @param
     * @return
     * @author weil
     * @date 2019-04-11
     */
    @RequestMapping("addPage")
    public String addPage() {
        //获取随机客户编码 zsc20190412-1
        /*查询当天创建的客户里最晚的那个编码*/
        String cusCode = customerService.randomCusCode("zsc");
        getRequest().setAttribute("cusCode", cusCode);
        return "customer/customer-add";
    }

    /**
     * <p>Title: </p>
     * <p>Description: 跳转客户更新界面</p>
     * <p>Company: </p>
     * @param
     * @return
     * @author weil
     * @date 2019-04-11
     */
    @RequestMapping("updatePage")
    public String updatePage(Long id) {
        TCusCustomerCustom cus = customerService.queryById(id);
        getRequest().setAttribute("cus", cus);
        return "customer/customer-add";
    }

    /**
     * <p>Title: </p>
     * <p>Description: 客户详情页面</p>
     * <p>Company: </p>
     * @param
     * @return
     * @author weil
     * @date 2019-04-13
     */
    @RequestMapping("cusDetailPage")
    public String cusDetailPage(Long id) {
        TCusCustomerCustom cus = customerService.queryById(id);
        getRequest().setAttribute("cus", cus);
        return "customer/customer-detail";
    }

    /**
     * <p>Title: </p>
     * <p>Description: 查询跟进记录或日程</p>
     * <p>Company: </p>
     * @param
     * @return
     * @author weil
     * @date 2019-04-13
     */
    @RequestMapping("queryFollowLog")
    @ResponseBody
    public String queryFollowLog(TCusFollowLog followLog) {
        List<TCusFollowLogCustom> logs = customerService.query(followLog);
        //处理头像地址
        for (TCusFollowLogCustom log : logs) {
            String iconUrl = null;
            if (StringUtils.isNotEmpty(log.getIconUrl())) {
                //图片不为空，则拼接服务器图片地址
                try {
                    iconUrl = PropertiesUtils.getFileValue("user-icon-url") + log.getCreateBy() + "/" + log.getIconUrl();
                } catch (Exception e) {
                    return getResultJsonStr(Constants.RETRUN_FAILURE, "头像地址获取出错！");
                }
            }
            log.setIconUrl(iconUrl);
        }
        return getResultJsonStr(Constants.RETURN_SUCCESS, "操作成功！", logs);
    }

    /**
     * <p>Title: </p>
     * <p>Description: 新增客户跟进日志或日程</p>
     * <p>Company: </p>
     * @param
     * @return
     * @author weil
     * @date 2019-04-13
     */
    @RequestMapping("saveFollowLog")
    @ResponseBody
    public String saveFollowLog(TCusFollowLog followLog) {
        try {
            followLog.setCreateBy(getActiveUser().getId());
            followLog.setCreateTime(new Date());
            customerService.save(followLog);
            logger.info("followLog.id--------------->" + followLog.getId());

            //跟进日志产生，更新客户更新时间
            TCusCustomerCustom cus = new TCusCustomerCustom();
            cus.setId(followLog.getCusId());
            cus.setModifyTime(new Date());
            customerService.update(cus);
        } catch (Exception e) {
            return getResultJsonStr(Constants.RETRUN_FAILURE, "操作失败！" + e.getMessage());
        }
        return getResultJsonStr(Constants.RETURN_SUCCESS, "操作成功！", followLog.getId());
    }

    /**
     * <p>Title: </p>
     * <p>Description: 删除跟进日志</p>
     * <p>Company: </p>
     *
     * @param
     * @return
     * @author weil
     * @date 2019-04-13
     */
    @RequestMapping("deleteFollowLog")
    @ResponseBody
    public String deleteFollowLog(String ids) {
        if (StringUtils.isEmpty(ids)) {
            return getResultJsonStr(Constants.RETRUN_FAILURE, "需要删除的id不存在！");
        }
        String[] split = ids.split(",");
        for (String s : split) {
            try {
                long id = Long.parseLong(s);
                customerService.deleteLog(id);
            } catch (Exception e) {
                return getResultJsonStr(Constants.RETRUN_FAILURE, "删除失败！" + e.getMessage());
            }
        }
        return getResultJsonStr(Constants.RETURN_SUCCESS, "操作成功！");
    }

    /**
     * <p>Title: </p>
     * <p>Description: 跳转客户池</p>
     * <p>Company: </p>
     * @param
     * @return
     * @author weil
     * @date 2019-04-14
     */
    @RequestMapping("poolPage")
    public String poolPage() {
        return "customer/customer-pool";
    }

    /**
     * <p>Title: </p>
     * <p>Description: 查询客户池</p>
     * <p>Company: </p>
     * @param
     * @return
     * @author weil
     * @date 2019-04-14
     */
    @RequestMapping("queryPool")
    @ResponseBody
    public String queryPool(TCusCustomerCustom tCusCustomerCustom) {
        startPagination();
        List<TCusCustomerCustom> list = customerService.query(tCusCustomerCustom);
        return getResultJsonStr(Constants.RETURN_SUCCESS, "操作成功！", list);
    }

    /**
     * <p>Title: </p>
     * <p>Description: 放回客户池</p>
     * <p>Company: </p>
     * @param
     * @return
     * @author weil
     * @date 2019-04-14
     */
    @RequestMapping("toPool")
    @ResponseBody
    public String toPool(String ids) {
        if (StringUtils.isEmpty(ids)) {
            return getResultJsonStr(Constants.RETRUN_FAILURE, "需要操作的id不存在！");
        }
        String[] split = ids.split(",");
        for (String s : split) {
            try {
                long id = Long.parseLong(s);
                //将该领用人添加的多余（大于当天的）日程删除
                TCusFollowLogCustom followLogCustom = new TCusFollowLogCustom();
                followLogCustom.setCusId(id);
                customerService.cusPlanDel(followLogCustom);

                //返回客户池操作
                TCusCustomerCustom cus = new TCusCustomerCustom();
                cus.setId(id);
                cus.setStatus(1);
                customerService.toPool(cus);
            } catch (Exception e) {
                return getResultJsonStr(Constants.RETRUN_FAILURE, "操作失败！" + e.getMessage());
            }
        }
        return getResultJsonStr(Constants.RETURN_SUCCESS, "操作成功！");
    }

    /**
     * <p>Title: </p>
     * <p>Description: 领用客户</p>
     * <p>Company: </p>
     * @param
     * @return
     * @author weil
     * @date 2019-04-14
     */
    @RequestMapping("receive")
    @ResponseBody
    public String receive(String ids){
        if (StringUtils.isEmpty(ids)) {
            return getResultJsonStr(Constants.RETRUN_FAILURE, "需要操作的id不存在！");
        }
        String[] split = ids.split(",");
        for (String s : split) {
            try {
                long id = Long.parseLong(s);
                TCusCustomerCustom cus = new TCusCustomerCustom();
                cus.setId(id);
                cus.setStatus(2);
                cus.setLeader(getActiveUser().getId());
                cus.setModifyTime(new Date());
                customerService.update(cus);
            } catch (Exception e) {
                return getResultJsonStr(Constants.RETRUN_FAILURE, "操作失败！" + e.getMessage());
            }
        }
        return getResultJsonStr(Constants.RETURN_SUCCESS, "操作成功！");
    }

    @RequestMapping("allotUser")
    @ResponseBody
    public String receive(String ids,Long leader){
        if (StringUtils.isEmpty(ids)) {
            return getResultJsonStr(Constants.RETRUN_FAILURE, "需要操作的id不存在！");
        }
        String[] split = ids.split(",");
        for (String s : split) {
            try {
                long id = Long.parseLong(s);
                TCusCustomerCustom cus = new TCusCustomerCustom();
                cus.setId(id);
                cus.setStatus(2);
                cus.setLeader(leader);
                cus.setModifyTime(new Date());
                customerService.update(cus);
            } catch (Exception e) {
                return getResultJsonStr(Constants.RETRUN_FAILURE, "操作失败！" + e.getMessage());
            }
        }
        return getResultJsonStr(Constants.RETURN_SUCCESS, "操作成功！");
    }

    /**
     * <p>Title: </p>
     * <p>Description: excel文件导入客户</p>
     * <p>Company: </p>
     * @param
     * @return
     * @author weil
     * @date 2019-04-15
     */
    @RequestMapping("importCus")
    @ResponseBody
    public String importCus(MultipartFile file){
        List<TCusCustomerCustom> cuss = new ArrayList<>();

        if (file != null) {
            String[][] sheetData = ImportExcelUntil.getExcelData(file);
            for(int x=0;x<sheetData.length;x++){
                TCusCustomerCustom cus = new TCusCustomerCustom();
                //客户名

                   //判断客户名是否重复
                   TCusCustomerCustom c2 = new TCusCustomerCustom();
                   c2.setCusName(sheetData[x][0]);
                   if (StringUtils.isNotEmpty(sheetData[x][0])) {
                       List<TCusCustomerCustom> tcs2 = customerService.query(c2);
                       if (tcs2 != null && tcs2.size() > 0) {
                           return getResultJsonStr(Constants.RETRUN_FAILURE, "第" + (x + 1) + "行【客户名称：" + sheetData[x][0] + "】已经存在！");
                       }
                   }
                cus.setCusName(sheetData[x][0]);
                //客户编号
                if(StringUtils.isBlank(sheetData[x][1])){
                    //如果编号为空，自动生成
                    cus.setCusCode(customerService.randomCusCode("zsc"));
                }else {
                    //判断是否编号重复
                    TCusCustomerCustom c1 = new TCusCustomerCustom();
                    c1.setCusCode(cus.getCusCode());
                    List<TCusCustomerCustom> tcs = customerService.query(c1);
                    if (tcs != null && tcs.size() > 0) {
                        return getResultJsonStr(Constants.RETRUN_FAILURE, "客户编码已存在！");
                    }
                    cus.setCusCode(sheetData[x][1]);
                }
                //客户状态
                if(StringUtils.isNotBlank(sheetData[x][2])){
                    cus.setCusStatus(sheetData[x][2]);
                }
                //客户行业
                if(StringUtils.isNotBlank(sheetData[x][3])){
                    cus.setCusBelong(sheetData[x][3]);
                }
                //所在地址
                if(StringUtils.isNotBlank(sheetData[x][4])){
                    cus.setAddress(sheetData[x][4]);
                }
                //客户信息来源
                if(StringUtils.isBlank(sheetData[x][5])){
                    return getResultJsonStr(Constants.RETRUN_FAILURE, "第"+(x+1)+"行【客户信息来源】为空，请校验！");
                }
                cus.setInfoFrom(sheetData[x][5]);
                //客户等级
                if(StringUtils.isNotBlank(sheetData[x][6])){
                    Integer cusGrade = null;
                    try {
                        cusGrade = Integer.parseInt(sheetData[x][6]);
                    } catch (Exception e) {
                        e.printStackTrace();
                        return getResultJsonStr(Constants.RETRUN_FAILURE, "第"+(x+1)+"行【客户等级】只能为数字，请校验！");
                    }
                    cus.setCusGrade(cusGrade);
                }
                //员工数
                if(StringUtils.isNotBlank(sheetData[x][7])){
                    cus.setStaffNum(sheetData[x][7]);
                }
                //备注
                if(StringUtils.isNotBlank(sheetData[x][8])){
                    cus.setRemark(sheetData[x][8]);
                }

                cus.setCreateBy(getActiveUser().getId());
                cus.setCreateTime(new Date());
                cus.setModifyTime(new Date());
                cus.setStatus(1);

                cuss.add(cus);
            }
        }else{
            return  getResultJsonStr(Constants.RETRUN_FAILURE,"文件为空");
        }

        for (TCusCustomerCustom cus : cuss) {
            try{
                customerService.save(cus);
            } catch (Exception e){
                e.printStackTrace();
                return getResultJsonStr(Constants.RETRUN_FAILURE, e.getMessage());
            }
        }
        return getResultJsonStr(Constants.RETURN_SUCCESS, "已导入"+cuss.size()+"条数据");
    }

    /**
     * <p>Title: </p>
     * <p>Description: 客户置顶操作</p>
     * <p>Company: </p>
     * @param
     * @return
     * @author weil
     * @date 2019-04-17
     */
    @RequestMapping("totop")
    @ResponseBody
    public String totop(TCusCustomerCustom cus){
        try {
            if(cus.getTopStatus()){
             //需要置顶
                cus.setTotop(new Date());
            }
            customerService.totop(cus);
        } catch (Exception e) {
            return getResultJsonStr(Constants.RETRUN_FAILURE, "操作失败！" + e.getMessage());
        }
        return getResultJsonStr(Constants.RETURN_SUCCESS, "操作成功！");
    }
}
