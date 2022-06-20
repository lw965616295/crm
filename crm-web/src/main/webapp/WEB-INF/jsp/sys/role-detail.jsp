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
    <title>添加角色</title>
</head>
    <meta charset="utf-8">
    <title>新建角色</title>
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
    <input type="text"  name="id" value="${role.id}" placeholder="" hidden="true">
    <div class="layui-form-item">
        <label class="layui-form-label">角色名</label>
        <div class="layui-input-block">
            <input type="text" name="name" lay-verify="required" placeholder="请输入角色名" autocomplete="off"
                   class="layui-input" value="${role.name}">
        </div>
    </div>

    <div class="layui-form-item ">
        <label class="layui-form-label">描述</label>
        <div class="layui-input-block">
            <textarea name="description" placeholder="请输入描述" class="layui-textarea">${role.description}</textarea>
        </div>
    </div>

    <div class="layui-form-item layui-hide">
        <input type="button" lay-submit lay-filter="role-add-submit" id="role-add-submit" value="确认">
    </div>
</div>

<script>
    layui.use('form', function () {
        var $ = layui.$,
            form = layui.form;
    })
</script>
</body>

</html>