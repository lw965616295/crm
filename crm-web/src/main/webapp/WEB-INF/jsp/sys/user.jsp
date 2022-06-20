<!DOCTYPE HTML>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jsp/common/tag.jsp" %>
<%@ include file="/WEB-INF/jsp/common/css.jsp" %>
<%@ include file="/WEB-INF/jsp/common/js.jsp" %>
<html>

<head>
    <meta charset="utf-8">
    <title>用户管理</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
</head>

<body>

<div class="layui-fluid">
    <div class="layui-card">
        <div class="layui-form layui-card-header layuiadmin-card-header-auto">
            <div class="layui-form-item">

                <div class="layui-inline">
                    <button class="layui-btn" data-type="add_user" id="add_user">新建用户</button>
                </div>

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
                    <div class="layui-input-block" style="margin-left: 10px;">
                        <select name="status">
                            <option value="">全部</option>
                            <option value="1" selected>启用</option>
                            <option value="0">禁用</option>
                        </select>
                    </div>
                </div>
                <div class="layui-inline">
                    <!-- 搜索按钮 -->
                    <button id="btn_search" class="layui-btn " lay-submit lay-filter="LAY-user-front-search">
                        <i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
                    </button>
                </div>

            </div>
        </div>

        <div class="layui-card-body">


            <!-- 表格容器 -->
            <table id="LAY-user-manage" lay-filter="LAY-user-manage"></table>

            <script type="text/html" id="toolbarDemo">
                <div class="layui-btn-container">
                    <button class="layui-btn layui-btn-sm layui-hide" lay-event="update" id="btn_update">编辑</button>
                    <button class="layui-btn layui-btn-sm layui-hide" lay-event="delete" id="btn_del">禁用</button>
                    <button class="layui-btn layui-btn-sm layui-hide" lay-event="allot" id="btn_allot">分配</button>
                </div>
            </script>

        </div>
    </div>
</div>


<!-- 审核状态 -->
<script type="text/html" id="buttonTpl">
    {{#  if(d.status == true){ }}
    <button class="layui-btn layui-btn-xs">启用</button>
    {{#  } else { }}
    <button class="layui-btn layui-btn-danger layui-btn-xs">禁用</button>
    {{#  } }}
</script>

<script>
    /*回车查询*/
    document.onkeydown = function (e) {
        if (e.keyCode == 13) {
            $("#btn_search").click();
        }
    }
    layui.use(['form', 'table'], function () {

        var $ = layui.$,
            form = layui.form,
            table = layui.table;

        //使用表格
        var tableIns = table.render({
            elem: '#LAY-user-manage',
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
            height: "full-220",
            text: "对不起，加载出现异常！",
            toolbar: '#toolbarDemo',
            defaultToolbar: ['filter'],
            cols: [
                [ //表头
                    {
                        type: "checkbox",
                        fixed: "left"
                    }, {
                    field: "account",
                    title: "账号",
                    width: "6%",
                    event: 'account', // 点击事件绑定
                    style: "color: #2898E0;cursor:pointer;" // 样式
                }, {
                    field: "name",
                    title: "姓名",
                    width: "6%"
                }, {
                    field: "gender",
                    title: "性别",
                    align: 'center',
                    width: "5%"
                }, {
                    field: "age",
                    title: "年龄",
                    align: 'center',
                    width: "5%"
                }, {
                    field: "mobilePhone",
                    title: "手机号",
                    width: "8%"
                }, {
                    field: "password",
                    title: "密码",
                    width: "8%"
                }, {
                    field: "officePhone",
                    title: "办公电话",
                    width: "8%"
                }, {
                    field: "qqMsn",
                    title: "QQ/MSN",
                    width: "8%"
                }, {
                    field: "email",
                    title: "邮箱",
                    width: "12%"
                }, {
                    field: "deptName",
                    title: "部门",
                    width: "10%"
                }, {
                    field: "positionName",
                    title: "岗位",
                    width: "10%"
                }, {
                    field: "address",
                    title: "联系地址",
                    width: "25%"
                }, {
                    field: "createBy",
                    title: "创建人",
                    width: "8%"
                }, {
                    field: "createTime",
                    title: "创建时间",
                    width: "10%",
                    templet: function (d) {
                        return dateFormatter1(d.createTime);
                    }
                }, {
                    field: "status",
                    title: "状态",
                    templet: "#buttonTpl",
                    fixed: "right",
                    width: "5%"
                }
                ]
            ]
        });

        //添加用户
        $("#add_user").click(function () {
            layer.open({
                type: 2,
                title: '新建用户',
                content: '${baseurl}/user/addPage',
                maxmin: true,
                area: ['820px', '600px'],
                btn: ['确定', '取消'],
                yes: todo
            });
        });
        //监听搜索
        form.on('submit(LAY-user-front-search)', function (data) {
            var field = data.field;
            var data = new Array();
            data[field.searchType] = field.searchValue;
            data["status"] = field.status;
            console.log(data);
            //执行重载
            tableIns.reload({
                where: data,
            });
        });

        //表头按钮监听
        table.on('toolbar(LAY-user-manage)', function (obj) {
            var checkStatus = table.checkStatus('LAY-user-manage');
            selectData = checkStatus.data;
            switch (obj.event) {
                case 'update':
                    layer.open({
                        type: 2,
                        title: '编辑用户',
                        content: '${baseurl}/user/updatePage?id=' + selectData[0].id,
                        maxmin: true,
                        area: ['820px', '600px'],
                        btn: ['确定', '取消'],
                        yes: todo
                    });
                    break;
                case 'delete':
                    layer.confirm('确认要作废吗？', function () {
                        var ids = "";
                        $.each(selectData, function (i, n) {
                            ids += n.id + ',';
                        });
                        console.log(ids);
                        $.get("${baseurl}/user/delete?ids=" + ids, function (data) {
                            var d = JSON.parse(data);
                            if (d.code == 1) {
                                layer.msg(d.msg, {icon: 1, time: 1000});
                                tableIns.reload(); //数据刷新
                            } else {
                                layer.msg(d.msg, {icon: 2, time: 1000});
                            }
                        });
                    });
                    break;
                case 'allot':
                    layer.open({
                        type: 2,
                        title: '用户分配',
                        content: '${baseurl}/user/allotPage?id=' + selectData[0].id,
                        maxmin: true,
                        area: ['820px', '600px']
                    });
                    break;
            }
            ;
        });

        //监听单元格事件
        table.on('tool(LAY-user-manage)', function (obj) {
            var data = obj.data;
            console.log(data)
            if (obj.event === 'account') {
                layer.open({
                    title: "基本信息",
                    type: 2,
                    content: '${baseurl}/user/baseInfoPage?id='+data.id,
                    area: ['800px', '500px'],
                    maxmin: true
                });
            }
            ;
        });

        // 表格元素选中显示按钮
        table.on('checkbox(LAY-user-manage)', function (obj) {
            var checkStatus = table.checkStatus('LAY-user-manage');
            if (checkStatus.data.length == 0) { //未选择不显示
                $("#btn_update").addClass("layui-hide");
                $("#btn_del").addClass("layui-hide");
                $("#btn_allot").addClass("layui-hide");
            } else if (checkStatus.data.length == 1) { // 选择一个，都显示
                $("#btn_update").removeClass("layui-hide");
                $("#btn_del").removeClass("layui-hide");
                $("#btn_allot").removeClass("layui-hide");

            } else { // 选择多个，只显示作废
                $("#btn_update").addClass("layui-hide");
                $("#btn_del").removeClass("layui-hide");
                $("#btn_allot").addClass("layui-hide");
            }
        });

        /*处理回调事件，新增or更新*/
        function todo(index, layero) {
            var iframeWindow = window['layui-layer-iframe' + index],
                submitID = 'user-add-submit',
                submit = layero.find('iframe').contents().find('#' +
                    submitID);
            //监听提交
            iframeWindow.layui.form.on('submit(' + submitID + ')',
                function (data) {
                    var field = data.field; //获取提交的字段
                    if (field.id == "") {
                        //处理新增逻辑
                        var url = '${baseurl}/user/save';
                    } else {
                        //处理更新逻辑
                        var url = '${baseurl}/user/update';
                    }
                    console.log(field)
                    //提交 Ajax 成功后，静态更新表格中的数据
                    $.ajax({
                        type: 'post',
                        url: url,
                        data: field,
                        success: function (data) {
                            var code = JSON.parse(data).code;
                            if (code == 1) {
                                layer.msg('操作成功', {
                                    icon: 1,
                                    time: 500, //0.5秒关闭
                                }, function () {
                                    layer.close(index); //关闭弹层
                                    tableIns.reload(); //数据刷新
                                });
                            } else {
                                layer.alert(JSON.parse(data).msg, {icon: 2});
                            }
                        }
                    });
                });
            submit.trigger('click');
        }
    });
</script>
</body>

</html>