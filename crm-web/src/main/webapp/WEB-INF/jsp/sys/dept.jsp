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
    <title>部门管理</title>
</head>
<link rel="stylesheet" href="${baseurl}/js/lib/zTree/v3/css/metroStyle/metroStyle.css" type="text/css">
<script src="${baseurl}/js/lib/zTree/v3/js/jquery.ztree.core-3.5.min.js"></script>
<script src="${baseurl}/js/lib/zTree/v3/js/jquery.ztree.excheck-3.5.min.js"></script>
<script src="${baseurl}/js/lib/zTree/v3/js/jquery.ztree.exedit-3.5.min.js"></script>
<body>
    <div class="zTreeDemoBackground" style="margin-left: 100px; margin-top: 100px">
        <ul id="treeDemo" class="ztree"></ul>
    </div>
    <script>
        layui.use("layer");
        var setting = {
            view: {
                addHoverDom: addHoverDom,
                removeHoverDom: removeHoverDom,
            },
            edit: {
                enable: true,
                showRemoveBtn: showRemoveBtn,
                showRenameBtn: showRenameBtn
            },
            data: {
                simpleData: {
                    enable: true
                }
            },
            callback: {
                beforeEditName: beforeEditName,
                beforeRemove: beforeRemove,
            }
        };

        function beforeEditName(treeId, treeNode) {

            deptEdit(treeNode.id);
            return false;
        }
        function beforeRemove(treeId, treeNode) {
            deptDel(treeNode.id);
            return false;
        }

        function showRemoveBtn(treeId, treeNode) {
            return treeNode.id != 1;
        }
        function showRenameBtn(treeId, treeNode) {
            return treeNode.id != 1 ;
        }
        function addHoverDom(treeId, treeNode) {
            var sObj = $("#" + treeNode.tId + "_span");
            if (treeNode.editNameFlag || $("#addBtn_"+treeNode.tId).length>0) return;
            var addStr = "<span class='button add' id='addBtn_" + treeNode.tId
                + "' title='添加部门' onfocus='this.blur();'></span>";
            sObj.after(addStr);
            var btn = $("#addBtn_"+treeNode.tId);
            if (btn) btn.bind("click", function(){
                var zTree = $.fn.zTree.getZTreeObj("treeDemo");
                deptAdd(treeNode.id);
                return false;
            });
        };
        function removeHoverDom(treeId, treeNode) {
            $("#addBtn_"+treeNode.tId).unbind().remove();
        };
        /*跳转添加页面*/
        function deptAdd(pid) {
            layer.open({
                type: 2,
                title: '添加部门',
                content: "${baseurl}/dept/addPage?pId="+pid ,
                maxmin: true,
                area: ['800px', '570px']
            });
        }
        /*修改部门名称*/
        function deptEdit(id) {
            layer.open({
                type: 2,
                title: '修改部门',
                content: "${baseurl}/dept/updatePage?id="+id ,
                maxmin: true,
                area: ['800px', '570px']
            });
        }
        /*删除部门*/
        function deptDel(id) {
            layer.confirm('确认要删除吗？',function(){
                $.get("${baseurl}/dept/delete?ids="+id, function(data){
                    var d = JSON.parse(data);
                    if(d.code == 1){
                        layer.msg(d.msg,{icon:1,time:1000});
                        location.reload();
                    }else{
                        layer.msg(d.msg,{icon:2,time:1000});
                    }
                });
            });
        }
        //加载部门信息
        $(document).ready(function(){
            $.ajax({
                url: "${baseurl}/dept/query",
                type: "post",
                success: function(data){
                    var zNodes = JSON.parse(data).rows;
                    $.fn.zTree.init($("#treeDemo"), setting, zNodes);
                    var ztree = $.fn.zTree.getZTreeObj("treeDemo");
                    //获取所有节点
                    var nodes = ztree.transformToArray(ztree.getNodes());

                    for (var i = 0; i < nodes.length; i++) { //设置节点展开
                        ztree.expandNode(nodes[i], true, false, true);
                    }
                }
            });
        });
    </script>
</body>

</html>