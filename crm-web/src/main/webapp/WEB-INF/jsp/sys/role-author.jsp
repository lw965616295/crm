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
    <link rel="stylesheet" href="${baseurl}/js/lib/zTree/v3/css/metroStyle/metroStyle.css" type="text/css">
    <script src="${baseurl}/js/lib/zTree/v3/js/jquery.ztree.core-3.5.min.js"></script>
    <script src="${baseurl}/js/lib/zTree/v3/js/jquery.ztree.excheck-3.5.min.js"></script>
    <script src="${baseurl}/js/lib/zTree/v3/js/jquery.ztree.exedit-3.5.min.js"></script>
    <title>角色授权</title>
</head>
<script>
    layui.use('layer');
    $(function(){
        var setting = {
            check: {
                enable: true,
                /* 勾选影响父节点不影响子节点 */
                chkboxType: { "Y": "p", "N": "s" }
            },
            data: {
                simpleData: {
                    enable: true
                }
            },
            callback: {
                onClick: function(event, treeId, treeNode) {
                    //点击触发勾选checkbox
                    console.log(treeNode.tId + ", " + treeNode.name+","+treeNode.id);

                    var ztree = $.fn.zTree.getZTreeObj("permTree");
                    if(treeNode.checked){
                        ztree.checkNode(treeNode, false, true);
                    }else{
                        ztree.checkNode(treeNode, true, true);
                    }
                },
                onCheck: function (event, treeId, treeNode) {
                    console.log(treeNode.tId + ", " + treeNode.name + "," + treeNode.checked);
                }
            },
            edit:{
                /*禁止框架触发url */
                enable: true,
                showRemoveBtn: false,
                showRenameBtn: false,
            }
        };
        var zNodes = ${perms}.rows;
        console.log(zNodes)
        $.fn.zTree.init($("#permTree"), setting, zNodes);
        var ztree = $.fn.zTree.getZTreeObj("permTree");
        //获取所有节点
        var nodes = ztree.transformToArray(ztree.getNodes());

        for (var i = 0; i < nodes.length; i++) { //设置节点展开
            ztree.expandNode(nodes[i], true, false, true);
        }
        //获取当前role所有的权限资源
        var rolePerms = ${perms2}.rows;
        console.log("rolePerms"+rolePerms.length);
        for(var i=0; i<rolePerms.length; i++){
            //权限树中只要有的该角色的权限就勾选
            for (var j = 0; j < nodes.length; j++) {
                if(rolePerms[i].permId == nodes[j].id){
                    ztree.checkNode(nodes[j], true, true);
                    break;
                }
            }
        }
    });
    /*保存授权*/
    function saveAuthor(){
        var ztree = $.fn.zTree.getZTreeObj("permTree");
        var nodes = ztree.getCheckedNodes();
        /* 取出所有点击的节点的id */
        var ids = "";
        $.each(nodes,function(i, n){
            ids += n.id + ",";
        });
        $.ajax({
            url: "${baseurl}/role/author",
            type: "post",
            data: {
                roleId: "${roleId}",
                ids: ids
            },
            success: function(data){
                var code = JSON.parse(data).code;
                if(code == 1){
                    parent.layer.msg(JSON.parse(data).msg,{
                        icon: 1,
                        time: 800, //0.8秒关闭
                    },function(index){
                        cancel1();
                    });
                }else{
                    layer.alert(JSON.parse(data).msg);
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
<body>
    <input type="button" class="layui-btn layui-btn-normal" onclick="saveAuthor()" value="确认" style="margin-left: 10px;margin-top: 10px">
    <ul id="permTree" class="ztree"></ul>
</body>

</html>