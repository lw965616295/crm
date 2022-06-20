<!DOCTYPE HTML>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/tag.jsp"%>
<%@ include file="/WEB-INF/jsp/common/css.jsp"%>
<%@ include file="/WEB-INF/jsp/common/js.jsp"%>
<html>
<head>
    <meta charset="utf-8">
    <title>用户分配</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="stylesheet" href="${baseurl}/js/lib/zTree/v3/css/metroStyle/metroStyle.css" type="text/css">
    <script src="${baseurl}/js/lib/zTree/v3/js/jquery.ztree.core-3.5.min.js"></script>
    <script src="${baseurl}/js/lib/zTree/v3/js/jquery.ztree.excheck-3.5.min.js"></script>
    <script src="${baseurl}/js/lib/zTree/v3/js/jquery.ztree.exedit-3.5.min.js"></script>
    <style>
        .prompt {
            text-align: center;
            color: #535353;
            font-size: 17px;
            font-weight: 700;
            padding: 15px 0px;
        }

        .prompt i {
            font-size: 20px;
            margin-right: 5px;
            color: #FF5722;
        }

        .lBxo,
        .rBxo {
            border: 1px solid #666666;
            border-radius: 2%;
            padding: 10px 10px;
            height: 350px;
            overflow: auto;
            margin-left: 20px;
        }

        .mBox {
            margin: 0 20px;
            box-shadow: none;
            height: 350px;
            position: relative;
        }

        .mBox .middle {
            position: absolute;
            top: 40%;
            left: 40%;
        }
    </style>
</head>

<body>

<div class="layui-form">

    <div class="layui-form-item">
        <p class="prompt"><i class="layui-icon layui-icon-tips"></i>在左边的列表选择角色后，点击向右的箭头即可为用户设置角色。</p>
    </div>

    <div class="layui-fluid">
        <div class="layui-row ">
            <div class="layui-col-sm4 layui-col-md4 layui-col-lg4">
                <div class="layui-card lBxo">
                    未分配<br>
                    <ul id="roleTree1" class="ztree" style="border: 1px solid #999999;"></ul>
                </div>
            </div>

            <div class="layui-col-sm4 layui-col-md4 layui-col-lg4">
                <div class="mBox">
                    <div class="middle">
                        <button class="layui-btn layui-btn-sm layui-btn-normal" onclick="addRole()">
                            <i class="layui-icon layui-icon-right"></i>
                        </button><br><br>
                        <button class="layui-btn layui-btn-sm layui-btn-warm" onclick="delRole()">
                            <i class="layui-icon layui-icon-left"></i>
                        </button>
                    </div>
                </div>
            </div>

            <div class="layui-col-sm4 layui-col-md4 layui-col-lg4">
                <div class="layui-card rBxo">
                    已分配<br/>
                    <ul id="roleTree2" class="ztree" style="border: 1px solid #999999;"></ul>
                </div>
            </div>
        </div>
    </div>
    <div class="layui-col-sm4 layui-col-md4 layui-col-lg4" style="margin-left: 40px;margin-top: 40px">
        <input type="button" class="layui-btn layui-btn-normal" onclick="allocation()" value="确认">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <input type="button" class="layui-btn layui-btn-primary" onclick="cancel1()" value="取消">
    </div>
</div>

<script>
    layui.use('layer',function () {
//        var layer = layui.layer
    })
    $(function(){
        //ztree树初始化设置
        var setting = {
            edit: {
                enable: false
            },
            data: {
                simpleData: {
                    enable: true
                }
            }
        };
        $.fn.zTree.init($("#roleTree1"), setting);
        $.fn.zTree.init($("#roleTree2"), setting);
        leftObj = $.fn.zTree.getZTreeObj("roleTree1");
        rightObj = $.fn.zTree.getZTreeObj("roleTree2");
        $.ajax({
            url: "${baseurl }/role/query",
            type: "post",
            success:function(data){
                var r = JSON.parse(data);
                allRoles = r.rows;
                //获取用户对应角色信息
                var userRoles;
                $.ajax({
                    url: "${baseurl }/user/queryRole",
                    data:{
                        userId: "${userId}"
                    },
                    type: "post",
                    success:function(data){
                        var r = JSON.parse(data);
                        console.log(r.rows);
                        userRoles = r.rows;
                        console.log("allRoles:"+allRoles);
                        console.log("userRoles:"+userRoles);
                        //左右树初始化
                        $.each(allRoles, function(i, e){

                            var flag = true;
                            $.each(userRoles, function(j, v){
                                if(e.id == v.roleId){
                                    flag = false;
                                }
                            });
                            if(flag){
                                leftObj.addNodes(null,e);
                            }else{
                                rightObj.addNodes(null,e);
                            }

                        });
                    }
                });

            }
        });
    });
    //添加角色
    function addRole(){
        var nodes = leftObj.getSelectedNodes();
        if(nodes.length <= 0){
            layer.msg('请选择要分配的角色！');
            return;
        }
        $.each(nodes, function(i,e) {
            leftObj.removeNode(e);
            rightObj.addNodes(null,e);
        });
    }
    //删除角色
    function delRole(){
        var nodes = rightObj.getSelectedNodes();
        if(nodes.length <= 0){
            layer.msg('请选择要移除的角色！');
            return;
        }
        $.each(nodes, function(i,e) {
            rightObj.removeNode(e);
            leftObj.addNodes(null,e);
        });

    }
    //用户角色分配
    function allocation(){
        //获取所有分配角色ids
        rightObj = $.fn.zTree.getZTreeObj("roleTree2");
        var rightNodes = rightObj.getNodes();
        var roleIds = "";
        $.each(rightNodes, function(i, e){
            roleIds += e.id + ",";
        });
        console.log("roleIds:"+roleIds);
        //提交已分配角色信息
        $.ajax({
            url: "${baseurl }/user/allotRoles",
            data:{
                userId: "${userId}",
                roleIds: roleIds
            },
            type: "post",
            success:function(data){
                var code = JSON.parse(data).code;
                if(code == 1){
                    parent.layer.msg(JSON.parse(data).msg,{
                        icon: 1,
                        time: 800,
                    },function(index){
                        cancel1();
                    });
                }else if(code == 0){
                    layer.msg("操作失败！"+JSON.parse(data).msg);
                }
            }
        });
    }
    /*取消*/
    function cancel1(){
        var index = parent.layer.getFrameIndex(window.name);
        parent.layer.close(index);
    }
</script>
</body>

</html>