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
    <title>添加岗位</title>
</head>

<body>
<div class="layui-form layui-card" style="padding: 20px 70PX 20px 20PX;">
    <form class="layui-form">
        <div class="layui-form-item">
            <label class="layui-form-label">父id</label>
            <div class="layui-input-block">
                <input type="text" name="pId" value="${position.pId}" placeholder="父id" autocomplete="off"
                       class="layui-input" readonly="readonly">
            </div>
        </div>
        <div class="layui-form-item">
            <input type="text" name="updateOrSave" value="${position.id}" placeholder="" hidden="true">
            <label class="layui-form-label">岗位id</label>
            <div class="layui-input-block">
                <input type="text" name="id" value="${position.id}" placeholder="岗位id" autocomplete="off" lay-verify="required"
                       class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">岗位名称</label>
            <div class="layui-input-block">
                <input type="text" name="name" value="${position.name}" placeholder="岗位名称" autocomplete="off" lay-verify="required"
                       class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">所属部门</label>
            <div class="layui-input-block">
                <select id="dept_select" name="deptId" lay-verify="required"></select>
            </div>
        </div>
        <div class="layui-form-item" style="margin-top: 250px;margin-left: 30px">
            <input type="button" lay-submit lay-filter="position-add-submit" class="layui-btn layui-btn-normal" value="确认">&nbsp;&nbsp;&nbsp;&nbsp;
            <input type="button" class="layui-btn layui-btn-primary" onclick="cancel1()" value="取消">
        </div>
    </form>
</div>
</body>
<script>
    /*取消*/
    function cancel1(){
        var index = parent.layer.getFrameIndex(window.name);
        parent.layer.close(index);
        parent.location.reload();
    }
    layui.use('form',function(){
        var form = layui.form;
        form.on('submit(position-add-submit)',function(data){
            var field = data.field; //获取提交的字段
            if (field.updateOrSave == ""){
                url = "${baseurl}/position/save"
            }else{
                url = "${baseurl}/position/update"
            }
            console.log(field);
            //提交 Ajax 成功后，静态更新表格中的数据
            $.ajax({
                type: 'post',
                url: url,
                data: field,
                success: function (data) {
                    var code = JSON.parse(data).code;
                    if(code == 1){
                        parent.layer.msg(JSON.parse(data).msg,{
                            icon: 1,
                            time: 800,
                        },function(index){
                            cancel1();
                        });

                    }else if(code == 0){
                        layer.alert("操作失败！"+JSON.parse(data).msg);
                    }
                }
            });
        });

        //获取部门信息
        $.ajax({
            url: "${baseurl}/dept/query",
            type: "post",
            success: function(data){
                var da = JSON.parse(data).rows;
                //用于编辑修改时，回显部门信息
                var deptId = "${position.deptId}";
                if(da){
                    var sel=[];
                    sel.push('<option value=""></option>')
                    for(var i=0; i<da.length; i++){
                        var dept = da[i];
                        if(dept.id == deptId){
                            sel.push('<option value="'+dept.id+'" selected>'+dept.name+'</option>')
                        }else{
                            sel.push('<option value="'+dept.id+'">'+dept.name+'</option>')
                        }
                    }
                    $("#dept_select").html(sel.join(' '));
                    //渲染selector
                    form.render('select');
                }
            }
        });
    });

</script>
</html>