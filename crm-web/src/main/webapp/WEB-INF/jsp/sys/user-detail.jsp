<!DOCTYPE HTML>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/tag.jsp"%>
<%@ include file="/WEB-INF/jsp/common/css.jsp"%>
<%@ include file="/WEB-INF/jsp/common/js.jsp"%>
<html>
<head>
    <meta charset="utf-8">
    <title>新建用户</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <style>
        .layui-form-label {
            width: 90px;
            padding: 9px 10px 9px 10px;
            font-weight: bold;
            color: grey;
        }

        .layui-textarea {
            resize: none;
        }
    </style>
</head>

<body>

<div class="layui-form" style="padding: 20px 70PX 20px 20PX;">
    <input name="id" type="text" value="${user.id}" hidden="true">
    <div class="layui-form-item">
        <label class="layui-form-label">账号</label>
        <div class="layui-input-inline">
            <input type="text" name="account" lay-verify="required" placeholder="请输入账号" autocomplete="off"
                   class="layui-input" value="${user.account}">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">状态</label>
        <div class="layui-input-inline">
            <select name="status" lay-verify="required">
                <c:set var="status" scope="request" value="${user.status}"></c:set>
                <option value="1" <c:if test="${status == 1}">selected</c:if>>启用</option>
                <option value="0" <c:if test="${status == 0}">selected</c:if>>禁用</option>
            </select>
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">姓名</label>
        <div class="layui-input-inline">
            <input type="text" name="name" lay-verify="required" placeholder="请输入姓名" autocomplete="off"
                   class="layui-input" value="${user.name}">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">年龄</label>
        <div class="layui-input-inline">
            <input type="text" name="age" lay-verify="number" placeholder="请输入年龄" autocomplete="off"
                   class="layui-input" value="${user.age}">
        </div>
    </div>

    <div class="layui-form-item" lay-filter="sex">
        <label class="layui-form-label">性别</label>
        <div class="layui-input-block">
            <c:set var="gender" scope="request" value="${user.gender}"/>
            <input type="radio" name="gender" value="男" title="男" <c:if test="${gender == '男' || gender == undefined}">checked</c:if>>
            <input type="radio" name="gender" value="女" title="女" <c:if test="${gender == '女'}">checked</c:if>>
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">手机</label>
        <div class="layui-input-inline">
            <input type="text" name="mobilePhone" lay-verify="phone" placeholder="请输入手机" autocomplete="off"
                   class="layui-input" value="${user.mobilePhone}">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">邮箱</label>
        <div class="layui-input-inline">
            <input type="text" name="email" lay-verify="email" placeholder="请输入邮箱" autocomplete="off"
                   class="layui-input" value="${user.email}">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">岗位</label>
        <div class="layui-input-inline">
            <select id="position_select" name="positionId" lay-verify="required"></select>
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">办公电话</label>
        <div class="layui-input-inline">
            <input type="text" name="officePhone" placeholder="请输入办公电话" autocomplete="off"
                   class="layui-input" value="${user.officePhone}">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">QQ/MSN</label>
        <div class="layui-input-inline">
            <input type="text" name="qqMsn" placeholder="请输入QQ/MSN" autocomplete="off"
                   class="layui-input" value="${user.qqMsn}">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">地址</label>
        <div class="layui-input-block ">
            <input type="text" name="address" placeholder="地址" autocomplete="off"
                   class="layui-input" value="${user.address}">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">出生日期</label>
        <div class="layui-input-block ">
            <input type="text" name="birthday" class="layui-input test-item" autocomplete="off"
                   placeholder="请选择出生日期" >
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">入职日期</label>
        <div class="layui-input-block ">
            <input type="text" name="joinDate" class="layui-input test-item" autocomplete="off"
                   placeholder="请选择入职日期" >
        </div>
    </div>

    <div class="layui-form-item ">
        <label class="layui-form-label">自我介绍</label>
        <div class="layui-input-block ">
            <textarea name="introduce" placeholder="请输入自我介绍" class="layui-textarea">${user.introduce}</textarea>
        </div>
    </div>

    <div class="layui-form-item layui-hide">
        <input type="button" lay-submit lay-filter="user-add-submit" id="user-add-submit" value="确认">
    </div>

</div>

<!-- 地区选择 -->
<script>

    layui.use(['form', 'laydate'], function () {
        var $ = layui.$,
            form = layui.form,
            laydate = layui.laydate;

        // 时间选择，同时绑定多个
        lay('.test-item').each(function () {
            laydate.render({
                elem: this,
                trigger: 'click'
            });
        });

        //获取岗位信息
        $.ajax({
            url: "${baseurl}/position/query",
            type: "post",
            success: function(data){
                var da = JSON.parse(data).rows;
                //用于编辑修改时，回显部门信息
                var positionId = "${user.positionId}";
                if(da){
                    var sel=[];
                    sel.push('<option value=""></option>')
                    for(var i=0; i<da.length; i++){
                        var position = da[i];
                        if(position.id == positionId){
                            sel.push('<option value="'+position.id+'" selected>'+position.name+'</option>')
                        }else{
                            sel.push('<option value="'+position.id+'">'+position.name+'</option>')
                        }
                    }
                    $("#position_select").html(sel.join(' '));
                    //渲染selector
                    form.render('select');
                }
            }
        });
    });

</script>
</body>

</html>