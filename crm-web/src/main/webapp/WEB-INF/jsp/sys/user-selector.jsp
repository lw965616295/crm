<!DOCTYPE HTML>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/tag.jsp"%>
<%@ include file="/WEB-INF/jsp/common/css.jsp"%>
<%@ include file="/WEB-INF/jsp/common/js.jsp"%>
<html>
<head>
    <meta charset="utf-8">
    <title>用户选择器</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
        content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <style>
        html {
            background-color: #fff;
        }

        .from-btn {
            float: right;
        }
    </style>
</head>

<body>
    <div class="layui-fluid">
        <div class="layui-row layui-col-space15">
            <div class="layui-col-md12">
                <div class="layui-card">

                    <div class="layui-form layui-card-header layuiadmin-card-header-auto">
                        <div class="layui-form-item">

                            <div class="layui-inline">
                                <div class="layui-input-block" style="margin-left: 10px;">
                                    <select name="searchType">
                                        <option value="account">账号</option>
                                        <option value="name">姓名</option>
                                        <option value="mobilePhone">手机号</option>
                                        <option value="deptName">部门</option>
                                        <option value="positionName">岗位</option>
                                    </select>
                                </div>
                            </div>

                            <div class="layui-inline">
                                <label class="layui-form-label">搜索</label>
                                <div class="layui-input-block">
                                    <input type="text" name="searchValue" placeholder="请输入" autocomplete="off"
                                           class="layui-input">
                                </div>
                            </div>

                            <div class="layui-inline">
                                <!-- 搜索按钮 -->
                                <button id="btn_search" class="layui-btn " lay-submit lay-filter="LAY-user-search">
                                    <i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
                                </button>
                            </div>

                        </div>
                    </div>

                    <div class="layui-card-body">
                        <!-- 表格容器 -->
                        <table id="user-table" lay-filter="user-table"></table>
                    </div>

                    <!-- 按钮盒子 -->
                    <div class="layui-input-block from-btn">
                        <button class="layui-btn layui-btn-normal" data-type="btn_ok">确定</button>
                        <button class="layui-btn layui-btn-primary" data-type="btn_cancel">取消</button>
                    </div>

                </div>
            </div>

        </div>
    </div>

    <script>
        /*回车查询*/
        document.onkeydown = function (e) {
            if (e.keyCode == 13) {
                $("#btn_search").click();
            }
        }

        layui.use(['form', 'table'], function () {
            var $ = layui.$,
                table = layui.table,
                form = layui.form;

            tableIns = table.render({
                elem: '#user-table',
                url: '${baseurl}/user/query', //数据接口
                method: 'post',
                request: {
                    limitName: 'rows' //每页数据量的参数名，默认：limit
                },
                response: {
                    statusCode: 1 //规定成功的状态码，默认：0
                    , countName: 'total' //规定数据总数的字段名称，默认：count
                    , dataName: 'rows' //规定数据列表的字段名称，默认：data
                },
                where: {status: 1},
                page: true, //开启分页
                limit: 15,
                limits: [15, 50, 100],
                height: "full-180",
                text: "对不起，加载出现异常！",
                cols: [
                    [{
                        type: 'radio',
                        fixed: "left"
                    }, {
                        field: 'account',
                        title: '账号'
                    },{
                        field: 'name',
                        title: '姓名'
                    }, {
                        field: 'gender',
                        title: '性别',
                    }, {
                        field: 'deptName',
                        title: '部门'
                    }, {
                        field: 'positionName',
                        title: '岗位',
                    }]
                ]
            });

            //监听搜索
            form.on('submit(LAY-user-search)', function (data) {
                var field = data.field;
                var data = new Array();
                data[field.searchType] = field.searchValue;
                data["status"] = 1;
                console.log(data);
                //执行重载
                tableIns.reload({
                    where: data,
                });
            });

            var index = parent.layer.getFrameIndex(window.name); // 得到当前iframe层的索引
            //事件 
            var active = {
                btn_cancel: function () { // 取消
                    parent.layer.close(index);
                },
                btn_ok: function () {
                    var checkStatus = table.checkStatus('user-table'); // 当前点击行数据

                    if (checkStatus.data.length == 0) {
                        layer.msg('你未选中任何数据！', {
                            time: 1500, //20s后自动关闭
                        });
                    } else {
                        //回显数据
                         parent.$("#selector_user_name").val(checkStatus.data[0].name);
                         parent.$("#selector_user_id").val(checkStatus.data[0].id);
                        parent.layer.close(index);
                    }
                }
            };


            // 事件调用
            $('.layui-btn,.layui-input').on('click', function () {
                var type = $(this).data('type');
                active[type] ? active[type].call(this) : '';
            });

        });
    </script>
</body>

</html>