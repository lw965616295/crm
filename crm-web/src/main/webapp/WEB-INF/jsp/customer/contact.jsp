<!DOCTYPE HTML>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jsp/common/tag.jsp" %>
<%@ include file="/WEB-INF/jsp/common/css.jsp" %>
<%@ include file="/WEB-INF/jsp/common/js.jsp" %>
<html>

<head>
    <meta charset="utf-8">
    <title>客户联系人</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <style>
        .layui-table-tool {
            height: 42px;
        }
    </style>
</head>

<body>
<div style="display: none" id="importBox">
    <div align="center" style="margin-top: 20px;margin-bottom: 20px">
        <button class="layui-btn" data-type="import" id="import">选择文件</button>
    </div>
    <div align="center"><a href="${baseurl}/templet/contact.xlsx" download="联系人模板.xlsx">模版下载</a></div>
</div>

<div class="layui-fluid">
    <div class="layui-card">
        <div class="layui-form layui-card-header layuiadmin-card-header-auto">
            <div class="layui-form-item">

                <div class="layui-inline">
                    <button class="layui-btn" data-type="add_info">新建联系人</button>

                </div>

                <div class="layui-inline">

                    <div class="layui-input-block">
                        <label class="layui-form-label">搜索:</label>
                        <div class="layui-input-block">
                        <input type="text" name="queryStr" placeholder="请输入" autocomplete="off"
                               class="layui-input">
                        </div>
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



                <div class="layui-inline">
                    <!-- 搜索按钮 -->
                    <button id="btn_search" class="layui-btn" lay-submit lay-filter="searchFilter">
                        <i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
                    </button>
                </div>

            </div>
        </div>

        <div class="layui-card-body">
            <!-- 表格容器 -->
            <table id="LAY-contact-manage" lay-filter="LAY-contact-manage"></table>

            <!-- 表头 -->
            <script type="text/html" id="checkbox">
            <!-- 复选框盒子 -->

            <button class="layui-btn layui-btn-sm layui-hide" lay-event="update" id="btn_update">编辑</button>
            <button class="layui-btn layui-btn-sm layui-hide" lay-event="delete" id="btn_delete">删除</button>

        </script>

        </div>
    </div>
</div>

<script type="text/html" id="timeFormatter">
    {{dateFormatter1(d.createTime)}}
</script>

<!-- 审核状态 -->
<script type="text/html" id="buttonTpl">
    {{#  if(d.firstContact == true){ }}
    <button class="layui-btn layui-btn-xs">是</button>
    {{#  } else { }}
    <button class="layui-btn layui-btn-danger layui-btn-xs">否</button>
    {{#  } }}
</script>


<script type="text/html" id="ramainDay">
    {{#
    var t1 = new Date(dateFormatter1(new Date().getTime()));
    var t2 = new Date(dateFormatter1(d.modifyTime));
    var day = (t1.getTime()-t2.getTime())/(24*60*60*1000);
    return '<span style="color: red;">'+day+'天</span>'
    }}
</script>

<script>

    /*回车查询*/
    document.onkeydown = function (e) {
        if (e.keyCode == 13) {
            $("#btn_search").click();
        }
    };

     layui.use(['table', 'laydate','form'], function () {

        var table = layui.table,

            laydate = layui.laydate,
        form = layui.form;

            //使用日期开始
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

            elem: '#LAY-contact-manage',
            url: '${baseurl}/contact/query', //数据接口
            method: 'post',
            request: {
                limitName: 'rows'
            },
            response: {
                statusCode: 1
                , countName: 'total'
                , dataName: 'rows'
            },

            page: true, //开启分页
            limit: 15,
            limits: [15, 50, 100],
            height: "full-220",
            text: "对不起，加载出现异常！",
            toolbar: '#checkbox',
            defaultToolbar: ['filter'],

         cols: [
             [ //表头
                 {
                     type: "checkbox",
                     fixed: "left"
                 }, {
                 field: "name",
                 title: "联系人姓名",
                 width: "10%",
                 event: 'cus_cont',
                 align: "center",// 点击事件绑定
                 style: "color: #2898E0;cursor:pointer;" // 样式
             }, {
                 field: "cusName",
                 title: "所属客户",
                 width: "10%",
                 align: "center",
                 event: 'cus_name' // 点击事件绑定

             }, {
                 field: "role",
                 title: "角色",
                 align: "center",
                 width: "8%"
             }, {
                 field: "callname",
                 title: "尊称",
                 align: "center",
                 width: "8%"
             }, {
                 field: "position",
                 title: "职位",
                 align: "center",
                 width: "9%"
             }, {
                 field: "phone",
                 title: "手机",
                 align: "center",
                 width: "12%"
             }, {
                 field: "qq",
                 title: "QQ",
                 align: "center",
                 width: "10%"
             }, {
                 field: "email",
                 title: "邮箱",
                 align: "center",
                 width: "12%"
             }, {
                 field: "createrName",
                 title: "客户负责人",
                 event: 'leader', // 点击事件绑定
                 style: "color: #2898E0;cursor:pointer;" ,// 样式
                 align: "center",
                 width: "12%"
             }, {
                 field: "createTime",
                 title: "创建时间",
                 sort: true,
                 width: "12%",
                 align: "center",
                 templet: '#timeFormatter',

             },{
                 field: "firstContact",
                 title: "是否首要联系人",
                 templet: "#buttonTpl",
                 fixed: "right",
                 width: "10%",
                 align: "center",
                 width: "8%"
             }
             ]
         ]
     });
        //监听搜索
        form.on('submit(searchFilter)', function (data2) {
            var field = data2.field;
            var data = new Array();
            data["queryStr"] = field.queryStr;
            data["status"] = 2;
            data["beginTime"] = field.beginTime;
            data["endTime"] = field.endTime;
            console.log(data);
            //执行重载
            tableIns.reload({
                where: data,
            });

        });

        //监听单元格事件
         table.on('tool(LAY-contact-manage)', function (obj) {
            var data = obj.data;
            if (obj.event === 'cus_cont') {

                var index = layer.open({

                    title: "联系人详情",
                    type: 2,
                    content: '${baseurl}/contact/queryById?id=' + data.id,
                    area: ['300px', '300px'],
                    maxmin: true
                });
                layer.full(index);
            } else if (obj.event === 'leader') {

                layer.open({
                    title: "员工信息",
                    type: 2,
                    content: '${baseurl}/user/baseInfoPage?id=' + data.createBy,
                    area: ['800px', '500px'],
                    maxmin: true
                });
            }

        });

        //监听事件

          table.on('toolbar(LAY-contact-manage)', function (obj) {
            var checkStatus = table.checkStatus('LAY-contact-manage');
            selectData = checkStatus.data;
            switch (obj.event) {
                case 'update':
                    layer.open({
                        type: 2,
                        title: '编辑客户联系人',
                        content: '${baseurl}/contact/updatePage?id=' + selectData[0].id,
                        maxmin: true,
                        area: ['900px', '600px']
                    });
                    break;
                case 'delete':
                    layer.confirm('确认要删除吗？', function () {
                        var ids = "";
                        $.each(selectData, function (i, n) {
                            ids += n.id + ',';
                        });
                        console.log(ids);

                        $.get("${baseurl}/contact/delete?ids=" + ids, function (data) {

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
            };
        });

        //事件
        var active = {
            add_info: function () { // 新建联系人
                var index = layer.open({
                    type: 2,
                    title: '新建联系人',
                    content: '${baseurl}/contact/addPage',
                    maxmin: true,
                });
                layer.full(index);
            },
            import: function () { //导入
                layer.msg('导入按钮', {
                    time: 500, //0.5秒关闭
                })
            }

        };

        // 事件调用
        $('.layui-btn').on('click', function () {
            var type = $(this).data('type');
            active[type] ? active[type].call(this) : '';
        });


        //复选框调用
        table.on('checkbox(LAY-contact-manage)', function (obj) {


             var checkStatus = table.checkStatus('LAY-contact-manage');
             selectData = checkStatus.data;

             if (checkStatus.data.length == 0) {
                 $("#btn_update").addClass("layui-hide");
                 $("#btn_delete").addClass("layui-hide");

             } else if (checkStatus.data.length == 1) {
                 $("#btn_update").removeClass("layui-hide");
                 $("#btn_delete").removeClass("layui-hide");

             } else {
                 $("#btn_update").addClass("layui-hide");
                 $("#btn_delete").addClass("layui-hide");
                 $("#btn_delete").removeClass("layui-hide");
             }

         });
    });


    /*弹出窗口*/
    function importClue() {
        importIndex = layer.open({
            title: "联系人导入",
            type: 1,
            closeBtn: false,
            shift: 2,
            area: ['300px', '200px'],
            shadeClose: true,
            content: $("#importBox")
        });
    }

</script>
</body>

</html>