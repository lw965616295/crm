<!DOCTYPE HTML>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jsp/common/tag.jsp" %>
<%@ include file="/WEB-INF/jsp/common/css.jsp" %>
<%@ include file="/WEB-INF/jsp/common/js.jsp" %>
<html>

<head>
    <meta charset="utf-8">
    <title>新建客户</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <style>
        .layui-card-header {
            border: none;
        }

        .sq-tag {
            width: 8px;
            height: 18px;
            background-color: #009688;
            padding: 0px;
            display: inline-block;
        }

        .text-tag {
            display: inline-block;
            position: relative;
            top: -3px;
        }

        .layui-form-label {
            text-align: left;
            width: 90px;
            padding: 9px 15px 9px 0;
        }

        .layui-input-block {
            margin-left: 105px;
        }

        .layui-textarea {
            resize: none;
        }
    </style>
</head>

<body>

<div class="layui-form" lay-filter="customer_add" id="customer_add" style="padding: 20px 70PX 20px 20PX;">
    <form class="layui-form">
    <div class="layui-row layui-col-space10">
        <input type="text" name="id" value="${cus.id}" hidden>
        <div class="layui-col-xs12 layui-col-sm6 layui-col-md6">
            <div class="layui-card">
                <div class="layui-card-header">
                    <span class="sq-tag"></span>
                    <div class="text-tag">
                        <span>基础信息</span>
                    </div>
                </div>
                <div class="layui-card-body">

                    <div class="layui-form-item">
                        <label class="layui-form-label">客户名称</label>
                        <div class="layui-input-inline">
                            <input type="text" name="cusName" value="${cus.cusName}"  placeholder="请输入客户名称"

                                   autocomplete="off" class="layui-input">
                        </div>
                    </div>
                    <shiro:hasPermission name="cusallot">
                    <c:if test="${cus.id == undefined}">
                    <div class="layui-form-item">
                        <label class="layui-form-label">客户负责人</label>
                        <div class="layui-input-inline">
                            <input type="text" id="selector_user_name" name="leaderName" placeholder="请输入负责人" autocomplete="off"
                                   class="layui-input" onclick="selectLeader()" readonly>
                            <input type="text" id="selector_user_id" name="leader" hidden>
                        </div>
                    </div>
                    </c:if>
                    </shiro:hasPermission>
                    <div class="layui-form-item">
                        <label class="layui-form-label">客户编号</label>
                        <div class="layui-input-inline">
                            <input type="text" name="cusCode" lay-verify="required" autocomplete="off"
                                <c:if test="${cusCode != undefined}">value="${cusCode}"</c:if>
                                <c:if test="${cusCode == undefined}">value="${cus.cusCode}"</c:if>
                                   class="layui-input" <c:if test="${cus.id != undefined}">disabled</c:if> >
                        </div>
                    </div>

                    <div class="layui-form-item">
                        <label class="layui-form-label">客户状态</label>
                        <div class="layui-input-inline">
                            <select name="cusStatus">
                                <option value=""></option>
                                <option value="意向客户" <c:if test="${cus.cusStatus=='意向客户'}">selected="selected"</c:if>>意向客户</option>
                                <option value="已成交客户" <c:if test="${cus.cusStatus=='已成交客户'}">selected="selected"</c:if>>已成交客户</option>
                                <option value="失败客户" <c:if test="${cus.cusStatus=='失败客户'}">selected="selected"</c:if>>失败客户</option>
                            </select>
                        </div>
                    </div>

                    <div class="layui-form-item">
                        <label class="layui-form-label">客户行业</label>
                        <div class="layui-input-inline">
                            <select name="cusBelong">
                                <option value=""></option>
                                <option value="IT/教育" <c:if test="${cus.cusBelong=='IT/教育'}">selected="selected"</c:if>>IT/教育</option>
                                <option value="电子/商务" <c:if test="${cus.cusBelong=='电子/商务'}">selected="selected"</c:if>>电子/商务</option>
                                <option value="对外贸易" <c:if test="${cus.cusBelong=='对外贸易'}">selected="selected"</c:if>>对外贸易</option>
                                <option value="酒店、旅游" <c:if test="${cus.cusBelong=='酒店、旅游'}">selected="selected"</c:if>>酒店、旅游</option>
                                <option value="金融、保险" <c:if test="${cus.cusBelong=='金融、保险'}">selected="selected"</c:if>>金融、保险</option>
                                <option value="房产行业" <c:if test="${cus.cusBelong=='房产行业'}">selected="selected"</c:if>>房产行业</option>
                                <option value="医疗/保健" <c:if test="${cus.cusBelong=='医疗/保健'}">selected="selected"</c:if>>医疗/保健</option>
                                <option value="政府、机关" <c:if test="${cus.cusBelong=='政府、机关'}">selected="selected"</c:if>>政府、机关</option>
                                <option value="其他" <c:if test="${cus.cusBelong=='其他'}">selected="selected"</c:if>>其他</option>
                            </select>
                        </div>
                    </div>

                    <div class="layui-form-item">
                        <label class="layui-form-label">所在地区</label>
                        <div class="layui-input-block">
                            <input type="text" name="address" value="${cus.address}" placeholder="所在地区" autocomplete="off"
                                   class="layui-input">
                        </div>
                    </div>

                    <div class="layui-form-item">
                        <label class="layui-form-label">客户信息来源<span style="color: red">*</span></label>
                        <div class="layui-input-inline">
                            <select name="infoFrom" lay-verify="required">
                                <option value=""></option>
                                <option value="电话营销" <c:if test="${cus.infoFrom=='电话营销'}">selected="selected"</c:if>>电话营销</option>
                                <option value="网络营销" <c:if test="${cus.infoFrom=='网络营销'}">selected="selected"</c:if>>网络营销</option>
                                <option value="上门推销" <c:if test="${cus.infoFrom=='上门推销'}">selected="selected"</c:if>>上门推销</option>
                                <option value="其他" <c:if test="${cus.infoFrom=='其他'}">selected="selected"</c:if>>其他</option>
                            </select>
                        </div>
                    </div>

                    <div class="layui-form-item">
                        <label class="layui-form-label">客户等级</label>
                        <div class="layui-input-inline">
                            <div id="star1"></div>
                        </div>
                        <input type="text" name="cusGrade" id="cusGrade" hidden>
                    </div>

                    <div class="layui-form-item">
                        <span class="sq-tag"></span>
                        <div class="text-tag">
                            <span>附加信息</span>
                        </div>
                    </div>

                    <div class="layui-form-item">
                        <label class="layui-form-label">员工数</label>
                        <div class="layui-input-inline">
                            <select name="staffNum">
                                <option value=""></option>
                                <option value="10人以下" <c:if test="${cus.staffNum=='10人以下'}">selected="selected"</c:if>>10人以下</option>
                                <option value="10-20人" <c:if test="${cus.staffNum=='10-20人'}">selected="selected"</c:if>>10-20人</option>
                                <option value="20-50人" <c:if test="${cus.staffNum=='20-50人'}">selected="selected"</c:if>>20-50人</option>
                                <option value="50人以上" <c:if test="${cus.staffNum=='50人以上'}">selected="selected"</c:if>>50人以上</option>
                            </select>
                        </div>
                    </div>

                    <div class="layui-form-item ">
                        <label class="layui-form-label">备注</label>
                        <div class="layui-input-block ">
                            <textarea name="remark" placeholder="请输入备注" class="layui-textarea">${cus.remark}</textarea>
                        </div>
                    </div>

                </div>


            </div>
        </div>

        <div class="layui-col-xs12 layui-col-sm6 layui-col-md6">
            <div class="layui-card"
                    <c:if test="${cus.id != undefined}">
                        style="visibility: hidden"
                    </c:if>
                 >
                <div class="layui-card-header">
                    <span class="sq-tag"></span>
                    <div class="text-tag">
                        <span>首要联系人</span>
                    </div>
                </div>
                <div class="layui-card-body">

                    <div class="layui-form-item">
                        <label class="layui-form-label">联系人姓名</label>
                        <div class="layui-input-inline">
                            <input type="text" name="name" id="contact" placeholder="请输入联系人姓名" autocomplete="off"
                                   class="layui-input">
                        </div>
                        <div class="layui-form-mid layui-word-aux">如有联系人信息，则联系人姓名不能为空</div>
                    </div>

                    <div class="layui-form-item">
                        <label class="layui-form-label">角色</label>
                        <div class="layui-input-inline">
                            <select name="role">
                                <option value=""></option>
                                <option value="普通人">普通人</option>
                                <option value="决策人">决策人</option>
                                <option value="分项决策人">分项决策人</option>
                                <option value="商务决策">商务决策</option>
                                <option value="技术决策">技术决策</option>
                                <option value="财务决策">财务决策</option>
                                <option value="使用人">使用人</option>
                                <option value="意见影响人">意见影响人</option>
                            </select>
                        </div>
                    </div>

                    <div class="layui-form-item">
                        <label class="layui-form-label">尊称</label>
                        <div class="layui-input-block">
                            <input type="radio" name="callname" value="先生" title="先生" checked>
                            <input type="radio" name="callname" value="女士" title="女士">
                        </div>
                    </div>

                    <div class="layui-form-item">
                        <label class="layui-form-label">职位</label>
                        <div class="layui-input-inline">
                            <input type="text" name="position" placeholder="请输入职位" autocomplete="off"
                                   class="layui-input">
                        </div>
                    </div>

                    <div class="layui-form-item">
                        <label class="layui-form-label">手机</label>
                        <div class="layui-input-inline">
                            <input type="text" name="phone"  placeholder="请输入手机号" autocomplete="off"
                                   class="layui-input">
                        </div>
                    </div>

                    <div class="layui-form-item">
                        <label class="layui-form-label">QQ/MSN</label>
                        <div class="layui-input-inline">
                            <input type="text" name="qq" placeholder="请输入QQ/MSN" autocomplete="off"
                                   class="layui-input">
                        </div>
                    </div>

                    <div class="layui-form-item">
                        <label class="layui-form-label">邮箱</label>
                        <div class="layui-input-inline">
                            <input type="text" name="email" placeholder="请输入邮箱" autocomplete="off"
                                   class="layui-input">
                        </div>
                    </div>

                    <div class="layui-form-item">
                        <label class="layui-form-label">邮编</label>
                        <div class="layui-input-inline">
                            <input type="text" name="postcode" placeholder="请输入邮编" autocomplete="off"
                                   class="layui-input">
                        </div>
                    </div>

                    <div class="layui-form-item">
                        <label class="layui-form-label">地址</label>
                        <div class="layui-input-block">
                            <input type="text" name="address2" placeholder="请输入地址" autocomplete="off"
                                   class="layui-input">
                        </div>
                    </div>

                    <div class="layui-form-item">
                        <label class="layui-form-label">备注</label>
                        <div class="layui-input-block ">
                            <textarea name="ch2" placeholder="请输入备注" class="layui-textarea"></textarea>
                        </div>
                    </div>

                </div>

            </div>
            <div class="layui-form-item">
                <div class="layui-input-block">
                    <input type="button" lay-submit lay-filter="cus-submit" class="layui-btn layui-btn-normal" value="提交"/>
                    <input type="reset" class="layui-btn layui-btn-primary" value="重置"/>
                </div>
            </div>

        </div>
    </div>
    </form>
</div>

<script>
    console.log("${cusCode}")
    /*取消*/
    function cancel1(){
        var index = parent.layer.getFrameIndex(window.name);
        parent.layer.close(index);
        parent.location.reload();
    }
    /*选择负责人*/
    function selectLeader(){
        layer.open({
            title: "选择负责人",
            type: 2,
            area: ['700px', '450px'],
            maxmin: true,
            content: '${baseurl}/user/selectorPage'
        });
    }
    layui.use(['form', 'rate'], function () {
        var $ = layui.$,
            form = layui.form,
            rate = layui.rate;
        // 评星
        <c:if test="${cus.cusGrade == undefined}">
            rate.render({
                elem: '#star1',
                setText: function(value){
                    $("#cusGrade").val(value);
                }
            });
        </c:if>
        <c:if test="${cus.cusGrade != undefined}">
            rate.render({
                elem: '#star1',
                value: ${cus.cusGrade},
                setText: function(value){
                    $("#cusGrade").val(value);
                }
            });
        </c:if>

        //表单提交操作
         form.on('submit(cus-submit)',function(data){
            var field = data.field; //获取提交的字段

            console.log(field);
            //提交 Ajax 成功后，更新表格中的数据
            $.ajax({
                type: 'post',
                url: '${baseurl}/customer/'+ (${cus.id == undefined}?'save':'update'),
                data: field,
                success: function (data) {
                    var code = JSON.parse(data).code;
                    if(code == 1){
                        cusid = JSON.parse(data).data;
                        parent.layer.msg(JSON.parse(data).msg,{
                            icon: 1,
                            time: 800,

                        },function(index){

                            cancel1();

                            if (field.name != ''){
                                console.log("cus1:");
                                console.log(field);
                                var daa = {};
                                daa["cusId"] = cusid;
                                daa["name"] = field.name;
                                daa["role"] = field.role;
                                daa["callname"] = field.callname;
                                daa["position"] = field.position;
                                daa["phone"] = field.phone;
                                daa["qq"] = field.qq;
                                daa["email"] = field.email;
                                daa["postcode"] = field.postcode;
                                daa["address"] = field.address2;
                                daa["ch2"] = field.ch2;
                                daa["firstContact"] = 1;
                                console.log(daa);

                                $.ajax({
                                    type:'post',
                                    url:'${baseurl}/contact/save',
                                    data:daa,

                                    success: function (data) {
                                        var code = JSON.parse(data).code;
                                        if(code == 1){
                                            parent.layer.msg(JSON.parse(data).msg,{
                                                icon: 1,
                                                time: 800,
                                            },function(index){
                                                cancel1();
                                            });

                                        }else if(code == 0){
                                            layer.alert("操作失败！"+JSON.parse(data).msg);
                                        }
                                    }
                                })

                                }

                        });


                    }else if(code == 0){
                        layer.alert("操作失败！"+JSON.parse(data).msg);
                    }
                }
            });
        });



    })
</script>
</body>

</html>