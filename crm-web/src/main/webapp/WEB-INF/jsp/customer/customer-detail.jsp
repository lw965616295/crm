<!DOCTYPE HTML>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jsp/common/tag.jsp" %>
<%@ include file="/WEB-INF/jsp/common/css.jsp" %>
<%@ include file="/WEB-INF/jsp/common/js.jsp" %>
<html>

<head>
    <meta charset="utf-8">
    <title>客户详情</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
        content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <style>
        .headTit a {
            overflow: hidden;
            white-space: nowrap;
            text-overflow: ellipsis;
            font-size: 20px;
            font-weight: 600;
            color: #555;
            line-height: 42px;
            max-width: 500px;
        }

        .headTit .layui-clear {
            float: right;
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

        .cusTab td a:hover,
        .cusTab td a:focus {
            text-decoration: none;
            cursor: pointer;
            color: #23527c;
        }

        .cusTab td a {
            color: #337ab7;
        }

        .tab-item1 .layui-form-item .layui-form-label {
            text-align: left;
            padding: 9px 0;
            width: 8em;
        }

        .record-box {
            border: 1px solid #ccc;
            padding: 15px 20px 20px 20px;
            background-color: #f2f4f7;
        }

        .record-box ul li {
            display: inline-block;
            margin-right: 5px;
        }

        .record-box ul li a {
            color: #337ab7;
        }

        .record-box ul li a:focus,
        .record-box ul li a:hover {
            color: #23527c;
        }

        .delItem {
            color: #333;
            float: right;
            cursor: pointer;
            position: relative;
        }

        .delBox {
            border: 1px solid #ccc;
            background-color: #fff;
            border-radius: 3px;
            padding: 5px 15px;
            position: absolute;
            top: 20px;
            left: -60px;
        }

        .conData {
            margin-left: 50px;
            word-wrap: break-word;
            line-height: 21px;
            color: #000;
        }

        .conTime {
            float: right;
        }

        .conTime a {
            color: #337ab7;
        }


        .conTime a:focus,
        .conTime a:hover {
            color: #23527c;
        }

        .conTab tr td {
            color: #050505;
        }

        .tab-item3 h3 span {
            color: #999;
        }

        .tab-item3 h3 span+span {
            margin-left: 15px;
        }

        .tab-item2 .hideP,
        .tab-item3 .hideP {
            text-align: center;
            color: #E4E4E4;
            font-size: 22px;
            font-weight: 700;
            padding: 15px 0px;
        }

        .tab-item2 .hideP i,
        .tab-item3 .hideP i {
            font-size: 22px;
        }

        .tab-item4 table span a {
            color: #337ab7;
        }

        .tab-item4 table span a:focus,
        .tab-item4 table span a:hover {
            color: #23527c;
        }

        .tab-item4 table td a {
            color: #337ab7;
        }

        .tab-item4 table td a:focus,
        .tab-item4 table td a:hover {
            color: #23527c;
        }

        .tab-item5 img {
            margin: 0 10px;
        }
    </style>
</head>

<body>

    <div class="layui-fluid">
        <div class="layui-row layui-col-space15">
            <div class="layui-col-md12">
                <div class="layui-card">

                    <div class=" layui-card-header layuiadmin-card-header-auto headTit">
                        <img src="https://my.crm.cc/Public/img/customer_view_icon.png" class="layui-nav-img">
                        <a href="#" title="${cus.cusName}" class="layui-inline">
                            ${cus.cusName}
                        </a>

                    </div>

                    <div class="layui-card-body">
                        <!-- 客户信息 -->
                        <table class="layui-table cusTab" lay-skin="nob">
                            <colgroup>
                                <col width="150">
                                <col width="200">
                                <col width="200">
                                <col width="200">
                            </colgroup>
                            <thead>
                                <tr>
                                    <th>客户名称</th>
                                    <th>${cus.cusName}</th>
                                    <th>联系人姓名</th>
                                    <th>${cus.contactName}</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>客户编号</td>
                                    <td>${cus.cusCode}</td>
                                    <td>联系电话</td>
                                    <td>${cus.conPhone}</td>
                                </tr>
                                <tr>
                                    <td>客户等级</td>
                                    <td>${cus.cusGrade}星</td>
                                    <td>尊称</td>
                                    <td>${cus.conCall}</td>
                                </tr>
                                <tr>
                                    <td>客户负责人</td>
                                    <td>
                                        <c:if test="${cus.status != 1}">
                                            <a onclick="openUserInfo(${cus.leader})" style="color: #2898E0;cursor:pointer;">${cus.leaderName}</a>
                                        </c:if>
                                    </td>
                                    <td>创建时间</td>
                                    <td><fmt:formatDate value="${cus.createTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                                </tr>
                                <tr>
                                    <td>客户行业</td>
                                    <td>${cus.cusBelong}</td>
                                    <td>客户地址</td>
                                    <td>${cus.address}
                                        <i class="layui-icon layui-icon-location" style="color: #2898E0;cursor:pointer;"
                                           onclick="map()"></i>
                                    </td>
                                </tr>
                                <tr>
                                    <td>客户信息来源</td>
                                    <td>${cus.infoFrom}</td>
                                    <td>员工数</td>
                                    <td>${cus.staffNum}</td>
                                </tr>
                                <tr>
                                    <td>下次联系时间</td>
                                    <td><fmt:formatDate value="${cus.nextTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                                    <td>下次联系内容</td>
                                    <td>${cus.content}</td>
                                </tr>
                                <tr>
                                    <td>客户状态</td>
                                    <td>${cus.cusStatus}</td>
                                    <td>备注</td>
                                    <td>${cus.remark}</td>
                                </tr>
                            </tbody>
                        </table>

                    </div>

                </div>
            </div>

            <div class="layui-col-md12">
                <div class="layui-card">
                    <div class="layui-card-body">
                        <div class="layui-tab layui-tab-brief" lay-filter="cus-tabs">
                            <ul class="layui-tab-title">
                                <li class="layui-this" lay-id="11">跟进记录</li>
                                <li lay-id="22">联系人</li>
                                <li lay-id="33">日程</li>
                                <li lay-id="44">附件</li>
                                <li lay-id="55">操作记录</li>
                            </ul>
                            <div class="layui-tab-content">
                                <div class="layui-tab-item layui-show tab-item1">
                                    <c:if test="${cus.status != 1}">
                                    <form class="layui-form" action="" lay-filter="component-form-element ">

                                        <div class="layui-form-item layui-form-text">
                                            <div class="layui-input-block" style="margin: 0;">
                                                <textarea name="content" placeholder="添加跟进记录" class="layui-textarea"
                                                    style="resize:none;" lay-verify="required"></textarea>
                                            </div>
                                        </div>

                                        <!-- 默认隐藏，点击文本域后显示 -->
                                        <div id="optionsBox">
                                            <div class="layui-form-item ">

                                                <div class="layui-inline">
                                                    <label class="layui-form-label">跟进类型：</label>
                                                    <div class="layui-inline">
                                                        <select name="type" lay-verify="required">
                                                            <option value=""></option>
                                                            <option value="电话">电话</option>
                                                            <option value="发邮件">发邮件</option>
                                                            <option value="发短信">发短信</option>
                                                            <option value="见面拜访">见面拜访</option>
                                                        </select>
                                                    </div>
                                                </div>

                                                <div class="layui-inline">
                                                    <label class="layui-form-label">相关联系人</label>
                                                    <div class="layui-input-inline">
                                                        <input type="text" id="selector_customer_name" lay-verify="required"
                                                               data-type="fromCust" placeholder="请输入联系人"
                                                               autocomplete="off" onclick="selectLeader()"name="contactName" class="layui-input" readonly>
                                                        <input type="text" id="selector_customer_id"  data-type="fromCust"
                                                               name="contactId"
                                                               autocomplete="off" hidden>
                                                        <input type="text" id="selector_customer_phone" data-type="fromCust" name="contactPhone" hidden>
                                                    </div>
                                                </div>

                                                <div class="layui-inline">
                                                    <input type="button" lay-submit lay-filter="followLog-submit" class="layui-btn" value="添加"/>
                                                </div>

                                            </div>

                                            <div class="layui-form-item">

                                                <label class="layui-form-label">新增日程</label>
                                                <div class="layui-input-inline">
                                                    <input type="checkbox" name="close" lay-skin="switch" name="isPlan" id="isPlan"
                                                        lay-text="ON|OFF" lay-filter="switchItem">
                                                </div>

                                                <div class="layui-inline layui-hide" id="dateBox">
                                                    <label class="layui-form-label">下次联系时间：</label>
                                                    <div class="layui-input-inline">
                                                        <input type="text" name="nextTime" id="nextTime" autocomplete="off"
                                                            class="layui-input" lay-key="2">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                    </c:if>
                                    <div id="followLog"></div>
                                </div>

                                <div class="layui-tab-item tab-item2">

                                    <!-- 表格容器 -->
                                    <table id="LAY-contact-manage" lay-filter="LAY-contact-manage"></table>

                                    <!-- 表头 -->
                                    <script type="text/html" id="checkbox">
                                        <!-- 复选框盒子 -->
                                        <button class="layui-btn layui-btn-sm layui-hide" lay-event="contact" id="btn_contact">设为首要联系人</button>

                                    </script>

                                    <!-- 没有数据时显示 -->


                                </div>

                                <div class="layui-tab-item tab-item3">
                                    <div class="layui-card-body">
                                        <ul class="layui-timeline" id="cusPlan">

                                        </ul>
                                    </div>
                                    <!-- 没有数据时显示 -->
                                    <!-- <p class="hideP"><i class="layui-icon layui-icon-face-cry"></i> 暂无数据</p> -->
                                </div>

                                <div class="layui-tab-item tab-item4">
                                    <c:if test="${cus.status != 1}">
                                    <div class="layui-inline">
                                        <button type="button" class="layui-btn" id="add_file">
                                            上传
                                        </button>
                                    </div>
                                    </c:if>
                                    <table id="file-table" lay-filter="file-table"></table>

                                </div>

                                <div class="layui-tab-item tab-item5">
                                    <p class="hideP"><i class="layui-icon layui-icon-face-cry"></i> 暂未开放</p>
                                    <%--<ul class="layui-timeline">--%>
                                        <%--<li class="layui-timeline-item">--%>
                                            <%--<i class="layui-icon layui-timeline-axis"></i>--%>
                                            <%--<div class="layui-timeline-content layui-text">--%>
                                                <%--<div class="layui-timeline-title">--%>
                                                    <%--2019-03-15 09:24--%>
                                                    <%--<span>--%>
                                                        <%--<img src="https://gw.alipayobjects.com/zos/antfincdn/XAosXuNZyF/BiazfanxmamNRoxxVxka.png"--%>
                                                            <%--class="layui-nav-img">--%>
                                                    <%--</span>--%>
                                                    <%--zhangsc 将 客户地址 由 "江苏省 南京市 江宁区 天元西路牛首山工业园" 修改为 "江苏省 南京市 江宁区--%>
                                                    <%--天元西路牛首山工业园 "--%>
                                                <%--</div>--%>
                                            <%--</div>--%>
                                        <%--</li>--%>

                                    </ul>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script type="text/html" id="operater">
        <a href="${baseurl}/clue/download?id={{d.id}}">下载</a>&nbsp;&nbsp;&nbsp;
        <c:if test="${cus.status != 1}">
        <a href="javascript:fileDelete('{{d.id}}')">删除</a>
        </c:if>
    </script>
    <script type="text/html" id="createTimeFormatter">
        {{dateFormatter1(d.createTime)}}
    </script>
    <script type="text/html" id="buttonTpl">
        {{#  if(d.firstContact == true){ }}
        <button class="layui-btn layui-btn-xs">是</button>
        {{#  } else { }}
        <button class="layui-btn layui-btn-danger layui-btn-xs">否</button>
        {{#  } }}
    </script>

    <script type="text/html" id="timeFormatter">
        {{dateFormatter(d.uploadTime)}}
    </script>

    <script type="text/html" id="previewFormatter">
        {{# if(/\.(gif|jpg|jpeg|png|GIF|JPG|PNG)$/.test(d.fileName)){ }}
        <a id='previewA' onclick='previewImg("{{d.url}}")'>{{d.fileName}}</a>
        {{# }else if(/\.(pdf|xls|xlsx|docx|pptx|doc|ppt|txt)$/.test(d.fileName)){ }}
        <a id='previewB' onclick='previewFile("{{d.url}}")'>{{d.fileName}}</a>
        {{#  } else{ }}
        <span>{{d.fileName}}</span>
        {{#  } }}
    </script>

    <script>


        function selectLeader() {
            layer.open({
                title: "选择所属客户",
                type: 2,
                area: ['850px', '530px'],
                maxmin: true,
                content: '${baseurl}/contact/contactPage?cusId=${cus.id}'
            });
        }



        var isPlan = 0;
        layui.use(['element', 'form', 'laydate', 'table'], function () {
            var $ = layui.$,
                element = layui.element,
                laydate = layui.laydate,
                table = layui.table,
                form = layui.form;

            /*选项卡tab监听*/
            element.on('tab(cus-tabs)',function (data) {
                switch (data.index){
                    case 0://跟进记录
//                        layer.msg("0");
                        break;
                    case 1://联系人
//                        layer.msg("1");
                        break;
                    case 2://日程
                        initPlan();
                        break;
                    case 3://附件
                        break;
                    case 4://操作记录
//                        layer.msg("4");
                        break;
                }

            });

            /* 先获取本地时间，最小值不能设定为比当前时间小 */
            // 获取当前日期
            var date = new Date();
            // 获取当前月份
            var nowMonth = date.getMonth() + 1;
            // 获取当前是几号
            var strDate = date.getDate();
            // 添加分隔符“-”
            var seperator = "-";
            // 对月份进行处理，1-9月在前面添加一个“0”
            if (nowMonth >= 1 && nowMonth <= 9) {
                nowMonth = "0" + nowMonth;
            }
            // 对月份进行处理，1-9号在前面添加一个“0”
            if (strDate >= 0 && strDate <= 9) {
                strDate = "0" + strDate;
            }
            // 最后拼接字符串，得到一个格式为(yyyy-MM-dd)的日期
            var nowDate = date.getFullYear() + seperator + nowMonth + seperator + strDate;
            // 时间选择
            var dateBox = laydate.render({
                elem: '#nextTime',
                type: 'datetime',
                min: nowDate,
                max: '2080-10-14',
                ready: function () {
                    dateBox.hint('日期可选值设定在 <br> ' + nowDate + '到 2080-10-14');
                }
            });

            /* 监听指定开关 */
            form.on('switch(switchItem)', function (data) {
                if (this.checked == true) {
                    $("#dateBox").removeClass("layui-hide")
                    // 设置文本域的placeholder
                    $('.layui-textarea').attr('placeholder', '添加日程记录');
                    isPlan = 1;
                    layer.msg('日程已打开', {
                        offset: '6px',
                        time: 1500
                    });
                } else {
                    $("#dateBox").addClass("layui-hide")
                    // 设置文本域的placeholder
                    $('.layui-textarea').attr('placeholder', '添加跟进记录');
                    isPlan = 0;
                    layer.msg('日程已关闭', {
                        offset: '6px',
                        time: 1500
                    });
                }
            });

            // 页面加载先默认隐藏文本域
            if ($(".layui-textarea").val() == "") {
                $("#optionsBox").hide();
            }

            // 点击文本域后显示
            $('.layui-textarea').click(function () {
                $("#optionsBox").show();
            })

            // 点击下标 出现删除
            var index;
            $(".delItem").click(function (e) {
                index = $(".delItem").index(this); // 当前点击的是第几个
                $(".delBox:eq(" + index + ")").removeClass("layui-hide").show()
                e.stopPropagation();
            })

            // 点击元素以外隐藏
            $(document.body).click(function (e) {
                $(".delBox").hide();
            });

            /*点击添加按钮（跟进日志or日程）*/
            form.on('submit(followLog-submit)',function (data) {
                var field = data.field; //获取提交的字段

                field["isPlan"] = isPlan;
                field["cusId"] = "${cus.id}";
                console.log(field);
                if(isPlan == 1){
                    if($("#nextTime").val() == ''){
                        layer.msg("请选择下次联系时间！",{icon:2});
                        return;
                    }
                }else{
                    field["nextTime"] = "";
                }
                $.ajax({
                    type: 'post',
                    url: '${baseurl}/customer/saveFollowLog' ,
                    data: field,
                    success: function (data) {
                        var code = JSON.parse(data).code;
                        if(code == 1){
                            layer.msg(JSON.parse(data).msg,{
                                icon: 1,
                                time: 800,
                            },function(index){
                                if(isPlan == 0){
                                    addFollowLog("${activeUser.iconUrl}", "${activeUser.account}",dateFormatter(new Date().getTime()), field.type, field.content, JSON.parse(data).data,field.contactName,field.contactPhone);
                                }
                            });

                        }else if(code == 0){
                            layer.alert("操作失败！"+JSON.parse(data).msg);
                        }
                    }
                });
            });

            // 上传文件弹窗
            $("#add_file").click(function () {
                layer.open({
                    type: 2,
                    area: ['700px', '450px'],
                    fixed: false, //不固定
                    title: '文件上传',
                    content: '${baseurl}/clue/uploadPage?belongId=${cus.id}&fileBelong=cus',
                    maxmin: true,
                });
            });

            contableIns =   table.render({

                elem: '#LAY-contact-manage',
                url: '${baseurl}/contact/query?cusId=${cus.id}', //数据接口
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
                        width: "7%",
                        event: 'cus_cont', // 点击事件绑定

                    }, {
                        field: "cusName",
                        title: "所属客户",
                        width: "7%",
                        event: 'cus_name', // 点击事件绑定

                    }, {
                        field: "role",
                        title: "角色",
                        width: "7%"
                    }, {
                        field: "callname",
                        title: "尊称",
                        width: "7%"
                    }, {
                        field: "position",
                        title: "职位",
                        width: "7%"
                    }, {
                        field: "phone",
                        title: "手机",
                        width: "8%"
                    }, {
                        field: "qq",
                        title: "QQ",
                        width: "8%"
                    }, {
                        field: "email",
                        title: "邮箱",
                        width: "12%"
                    }, {
                        field: "createrName",
                        title: "客户负责人",
                        event: 'leader', // 点击事件绑定

                    }, {
                        field: "createTime",
                        title: "创建时间",
                        sort: true,
                        templet: '#createTimeFormatter',

                    },{
                        field: "firstContact",
                        title: "是否首要联系人",
                        templet: "#buttonTpl",
                        fixed: "right",
                        align: "center",
                        width: "8%"
                    }
                    ]
                ]
            });

              table.on('toolbar(LAY-contact-manage)', function (obj) {
                var checkStatus = table.checkStatus('LAY-contact-manage');
                selectData = checkStatus.data;
                switch (obj.event) {
                    case 'contact':
                        layer.confirm('确认设为首要联系人？', function () {

                            $.get("${baseurl}/contact/updateSet1?cusId=${cus.id}&id="+selectData[0].id, function (data) {
                                var d = JSON.parse(data);
                                if (d.code == 1) {
                                    layer.msg(d.msg, {icon: 1, time: 1000});
                                    contableIns.reload(); //数据刷新
                                } else {
                                    layer.alert(d.msg, {icon: 2});
                                }
                            });
                        });
                        break;
                };
            });


            //复选框调用
            table.on('checkbox(LAY-contact-manage)', function (obj) {


                var checkStatus = table.checkStatus('LAY-contact-manage');
                selectData = checkStatus.data;

                if (checkStatus.data.length == 0) {
                    $("#btn_contact").addClass("layui-hide");


                } else if (checkStatus.data.length == 1) {
                    $("#btn_contact").removeClass("layui-hide");


                } else {
                    $("#btn_contact").addClass("layui-hide");

                }

            });

            //使用表格
            tableIns = table.render({
                elem: '#file-table',
                url: '${baseurl}/clue/queryFile?belongId=${cus.id}&fileBelong=cus', //数据接口
                method: 'post',
                page: false, //开启分页
                request: {
                    limitName: 'rows' //每页数据量的参数名，默认：limit
                },
                response: {
                    statusCode: 1 //规定成功的状态码，默认：0
                    ,countName: 'total' //规定数据总数的字段名称，默认：count
                    ,dataName: 'rows' //规定数据列表的字段名称，默认：data
                },
                text: "对不起，加载出现异常！",
                cols: [
                    [ //表头
                        {
                            field: "fileName",
                            title: "文件名",
                            event: 'media', // 点击事件绑定
                            style: "color: #2898E0;cursor:pointer;", // 样式
                            width: "30%",
                            templet:"#previewFormatter"
                        }, {
                        field: "size",
                        title: "大小(kb)",
                        style: "color: #2898E0;cursor:pointer;", // 样式
                        width: "10%"
                    }, {
                        field: "uploaderName",
                        title: "上传人",
                        width: "20%"
                    }, {
                        field: "uploadTime",
                        title: "上传时间",
                        templet:"#timeFormatter",
                        width: "20%"
                    }, {
                        title: "操作",
                        templet: '#operater',
                        width: "20%"
                    }
                    ]
                ]

            });

        });

        /*初始化页面时加载*/
        $(function () {
            initFollowLog();
            // initPlan();
        });

        /*初始化沟通日志*/
        function initFollowLog() {
            $.ajax({
                url: "${baseurl}/customer/queryFollowLog?cusId=${cus.id}&isPlan=0",
                type: "get",
                success: function (data) {
                    var d = JSON.parse(data);


                    if(d.code == 1){
                        var list = d.rows;
                        if(list.length>0){
                            for (var i=0;i<list.length;i++){
                                $("#followLog").append(
                                    "<div class='layui-form-item layui-form-text record-box' id='log"+list[i].id+"'>" +
                                    "<ul class='layui-clear'>" +
                                    "<li>" +
                                    "<img src='"+list[i].iconUrl+"' class='layui-nav-img'>" +
                                    "</li>" +
                                    "<li><a href='#'>"+list[i].createrName+"</a></li>" +
                                    "<li>发布了一条快速记录</li>" +
                                    "<li>"+dateFormatter(list[i].createTime)+"</li>" +
                                    "<li>"+list[i].type+"</li>" +
                                    "<li class='delItem'>" +
                                    "<i class='layui-icon layui-icon-close' onclick='delLog("+list[i].id+")'></i>" +
                                    "</li>" +
                                    "</ul>" +
                                    "<p class='conData'>"+list[i].content+"</p>" +
                                    "<ul style='padding-left: 1200px' class='layui-clear'>" +
                                    "<li>相关联系人:</li>" +
                                    "<li><a href='#'>"+list[i].contactName+"</a></li>"+
                                    "<li><a href='#'>"+"("+list[i].conPhone+")"+"</a></li>"+
                                    "</ul>" +
                                    "</div>"
                                );
                            }
                        }else{
                            $("#followLog").append("<p class='hideP'><i class='layui-icon layui-icon-face-cry'></i> 暂无数据</p>")
                        }
                    }else{
                        layer.alert(d.msg);
                    }

                },
                error: function(){
                    layer.msg('请求错误！', {icon: 7});
                    return;
                }
            });
        }

        //添加一条沟通日志页面操作
        function addFollowLog(iconUrl, createrName, createTime, type, content, id,contactName,contactPhone){
            $("#followLog").prepend(
                "<div class='layui-form-item layui-form-text record-box' id='log"+id+"'>" +
                "<ul class='layui-clear'>" +
                "<li>" +
                "<img src='"+iconUrl+"' class='layui-nav-img'>" +
                "</li>" +
                "<li><a href='#'>"+createrName+"</a></li>" +
                "<li>发布了一条快速记录</li>" +
                "<li>"+createTime+"</li>" +
                "<li>"+type+"</li>" +
                "<li class='delItem'>" +
                "<i class='layui-icon layui-icon-close' onclick='delLog("+id+")'></i>" +
                "</li>" +
                "</ul>" +
                "<p class='conData'>"+content+"</p>" +
                "<ul style='padding-left: 1200px' class='layui-clear'>" +
                "<li>相关联系人</li>" +
                "<li><a href='#'>"+contactName+"</a></li>"+
                "<li><a href='#'>"+contactPhone+"</a></li>"+
                   "</ul>" +
                "</div>"
            );
        }

        //初始化日程
        function initPlan() {
            $("#cusPlan").children().remove();
            $.ajax({
                url: "${baseurl}/customer/queryFollowLog?cusId=${cus.id}&isPlan=1",
                type: "get",
                success: function (data) {
                    var d = JSON.parse(data);
                    if(d.code == 1){
                        var list = d.rows;
                        if(list.length>0){
                            for (var i=0;i<list.length;i++){
                                $("#cusPlan").append(
                                    "<li class='layui-timeline-item'>" +
                                    "<i class='layui-icon layui-timeline-axis'></i>" +
                                    "<div class='layui-timeline-content layui-text'>" +
                                    "<h3 class='layui-timeline-title'>" +
                                    "<span>"+dateFormatter(list[i].nextTime)+"</span>" +
                                    "<span>~</span>" +
                                    "<span>"+dateFormatter(list[i].nextTime).substr(0,10)+"</span>" +
                                    "<span><img src='"+list[i].iconUrl+"' class='layui-nav-img'>" +
                                    "</span>" +
                                    "<span>"+list[i].createrName+"</span>" +
                                    "</h3>" +
                                    "<p>"+list[i].content+"</p>" +
                                    "</div>" +
                                    "</li>"
                                );
                            }

                        }else{
                            $("#cusPlan").append("<p class='hideP'><i class='layui-icon layui-icon-face-cry'></i> 暂无数据</p>")
                        }
                    }else{
                        layer.alert(d.msg);
                    }
                },
                error: function(){
                    layer.msg('请求错误！', {icon: 7});
                    return;
                }
            });
        }

        /*预览图片*/
        function previewImg(obj) {
            var img = new Image();
            img.src = obj.src;
            var imgHtml = "<img src='" + obj + "' height='600px'/>";
            //弹出层
            layer.open({
                type: 1,
                area: ['900px', '650px'],
                title: "图片预览", //不显示标题
                content: imgHtml
            });
        }

        /*预览文件*/
        function previewFile(obj) {
            //弹出层
            layer.open({
                type: 2,
                area: ['900px', '650px'],
                title: "文件预览", //不显示标题
                content: '${baseurl}/clue/media?url='+obj
            });
        }

        //删除文件
        function fileDelete(id) {
            layer.confirm('确定删除该文件?', function () {
                    $.ajax({
                        url: "${baseurl}/clue/deleteFile?ids="+id,
                        type: "POST",
                        success: function (data) {
                            var d = JSON.parse(data);
                            if(d.code == "1"){
                                tableIns.reload();
                                layer.msg(d.msg, {icon: 1});

                            }else{
                                layer.alert('删除失败!'+d.msg);
                            }
                        },
                        error: function(){
                            layer.msg('请求错误！', {icon: 7});
                        }
                    });
                }
            );
        }

        /*系统人员信息*/
        function openUserInfo(id) {
            layer.open({
                title: "基本信息",
                type: 2,
                content: '${baseurl}/user/baseInfoPage?id='+id,
                area: ['800px', '500px'],
                maxmin: true
            });
        }
        //地图
        function map(){
            layer.open({
                title: "查看地图",
                type: 2,
                area: ['700px', '450px'],
                maxmin: true,
                content: '${baseurl}/clue/map?address=${cus.address}'
            });
        }

        //删除跟进日志
        function delLog(id){
            layer.confirm('确定删除该日志吗?', function () {
                    $.ajax({
                        url: "${baseurl}/customer/deleteFollowLog?ids="+id,
                        type: "POST",
                        success: function (data) {
                            var d = JSON.parse(data);
                            if(d.code == "1"){
                                layer.msg(d.msg, {icon: 1, time: 500},function () {
                                    $("#log"+id).remove();
                                });

                            }else{
                                layer.alert('删除失败!'+d.msg);
                            }
                        },
                        error: function(){
                            layer.msg('请求错误！', {icon: 7});
                        }
                    });
                }
            );
        }
    </script>
</body>

</html>