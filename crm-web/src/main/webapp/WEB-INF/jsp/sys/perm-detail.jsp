<!DOCTYPE HTML>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jsp/common/tag.jsp" %>
<%@ include file="/WEB-INF/jsp/common/css.jsp" %>
<%@ include file="/WEB-INF/jsp/common/js.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no"/>
    <meta http-equiv="Cache-Control" content="no-siteapp"/>
    <title>添加权限</title>
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
    <input type="text" class="input-text" name="updateOrSave" value="${permission.id}" placeholder="" hidden="true">
    <div class="layui-form-item">
        <label class="layui-form-label">ID</label>
        <div class="layui-input-block">
            <input type="text" name="id" value="${permission.id}" lay-verify="required" placeholder="请输入ID" autocomplete="off"
                   class="layui-input">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">资源名称</label>
        <div class="layui-input-block">
            <input type="text" name="name" value="${permission.name}" lay-verify="required" placeholder="请输入资源名称" autocomplete="off"
                   class="layui-input">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">信息来源</label>
        <div class="layui-input-block">
            <select name="type" lay-verify="required">
                <c:set var="type" scope="request" value="${permission.type}"></c:set>
                <option value="menu" <c:if test="${type == 'menu'}">selected</c:if>>菜单</option>
                <option value="permission" <c:if test="${type == 'permission'}">selected</c:if>>权限</option>
            </select>
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">URL</label>
        <div class="layui-input-block">
            <input type="text" name="url" value="${permission.url}" lay-verify="required" placeholder="请输入URL" autocomplete="off"
                   class="layui-input">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">权限码</label>
        <div class="layui-input-block">
            <input type="text" name="percode" value="${permission.percode}" placeholder="请输入权限码" autocomplete="off" class="layui-input">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">直接父ID</label>
        <div class="layui-input-block">
            <input type="text" name="pId" value="${permission.pId}" lay-verify="required" placeholder="请输入直接父ID" autocomplete="off"
                   class="layui-input">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">排序字段</label>
        <div class="layui-input-block">
            <input type="text" name="sortstr" value="${permission.sortstr}" placeholder="请输入排序字段" autocomplete="off" class="layui-input">
        </div>
    </div>


    <div class="layui-form-item layui-hide">
        <input type="button" lay-submit lay-filter="perm-add-submit" id="perm-add-submit" value="确认">
    </div>

</div>

<script>
    layui.use(['form'], function () {
        var $ = layui.$,
            form = layui.form;
    })
</script>
</body>

</html>