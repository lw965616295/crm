<!DOCTYPE HTML>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/tag.jsp"%>
<%@ include file="/WEB-INF/jsp/common/css.jsp"%>
<%@ include file="/WEB-INF/jsp/common/js.jsp"%>
<html>
<head>
    <meta charset="utf-8">
    <title>基本信息</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
        content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <style>
        html {
            background-color: #fff;
        }

        .layui-card-header {
            height: 60px;
            line-height: 0;
        }

        .headPort {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            max-width: 100%;
            margin-right: 8%;
            border: 0;
            vertical-align: bottom;
        }

        .accountBox {
            display: inline-block;
            height: 60px;
            line-height: 30px;
        }

        .accountBox h3 {
            font-size: 19px;
            color: #000;
            font-weight: bold;
        }

        .accountBox p span {
            color: #000;
        }

        th,
        td {
            background-color: #fff;
        }

        th {
            color: #000;
        }

        tr td:nth-child(even) {
            color: #000;
        }
    </style>
</head>

<body>

    <div class="layui-fluid">
        <div class="layui-row layui-col-space15">
            <div class="layui-col-md12">
                <div class="layui-card">
                    <div class="layui-card-header">
                        <c:set var="iconUrl" value="${baseurl}/images/favicon.ico"/>
                        <c:if test="${user.iconUrl != null}">
                            <c:set var="iconUrl" value="${user.iconUrl}"/>
                        </c:if>
                        <img class="headPort"
                            src="${iconUrl}">

                        <div class="accountBox">
                            <h3>${user.account}</h3>
                            <p>账号状态：
                                <c:if test="${user.status == 0}">
                                    <span style="color: red">禁用</span>
                                </c:if>
                                <c:if test="${user.status == 1}">
                                    <span style="color: green">启用</span>
                                </c:if>
                            </p>
                        </div>
                    </div>

                    <div class="layui-card-body">

                        <table class="layui-table" lay-even="" lay-skin="nob">
                            <colgroup>
                                <col width="150">
                                <col width="200">
                                <col width="150">
                                <col width="200">
                            </colgroup>
                            <thead>
                                <tr>
                                    <th>基本信息</th>
                                    <th></th>
                                    <th></th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>姓名</td>
                                    <td>${user.name}</td>
                                    <td>性别</td>
                                    <td>${user.gender}</td>
                                </tr>
                                <tr>
                                    <td>部门</td>
                                    <td>${user.deptName}</td>
                                    <td>岗位</td>
                                    <td>${user.positionName}</td>
                                </tr>
                                <tr>
                                    <td>手机</td>
                                    <td>${user.mobilePhone}</td>
                                    <td>邮箱</td>
                                    <td>${user.email}</td>
                                </tr>
                                <tr>
                                    <td>QQ/MSN</td>
                                    <td>${user.qqMsn}</td>
                                    <td>地址</td>
                                    <td>${user.address}</td>
                                </tr>
                            </tbody>
                        </table>

                    </div>
                </div>
            </div>

        </div>
    </div>

    <script>
        layui.use('layer', function () {

        });
    </script>
</body>

</html>