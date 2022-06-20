<!DOCTYPE HTML>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jsp/common/tag.jsp" %>
<%@ include file="/WEB-INF/jsp/common/css.jsp" %>
<%@ include file="/WEB-INF/jsp/common/js.jsp" %>
<html>

<head>
    <meta charset="utf-8">
    <title>选择联系人所属客户</title>
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
                            <label class="layui-form-label">搜索</label>
                            <div class="layui-input-block">
                                <input type="text" name="searchValue" placeholder="请输入" autocomplete="off"
                                       class="layui-input">
                            </div>
                        </div>

                        <div class="layui-inline">
                            <!-- 搜索按钮 -->
                            <button id = "btn_search" class="layui-btn " lay-submit lay-filter="LAY-customer-search">
                                <i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
                            </button>
                        </div>

                    </div>
                </div>

                <div class="layui-card-body">
                    <!-- 表格容器 -->
                    <table id="customer-table" lay-filter="customer-table"></table>
                </div>


                <!-- 按钮盒子 -->
                <div class="layui-input-block from-btn">
                    <button class="layui-btn layui-btn-normal" data-type="sub_form">确定</button>
                    <button class="layui-btn layui-btn-primary" data-type="cancel">取消</button>
                </div>

            </div>
        </div>

    </div>
</div>

<!-- 审核状态 -->
<script type="text/html" id="buttonTpl">
    {{#  if(d.firstContact == true){ }}
    <button class="layui-btn layui-btn-xs">是</button>
    {{#  } else { }}
    <button class="layui-btn layui-btn-danger layui-btn-xs">否</button>
    {{#  } }}
</script>
<script>

    /*回车查询*/
    document.onkeydown = function (e) {
        if (e.keyCode == 13) {
            $("#btn_search").click();
        }
    };

    layui.use(['form','table'], function () {

        var $ = layui.$,
            form = layui.form,
            table = layui.table;

        //使用表格
        tableIns = table.render({
            elem: '#customer-table',
            url: '${baseurl}/contact/query?cusId=${cusId}',
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
            cols: [
                [ //表头
                    {
                        type: 'radio',
                        fixed: "left"
                    }, {
                    field: "name",
                    title: "联系人名称",

                }, {
                    field: "position",
                    title: "联系人职位",

                }, {
                    field: "phone",
                    title: "联系人号码",
                    align: "center"
                }, {
                    field: "firstContact",
                    title: "是否首要联系人",
                    templet: "#buttonTpl",
                    align: "center"
                }
                ]
            ]
        });

        //监听搜索
        form.on('submit(LAY-customer-search)', function (data) {
            var field = data.field;
            var data = new Array();
            data["queryStr"] = field.searchValue;
            data["status"] = 2;
            console.log(data);

            //执行重载
            tableIns.reload({
                where: data
            });
        });

        var index = parent.layer.getFrameIndex(window.name); // 得到当前iframe层的索引
        //事件
        var active = {
            cancel: function () { // 取消
                parent.layer.close(index); // 关闭
            },
            sub_form: function () {
                var checkStatus = table.checkStatus('customer-table'); // 当前点击行数据

                if (checkStatus.data.length == 0) {
                    layer.msg('你未选中任何数据！', {
                        time: 1500, //20s后自动关闭
                    });
                } else {
                    parent.$("#selector_customer_name").val(checkStatus.data[0].name);
                    parent.$("#selector_customer_id").val(checkStatus.data[0].id);
                    parent.$("#selector_customer_phone").val(checkStatus.data[0].phone);
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