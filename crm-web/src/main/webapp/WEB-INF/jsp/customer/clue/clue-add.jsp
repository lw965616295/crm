<!DOCTYPE HTML>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/tag.jsp"%>
<%@ include file="/WEB-INF/jsp/common/css.jsp"%>
<%@ include file="/WEB-INF/jsp/common/js.jsp"%>
<html>
<head>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <title>新建线索</title>
</head>

<body>
<div class="layui-form layui-card" style="padding: 20px 70PX 20px 20PX;">
    <form class="layui-form">
        <input type="text" name="id" value="${clue.id}" hidden>
        <div class="layui-form-item">
            <label class="layui-form-label">信息来源<span style="color: red">*</span></label>
            <div class="layui-input-inline">
                <select name="infoFrom" lay-verify="required">
                    <option value=""></option>
                    <option value="网络营销" <c:if test="${clue.infoFrom=='网络营销'}">selected="selected"</c:if>>网络营销</option>
                    <option value="公开媒体" <c:if test="${clue.infoFrom=='公开媒体'}">selected="selected"</c:if>>公开媒体</option>
                    <option value="合作伙伴" <c:if test="${clue.infoFrom=='合作伙伴'}">selected="selected"</c:if>>合作伙伴</option>
                    <option value="员工介绍" <c:if test="${clue.infoFrom=='员工介绍'}">selected="selected"</c:if>>员工介绍</option>
                    <option value="广告" <c:if test="${clue.infoFrom=='广告'}">selected="selected"</c:if>>广告</option>
                    <option value="其他" <c:if test="${clue.infoFrom=='其他'}">selected="selected"</c:if>>其他</option>
                </select>
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">联系人<span style="color: red">*</span></label>
            <div class="layui-input-inline">
                <input type="text" name="contact" lay-verify="required" placeholder="请输入联系人姓名" autocomplete="off"
                       value="${clue.contact}" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">公司名</label>
            <div class="layui-input-inline">
                <input type="text" name="company"  value="${clue.company}" placeholder="请输入公司名" autocomplete="off"
                       class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">职位<span style="color: red">*</span></label>
            <div class="layui-input-inline">
                <input type="text" name="position" value="${clue.position}" placeholder="请输入职位" autocomplete="off" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item" lay-filter="sex">
            <label class="layui-form-label">尊称</label>
            <div class="layui-input-block">
                <c:set var="callname" scope="request" value="${clue.callname}"/>
                <input type="radio" name="callname" value="先生" title="先生" <c:if test="${callname == '先生' || callname == undefined}">checked</c:if>>
                <input type="radio" name="callname" value="女士" title="女士" <c:if test="${callname == '女士'}">checked</c:if>>
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">手机号码<span style="color: red">*</span></label>
            <div class="layui-input-inline">
                <input type="text" name="phone" lay-verify="phone" value="${clue.phone}" placeholder="请输入手机号" autocomplete="off" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">邮箱</label>
            <div class="layui-input-inline">
                <input type="text" name="email"  value="${clue.email}" placeholder="请输入邮箱" autocomplete="off" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">地址</label>
            <div class="layui-input-block ">
                <input type="text" name="address" placeholder="地址" autocomplete="off"
                       class="layui-input" value="${clue.address}">
            </div>
        </div>
        <shiro:hasPermission name="clue:allot">
        <c:if test="${clue.id == undefined}">
            <%--<div class="layui-form-item">--%>
                <%--<label class="layui-form-label">负责人</label>--%>
                <%--<div class="layui-input-inline">--%>
                    <%--<input type="text" id="selector_user_name" name="leaderName" placeholder="请输入负责人" autocomplete="off"--%>
                           <%--class="layui-input" onclick="selectLeader()" readonly>--%>
                    <%--<input type="text" id="selector_user_id" name="leader" hidden>--%>
                <%--</div>--%>
            <%--</div>--%>
        </c:if>
        </shiro:hasPermission>
        <div class="layui-form-item ">
            <label class="layui-form-label">备注</label>
            <div class="layui-input-block w50">
                <textarea name="remark" placeholder="请输入备注" class="layui-textarea">${clue.remark}</textarea>
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-input-block">
                <input type="button" lay-submit lay-filter="LAY-clue-submit" class="layui-btn layui-btn-normal" value="提交"/>
                <input type="reset" class="layui-btn layui-btn-primary" value="重置"/>
            </div>
        </div>
    </form>
</div>
</body>
<script>
    /*取消*/
    function cancel1(){
        var index = parent.layer.getFrameIndex(window.name);
        parent.layer.close(index);
        parent.location.reload();
    }
    <%--/*选择负责人*/--%>
    <%--function selectLeader(){--%>
        <%--layer.open({--%>
            <%--title: "选择负责人",--%>
            <%--type: 2,--%>
            <%--area: ['700px', '450px'],--%>
            <%--maxmin: true,--%>
            <%--content: '${baseurl}/user/selectorPage'--%>
        <%--});--%>
    <%--}--%>

    layui.use('form',function(){
        var form = layui.form;
        form.on('submit(LAY-clue-submit)',function(data){
            var field = data.field; //获取提交的字段
            console.log(field);
            //提交 Ajax 成功后，更新表格中的数据
            $.ajax({
                type: 'post',
                url: '${baseurl}/clue/'+ (${clue.id == undefined}?'save':'update'),
                data: field,
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
            });
        });
    });
    //获取部门信息


    $.ajax({
        url: "${baseurl}/dept/query",
        type: "post",
        success: function(data){
            var da = JSON.parse(data).rows;
            //用于编辑修改时，回显部门信息
            var deptId = "${position.deptId}";
            if(da){
                var sel=[];
                sel.push('<option value=""></option>')
                for(var i=0; i<da.length; i++){
                    var dept = da[i];
                    if(dept.id == deptId){
                        sel.push('<option value="'+dept.id+'" selected>'+dept.name+'</option>')
                    }else{
                        sel.push('<option value="'+dept.id+'">'+dept.name+'</option>')
                    }
                }
                $("#dept_select").html(sel.join(' '));
            }
        }
    });
</script>
</html>