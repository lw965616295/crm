<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/tag.jsp"%>
<%@ include file="/WEB-INF/jsp/common/css.jsp"%>
<%@ include file="/WEB-INF/jsp/common/js.jsp"%>
<html>

<head>
	<meta charset="utf-8">
	<title>登录</title>
	<meta name="renderer" content="webkit">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
</head>

<body>

<div class="layadmin-user-login layadmin-user-display-show" id="LAY-user-login" style="display: none;">

	<div class="layadmin-user-login-main">
		<div class="layadmin-user-login-box layadmin-user-login-header">
			<h2>掌上仓 CRM</h2>
		</div>
		<form class="layui-form" action="${baseurl}/login" method="post">
		<div class="layadmin-user-login-box layadmin-user-login-body layui-form">
			<div class="layui-form-item">
				<label class="layadmin-user-login-icon layui-icon layui-icon-username" for="LAY-user-login-username"></label>
				<input type="text" name="username" id="LAY-user-login-username" lay-verify="required" placeholder="用户名" class="layui-input">
			</div>
			<div class="layui-form-item">
				<label class="layadmin-user-login-icon layui-icon layui-icon-password" for="LAY-user-login-password"></label>
				<input type="password" name="password" id="LAY-user-login-password" lay-verify="required" placeholder="密码"
					   class="layui-input">
			</div>

			<div class="layui-form-item" style="margin-bottom: 20px;">
				<a href="javascript:;" class="layadmin-user-jump-change layadmin-link" style="margin-top: 7px;" onclick="forgetPw()">忘记密码？</a>
			</div>
			<div class="layui-form-item">
				<button class="layui-btn layui-btn-fluid" lay-submit lay-filter="LAY-user-login-submit">登 入</button>
			</div>
		</div>
		</form>
	</div>

	<div class="layui-trans layadmin-user-login-footer">
		<p>© 2019 <a href="http://www.zhangsc.com/" target="_blank">zhangsc.com</a></p>
	</div>

</div>
<script>
	//回车登录
	document.onkeydown = function (e) {
		if(e.keyCode == 13){
		    $(".layui-btn").click();
		}
    }

    // 忘记密码
    function forgetPw() {
        layer.msg('请联系管理员！', {
            offset: '50px',
            icon: 1,
            time: 1000
        });
    }
</script>
</body>

</html>