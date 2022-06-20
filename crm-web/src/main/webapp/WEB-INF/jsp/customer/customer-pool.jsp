<!DOCTYPE HTML>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jsp/common/tag.jsp" %>
<%@ include file="/WEB-INF/jsp/common/css.jsp" %>
<%@ include file="/WEB-INF/jsp/common/js.jsp" %>
<html>

<head>
    <meta charset="utf-8">
    <title>客户池</title>
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

<div style="display: none" id="importBox">
    <div align="center" style="margin-top: 20px;margin-bottom: 20px"><button class="layui-btn" data-type="import" id="import">选择文件</button></div>
    <div align="center"><a href="${baseurl}/templet/customer.xlsx" download="客户模板.xlsx">模版下载</a></div>

</div>

<div style="display: none" id="allotClue">


    <div class="layui-col-xs6 layui-col-sm6 layui-col-md6 layui-col-lg6">
        <label style="margin-top: 10px"  class="layui-form-label"><h5>客户分配</h5></label>
        <div class="layui-input-inline">
            <input style="margin-top: 10px" type="text" id="selector_user_name" placeholder="请选择需要分配的人员" onclick="allotClue2()"
                   autocomplete="off" class="layui-input" readonly>
        </div>
        <input type="text" id="selector_user_id" name="leader" value="" hidden>

        <div class="layui-form-item">

            <div class="layui-input-block from-btn">
                 <button style="margin-top: 20px" class="layui-btn layui-btn-sm " onclick="allotuser()" >确定</button>
            </div>
        </div>

    </div>

</div>






<div class="layui-fluid">
    <div class="layui-card">
        <div class="layui-form layui-card-header layuiadmin-card-header-auto">
            <div class="layui-form-item">
                <shiro:hasPermission name="cus:add">
                <div class="layui-inline">
                    <button class="layui-btn" data-type="add_info">新建客户</button>
                    <button class="layui-btn" data-type="importBtn">导入</button>
                </div>
                </shiro:hasPermission>
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

                <shiro:hasPermission name="cus:queryPool">
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
                <shiro:hasPermission name="cus:updatePool">
                <button class="layui-btn layui-btn-sm layui-hide" lay-event="update" id="btn_update">编辑</button>
                </shiro:hasPermission>
                <shiro:hasPermission name="cus:receive">
                <button class="layui-btn layui-btn-sm layui-hide" lay-event="receive" id="btn_receive">领用</button>
                </shiro:hasPermission>
                <shiro:hasPermission name="cus:allot">
                <button class="layui-btn layui-btn-sm layui-hide" lay-event="allot" id="btn_allot">分配</button>
                </shiro:hasPermission>
                <shiro:hasPermission name="cus:delete">
                <button class="layui-btn layui-btn-sm layui-hide" lay-event="delete" id="btn_delete">删除</button>
                </shiro:hasPermission>
            </script>

            <!-- 客户评星 -->
            <script type="text/html" id="cusGrade">
                <!-- 给星星容器设置动态id -->
                <div id="cusGrade{{d.id}}"></div>
            </script>

            <%--时间格式化--%>
            <script type="text/html" id="timeFormatter">
                {{dateFormatter1(d.createTime)}}
            </script>
        </div>
    </div>
</div>

<script>
    function allotuser(){
        if ($('#selector_user_name').val() == '') {

            alert("请选择分配人员");

        }else{

        var ids = "";
        $.each(selectData, function (i, n) {
            ids += n.id + ',';
        });
        var leader = $("#selector_user_id").val();

        console.log(ids);
        $.get("${baseurl}/customer/allotUser?leader="+leader+"&ids=" + ids, function (data) {
            var d = JSON.parse(data);
            if (d.code == 1) {
                layer.msg(d.msg, {icon: 1, time: 500},function () {
                    layer.close(allotWindow);
                    tableIns.reload(); //数据刷新

                });

            } else {
                layer.alert(d.msg, {icon: 2});
            }
        });

        }
    }

    function allotClue2() {
        layer.open({
            title: "选择所属客户",
            type: 2,
            area: ['700px', '450px'],
            maxmin: true,
            content: '${baseurl}/user/selectorPage'
        });
    }


    layui.use(['table', 'rate', 'laydate', 'form', 'upload'], function () {

        var $ = layui.$,
            form = layui.form,
            table = layui.table,
            laydate = layui.laydate,
            upload = layui.upload,
            rate = layui.rate;

        //使用日期(开始)
        laydate.render({
            elem: '#beginTime',
            done: function(value, date, endDate){
                var beginTime = new Date(value).getTime();
                var endTime = new Date($("#endTime").val()).getTime();
                if(beginTime > endTime){
                    layer.msg("开始时间不能大于结束时间！")
                    $("#endTime").val(value);
                }
            }
        });
        //使用日期(结束)
        laydate.render({
            elem: '#endTime',
            done: function(value, date, endDate){
                var endTime = new Date(value).getTime();
                var beginTime = new Date($("#beginTime").val()).getTime();
                if(beginTime > endTime){
                    layer.msg("开始时间不能大于结束时间！")
                    $("#beginTime").val(value);
                }
            }
        });

        //使用表格
        tableIns = table.render({
            elem: '#cus-table',
            url: '${baseurl}/customer/queryPool', //数据接口
            method: 'post',
            request: {
                limitName: 'rows' //每页数据量的参数名，默认：limit
            },
            response: {
                statusCode: 1 //规定成功的状态码，默认：0
                ,countName: 'total' //规定数据总数的字段名称，默认：count
                ,dataName: 'rows' //规定数据列表的字段名称，默认：data
            },
            where: {status: 1},
            page: true, //开启分页
            limit: 15,
            limits: [15,50,100],
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
                    field: "cusName",
                    title: "客户名称",
                    width: "12%",
                    align: "center",
                    event: 'cusName', // 点击事件绑定
                    style: "color: #2898E0;cursor:pointer;" // 样式
                }, {
                    field: "contactName",
                    title: "客户联系人",
                    width: "10%",
                    align: "center",
                    event: 'contactName', // 点击事件绑定
                    style: "color: #2898E0;cursor:pointer;" // 样式
                }, {
                    field: "conPhone",
                    title: "联系人电话",
                    align: "center",
                    width: "12%"
                },  {
                    field: "cusCode",
                    title: "客户编号",
                    width: "13%",
                    align: "center",
                    align: "center"
                }, {
                    field: "cusStatus",
                    title: "客户状态",
                    align: "center",
                    width: "10%"
                }, {
                    field: "cusBelong",
                    title: "客户行业",
                    align: "center",
                    width: "10%"
                }, {
                    field: "address",
                    title: "客户地址",
                    align: "center",
                    width: "15%"
                }, {
                    field: "infoFrom",
                    title: "客户信息来源",
                    width: "11%",
                    align: "center",
                    align: "center"
                }, {
                    field: "staffNum",
                    title: "员工数",
                    align: "center",
                    width: "10%"
                }, {
                    field: "cusGrade",
                    title: "客户等级",
                    width: "14%",
                    align: "center",
                    toolbar: "#cusGrade"
                }, {
                    field: "createrName",
                    title: "创建人",
                    width: "10%",
                    align: "center",
                    event: 'createrName', // 点击事件绑定
                    style: "color: #2898E0;cursor:pointer;" // 样式
                }, {
                    field: "createTime",
                    title: "创建时间",
                    sort: true,
                    align: "center",
                    templet: '#timeFormatter',
                    width: "11%"
                }
                ]
            ],
            done: function (res, curr, count) {
                for (var i = 0; i < count; i++) {
                    //渲染星星
                    rate.render({
                        elem: '#cusGrade'+res.rows[i].id, // 获取星星的id
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
            data["status"] = 1;
            data["beginTime"] = field.beginTime;
            data["endTime"] = field.endTime;
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
                    content: '${baseurl}/customer/cusDetailPage?id='+data.id,
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
            }  else if (obj.event === 'createrName') {
                layer.open({
                    title: "基本信息",
                    type: 2,
                    content: '${baseurl}/user/baseInfoPage?id='+data.createBy,
                    area: ['800px', '500px'],
                    maxmin: true
                });
            }

        });

        //监听事件
        table.on('toolbar(cus-table)', function (obj) {
            var checkStatus = table.checkStatus('cus-table');
            selectData = checkStatus.data;
            switch (obj.event) {
                case 'update':
                    var index = layer.open({
                        type: 2,
                        title: '编辑客户',
                        content: '${baseurl}/customer/updatePage?id='+selectData[0].id,
                        maxmin: true,
                        area: ['900px', '600px']
                    });
                    layer.full(index);
                    break;
                case 'delete':
                    layer.confirm('确认要删除吗？', function () {
                        var ids = "";
                        $.each(selectData, function (i, n) {
                            ids += n.id + ',';
                        });
                        console.log(ids);
                        $.get("${baseurl}/customer/delete?ids=" + ids, function (data) {
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
                case 'receive':
                    layer.confirm('确认要领用吗？', function () {
                        var ids = "";
                        $.each(selectData, function (i, n) {
                            ids += n.id + ',';
                        });
                        console.log(ids);
                        $.get("${baseurl}/customer/receive?ids=" + ids, function (data) {
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
                case 'allot':

                    allotWindow=   layer.open({
                        title: "分配客户",
                        type: 1,
                        closeBtn: false,
                        shift: 2,
                        area: ['550px', '250px'],
                        shadeClose: true,
                        content: $("#allotClue")
                    });
                    break;
            };
        });

        // 单复选框操作

        /* 定义一个变量存储单复选框值，作为下面事件调动 */
        table.on('checkbox(cus-table)', function (obj) {
            var checkStatus = table.checkStatus('cus-table');
            selectData = checkStatus.data

            if (selectData.length == 0) {
                $("#btn_update").addClass("layui-hide");
                $("#btn_delete").addClass("layui-hide");
                $("#btn_receive").addClass("layui-hide");
                $("#btn_allot").addClass("layui-hide");
            } else if (selectData.length == 1) {
                $("#btn_update").removeClass("layui-hide");
                $("#btn_delete").removeClass("layui-hide");
                $("#btn_receive").removeClass("layui-hide");
                $("#btn_allot").removeClass("layui-hide");
            } else {
                $("#btn_update").addClass("layui-hide");
                $("#btn_delete").removeClass("layui-hide");
                $("#btn_receive").removeClass("layui-hide");
                $("#btn_allot").removeClass("layui-hide");
            }
        });

        // 导入线索
        upload.render({
            elem: '#import',
            url: '${baseurl}/customer/importCus',
            accept: 'file',
            size: 2000,
            before: function(obj){
                loadIndex = layer.load(2); //上传loading
            },
            done: function(data, index, upload){
                layer.close(loadIndex);
                if(data.code == 1){
                    layer.msg(data.msg,{
                        icon: 1,
                        time: 800, //0.8秒关闭
                    },function () {
                        layer.close(importIndex);
                        tableIns.reload();
                    });
                }else{
                    layer.alert(data.msg);
                }
            },
            error: function(index, upload){
                layer.close(loadIndex);
                layer.alert('上传错误！');
            }
        });

        //事件
        var active = {
            add_info: function () { // 新建客户
                var index = layer.open({
                    type: 2,
                    title: '新建客户',
                    content: '${baseurl}/customer/addPage',
                    maxmin: true
                });
                layer.full(index);
            },
            importBtn: function () { //导入
                importIndex = layer.open({
                    title:"客户导入",
                    type: 1,
                    closeBtn: false,
                    shift: 2,
                    area: ['300px', '200px'],
                    shadeClose: true,
                    content: $("#importBox")
                });
            }

        };

        // 事件调用
        $('.layui-btn').on('click', function () {
            var type = $(this).data('type');
            active[type] ? active[type].call(this) : '';
        });

    });
</script>
</body>

</html>