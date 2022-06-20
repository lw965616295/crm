<!DOCTYPE HTML>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jsp/common/tag.jsp" %>
<%@ include file="/WEB-INF/jsp/common/css.jsp" %>
<%@ include file="/WEB-INF/jsp/common/js.jsp" %>
<html>

<head>
    <meta charset="utf-8">
    <title>联系人详情</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">

    <style>
        .badge {
            margin-left: 10px;
            padding: 4px 12px;
            background-color: #1ab394;
            color: #FFFFFF;
            text-align: center;
            white-space: nowrap;
            vertical-align: middle;
            border-radius: 10px;
        }


        .cusTab th,
        .cusTab td {
            background-color: #fff;
            color: #050505;
        }

        .cusTab tr th:nth-of-type(odd),
        .cusTab tr td:nth-of-type(odd) {
            color: #999;
        }

        .cusTab th div:hover,
        .cusTab th div:focus,
        .cusTab td div:hover,
        .cusTab td div:focus {
            text-decoration: none;
            cursor: pointer;
            color: #23527c;
        }

        .cusTab td div,
        .cusTab th div {
            color: #337ab7;
        }

        td i {
            padding-left: 10px;
            color: #1E9FFF;
            cursor: pointer;
        }
    </style>
</head>

<body>
<div class="layui-fluid">
    <div class="layui-card">
        <div class=" layui-card-header layuiadmin-card-header-auto">
            <img src="https://my.crm.cc/Public/img/contacts_view_icon.png" class="layui-nav-img">
            <div class="layui-inline" style="font-size: 21px;margin-left: 5px;color: #676a6c;">
                ${contact.name}
            </div>
            <span class="badge">${contact.role}</span>
        </div>

        <div class="layui-card">
            <div class="layui-card-body">
                <div class="layui-tab layui-tab-brief" lay-filter="component-tabs-hash">
                    <ul class="layui-tab-title">
                        <li class="layui-this" lay-id="11">基本信息</li>
                    </ul>

                    <div class="layui-tab-content">
                        <!-- 基本信息 -->
                        <div class="layui-tab-item layui-show">

                            <table class="layui-table cusTab" lay-skin="nob">
                                <colgroup>
                                    <col width="150">
                                    <col width="200">
                                    <col width="200">
                                    <col width="200">
                                </colgroup>
                                <thead>
                                <tr>
                                    <th>所属客户</th>
                                    <th>
                                        ${contact.cusName}
                                    </th>

                                    <th>联系人姓名</th>
                                    <th>${contact.name}</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr>
                                    <td>角色</td>
                                    <td>${contact.role}</td>
                                    <td>尊称</td>
                                    <td>${contact.callname}</td>
                                </tr>
                                <tr>
                                    <td>职位</td>
                                    <td>${contact.position}</td>
                                    <td>手机</td>
                                    <td>${contact.phone}</td>
                                </tr>
                                <tr>
                                    <td>QQ</td>
                                    <td>${contact.qq}</td>
                                    <td>邮箱</td>
                                    <td>${contact.email}</td>
                                </tr>
                                <tr>
                                    <td>地址</td>
                                    <td>${contact.address}<i class="layui-icon layui-icon-location"
                                                             onclick="map()"></i></td>
                                    <td>邮编</td>
                                    <td>${contact.postcode}</td>
                                </tr>
                                <tr>
                                    <td>备注</td>
                                    <td>${contact.ch2}</td>
                                    <td></td>
                                    <td></td>
                                </tr>
                                </tbody>
                            </table>

                        </div>

                    </div>
                </div>
            </div>
        </div>

    </div>
</div>


<script>
    layui.use(['laydate', 'form', 'element', 'table'], function () {
        var $ = layui.$,
            element = layui.element,
            laydate = layui.laydate,
            table = layui.table,
            form = layui.form;

    });

    function map() {

        layer.open({

            title: "查看地图",
            type: 2,
            area: ['700px', '450px'],
            maxmin: true,
            content: '${baseurl}/contact/map?address=${contact.address}'
        });

    }

</script>
</body>

</html>