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
    <title>角色管理</title>
</head>

<body>

<div class="layui-fluid">
    <div class="layui-card">
        <div class="layui-form layui-card-header layuiadmin-card-header-auto">
            <div class="layui-form-item">

                <div class="layui-inline">
                    <button class="layui-btn" data-type="add_role" id="add_role">新建角色</button>
                </div>

                <div class="layui-inline">
                    <div class="layui-input-block" style="margin-left: 10px;">
                        <select name="searchType" >
                            <option value="name">名称</option>
                            <option value="description">描述</option>
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
                    <button class="layui-btn " lay-submit lay-filter="LAY-role-search" id="btn_search">
                        <i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
                    </button>
                </div>

            </div>
        </div>

        <div class="layui-card-body">
            <!-- 表格容器 -->
            <table id="LAY-role-manage" lay-filter="LAY-role-manage"></table>

            <script type="text/html" id="toolbarDemo">
                <div class="layui-btn-container">
                    <button class="layui-btn layui-btn-sm layui-hide" lay-event="update" id="btn_update">编辑</button>
                    <button class="layui-btn layui-btn-sm layui-hide" lay-event="delete" id="btn_del">删除</button>
                    <button class="layui-btn layui-btn-sm layui-hide" lay-event="author" id="btn_author">授权</button>
                </div>
            </script>

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
    layui.use(['table','form'], function () {

        var $ = layui.$,
            form = layui.form,
            table = layui.table;

        //使用表格
        var tableIns = table.render({
            elem: '#LAY-role-manage',
            url: '${baseurl}/role/query', //数据接口
            method: 'post',
            request: {
                limitName: 'rows' //每页数据量的参数名，默认：limit
            },
            response: {
                statusCode: 1 //规定成功的状态码，默认：0
                , countName: 'total' //规定数据总数的字段名称，默认：count
                , dataName: 'rows' //规定数据列表的字段名称，默认：data
            },
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
                    },  {
                    field: "name",
                    title: "名称",
                }, {
                    field: "description",
                    title: "描述",
                },
                ]
            ]
        });
        //添加角色
        $("#add_role").click(function () {
            layer.open({
                type: 2,
                title: '新建角色',
                content: '${baseurl}/role/addPage',
                maxmin: true,
                area: ['820px', '600px'],
                btn: ['确定', '取消'],
                yes: todo
            });
        });
        //监听搜索
        form.on('submit(LAY-role-search)', function (data) {
            var field = data.field;
            var data = new Array();
            data[field.searchType] = field.searchValue;
            console.log(data);
            //执行重载
            table.reload({
                where: data
            });
        });
        //表头按钮监听
        table.on('toolbar(LAY-role-manage)', function (obj) {
            var checkStatus = table.checkStatus('LAY-role-manage');
            selectData = checkStatus.data;
            switch (obj.event) {
                case 'update':
                    layer.open({
                        type: 2,
                        title: '编辑角色',
                        content: '${baseurl}/role/updatePage?id=' + selectData[0].id,
                        maxmin: true,
                        area: ['820px', '600px'],
                        btn: ['确定', '取消'],
                        yes: todo
                    });
                    break;
                case 'delete':
                    layer.confirm('确认要删除吗？', function () {
                        var ids = "";
                        $.each(selectData, function (i, n) {
                            ids += n.id + ',';
                        });
                        console.log(ids);
                        $.get("${baseurl}/role/delete?ids=" + ids, function (data) {
                            var d = JSON.parse(data);
                            if (d.code == 1) {
                                layer.msg(d.msg, {icon: 1, time: 1000});
                                tableIns.reload();; //数据刷新
                            } else {
                                layer.msg(d.msg, {icon: 2, time: 1000});
                            }
                        });
                    });
                    break;
                case 'author':
                    layer.open({
                        type: 2,
                        title: '角色授权',
                        content: '${baseurl}/role/authorPage?id=' + selectData[0].id,
                        maxmin: true,
                        area: ['820px', '600px']
                    });
                    break;
            }
            ;
        });

        // 表格元素选中显示按钮
        table.on('checkbox(LAY-role-manage)', function (obj) {
            var checkStatus = table.checkStatus('LAY-role-manage');
            if (checkStatus.data.length == 0) { //未选择不显示
                $("#btn_update").addClass("layui-hide");
                $("#btn_del").addClass("layui-hide");
                $("#btn_author").addClass("layui-hide");
            } else if (checkStatus.data.length == 1) { // 选择一个，都显示
                $("#btn_update").removeClass("layui-hide");
                $("#btn_del").removeClass("layui-hide");
                $("#btn_author").removeClass("layui-hide");

            } else { // 选择多个，只显示作废
                $("#btn_update").addClass("layui-hide");
                $("#btn_del").removeClass("layui-hide");
                $("#btn_author").addClass("layui-hide");
            }
        });

        /*处理回调事件，新增or更新*/
        function todo(index, layero) {
            var iframeWindow = window['layui-layer-iframe' + index],
                submitID = 'role-add-submit',
                submit = layero.find('iframe').contents().find('#' +
                    submitID);
            //监听提交
            iframeWindow.layui.form.on('submit(' + submitID + ')',
                function (data) {
                    var field = data.field; //获取提交的字段
                    if (field.id == "") {
                        //处理新增逻辑
                        var url = '${baseurl}/role/save';
                    } else {
                        //处理更新逻辑
                        var url = '${baseurl}/role/update';
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
                                    tableIns.reload();; //数据刷新
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