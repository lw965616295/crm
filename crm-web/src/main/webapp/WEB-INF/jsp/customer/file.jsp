<!DOCTYPE HTML>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jsp/common/tag.jsp" %>
<%@ include file="/WEB-INF/jsp/common/css.jsp" %>
<%@ include file="/WEB-INF/jsp/common/js.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <title>文件上传</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <style>

    </style>
</head>

<body>
<div class="layui-card">
    <div class="layui-card-body">
        <div class="layui-upload">
            <button type="button" class="layui-btn layui-btn-normal" id="test-upload-testList">选择文件</button>
            <button type="button" class="layui-btn" id="test-upload-testListAction">开始上传</button>
            <div class="layui-upload-list">
                <table class="layui-table">
                    <thead>
                    <tr>
                        <th>文件名</th>
                        <th>大小</th>
                        <th>状态</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody id="test-upload-demoList"></tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script>
    layui.use(['upload'], function () {
        var $ = layui.$,
            upload = layui.upload;
        var url = "${baseurl}/clue/upload?belongId=${file.belongId}&fileBelong=${file.fileBelong}";
        var demoListView = $('#test-upload-demoList'),
            uploadListIns = upload.render({
                elem: '#test-upload-testList',
                url: url,
                accept: 'file',
                multiple: true,
                auto: false,
                bindAction: '#test-upload-testListAction',
                choose: function (obj) {
                    var files = this.files = obj.pushFile(); //将每次选择的文件追加到文件队列
                    //读取本地文件
                    obj.preview(function (index, file, result) {
                        var tr = $(['<tr id="upload-' + index + '">', '<td>' + file.name +
                        '</td>', '<td>' + (file.size / 1014).toFixed(1) +
                        'kb</td>', '<td>等待上传</td>', '<td>',
                            '<button class="layui-btn layui-btn-mini test-upload-demo-reload layui-hide">重传</button>',
                            '<button class="layui-btn layui-btn-mini layui-btn-danger test-upload-demo-delete">删除</button>',
                            '</td>', '</tr>'
                        ].join(''));

                        //单个重传
                        tr.find('.test-upload-demo-reload').on('click', function () {
                            obj.upload(index, file);
                        });

                        //删除
                        tr.find('.test-upload-demo-delete').on('click', function () {
                            delete files[index]; //删除对应的文件
                            tr.remove();
                            uploadListIns.config.elem.next()[0].value = ''; //清空 input file 值，以免删除后出现同名文件不可选
                        });

                        demoListView.append(tr);
                    });
                },
                done: function (res, index, upload) {
                    if (res.code == 1) { //上传成功
                        var tr = demoListView.find('tr#upload-' + index),
                            tds = tr.children();
                        tds.eq(2).html('<span style="color: #5FB878;">上传成功</span>');
                        tds.eq(3).html(''); //清空操作
                        parent.tableIns.reload();
                        return delete this.files[index]; //删除文件队列已经上传成功的文件
                    }else{
                        //上传失败！
                        layer.alert(res.msg);
                    }
                    this.error(index, upload);
                },
                error: function (index, upload) {
                    var tr = demoListView.find('tr#upload-' + index),
                        tds = tr.children();
                    tds.eq(2).html('<span style="color: #FF5722;">上传失败</span>');
                    tds.eq(3).find('.test-upload-demo-reload').removeClass('layui-hide'); //显示重传
                }
            });

    });
</script>
</body>
</html>
