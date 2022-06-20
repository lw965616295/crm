<!DOCTYPE HTML>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/tag.jsp"%>
<%@ include file="/WEB-INF/jsp/common/css.jsp"%>
<%@ include file="/WEB-INF/jsp/common/js.jsp"%>
<html>
<head>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <title>预览文件</title>
</head>
<body>
<div id='mediaDiv'></div>
<script type="text/javascript" src="${baseurl}/js/jquery.media.js"></script>
<script type="text/javascript">
    $(function () {
        var url = "${url}";
        if(/\.(pdf)$/.test(url)){
            $("#mediaDiv").media({
                width: '100%',
                height: '100%',
                autoplay: true,
                src:url
            });
        }else if(/\.(xls|xlsx|docx|pptx|doc|ppt)$/.test(url)){
            $("#mediaDiv").append("<iframe src='https://view.officeapps.live.com/op/view.aspx?src="+url+"' width='100%' height='600px' frameborder='1'></iframe>");
        }else if(/\.(txt)$/.test(url)){
            $("#mediaDiv").append("<div align='center'><iframe src='"+url+"' width='100%' height='600px'></iframe></div>");
        }
    })
</script>
</body>
</html>
