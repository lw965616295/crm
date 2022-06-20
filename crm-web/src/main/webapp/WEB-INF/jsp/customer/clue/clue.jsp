<!DOCTYPE HTML>
<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jsp/common/tag.jsp" %>
<%@ include file="/WEB-INF/jsp/common/css.jsp" %>
<%@ include file="/WEB-INF/jsp/common/js.jsp" %>
<html>

<head>
	<meta charset="utf-8">
	<title>线索</title>
	<meta name="renderer" content="webkit">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
</head>

<body>

<div class="layui-fluid">
	<div class="layui-card">
		<div class="layui-form layui-card-header layuiadmin-card-header-auto">
			<div class="layui-form-item">

				<shiro:hasPermission name="clue:add">
					<div class="layui-inline">
						<button class="layui-btn" data-type="addClue" id="addClue">新建线索</button>
					</div>
				</shiro:hasPermission>

				<div class="layui-inline">
					<div class="layui-input-block" style="margin-left: 10px;">
						<select name="clueRange">
							<option value="0">我的线索</option>
							<shiro:hasPermission name="clue:range">
							<option value="1">下属线索</option>
							<option value="2">全部线索</option>
							</shiro:hasPermission>
						</select>
					</div>
				</div>

				<%--<div class="layui-inline">--%>
					<%--<div class="layui-input-block" style="margin-left: 10px;">--%>
						<%--<select name="searchType" class="select">--%>
							<%--<option value="infoFrom">信息来源</option>--%>
							<%--<option value="contact">联系人</option>--%>
							<%--<option value="company">公司名</option>--%>
							<%--<option value="phone">手机号</option>--%>
						<%--</select>--%>
					<%--</div>--%>
				<%--</div>--%>

				<div class="layui-inline">
					<label class="layui-form-label">搜索:</label>
					<div class="layui-input-block">
						<input id="sContent" type="text" name="queryStr" placeholder="请输入搜索内容" autocomplete="off" class="layui-input">
					</div>
				</div>
				<div class="layui-inline">
					<input id="beginTime" name="beginTime" type="text" class="layui-input" placeholder="开始时间">
				</div>
				<div class="layui-inline">
					-
				</div>
				<div class="layui-inline">
					<input id="endTime" name="endTime" type="text" class="layui-input" placeholder="结束时间">
				</div>
				<shiro:hasPermission name="clue:query">
				<div class="layui-inline">
					<button class="layui-btn layuiadmin-btn-useradmin" lay-submit lay-filter="LAY-clue-front-search">
						<i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
					</button>
				</div>
				</shiro:hasPermission>
			</div>
		</div>

		<div class="layui-card-body">

			<table id="LAY-clue-manage" lay-filter="LAY-clue-manage"></table>

			<script type="text/html" id="toolbarDemo">
				<%--<button class="layui-btn layui-btn-sm layui-hide" lay-event="addLog" id="btn_addLog">添加沟通日志</button>--%>
				<shiro:hasPermission name="clue:update">
				<button class="layui-btn layui-btn-sm layui-hide" lay-event="update" id="btn_update">编辑</button>
				</shiro:hasPermission>
				<shiro:hasPermission name="clue:toPool">
				<button class="layui-btn layui-btn-sm layui-hide" lay-event="toPool" id="btn_toPool">放回线索池</button>
				</shiro:hasPermission>
				<shiro:hasPermission name="clue:change">
				<button class="layui-btn layui-btn-sm layui-hide" lay-event="change" id="btn_change">转化</button>
				</shiro:hasPermission>
			</script>
		</div>
	</div>
</div>

<script type="text/html" id="createTimeFormatter">
	{{dateFormatter1(d.createTime)}}
</script>
<script type="text/html" id="modifyTimeFormatter">
	{{dateFormatter1(d.modifyTime)}}
</script>
<script type="text/html" id="nextTimeFormatter">
	{{#  if(d.nextTime != undefined){
			var next = dateFormatter1(d.nextTime);
			var d = new Date();
			var today = dateFormatter1(d.getTime());
			if(next < today){
				return '<span style="color: red;">'+next+'</span>';
			}else if(next > today){
				return '<span style="color: green;">'+next+'</span>';
			}else{
				return next;
			}
		}
	}}
</script>
<script type="text/html" id="dueDayFormatter">
	{{#
		return "<span style='color: red'> "+d.dueDay+"天</span>"
	}}
</script>
<script>


    var tableIns;
	layui.use(['table', 'laydate', 'form'], function () {
		var table = layui.table
        	laydate = layui.laydate
            form = layui.form;

		//使用日期(开始)
		laydate.render({
			elem: '#beginTime',
            done: function(value, date, endDate){
			    var beginTime = new Date(value).getTime();
			    var endTime = new Date($("#endTime").val()).getTime();
			    if(beginTime > endTime){
			        layer.msg("开始时间不能大于结束时间！")
                    $("#endTime").val(value);
				}
			}
		});
        //使用日期(结束)
        laydate.render({
            elem: '#endTime',
            done: function(value, date, endDate){
                var endTime = new Date(value).getTime();
                var beginTime = new Date($("#beginTime").val()).getTime();
                if(beginTime > endTime){
                    layer.msg("开始时间不能大于结束时间！")
                    $("#beginTime").val(value);
                }
            }
        });

		//使用表格
        tableIns = table.render({
			elem: '#LAY-clue-manage',
			url: '${baseurl}/clue/query', //数据接口
			method: 'post',
			request: {
				limitName: 'rows' //每页数据量的参数名，默认：limit
			},
			response: {
				statusCode: 1 //规定成功的状态码，默认：0
				,countName: 'total' //规定数据总数的字段名称，默认：count
				,dataName: 'rows' //规定数据列表的字段名称，默认：data
			},
            where: {status: 2, clueRange: 0},
			page: true, //开启分页
			limit: 15,
			limits: [15,50,100],
			height: "full-220",
			text: "对不起，加载出现异常！",
			toolbar: '#toolbarDemo',
			defaultToolbar: ['filter'],
			cols: [
				[ //表头
					{
						type: "checkbox",
						fixed: "left"
					}, {
					field: "contact",
					title: "联系人姓名",
					align:"center",
					width: "10%"

				}, {
					field: "company",
					title: "公司名",
					event: 'company', // 点击事件绑定
					style: "color: #2898E0;cursor:pointer;" ,// 样式
					align:"center",
					width: "12%"


				}, {
                    field: "content",
                    title: "下次联系内容",
					align:"center",
					width: "13%"

                }, {
                    field: "nextTime",
                    title: "下次联系时间",
                    templet: '#nextTimeFormatter',
					align:"center",
					width: "11%"
                }, {
                    field: "callname",
                    title: "尊称",
					align:"center",
					width: "8%"
                }, {
					field: "position",
					title: "职位",
					align:"center",
					width: "9%"
				}, {
                    field: "infoFrom",
                    title: "信息来源",
					align:"center",
					width: "11%"

                }, {
					field: "phone",
					title: "手机",
					align:"center",
					width: "11%"
				}, {
					field: "email",
					title: "邮箱",
					align:"center",
					width: "11%"
				}, {
					field: "address",
					title: "地址",
					align:"center",
					width: "15%"


				}, {
					field: "remark",
					title: "备注",
					align:"center",
					width: "15%",


				}, {
                    field: "leaderName",
                    title: "负责人",
                    event: "leaderName",
                    style: "color: #2898E0;cursor:pointer;" ,
					align:"center",
					width: "8%"
                }, {
					field: "createrName",
					title: "创建人",
                    event: "createrName",
					style: "color: #2898E0;cursor:pointer;",
					align:"center",
					width: "8%"
				}, {
					field: "createTime",
					title: "创建时间",
					sort: true,
					templet: '#createTimeFormatter',
					align:"center",
					width: "11%"
				}, {
                    field: "dueDay",
                    title: "距到期天数",
                    sort: true,
                    templet: '#dueDayFormatter',
					align:"center",
                    width: "12%"
                },{
					field: "modifyTime",
					title: "最近跟进",
                    sort: true,
                    templet: '#modifyTimeFormatter',
					align:"center",
					width: "11%"
				}
				]
			]
		});
        //监听搜索
        form.on('submit(LAY-clue-front-search)', function (data2) {
            var field = data2.field;
            var data = new Array();
            data["queryStr"] = field.queryStr;
            data["status"] = 2;
            data["beginTime"] = field.beginTime;
            data["endTime"] = field.endTime;
            data["clueRange"] = field.clueRange;
            console.log(data);
            //执行重载
            tableIns.reload({
                where: data,
            });
        });
		// 单复选框操作
		table.on('checkbox(LAY-clue-manage)', function (obj) {
			var checkStatus = table.checkStatus('LAY-clue-manage');
			selectData = checkStatus.data

			if (selectData.length == 0) {
                $("#btn_update").addClass("layui-hide");
                $("#btn_delete").addClass("layui-hide");
//                $("#btn_addLog").addClass("layui-hide");
                $("#btn_toPool").addClass("layui-hide");
                $("#btn_change").addClass("layui-hide");
			} else if (selectData.length == 1) {
                $("#btn_update").removeClass("layui-hide");
                $("#btn_delete").removeClass("layui-hide");
//                $("#btn_addLog").removeClass("layui-hide");
                $("#btn_toPool").removeClass("layui-hide");
                $("#btn_change").removeClass("layui-hide");
			} else {
                $("#btn_update").addClass("layui-hide");
//                $("#btn_addLog").addClass("layui-hide");
                $("#btn_delete").removeClass("layui-hide");
                $("#btn_toPool").removeClass("layui-hide");
                $("#btn_change").removeClass("layui-hide");
			}
		});

        //添加用户
        $("#addClue").click(function () {
            var index = layer.open({
                type: 2,
                title: '新建线索',
                content: '${baseurl}/clue/addPage',
                maxmin: true,
                area: ['900px', '600px']
            });
            layer.full(index);
        });

        //表头按钮监听
        table.on('toolbar(LAY-clue-manage)', function (obj) {
            var checkStatus = table.checkStatus('LAY-clue-manage');
            selectData = checkStatus.data;
            switch (obj.event) {
                case 'update':
                    layer.open({
                        type: 2,
                        title: '编辑线索',
                        content: '${baseurl}/clue/updatePage?id='+selectData[0].id,
                        maxmin: true,
                        area: ['900px', '600px']
                    });
                    break;
                case 'delete':
                    layer.confirm('确认要删除吗？', function () {
                        var ids = "";
                        $.each(selectData, function (i, n) {
                            ids += n.id + ',';
                        });
                        console.log(ids);
                        $.get("${baseurl}/clue/delete?ids=" + ids, function (data) {
                            var d = JSON.parse(data);
                            if (d.code == 1) {
                                layer.msg(d.msg, {icon: 1, time: 1000});
                                tableIns.reload(); //数据刷新
                            } else {
                                layer.alert(d.msg, {icon: 2});
                            }
                        });
                    });
                    break;
                case 'toPool':
                    layer.confirm('确认要放回线索池吗？', function () {
                        var ids = "";
                        $.each(selectData, function (i, n) {
                            ids += n.id + ',';
                        });
                        console.log(ids);
                        $.get("${baseurl}/clue/toPool?ids=" + ids, function (data) {
                            var d = JSON.parse(data);
                            if (d.code == 1) {
                                layer.msg(d.msg, {icon: 1, time: 1000});
                                tableIns.reload(); //数据刷新
                            } else {
                                layer.alert(d.msg, {icon: 2});
                            }
                        });
                    });
                    break;
                case 'change':
					layer.confirm('确认要转换吗？', function () {
						var ids = "";
						$.each(selectData, function (i, n) {
							ids += n.id + ',';
						});
						console.log(ids);
						$.get("${baseurl}/clue/change?ids=" + ids, function (data) {
							var d = JSON.parse(data);
							if (d.code == 1) {
								layer.msg(d.msg, {icon: 1, time: 1000});
								tableIns.reload(); //数据刷新
							} else {
								layer.alert(d.msg, {icon: 2});
							}
						});
					});


                    break;
            };
        });

		//监听单元格事件
		table.on('tool(LAY-clue-manage)', function (obj) {
			var data = obj.data;
			if (obj.event === 'company') {
				var index = layer.open({
					title:"线索详情",
					type: 2,
					content: '${baseurl}/clue/clueDetailPage?id='+data.id,
					area: ['900px', '600px'],
					maxmin: true
				});
				layer.full(index);
			}else if(obj.event === 'leaderName'){
                layer.open({
                    title: "基本信息",
                    type: 2,
                    content: '${baseurl}/user/baseInfoPage?id='+data.leader,
                    area: ['800px', '500px'],
                    maxmin: true
                });
			}else if(obj.event === 'createrName'){
                layer.open({
                    title: "基本信息",
                    type: 2,
                    content: '${baseurl}/user/baseInfoPage?id='+data.createBy,
                    area: ['800px', '500px'],
                    maxmin: true
                });
            }

		});
	});
</script>
</body>

</html>
