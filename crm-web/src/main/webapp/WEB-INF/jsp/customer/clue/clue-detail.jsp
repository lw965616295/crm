<!DOCTYPE HTML>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jsp/common/tag.jsp" %>
<%@ include file="/WEB-INF/jsp/common/css.jsp" %>
<%@ include file="/WEB-INF/jsp/common/js.jsp" %>
<html>

<head>
    <meta charset="utf-8">
    <title>线索详情</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <style>
        .tab-item2 .layui-form-item .layui-form-label {
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

        .tab-item3 .hideP {
            text-align: center;
            color: #E4E4E4;
            font-size: 22px;
            font-weight: 700;
            padding: 15px 0px;
        }

        .tab-item3 .hideP i {
            font-size: 22px;
        }

        .tab-item4 h3 span {
            color: #999;
        }

        .tab-item4 h3 span+span {
            margin-left: 15px;
        }

        .tab-item4 .hideP {
            text-align: center;
            color: #E4E4E4;
            font-size: 22px;
            font-weight: 700;
            padding: 15px 0px;
        }

        .tab-item4 .hideP i {
            font-size: 22px;
        }

        .layui-timeline-title {
            margin-bottom: 0;
        }

        .layui-timeline-item {
            padding-bottom: 5px;
        }

        .tab-item5 table span a {
            color: #337ab7;
        }

        .tab-item5 table span a:focus,
        .tab-item5 table span a:hover {
            color: #23527c;
        }

        .tab-item5 table td a {
            color: #337ab7;
        }

        .tab-item5 table td a:focus,
        .tab-item5 table td a:hover {
            color: #23527c;
        }
        .tab-item2{
            position: -ms-device-fixed;
        }
        .layui-tab-content{
            height: 600px;
            overflow: auto;
        }
    </style>
</head>

<body>
<div class="layui-fluid">
    <div class="layui-card">
        <div class=" layui-card-header layuiadmin-card-header-auto">
            <img src="https://my.crm.cc/Public/img/contract_view_icon.png" class="layui-nav-img">
            <div class="layui-inline" style="font-size: 21px;margin-left: 5px;color: #676a6c;">
                ${clue.company}
            </div>
        </div>

        <div class="layui-card">
            <div class="layui-card-body" >
                <div class="layui-tab layui-tab-brief" lay-filter="clue-tabs">

                    <ul class="layui-tab-title">
                        <li class="layui-this" lay-id="11">基本信息</li>
                        <li lay-id="22">沟通日志</li>
                        <li lay-id="33">负责人日志</li>
                        <li lay-id="44">日程</li>
                        <li lay-id="55">文件</li>
                    </ul>


                    <div class="layui-tab-content">
                        <!-- 基本信息 -->
                        <div class="layui-tab-item layui-show">
                            <table class="layui-table" lay-even="" lay-skin="nob" >
                                <colgroup>
                                    <col width="150">
                                    <col width="200">
                                    <col width="200">
                                    <col width="200">
                                </colgroup>
                                <thead>
                                <tr>
                                    <th>创建时间</th>
                                    <th><fmt:formatDate value="${clue.createTime}" pattern="yyyy-MM-dd HH:mm:ss" /></th>
                                    <th>创建人</th>
                                    <th><a onclick="opencreatName()" style="color: #2898E0;cursor:pointer;">${clue.createrName}</a></th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr>
                                    <td>负责人</td>
                                    <td>
                                        <a onclick="openleaderName()" style="color: #2898E0;cursor:pointer;">${clue.leaderName}</a>
                                    </td>
                                    <td>最后修改时间</td>
                                    <td><fmt:formatDate value="${clue.modifyTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                                </tr>
                                <tr>
                                    <td>来源</td>
                                    <td>${clue.infoFrom}</td>
                                    <td>联系人姓名</td>
                                    <td>${clue.contact}</td>
                                </tr>
                                <tr>
                                    <td>公司名</td>
                                    <td>${clue.company}</td>
                                    <td>职位</td>
                                    <td>${clue.position}</td>
                                </tr>
                                <tr>
                                    <td>尊称</td>
                                    <td>${clue.callname}</td>
                                    <td>手机</td>
                                    <td>${clue.phone}</td>
                                </tr>
                                <tr>
                                    <td>邮箱</td>
                                    <td>${clue.email}</td>
                                    <td>地址</td>
                                    <td>${clue.address}
                                        <i class="layui-icon layui-icon-location" style="color: #2898E0;cursor:pointer;"
                                           onclick="map()"></i>
                                    </td>
                                </tr>
                                <tr>
                                    <td>下次联系时间</td>
                                    <td><fmt:formatDate value="${clue.nextTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                                    <td>下次联系内容</td>
                                    <td>${clue.content}</td>
                                </tr>
                                <tr>
                                    <td>备注</td>
                                    <td>${clue.remark}</td>
                                    <td></td>
                                    <td></td>
                                </tr>
                                </tbody>
                            </table>
                        </div>

                        <!-- 沟通日志 -->
                        <div class="layui-tab-item tab-item2">
                            <c:if test="${clue.status != 1}">
                            <form class="layui-form" lay-filter="commlog-form">

                                <div class="layui-form-item layui-form-text" >
                                    <div class="layui-input-block" style="margin: 0;">
                                        <textarea placeholder="添加沟通日志" class="layui-textarea" style="resize:none;" name="content" lay-verify="required"></textarea>
                                    </div>
                                </div>

                                <!-- 默认隐藏，点击文本域后显示 -->
                                <div id="optionsBox">
                                    <div class="layui-form-item">

                                        <div class="layui-inline">
                                            <label class="layui-form-label">跟进类型：</label>
                                            <div class="layui-inline">
                                                <select name="type" lay-verify="required" id="type">
                                                    <option value="电话">电话</option>
                                                    <option value="发邮件">发邮件</option>
                                                    <option value="发短信">发短信</option>
                                                    <option value="见面拜访">见面拜访</option>
                                                </select>
                                            </div>
                                        </div>

                                        <div class="layui-inline">
                                            <input type="button" lay-submit lay-filter="commlog-submit" class="layui-btn" value="添加"/>
                                        </div>

                                    </div>

                                    <div class="layui-form-item">
                                        <label class="layui-form-label">新增日程</label>
                                        <div class="layui-input-inline">
                                            <input id="isPlan" type="checkbox" name="isPlan" lay-skin="switch" lay-text="ON|OFF"
                                                   lay-filter="switchItem">
                                        </div>

                                        <div class="layui-inline layui-hide" id="dateBox">
                                            <label class="layui-form-label">下次联系时间：</label>
                                            <div class="layui-input-inline">
                                                <input type="text" name="nextTime" id="nextTime" autocomplete="off" class="layui-input"
                                                       lay-key="2" placeholder="下次联系时间">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </form>
                            </c:if>
                            <div id="commlog"></div>
                        </div>

                        <!-- 负责人日志 -->
                        <div class="layui-tab-item tab-item3">

                            <!-- 没有数据时，显示p标签 -->
                            <!-- <table class="layui-table" lay-even="" lay-skin="line">
                                        <colgroup>
                                            <col width="150">
                                            <col width="200">
                                        </colgroup>
                                        <thead>
                                            <tr>
                                                <th>负责人</th>
                                                <th>领取时间</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td>老王</td>
                                                <td>2019-03-15 08:46:30</td>
                                            </tr>
                                        </tbody>
                                    </table> -->

                            <!-- 没有数据时显示 -->
                            <p class="hideP"><i class="layui-icon layui-icon-face-cry"></i> 暂未开放</p>

                        </div>

                        <!-- 日程 -->
                        <div class="layui-tab-item tab-item4">
                            <div class="layui-card-body">
                                <ul class="layui-timeline" id="cluePlan">

                                </ul>
                            </div>
                        </div>

                        <!-- 文件 -->
                        <div class="layui-tab-item tab-item5">
                            <c:if test="${clue.status != 1}">
                            <div class="layui-inline">
                                <button type="button" class="layui-btn" id="add_file">
                                    上传
                                </button>
                            </div>
                            </c:if>
                            <table id="file-table" lay-filter="file-table"></table>
                        </div>

                    </div>
                </div>
            </div>
        </div>

    </div>
</div>

<script type="text/html" id="operater">
    <a href="${baseurl}/clue/download?id={{d.id}}">下载</a>&nbsp;&nbsp;&nbsp;
    <c:if test="${clue.status != 1}">
    <a href="javascript:fileDelete('{{d.id}}')">删除</a>
    </c:if>
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

</body>
<script>


    var isPlan = 0;
    layui.use(['laydate', 'form','element','table'], function () {
        var $ = layui.$,
            element = layui.element,
            laydate = layui.laydate,
            table = layui.table,
            form = layui.form;

        /*选项卡tab监听*/
        element.on('tab(clue-tabs)',function (data) {
            switch (data.index){
                case 0://基本信息
//                        layer.msg("0");
                    break;
                case 1://沟通日志
//                        layer.msg("1");
                    break;
                case 2://负责人日志

                    break;
                case 3://日程
                    initPlan();
                    break;
                case 4://文件
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
                layer.msg('日程已打开', {
                    offset: '6px'
                });
                isPlan = 1;
                $(".layui-textarea").attr('placeholder','添加日程');
            } else {
                $("#dateBox").addClass("layui-hide")
                layer.msg('日程已关闭', {
                    offset: '6px'
                });
                isPlan = 0;
                $(".layui-textarea").attr('placeholder','添加沟通日志');
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

        // 点击删除沟通日志
        var index;
        $(".delItem").click(function (e) {
            index = $(".delItem").index(this); // 当前点击的是第几个
//            $(".delBox:eq(" + index + ")").removeClass("layui-hide").show()
//            layer.msg(index)
        })

        // 点击元素以外隐藏
        $(document.body).click(function (e) {
            $(".delBox").hide();
        });

        /*点击添加按钮（沟通日志or日程）*/
        form.on('submit(commlog-submit)',function (data) {
            var field = data.field; //获取提交的字段

            field["isPlan"] = isPlan;
            field["clueId"] = "${clue.id}";
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
                url: '${baseurl}/clue/saveCommlog' ,
                data: field,
                success: function (data) {
                    var code = JSON.parse(data).code;
                    if(code == 1){
                        layer.msg(JSON.parse(data).msg,{
                            icon: 1,
                            time: 800,
                        },function(index){
                            if(isPlan == 0){
                                addCommlog("${activeUser.iconUrl}", "${activeUser.account}", dateFormatter(new Date().getTime()), field.type, field.content, JSON.parse(data).data);
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
                content: '${baseurl}/clue/uploadPage?belongId=${clue.id}&fileBelong=clue',
                maxmin: true,
            });
        });

        //使用表格
        tableIns = table.render({
            elem: '#file-table',
            url: '${baseurl}/clue/queryFile?belongId=${clue.id}&fileBelong=clue', //数据接口
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
        initCommlog();
       // initPlan();
    });

    /*初始化沟通日志*/
    function initCommlog() {
        $.ajax({
            url: "${baseurl}/clue/queryCommlog?clueId=${clue.id}&isPlan=0",
            type: "get",
            success: function (data) {
                var d = JSON.parse(data);
                if(d.code == 1){
                    var list = d.rows;
                    if(list.length>0){
                        for (var i=0;i<list.length;i++){
                            $("#commlog").append(
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
                                "</div>"
                            );
                        }
                    }else{
                        $("#commlog").append("<p class='hideP'><i class='layui-icon layui-icon-face-cry'></i> 暂无数据</p>")
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
    function addCommlog(iconUrl, createrName, createTime, type, content, id){
        $("#commlog").prepend(
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
            "<i class='layui-icon layui-icon-close'onclick='delLog("+id+")'></i>" +
            "</li>" +
            "</ul>" +
            "<p class='conData'>"+content+"</p>" +
            "</div>"
        );
    }
    //初始化日程
    function initPlan() {
        $("#cluePlan").children().remove();
        $.ajax({
            url: "${baseurl}/clue/queryCommlog?clueId=${clue.id}&isPlan=1",
            type: "get",
            success: function (data) {
                var d = JSON.parse(data);
                if(d.code == 1){
                    var list = d.rows;
                    if(list.length>0){
                        for (var i=0;i<list.length;i++){
                            $("#cluePlan").append(
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
                        $("#cluePlan").append("<p class='hideP'><i class='layui-icon layui-icon-face-cry'></i> 暂无数据</p>")
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
    function openleaderName() {
        layer.open({
        title: "基本信息",
        type: 2,
        content: '${baseurl}/user/baseInfoPage?id=${clue.leader}',
        area: ['800px', '500px'],
        maxmin: true
        });

    }

    function opencreatName() {
        layer.open({
            title: "基本信息",
            type: 2,
            content: '${baseurl}/user/baseInfoPage?id=${clue.createBy}',
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
            content: '${baseurl}/clue/map?address=${clue.address}'
        });
    }

    //删除沟通日志
    function delLog(id){
        layer.confirm('确定删除该日志吗?', function () {
                $.ajax({
                    url: "${baseurl}/clue/deleteCommlog?ids="+id,
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

</html>