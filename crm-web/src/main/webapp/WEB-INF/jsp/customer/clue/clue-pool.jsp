<!DOCTYPE HTML>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jsp/common/tag.jsp" %>
<%@ include file="/WEB-INF/jsp/common/css.jsp" %>
<%@ include file="/WEB-INF/jsp/common/js.jsp" %>
<html>

<head>
    <meta charset="utf-8">
    <title>线索池</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
</head>

<body>
<div style="display: none" id="importBox">
    <div align="center" style="margin-top: 20px;margin-bottom: 20px">
        <button class="layui-btn" data-type="import" id="import">选择文件</button>
    </div>
    <div align="center"><a href="${baseurl}/templet/clue.xlsx" download="线索模板.xlsx">模版下载</a></div>

</div>

<div style="display: none" id="allotClue">


    <div class="layui-col-xs6 layui-col-sm6 layui-col-md6 layui-col-lg6">
        <label style="margin-top: 10px" class="layui-form-label"><h4>线索分配</h4></label>
        <div class="layui-input-inline">
            <input style="margin-top: 10px" type="text" id="selector_user_name" placeholder="请选择需要分配的人员"
                   onclick="allotClue2()"
                   autocomplete="off" class="layui-input" readonly>
        </div>
        <input type="text" id="selector_user_id" name="leader" value="" hidden>
    </div>
    <div>
        <div class="layui-form-item">
            <div class="layui-input-block from-btn">
                <button style="margin-top: 20px" class="layui-btn layui-btn-sm " onclick="allotuser()">确定</button>

            </div>
        </div>

    </div>

</div>

</div>

<div class="layui-fluid">
    <div class="layui-card">
        <div class="layui-form layui-card-header layuiadmin-card-header-auto">
            <div class="layui-form-item">

                <shiro:hasPermission name="clue:add">
                    <div class="layui-inline">
                        <button class="layui-btn" data-type="addClue" id="addClue">新建线索</button>
                        <button class="layui-btn" onclick="importClue()">导入</button>
                    </div>
                </shiro:hasPermission>

                <%--<div class="layui-inline">--%>
                    <%--<div class="layui-input-block" style="margin-left: 10px;">--%>
                        <%--<select name="searchType" class="select">--%>
                            <%--<option value="infoFrom">信息来源</option>--%>
                            <%--<option value="contact">联系人</option>--%>
                            <%--<option value="company">公司名</option>--%>
                            <%--<option value="phone">手机号</option>--%>
                        <%--</select>--%>
                    <%--</div>--%>
                <%--</div>--%>

                <div class="layui-inline">
                    <label class="layui-form-label">搜索:</label>
                    <div class="layui-input-block">
                    <input id="sContent" type="text" name="queryStr" placeholder="请输入搜索内容" autocomplete="off"
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
                <shiro:hasPermission name="clue:queryPool">
                    <div class="layui-inline">
                        <button class="layui-btn layuiadmin-btn-useradmin" lay-submit
                                lay-filter="LAY-clue-front-search">
                            <i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
                        </button>
                    </div>
                </shiro:hasPermission>
            </div>
        </div>

        <div class="layui-card-body">

            <table id="LAY-clue-manage" lay-filter="LAY-clue-manage"></table>

            <script type="text/html" id="toolbarDemo">
                <shiro:hasPermission name="clue:updatePool">
                    <button class="layui-btn layui-btn-sm layui-hide" lay-event="update" id="btn_update">编辑</button>
                </shiro:hasPermission>
                <shiro:hasPermission name="clue:receive">
                    <button class="layui-btn layui-btn-sm layui-hide" lay-event="receive" id="btn_receive">领用</button>
                </shiro:hasPermission>
                <shiro:hasPermission name="clue:allot">
                    <button class="layui-btn layui-btn-sm layui-hide" lay-event="allot" id="btn_allot">分配</button>
                </shiro:hasPermission>
                <shiro:hasPermission name="clue:delete">
                    <button class="layui-btn layui-btn-sm layui-hide" lay-event="delete" id="btn_delete">删除</button>
                </shiro:hasPermission>
            </script>
        </div>
    </div>
</div>

<script type="text/html" id="timeFormatter">
    {{dateFormatter1(d.createTime)}}
</script>

<script>




        function allotuser() {

            if ($('#selector_user_name').val() == '') {

            alert("请选择分配人员");

        }else{
        var ids = "";
        $.each(selectData, function (i, n) {
            ids += n.id + ',';
        });
        var leader = $("#selector_user_id").val();

        console.log(ids);
        $.get("${baseurl}/clue/allotUser?leader=" + leader + "&ids=" + ids, function (data) {
            var d = JSON.parse(data);
            if (d.code == 1) {
                layer.msg(d.msg, {icon: 1, time: 500}, function () {
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

    var tableIns;
    layui.use(['table', 'upload', 'laydate', 'form'], function () {
        var upload = layui.upload,
            table = layui.table
        laydate = layui.laydate
        form = layui.form;

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
            elem: '#LAY-clue-manage',
            url: '${baseurl}/clue/queryPool', //数据接口
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
                    field: "contact",
                    title: "联系人姓名",
                    width: "11%",
                    align:"center"
                }, {
                    field: "company",
                    title: "公司名",
                    event: 'company', // 点击事件绑定
                    style: "color: #2898E0;cursor:pointer;" ,// 样式
                    width: "10%",
                    align:"center"
                }, {
                    field: "callname",
                    title: "尊称",
                    width: "8%",
                    align:"center"
                }, {
                    field: "position",
                    title: "职位",
                    width: "9%",
                    align:"center"
                }, {
                    field: "infoFrom",
                    title: "信息来源",
                    width: "10%",
                    align:"center"
                }, {
                    field: "phone",
                    title: "手机",
                    width: "12%",
                    align:"center"
                }, {
                    field: "email",
                    title: "邮箱",
                    width: "12%",
                    align:"center"
                }, {
                    field: "address",
                    title: "地址",
                    align:"center",
                    width: "15%",

                }, {
                    field: "remark",
                    title: "备注",
                    align:"center",
                    width: "15%",

                }, {
                    field: "createrName",
                    title: "创建人",
                    event: "createrName",
                    style: "color: #2898E0;cursor:pointer;" , // 样式
                    width: "10%",
                    align:"center"
                }, {
                    field: "createTime",
                    title: "创建时间",
                    sort: true,
                    templet: '#timeFormatter',
                    width: "11%",
                    align:"center"
                }
                ]
            ]
        });
        //监听搜索
        form.on('submit(LAY-clue-front-search)', function (data2) {
            var field = data2.field;
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
        // 单复选框操作
        table.on('checkbox(LAY-clue-manage)', function (obj) {
            var checkStatus = table.checkStatus('LAY-clue-manage');
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

        //添加用户
        $("#addClue").click(function () {
            var index = layer.open({
                type: 2,
                title: '新建线索',
                content: '${baseurl}/clue/addPage',
                maxmin: true,
                area: ['900px', '600px']
            });
            layer.full(index);
        });

        //表头按钮监听
        table.on('toolbar(LAY-clue-manage)', function (obj) {
            var checkStatus = table.checkStatus('LAY-clue-manage');
            selectData = checkStatus.data;
            switch (obj.event) {
                case 'update':
                    layer.open({
                        type: 2,
                        title: '编辑线索',
                        content: '${baseurl}/clue/updatePage?id=' + selectData[0].id,
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
                        $.get("${baseurl}/clue/delete?ids=" + ids, function (data) {
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
                        $.get("${baseurl}/clue/receive?ids=" + ids, function (data) {
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
                    allotWindow = layer.open({
                        title: "分配线索",
                        type: 1,
                        closeBtn: false,
                        shift: 2,
                        area: ['550px', '250px'],
                        shadeClose: true,
                        content: $("#allotClue")
                    });

                    break;

            }
            ;
        });

        //监听单元格事件
        table.on('tool(LAY-clue-manage)', function (obj) {
            var data = obj.data;
            if (obj.event === 'company') {
                var index = layer.open({
                    title: "线索详情",
                    type: 2,
                    content: '${baseurl}/clue/clueDetailPage?id=' + data.id,
                    area: ['900px', '600px'],
                    maxmin: true
                });
                layer.full(index);
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
            }

        });

        // 导入线索
        upload.render({
            elem: '#import',
            url: '${baseurl}/clue/importClue',
            accept: 'file',
            size: 2000,
            before: function (obj) { //obj参数包含的信息，跟 choose回调完全一致，可参见上文。
                loadIndex = layer.load(2); //上传loading
            },
            done: function (data, index, upload) {
                layer.close(loadIndex);
                if (data.code == 1) {
                    layer.msg(data.msg, {
                        icon: 1,
                        time: 800, //0.8秒关闭
                    }, function () {
                        layer.close(importIndex);
                        tableIns.reload();
                    });
                } else {
                    layer.alert(data.msg);
                }
            },
            error: function (index, upload) {
                layer.close(loadIndex);
                layer.alert('上传错误！');
            }
        });
    });

    /*弹窗*/
    function importClue() {
        importIndex = layer.open({
            title: "线索导入",
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
