package com.zhangsc.controller.customer;

import com.zhangsc.controller.BaseController;
import com.zhangsc.controller.BaseInterface;
import com.zhangsc.pojo.customer.*;
import com.zhangsc.service.ClueService;
import com.zhangsc.service.ContactService;
import com.zhangsc.service.CustomerService;
import com.zhangsc.utils.Constants;
import com.zhangsc.utils.CustomException;
import com.zhangsc.utils.ImportExcelUntil;
import com.zhangsc.utils.PropertiesUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * <p>Title: 线索功能Controller</p>
 * <p>Description: </p>
 * <p>Company: </p>
 *
 * @author weil
 * @date 2019-04-02
 */
@Controller
@RequestMapping("clue")
public class ClueController extends BaseController implements BaseInterface<TCusClueCustom> {
    @Autowired
    private ClueService clueService;

    @Autowired
    private CustomerService customerService;

    @Autowired
    private ContactService contactService;

    /**
     * <p>Title: </p>
     * <p>Description: 跳转线索界面</p>
     * <p>Company: </p>
     *
     * @param
     * @return
     * @author weil
     * @date 2019-04-03
     */
    @RequestMapping("page")
    public String page() {
        return "customer/clue/clue";
    }

    /**
     * <p>Title: </p>
     * <p>Description: 查询领用线索</p>
     * <p>Company: </p>
     *
     * @param
     * @return
     * @author weil
     * @date 2019-04-03
     */
    @RequestMapping("query")
    @ResponseBody
    public String query(TCusClueCustom tCusClueCustom) {
        startPagination();

        //负责人
        tCusClueCustom.setLeader(getActiveUser().getId());
        //模糊下属职位id
        tCusClueCustom.setSubPositionId(getActiveUser().getPositionId()+"_%");

        //放回周期
        Integer dueDay = 0;
        try {
            String d = PropertiesUtils.getCrmPros("date-remain");
            dueDay = Integer.parseInt(d);
        } catch (Exception e) {
            e.printStackTrace();
        }
        tCusClueCustom.setDueDay(dueDay);
        List<TCusClueCustom> list = clueService.query(tCusClueCustom);
        return getResultJsonStr(Constants.RETURN_SUCCESS, "操作成功！", list);
    }

    /**
     * <p>Title: </p>
     * <p>Description: 添加线索</p>
     * <p>Company: </p>
     *
     * @param
     * @return
     * @author weil
     * @date 2019-04-04
     */
    @RequestMapping("save")
    @ResponseBody
    public String save(TCusClueCustom tCusClueCustom) {
        //判断公司名是否重复
        TCusClueCustom c1 = new TCusClueCustom();
        c1.setCompany(tCusClueCustom.getCompany());
        if(StringUtils.isNotEmpty(tCusClueCustom.getCompany())) {
            List<TCusClueCustom> clues = clueService.query(c1);
            if (clues != null && clues.size() > 0) {
                return getResultJsonStr(Constants.RETRUN_FAILURE, "公司名已存在！");
            }
        }


        //判断是否领用还是放回线索池
        if (tCusClueCustom.getLeader() == null) {
            //放回线索池
            tCusClueCustom.setStatus(1);
        } else {
            tCusClueCustom.setStatus(2);
        }
        //其他信息添加
        tCusClueCustom.setCreateBy(getActiveUser().getId());
        tCusClueCustom.setCreateTime(new Date());
        tCusClueCustom.setModifyTime(new Date());

        try {
            clueService.save(tCusClueCustom);
        } catch (Exception e) {
            return getResultJsonStr(Constants.RETRUN_FAILURE, "操作失败！" + e.getMessage());
        }
        return getResultJsonStr(Constants.RETURN_SUCCESS, "操作成功！");
    }

    /**
     * <p>Title: </p>
     * <p>Description: 更新线索</p>
     * <p>Company: </p>
     *
     * @param
     * @return
     * @author weil
     * @date 2019-04-04
     */
    @RequestMapping("update")
    @ResponseBody
    public String update(TCusClueCustom tCusClueCustom) {

        TCusClueCustom c1 = new TCusClueCustom();
        c1.setCompany(tCusClueCustom.getCompany());

        if(StringUtils.isNotEmpty(tCusClueCustom.getCompany())) {
            List<TCusClueCustom> clues = clueService.query(c1);

            for (TCusClueCustom clue : clues) {

                if (clues != null && clues.size() > 1) {
                    return getResultJsonStr(Constants.RETRUN_FAILURE, "公司名已存在！");
                } else if (tCusClueCustom.getId().equals(clue.getId())){

                }else{
                    return getResultJsonStr(Constants.RETRUN_FAILURE, "公司名已存在！");
                }
            }

        }

        try {
            clueService.update(tCusClueCustom);
        } catch (Exception e) {
            return getResultJsonStr(Constants.RETRUN_FAILURE, "操作失败！" + e.getMessage());
        }
        return getResultJsonStr(Constants.RETURN_SUCCESS, "操作成功！");
    }

    /**
     * <p>Title: </p>
     * <p>Description: 线索删除</p>
     * <p>Company: </p>
     *
     * @param
     * @return
     * @author weil
     * @date 2019-04-04
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
                clueService.delete(id);
            } catch (Exception e) {
                return getResultJsonStr(Constants.RETRUN_FAILURE, "删除失败！" + e.getMessage());
            }
        }
        return getResultJsonStr(Constants.RETURN_SUCCESS, "操作成功！");
    }

    /**
     * <p>Title: </p>
     * <p>Description: 跳转添加新索页面</p>
     * <p>Company: </p>
     *
     * @param
     * @return
     * @author weil
     * @date 2019-04-04
     */
    @RequestMapping("addPage")
    public String addPage() {
        return "customer/clue/clue-add";
    }

    /**
     * <p>Title: </p>
     * <p>Description: 跳转更新线索页面</p>
     * <p>Company: </p>
     *
     * @param
     * @return
     * @author weil
     * @date 2019-04-04
     */
    @RequestMapping("updatePage")
    public String updatePage(Long id) {
        TCusClueCustom clue = clueService.queryById(id);
        getRequest().setAttribute("clue", clue);
        return "customer/clue/clue-add";
    }

    /**
     * <p>Title: </p>
     * <p>Description: 线索详情页</p>
     * <p>Company: </p>
     *
     * @param
     * @return
     * @author weil
     * @date 2019-04-04
     */
    @RequestMapping("clueDetailPage")
    public String clueDetailPage(Long id) {
        TCusClueCustom clue = clueService.queryById(id);
        getRequest().setAttribute("clue", clue);
        return "customer/clue/clue-detail";
    }

    /**
     * <p>Title: </p>
     * <p>Description: 查询沟通日志或日程</p>
     * <p>Company: </p>
     *
     * @param
     * @return
     * @author weil
     * @date 2019-04-05
     */
    @RequestMapping("queryCommlog")
    @ResponseBody
    public String queryCommlog(TCusClueCommLog commlog) {
        List<TCusClueCommLogCustom> logs = clueService.query(commlog);
        //处理头像地址
        for (TCusClueCommLogCustom log : logs) {
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
     * <p>Description: 新增沟通日志或日程</p>
     * <p>Company: </p>
     *
     * @param
     * @return
     * @author weil
     * @date 2019-04-05
     */
    @RequestMapping("saveCommlog")
    @ResponseBody
    public String saveCommlog(TCusClueCommLog commlog) {
        try {
            commlog.setCreateBy(getActiveUser().getId());
            commlog.setCreateTime(new Date());
            clueService.save(commlog);
            logger.info("commlog.id------------>"+commlog.getId());

            //跟进操作产生，更新线索跟进日期
            TCusClueCustom clue = new TCusClueCustom();
            clue.setId(commlog.getClueId());
            clue.setModifyTime(new Date());
            clueService.update(clue);
        } catch (Exception e) {
            return getResultJsonStr(Constants.RETRUN_FAILURE, "操作失败！" + e.getMessage());
        }
        return getResultJsonStr(Constants.RETURN_SUCCESS, "操作成功！", commlog.getId());
    }

    /**
     * <p>Title: </p>
     * <p>Description: 删除沟通日志</p>
     * <p>Company: </p>
     *
     * @param
     * @return
     * @author weil
     * @date 2019-04-05
     */
    @RequestMapping("deleteCommlog")
    @ResponseBody
    public String deleteCommlog(String ids) {
        if (StringUtils.isEmpty(ids)) {
            return getResultJsonStr(Constants.RETRUN_FAILURE, "需要删除的id不存在！");
        }
        String[] split = ids.split(",");
        for (String s : split) {
            try {
                long id = Long.parseLong(s);
                clueService.deleteLog(id);
            } catch (Exception e) {
                return getResultJsonStr(Constants.RETRUN_FAILURE, "删除失败！" + e.getMessage());
            }
        }
        return getResultJsonStr(Constants.RETURN_SUCCESS, "操作成功！");
    }

    /**
     * <p>Title: </p>
     * <p>Description: 跳转上传文件界面</p>
     * <p>Company: </p>
     *
     * @param
     * @return
     * @author weil
     * @date 2019-04-06
     */
    @RequestMapping("uploadPage")
    public String uploadPage(TFile file) {
        getRequest().setAttribute("file", file);
        return "customer/file";
    }

    /**
     * <p>Title: </p>
     * <p>Description: 上传文件</p>
     * <p>Company: </p>
     *
     * @param
     * @return
     * @author weil
     * @date 2019-04-06
     */
    @RequestMapping("upload")
    @ResponseBody
    public String upload(MultipartFile file, TFile f) {
        f.setUploader(getActiveUser().getId());
        try {
            clueService.upload(file, f);
            return getResultJsonStr(Constants.RETURN_SUCCESS, "上传成功！");
        } catch (Exception e) {
            e.printStackTrace();
            return getResultJsonStr(Constants.RETRUN_FAILURE, e.getMessage());
        }
    }

    /**
     * <p>Title: </p>
     * <p>Description: 查询文件</p>
     * <p>Company: </p>
     *
     * @param
     * @return
     * @author weil
     * @date 2019-04-06
     */
    @RequestMapping("queryFile")
    @ResponseBody
    public String queryFile(TFile file) {
        startPagination();
        List<TFileCustom> files = clueService.query(file);
        //处理文件地址
        try {
            for (TFileCustom f : files) {
                String dirStr = PropertiesUtils.getFileValue("file-url") + f.getFileBelong() + "/" + f.getBelongId() + "/";
                f.setUrl(dirStr + f.getUrl());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return getResultJsonStr(Constants.RETURN_SUCCESS, "操作成功！", files);
    }

    /**
     * <p>Title: </p>
     * <p>Description: 预览文件界面</p>
     * <p>Company: </p>
     *
     * @param
     * @return
     * @author weil
     * @date 2019-04-06
     */
    @RequestMapping("media")
    public String media(String url) {
        //get解决请求乱码
        getRequest().setAttribute("url", decode(url));
        return "customer/media";
    }

    /**
     * <p>Title: </p>
     * <p>Description: </p>
     * <p>Company: </p>
     *
     * @param
     * @return
     * @author weil
     * @date 2019-04-06
     */
    @RequestMapping("deleteFile")
    @ResponseBody
    public String deleteFile(String ids) {
        if (StringUtils.isEmpty(ids)) {
            return getResultJsonStr(Constants.RETRUN_FAILURE, "需要删除的id不存在！");
        }
        String[] split = ids.split(",");
        for (String s : split) {
            try {
                long id = Long.parseLong(s);
                clueService.deleteFile(id);
            } catch (Exception e) {
                return getResultJsonStr(Constants.RETRUN_FAILURE, "删除失败！" + e.getMessage());
            }
        }
        return getResultJsonStr(Constants.RETURN_SUCCESS, "操作成功！");
    }

    /**
     * <p>Title: </p>
     * <p>Description: 下载文件</p>
     * <p>Company: </p>
     *
     * @param
     * @return
     * @author weil
     * @date 2019-04-09
     */
    @RequestMapping("download")
    public ResponseEntity<byte[]> download(Long id) {
        TFile file = clueService.queryFileById(id);
        if (file == null) {
            return null;
        }
        try {
            String dirStr = PropertiesUtils.getFileValue("file-dir") + file.getFileBelong() + "/" + file.getBelongId() + "/";
            InputStream in = new FileInputStream(new File(dirStr, file.getUrl()));
            byte[] buff = new byte[in.available()];
            in.read(buff);
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
            headers.setContentDispositionFormData("attachment", new String(file.getFileName().getBytes(), "ISO-8859-1"));
            return new ResponseEntity<byte[]>(buff, headers, HttpStatus.OK);
        } catch (Exception e) {
            throw new CustomException(e.getMessage());
        }
    }

    /**
     * <p>Title: </p>
     * <p>Description: 跳转线索池</p>
     * <p>Company: </p>
     *
     * @param
     * @return
     * @author weil
     * @date 2019-04-09
     */
    @RequestMapping("poolPage")
    public String poolPage() {
        return "customer/clue/clue-pool";
    }

    /**
     * <p>Title: </p>
     * <p>Description: 查询线索池</p>
     * <p>Company: </p>
     *
     * @param
     * @return
     * @author weil
     * @date 2019-04-09
     */
    @RequestMapping("queryPool")
    @ResponseBody
    public String queryPool(TCusClueCustom tCusClueCustom) {
        startPagination();
        List<TCusClueCustom> list = clueService.query(tCusClueCustom);
        return getResultJsonStr(Constants.RETURN_SUCCESS, "操作成功！", list);
    }

    /**
     * <p>Title: </p>
     * <p>Description: 放回线索池</p>
     * <p>Company: </p>
     *
     * @param
     * @return
     * @author weil
     * @date 2019-04-09
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
                TCusClueCommLogCustom commLog = new TCusClueCommLogCustom();
                commLog.setClueId(id);
                clueService.cluePlanDel(commLog);

                //放入线索池操作
                TCusClueCustom clue = new TCusClueCustom();
                clue.setId(id);
                clue.setStatus(1);
                clueService.toPool(clue);
            } catch (Exception e) {
                return getResultJsonStr(Constants.RETRUN_FAILURE, "操作失败！" + e.getMessage());
            }
        }
        return getResultJsonStr(Constants.RETURN_SUCCESS, "操作成功！");
    }

    @RequestMapping("change")
    @ResponseBody
    public String change(String ids){
        if (StringUtils.isEmpty(ids)){
            return getResultJsonStr(Constants.RETRUN_FAILURE,"需要操作的id不存在");

        }
        String[] split = ids.split(",");
        for (String s : split){
            try{
                long id = Long.parseLong(s);
                TCusClueCustom clue = new TCusClueCustom();
                clue.setId(id);
                List<TCusClueCustom> clueCustoms = clueService.change(clue);
                TCusCustomerCustom cusCustomerCustom = new TCusCustomerCustom();
                TCusContactCustom cusContactCustom  = new TCusContactCustom();
                for (TCusClueCustom clueCustom : clueCustoms){

                   cusCustomerCustom.setCusName(clueCustom.getCompany());
                    cusContactCustom.setName(clueCustom.getContact());
                    cusContactCustom.setPhone(clueCustom.getPhone());
                    cusCustomerCustom.setLeaderName(clueCustom.getLeaderName());
                    cusCustomerCustom.setAddress(clueCustom.getAddress());
                    cusContactCustom.setAddress(clueCustom.getAddress());
                    cusCustomerCustom.setInfoFrom(clueCustom.getInfoFrom());
                    cusContactCustom.setCallname(clueCustom.getCallname());
                    cusContactCustom.setPosition(clueCustom.getPosition());
                    cusContactCustom.setEmail(clueCustom.getEmail());

                    cusCustomerCustom.setCreateBy(clueCustom.getCreateBy());
                    cusContactCustom.setCreateBy(clueCustom.getCreateBy());
                    cusCustomerCustom.setCh2(clueCustom.getRemark());
                    cusCustomerCustom.setLeader(clueCustom.getLeader());

                    cusCustomerCustom.setStatus(2);
                    cusContactCustom.setFirstContact(1);
                    cusCustomerCustom.setCusCode(customerService.randomCusCode("zsc"));

                }
                //判断客户名是否重复
               List<TCusCustomerCustom> cuss = customerService.query(cusCustomerCustom);
                if (cuss != null && cuss.size() > 0) {
                    return getResultJsonStr(Constants.RETRUN_FAILURE, "转换失败，已存在此客户！");
                }

                //判断客户编码是否存在
                List<TCusCustomerCustom> cus2 = customerService.query(cusCustomerCustom);
                if (cus2 != null && cus2.size() > 0) {
                    return getResultJsonStr(Constants.RETRUN_FAILURE, "客户编码已存在！");
                }

                customerService.save(cusCustomerCustom);
                cusContactCustom.setCusId(cusCustomerCustom.getId());

                contactService.save(cusContactCustom);
                clueService.updateStatus(clue);

            }catch (Exception e){
                return getResultJsonStr(Constants.RETRUN_FAILURE,"操作失败" +e.getMessage());
            }
        }
                return getResultJsonStr(Constants.RETURN_SUCCESS,"操作成功");

    }

    /**
     * <p>Title: </p>
     * <p>Description: 领用线索</p>
     * <p>Company: </p>
     * @param
     * @return
     * @author weil
     * @date 2019-04-09
     */
    @RequestMapping("allotUser")
    @ResponseBody
    public String allotUser(String ids,Long leader){
        if (StringUtils.isEmpty(ids)) {
            return getResultJsonStr(Constants.RETRUN_FAILURE, "需要操作的id不存在！");
        }
        String[] split = ids.split(",");
        for (String s : split) {
            try {
                long id = Long.parseLong(s);
                TCusClueCustom clue = new TCusClueCustom();
                clue.setId(id);
                clue.setStatus(2);
                clue.setLeader(leader);
                clue.setModifyTime(new Date());
                clueService.update(clue);
            } catch (Exception e) {
                return getResultJsonStr(Constants.RETRUN_FAILURE, "操作失败！" + e.getMessage());
            }
        }
        return getResultJsonStr(Constants.RETURN_SUCCESS, "操作成功！");
    }

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
                TCusClueCustom clue = new TCusClueCustom();
                clue.setId(id);
                clue.setStatus(2);
                clue.setLeader(getActiveUser().getId());
                clue.setModifyTime(new Date());
                clueService.update(clue);
            } catch (Exception e) {
                return getResultJsonStr(Constants.RETRUN_FAILURE, "操作失败！" + e.getMessage());
            }
        }
        return getResultJsonStr(Constants.RETURN_SUCCESS, "操作成功！");
    }
    /**
     * <p>Title: </p>
     * <p>Description: excel文件导入线索</p>
     * <p>Company: </p>
     * @param
     * @return
     * @author weil
     * @date 2019-04-09
     */
    @RequestMapping("importClue")
    @ResponseBody
    public String importClue(MultipartFile file){
        List<TCusClueCustom> clues = new ArrayList<>();

        if (file != null) {
            String[][] sheetData = ImportExcelUntil.getExcelData(file);
            for(int x=0;x<sheetData.length;x++){
                TCusClueCustom clue = new TCusClueCustom();
                if(StringUtils.isBlank(sheetData[x][0])){
                    return getResultJsonStr(Constants.RETRUN_FAILURE, "第"+(x+1)+"行信息来源为空，请校验");
                }
                clue.setInfoFrom(sheetData[x][0]);

                if(StringUtils.isBlank(sheetData[x][1])){
                    return getResultJsonStr(Constants.RETRUN_FAILURE, "第"+(x+1)+"行联系人为空，请校验");
                }
                clue.setContact(sheetData[x][1]);


                    TCusClueCustom c1 = new TCusClueCustom();
                    c1.setCompany(sheetData[x][2]);
                    if (StringUtils.isNotEmpty(sheetData[x][2])) {
                        List<TCusClueCustom> cs = clueService.query(c1);
                        if (cs != null && cs.size() > 0) {
                            return getResultJsonStr(Constants.RETRUN_FAILURE, "第" + (x + 1) + "行公司名已存在，请校验");
                        }
                    }
                clue.setCompany(sheetData[x][2]);

                if(StringUtils.isBlank(sheetData[x][3])){
                    return getResultJsonStr(Constants.RETRUN_FAILURE, "第"+(x+1)+"行职位为空，请校验");
                }
                clue.setPosition(sheetData[x][3]);

                if(!"先生".equals(sheetData[x][4])&&!"女士".equals(sheetData[x][4])){
                    return getResultJsonStr(Constants.RETRUN_FAILURE, "第"+(x+1)+"行尊称不规范，请校验");
                }
                clue.setCallname(sheetData[x][4]);

                if(StringUtils.isBlank(sheetData[x][5])){
                    return getResultJsonStr(Constants.RETRUN_FAILURE, "第"+(x+1)+"行手机号为空，请校验");
                }
                clue.setPhone(sheetData[x][5]);

                if(StringUtils.isBlank(sheetData[x][6])){
                    return getResultJsonStr(Constants.RETRUN_FAILURE, "第"+(x+1)+"行邮箱为空，请校验");
                }
                clue.setEmail(sheetData[x][6]);

                if(StringUtils.isBlank(sheetData[x][7])){
                    return getResultJsonStr(Constants.RETRUN_FAILURE, "第"+(x+1)+"行地址为空，请校验");
                }
                clue.setAddress(sheetData[x][7]);

                if(StringUtils.isBlank(sheetData[x][8])){
                    return getResultJsonStr(Constants.RETRUN_FAILURE, "第"+(x+1)+"行备注为空，请校验");
                }
                clue.setRemark(sheetData[x][8]);

                clue.setCreateBy(getActiveUser().getId());
                clue.setCreateTime(new Date());
                clue.setModifyTime(new Date());
                clue.setStatus(1);

                clues.add(clue);
            }
        }else{
            return  getResultJsonStr(Constants.RETRUN_FAILURE,"文件为空");
        }

        for (TCusClueCustom clue : clues) {
            try{
                clueService.save(clue);
            } catch (Exception e){
                e.printStackTrace();
                return getResultJsonStr(Constants.RETRUN_FAILURE, e.getMessage());
            }
        }
        return getResultJsonStr(Constants.RETURN_SUCCESS, "已导入"+clues.size()+"条数据");
    }

    /**
     * <p>Title: </p>
     * <p>Description: 地图位置查询</p>
     * <p>Company: </p>
     * @param
     * @return
     * @author weil
     * @date 2019-04-11
     */
    @RequestMapping("map")
    public String map(String address){
        String addr = decode(address);
        getRequest().setAttribute("map", addr);
        return "customer/map";
    }
}
