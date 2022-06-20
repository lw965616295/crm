<!DOCTYPE HTML>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/tag.jsp"%>
<%@ include file="/WEB-INF/jsp/common/css.jsp"%>
<%@ include file="/WEB-INF/jsp/common/js.jsp"%>
<html>
<head>
    <meta charset="utf-8">
    <title>基本资料</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <style>
        .layui-textarea{
            resize:none;
        }
    </style>
</head>

<body>

<div class="layui-fluid">
    <div class="layui-row layui-col-space15">
        <div class="layui-col-md12">
            <div class="layui-card">
                <div class="layui-card-header">设置我的资料</div>
                <div class="layui-card-body" pad15>

                    <div class="layui-form" lay-filter="">
                        <input type="text" name="id" value="${user.id}" placeholder="" hidden="true">
                        <div class="layui-form-item">
                            <label class="layui-form-label">账号</label>
                            <div class="layui-input-inline">
                                <input type="text" name="account" value="${user.account}" disabled class="layui-input">
                            </div>
                        </div>

                        <div class="layui-form-item">
                            <label class="layui-form-label">用户名</label>
                            <div class="layui-input-inline">
                                <input type="text" name="username" value="${user.name}" disabled class="layui-input">
                            </div>
                        </div>

                        <div class="layui-form-item">
                            <label class="layui-form-label">部门</label>
                            <div class="layui-input-inline">
                                <input type="text" name="department" value="${user.deptName}" disabled class="layui-input">
                            </div>
                        </div>

                        <div class="layui-form-item">
                            <label class="layui-form-label">岗位</label>
                            <div class="layui-input-inline">
                                <input type="text" name="jobs" value="${user.positionName}" disabled class="layui-input">
                            </div>
                        </div>

                        <div class="layui-form-item">
                            <label class="layui-form-label">年龄</label>
                            <div class="layui-input-inline">
                                <input type="text" name="age" value="${user.age}" lay-verify="number" autocomplete="off"
                                       placeholder="请输入年龄" class="layui-input">
                            </div>
                        </div>

                        <div class="layui-form-item">
                            <label class="layui-form-label">性别</label>
                            <div class="layui-input-block">
                                <c:set var="gender" scope="request" value="${user.gender}"/>
                                <input type="radio" name="gender" value="男" title="男" <c:if test="${gender == '男' || gender == undefined}">checked</c:if>>
                                <input type="radio" name="gender" value="女" title="女" <c:if test="${gender == '女'}">checked</c:if>>
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label">头像上传</label>
                            <div class="layui-upload">
                                <div class="layui-upload-list">
                                    <img class="layui-upload-img" id="demo1" style="height: 50px;width: 50px">
                                    <button type="button" class="layui-btn" id="test1">上传图片</button>
                                    <p id="demoText"></p>
                                </div>
                            </div>
                        </div>

                        <div class="layui-form-item">
                            <label class="layui-form-label">手机</label>
                            <div class="layui-input-inline">
                                <input type="text" name="mobilePhone" value="${user.mobilePhone}" lay-verify="phone" placeholder="请输入手机号"
                                       autocomplete="off" class="layui-input">
                            </div>
                        </div>

                        <div class="layui-form-item">
                            <label class="layui-form-label">办公电话</label>
                            <div class="layui-input-inline">
                                <input type="text" name="officePhone" value="${user.officePhone}" lay-verify="number" placeholder="请输入办公电话"
                                       autocomplete="off" class="layui-input">
                            </div>
                        </div>

                        <div class="layui-form-item">
                            <label class="layui-form-label">邮箱</label>
                            <div class="layui-input-inline">
                                <input type="text" name="email" value="${user.email}" lay-verify="email" placeholder="请输入邮箱"
                                       autocomplete="off" class="layui-input">
                            </div>
                        </div>

                        <div class="layui-form-item">
                            <label class="layui-form-label">QQ/MSN</label>
                            <div class="layui-input-inline">
                                <input type="text" name="qqMsn" value="${user.qqMsn}" lay-verify="number" autocomplete="off"
                                       placeholder="请输入QQ/MSN" class="layui-input">
                            </div>
                        </div>

                        <div class="layui-form-item">
                            <label class="layui-form-label">出生日期</label>
                            <div class="layui-input-inline">
                                <input type="text" name="birthday" id="birthday" value="" disabled class="layui-input">
                            </div>
                        </div>

                        <div class="layui-form-item">
                            <label class="layui-form-label">入职日期</label>
                            <div class="layui-input-inline">
                                <input type="text" name="joinDate" id="joinDate" value="" disabled class="layui-input">
                            </div>
                        </div>

                        <div class="layui-form-item">
                            <label class="layui-form-label ">联系地址</label>
                            <div class="layui-input-block ">
                                <input type="text" name="address" value="${user.address}" disabled class="layui-input ">
                            </div>
                        </div>

                        <div class="layui-form-item layui-form-text">
                            <label class="layui-form-label">个人简介</label>
                            <div class="layui-input-block">
                                <textarea name="introduce" placeholder="请输入内容" class="layui-textarea">${user.introduce}</textarea>
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <div class="layui-input-block">
                                <button class="layui-btn" lay-submit lay-filter="updateInfo">更新基本资料</button>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>

<script>
    layui.use(['form','upload'], function(){
        var form = layui.form;
        var upload = layui.upload;
        //普通图片上传
        var uploadInst = upload.render({
            elem: '#test1'
            ,url: '${baseurl}/user/iconUpload'
            ,size: 2000             //将近2MB的大小限制
            ,before: function(obj){
                //预读本地文件示例，不支持ie8
                obj.preview(function(index, file, result){
                    $('#demo1').attr('src', result); //图片链接（base64）
                });
            }
            ,done: function(data){
                if(data.code == 1){
                    layer.msg(data.msg,{
                        icon: 1,
                        time: 800, //0.8秒关闭
                    });
                }else{
                    layer.alert(data.msg);
                }
            }
            ,error: function(){
                //演示失败状态，并实现重传
                var demoText = $('#demoText');
                demoText.html('<span style="color: #FF5722;">上传失败,文件类型或者大小有误！</span> <a class="layui-btn layui-btn-xs demo-reload">重试</a>');
                demoText.find('.demo-reload').on('click', function(){
                    uploadInst.upload();
                });
            }
        });

        //表单提交更新
        form.on('submit(updateInfo)', function(data){
            var field = data.field; //获取提交的字段

            url = "${baseurl}/user/update"
            //提交 Ajax 成功后，静态更新表格中的数据
            $.ajax({
                type: 'post',
                url: url,
                data: field,
                success: function (data) {
                    var code = JSON.parse(data).code;
                    if(code == 1){
                        parent.layer.msg(JSON.parse(data).msg,{
                            icon: 1,
                            time: 800,
                        });

                    }else if(code == 0){
                        layer.alert("操作失败！"+JSON.parse(data).msg);
                    }
                }
            });
        });
    });
    $(function(){
        $("#birthday").val(dateFormatter1(new Date("${user.birthday}").getTime()));
        $("#joinDate").val(dateFormatter1(new Date("${user.joinDate}").getTime()))
    });
</script>
</body>

</html>