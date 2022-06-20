<!DOCTYPE HTML>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/tag.jsp"%>
<%@ include file="/WEB-INF/jsp/common/css.jsp"%>
<%@ include file="/WEB-INF/jsp/common/js.jsp"%>
<html>
<head>
  <meta charset="utf-8">
  <title>修改密码</title>
  <meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
</head>
<body>

  <div class="layui-fluid">
    <div class="layui-row layui-col-space15">
      <div class="layui-col-md12">
        <div class="layui-card">
          <div class="layui-card-header">修改密码</div>
          <div class="layui-card-body" pad15>
            
            <div class="layui-form" lay-filter="">
              <div class="layui-form-item">
                <label class="layui-form-label">当前密码</label>
                <div class="layui-input-inline">
                  <input type="password" name="password" lay-verify="required" autocomplete="off" class="layui-input" >
                </div>
              </div>
              <div class="layui-form-item">
                <label class="layui-form-label">新密码</label>
                <div class="layui-input-inline">
                  <input type="password" name="newPwd" lay-verify="newPwd"  autocomplete="off" id="newPwd" class="layui-input">
                </div>
                <div class="layui-form-mid layui-word-aux">6到16个字符</div>
              </div>
              <div class="layui-form-item">
                <label class="layui-form-label">确认新密码</label>
                <div class="layui-input-inline">
                  <input type="password" name="repassword" lay-verify="repasss" id="repassword" autocomplete="off" class="layui-input">
                </div>
              </div>
              <div class="layui-form-item">
                <div class="layui-input-block">
                  <button class="layui-btn" lay-submit lay-filter="updatePwd">确认修改</button>
                </div>
              </div>
            </div>
            
          </div>
        </div>
      </div>
    </div>
  </div>

  <script>
  layui.use('form',function(){
      var form = layui.form;
      form.verify({
          newPwd: [/^\S{6,12}$/, "密码必须6到12位，且不能出现空格"],
          repasss: function () {
              if ($("#repassword").val() !== $("#newPwd").val()) return "两次密码输入不一致"
          }
      });
      form.on('submit(updatePwd)', function(data){
          var field = data.field; //获取提交的字段
          url = '${baseurl}/user/updatePwd'
          $.ajax({
              type: 'post',
              url: url,
              data: field,
              success: function (data) {
                  var code = JSON.parse(data).code;
                  if(code == 1){
                      layer.msg(JSON.parse(data).msg,{
                          icon: 1,
                          time: 800,
                      });
                  }else if(code == 0){
                      layer.alert("操作失败！"+JSON.parse(data).msg);
                  }
              }
          });
      });

  });

  </script>
</body>
</html>