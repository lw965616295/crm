<!DOCTYPE HTML>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jsp/common/tag.jsp" %>
<%@ include file="/WEB-INF/jsp/common/css.jsp" %>
<%@ include file="/WEB-INF/jsp/common/js.jsp" %>
<html>

<head>
    <meta charset="utf-8">
    <title>客户</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <style>
        .layui-rate {
            padding: 0;
        }
    </style>
</head>

<body>

<div class="layui-fluid">
    <div class="layui-card">
        <div class="layui-form layui-card-header layuiadmin-card-header-auto">
            <div class="layui-form-item">

                <div class="layui-inline">
                    <div class="layui-input-block" style="margin-left: 10px;">
                        <select name="cusRange">
                            <option value="0">我的客户</option>
                            <shiro:hasPermission name="cus:range">
                            <option value="1">下属客户</option>
                            <option value="2">全部客户</option>
                            </shiro:hasPermission>
                        </select>
                    </div>
                </div>

                <div class="layui-inline">
                    <label class="layui-form-label">搜索</label>
                    <div class="layui-input-block">
                        <input type="text" name="queryStr" placeholder="请输入" autocomplete="off"
                               class="layui-input">
                    </div>
                </div>

                <div class="layui-inline">
                    <input id="beginTime" name="beginTime" type="text" class="layui-input" placeholder="开始时间">
                </div>
                <div class="layui-inline">
                    -
                </div>
                <div class="layui-inline">
                    <input id="endTime" name="endTime" type="text" class="layui-input" placeholder="结束时间">
                </div>
                <shiro:hasPermission name="cus:query">
                <div class="layui-inline">
                    <!-- 搜索按钮 -->
                    <button class="layui-btn " lay-submit lay-filter="searchFilter">
                        <i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
                    </button>
                </div>
                </shiro:hasPermission>
            </div>
        </div>

        <div class="layui-card-body">
            <!-- 表格容器 -->
            <table id="cus-table" lay-filter="cus-table"></table>

            <!-- 表头 -->
            <script type="text/html" id="toolbarDemo">
                <shiro:hasPermission name="cus:update">
                <button class="layui-btn layui-btn-sm layui-hide" lay-event="update" id="btn_update">编辑</button>
                </shiro:hasPermission>
                <shiro:hasPermission name="cus:toPool">
                <button class="layui-btn layui-btn-sm layui-hide" lay-event="toPool" id="btn_toPool">放回客户池</button>
                </shiro:hasPermission>
            </script>

            <!-- 客户评星 -->
            <script type="text/html" id="cusGrade">
                <!-- 给星星容器设置动态id -->
                <div id="cusGrade{{d.id}}"></div>
            </script>

            <!-- 到期天数 -->
            <script type="text/html" id="dueDay">
                {{#  if(d.islocked == 1){ }}
                <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="noLock"><i
                        class="layui-icon layui-icon-password"></i> 已锁定</a>
                {{#  } else { }}
                <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="lock" style="color: red"><i
                        class="layui-icon layui-icon-set"></i> {{d.dueDay}}天</a>
                {{#  } }}
            </script>

            <!-- 置顶 -->
            <script type="text/html" id="totop">
                {{#  if(d.totop != undefined){ }}
                <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="noTop">取消置顶</a>
                {{#  } else { }}
                <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="totop"><i
                        class="layui-icon layui-icon-top"></i> 置顶</a>
                {{#  } }}
            </script>

            <!-- 快捷操作 -->
            <script type="text/html" id="operating">
                <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="addProduct"><i
                        class="layui-icon layui-icon-template-1"></i> 商机</a>
            </script>

            <%--创建时间格式化--%>
            <script type="text/html" id="createTimeFormatter">
                {{dateFormatter1(d.createTime)}}
            </script>
            <%--最近跟进--%>
            <script type="text/html" id="modifyTimeFormatter">
                {{dateFormatter1(d.modifyTime)}}
            </script>
            <%--下次联系时间--%>
            <script type="text/html" id="nextTimeFormatter">
                {{#  if(d.nextTime != undefined){
                        var next = dateFormatter1(d.nextTime);
                        var d = new Date();
                        var today = dateFormatter1(d.getTime());
                        if(next < today){
                            return '<span style="color: red;">'+next+'</span>';
                        }else if(next > today){
                            return '<span style="color: green;">'+next+'</span>';
                        }else{
                            return next;
                            }
                        }
                }}
            </script>
        </div>
    </div>
</div>

<script>
    layui.use(['table', 'rate', 'laydate', 'form'], function () {

        var $ = layui.$,
            form = layui.form,
            table = layui.table,
            laydate = layui.laydate,
            rate = layui.rate;

        //使用日期(开始)
        laydate.render({
            elem: '#beginTime',
            done: function (value, date, endDate) {
                var beginTime = new Date(value).getTime();
                var endTime = new Date($("#endTime").val()).getTime();
                if (beginTime > endTime) {
                    layer.msg("开始时间不能大于结束时间！")
                    $("#endTime").val(value);
                }
            }
        });
        //使用日期(结束)
        laydate.render({
            elem: '#endTime',
            done: function (value, date, endDate) {
                var endTime = new Date(value).getTime();
                var beginTime = new Date($("#beginTime").val()).getTime();
                if (beginTime > endTime) {
                    layer.msg("开始时间不能大于结束时间！")
                    $("#beginTime").val(value);
                }
            }
        });

        //使用表格
        tableIns = table.render({
            elem: '#cus-table',
            url: '${baseurl}/customer/query', //数据接口
            method: 'post',
            request: {
                limitName: 'rows' //每页数据量的参数名，默认：limit
            },
            response: {
                statusCode: 1 //规定成功的状态码，默认：0
                , countName: 'total' //规定数据总数的字段名称，默认：count
                , dataName: 'rows' //规定数据列表的字段名称，默认：data
            },
            where: {status: 2, cusRange: 0},
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
                    },{
                    field: "cusName",
                    title: "客户名称",
                    width: "10%",
                    align:"center",
                    event: 'cusName', // 点击事件绑定
                    style: "color: #2898E0;cursor:pointer;" // 样式
                }, {
                    field: "contactName",
                    title: "客户联系人",
                    width: "10%",
                    align:"center",
                    event: 'contactName', // 点击事件绑定
                    style: "color: #2898E0;cursor:pointer;" // 样式
                }, {
                    field: "conPhone",
                    title: "联系人电话",
                    align:"center",
                    width: "11%"
                }, {
                    field: "leaderName",
                    title: "客户负责人",
                    width: "11%",
                    align:"center",
                    event: 'leaderName', // 点击事件绑定
                    style: "color: #2898E0;cursor:pointer;" // 样式
                }, {
                    field: "cusCode",
                    title: "客户编号",
                    width: "13%",
                    align:"center",
                    align: "center"
                }, {
                    field: "content",
                    title: "下次联系内容",
                    align:"center",
                    width: "11%"
                }, {
                    field: "nextTime",
                    title: "下次联系时间",
                    templet: '#nextTimeFormatter',
                    align:"center",
                    width: "11%"
                }, {
                    field: "cusStatus",
                    title: "客户状态",
                    align:"center",
                    width: "10%"
                }, {
                    field: "cusBelong",
                    title: "客户行业",
                    align:"center",
                    width: "10%"
                }, {
                    field: "address",
                    title: "客户地址",
                    align:"center",
                    width: "15%"
                }, {
                    field: "infoFrom",
                    title: "客户信息来源",
                    width: "11%",
                    align:"center",
                    align: "center"
                }, {
                    field: "staffNum",
                    title: "员工数",
                    align:"center",
                    width: "10%"
                }, {
                    field: "cusGrade",
                    title: "客户等级",
                    align:"center",
                    width: "15%",
                    toolbar: "#cusGrade"
                }, {
                    field: "createrName",
                    title: "创建人",
                    width: "10%",
                    align:"center",
                    event: 'createrName', // 点击事件绑定
                    style: "color: #2898E0;cursor:pointer;" // 样式
                }, {
                    field: "createTime",
                    title: "创建时间",
                    align:"center",
                    sort: true,
                    templet: '#createTimeFormatter',
                    align:"center",
                    width: "11%",
                }, {
                    field: "dueDay",
                    title: "距到期天数",
                    align:"center",
                    width: "12%",
                    sort: true,
                    toolbar: "#dueDay"
                }, {
                    field: "modifyTime",
                    title: "最近跟进",
                    sort: true,
                    align:"center",
                    templet: '#modifyTimeFormatter',
                    width: "11%"
                }, {
                    field: "totop",
                    title: "置顶状态",
                    align:"center",
                    width: "11%",
                    align: "center",
                    toolbar: "#totop"
                }, {
                    field: "operating",
                    title: "快捷操作",
                    fixed: "right",
                    width: "10%",
                    align:"center",
                    toolbar: "#operating",
                    align: "center"
                }
                ]
            ],
            done: function (res, curr, count) {
                for (var i = 0; i < count; i++) {
                    //渲染星星
                    rate.render({
                        elem: '#cusGrade' + res.rows[i].id, // 获取星星的id
                        value: res.rows[i].cusGrade, // 获取星星数
                        readonly: true // 只读
                    });
                }
            }
        });

        //监听搜索
        form.on('submit(searchFilter)', function (data) {
            var field = data.field;
            var data = new Array();
            data["queryStr"] = field.queryStr;
            data["status"] = 2;
            data["beginTime"] = field.beginTime;
            data["endTime"] = field.endTime;
            data["cusRange"] = field.cusRange;
            console.log(data);
            //执行重载
            tableIns.reload({
                where: data,
            });


        });

        //监听单元格事件
        table.on('tool(cus-table)', function (obj) {
            var data = obj.data;
            if (obj.event === 'cusName') {
                //console.log(data) // 当前点击行数据

                var index = layer.open({
                    title: "客户详情",
                    type: 2,
                    content: '${baseurl}/customer/cusDetailPage?id=' + data.id,
                    area: ['900px', '600px'],
                    maxmin: true
                });
                layer.full(index);
            } else if (obj.event === 'contactName') {
                if(data.contactName != undefined){
                    var index = layer.open({

                        title: "联系人详情",
                        type: 2,
                        content: '${baseurl}/contact/queryById?id=' + data.contactId,

                        area: ['300px', '300px'],
                        maxmin: true
                    });
                    layer.full(index);
                }

            } else if (obj.event === 'leaderName') {

                layer.open({
                    title: "基本信息",
                    type: 2,
                    content: '${baseurl}/user/baseInfoPage?id=' + data.leader,
                    area: ['800px', '500px'],
                    maxmin: true
                });
            } else if (obj.event === 'createrName') {
                layer.open({
                    title: "基本信息",
                    type: 2,
                    content: '${baseurl}/user/baseInfoPage?id=' + data.createBy,
                    area: ['800px', '500px'],
                    maxmin: true
                });
            } else if (obj.event === "totop") {
                //置顶
                var url = "${baseurl}/customer/totop";
                var da = {};
                da["id"] = data.id;
                da["topStatus"] = 1;
                $.post(url, da, function (res) {
                    var d = JSON.parse(res);
                    if (d.code == 1) {
                        layer.msg(d.msg, {icon: 1, time: 1000});
                        tableIns.reload(); //数据刷新
                    } else {
                        layer.alert(d.msg, {icon: 2});
                    }
                });
            } else if (obj.event === "noTop") {
                //取消置顶
                var url = "${baseurl}/customer/totop";
                var da = {};
                da["id"] = data.id;
                da["topStatus"] = 0;
                $.post(url, da, function (res) {
                    var d = JSON.parse(res);
                    if (d.code == 1) {
                        layer.msg(d.msg, {icon: 1, time: 1000});
                        tableIns.reload(); //数据刷新
                    } else {
                        layer.alert(d.msg, {icon: 2});
                    }
                });

            } else if (obj.event === "addProduct") {
                layer.msg('添加商机', {
                    time: 500, //0.5秒关闭
                })
            } else if (obj.event === "lock") {
                //锁定
                var url = "${baseurl}/customer/update";
                var da = {};
                da["id"] = data.id;
                da["islocked"] = 1;
                $.post(url, da, function (res) {
                    var d = JSON.parse(res);
                    if (d.code == 1) {
                        layer.msg(d.msg, {icon: 1, time: 1000});
                        tableIns.reload(); //数据刷新
                    } else {
                        layer.alert(d.msg, {icon: 2});
                    }
                });
            } else if (obj.event === "noLock") {
                //取消锁定
                var url = "${baseurl}/customer/update";
                var da = {};
                da["id"] = data.id;
                da["islocked"] = 0;
                $.post(url, da, function (res) {
                    var d = JSON.parse(res);
                    if (d.code == 1) {
                        layer.msg(d.msg, {icon: 1, time: 1000});
                        tableIns.reload(); //数据刷新
                    } else {
                        layer.alert(d.msg, {icon: 2});
                    }
                });
            }
            ;

        });

        //监听事件
        table.on('toolbar(cus-table)', function (obj) {
            var checkStatus = table.checkStatus('cus-table');
            selectData = checkStatus.data;
            switch (obj.event) {
                case 'toPool':
                    layer.confirm('确认要放回客户池吗？', function () {
                        var ids = "";
                        $.each(selectData, function (i, n) {
                            ids += n.id + ',';
                        });
                        console.log(ids);
                        $.get("${baseurl}/customer/toPool?ids=" + ids, function (data) {
                            var d = JSON.parse(data);
                            if (d.code == 1) {
                                layer.msg(d.msg, {icon: 1, time: 1000});
                                tableIns.reload(); //数据刷新
                            } else {
                                layer.alert(d.msg, {icon: 2});
                            }
                        });
                    });
                    break;
                case 'update':
                    var index = layer.open({
                        type: 2,
                        title: '编辑客户',
                        content: '${baseurl}/customer/updatePage?id=' + selectData[0].id,
                        maxmin: true,
                        area: ['900px', '600px']
                    });
                    layer.full(index);
                    break;
            }
            ;
        });

        // 单复选框操作

        /* 定义一个变量存储单复选框值，作为下面事件调动 */
        table.on('checkbox(cus-table)', function (obj) {
            var checkStatus = table.checkStatus('cus-table');
            selectData = checkStatus.data

            if (selectData.length == 0) { // 没有选择
                $("#btn_update").addClass("layui-hide");
                $("#btn_toPool").addClass("layui-hide");
            } else if (selectData.length == 1) { // 选择1个
                $("#btn_update").removeClass("layui-hide");
                $("#btn_toPool").removeClass("layui-hide");
            } else { // 选择超过1个
                $("#btn_update").addClass("layui-hide");
                $("#btn_toPool").removeClass("layui-hide");
            }
        });

    });
</script>
</body>

</html>