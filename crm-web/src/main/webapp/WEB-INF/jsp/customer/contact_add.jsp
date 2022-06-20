<!DOCTYPE HTML>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jsp/common/tag.jsp" %>
<%@ include file="/WEB-INF/jsp/common/css.jsp" %>
<%@ include file="/WEB-INF/jsp/common/js.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <title>新建联系人</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">

    <style>
        .layui-card-header {
            border: none;
        }

        .sq-tag {
            width: 8px;
            height: 18px;
            background-color: #009688;
            padding: 0px;
            display: inline-block;
        }

        .text-tag {
            display: inline-block;
            position: relative;
            top: -3px;
        }

        .layui-form-label {
            text-align: left;
            width: 90px;
            padding: 9px 15px 9px 0;
        }

        .layui-input-block {
            margin-left: 105px;
        }

        .layui-textarea {
            resize: none;
        }

    </style>
</head>

<body>

<div class="layui-form" lay-filter="contact_add" id="contact_add" style="padding: 20px 70PX 20px 20PX;">
    <form class="layui-form">
    <input type="text" name="id" value="${contact.id}" hidden>
    <div class="layui-row layui-col-space10">

        <div class="layui-col-xs12 layui-col-sm6 layui-col-md6">
            <div class="layui-card">
                <div class="layui-card-header">
                    <span class="sq-tag"></span>
                    <div class="text-tag">
                        <span>基本信息</span>
                    </div>
                </div>
                <div class="layui-card-body">

                    <div class="layui-form-item">
                        <label class="layui-form-label">所属客户<span style="color: red">*</span></label>
                        <div class="layui-input-inline">
                            <input type="text" id="selector_customer_name" lay-verify="required" value="${contact.cusName}"
                                   data-type="fromCust" placeholder="请选择客户"
                                   autocomplete="off" onclick="selectLeader()" class="layui-input" readonly>
                            <input type="text" id="selector_customer_id" value="${contact.cusId}" data-type="fromCust"
                                   name="cusId"
                                   autocomplete="off" hidden>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">联系人姓名<span style="color: red">*</span></label>
                        <div class="layui-input-inline">
                            <input type="text" name="name" value="${contact.name}" lay-verify="required"
                                   placeholder="请输入联系人姓名"
                                   autocomplete="off" class="layui-input">
                        </div>
                    </div>

                    <div class="layui-form-item">
                        <label class="layui-form-label">是否为首要联系人</label>
                        <div class="layui-input-block">
                            <input type="checkbox" name="firstContact" lay-skin="switch" lay-text="ON|OFF">
                        </div>


                        <div class="layui-form-item">
                            <label class="layui-form-label">角色<span style="color: red">*</span></label>
                            <div class="layui-input-inline">
                                <select name="role" lay-verify="required">
                                    <option value=""></option>
                                    <option value="普通人" <c:if test="${contact.role=='普通人'}">selected="selected"</c:if>>普通人
                                    </option>
                                    <option value="决策人" <c:if test="${contact.role=='决策人'}">selected="selected"</c:if>>决策人
                                    </option>
                                    <option value="分项决策人"
                                            <c:if test="${contact.role=='分项决策人'}">selected="selected"</c:if>>分项决策人

                                    </option>
                                    <option value="商务决策"
                                            <c:if test="${contact.role=='商务决策'}">selected="selected"</c:if>></option>
                                    <option value="技术决策"
                                            <c:if test="${contact.role=='技术决策'}">selected="selected"</c:if>>技术决策

                                    </option>
                                    <option value="财务决策"
                                            <c:if test="${contact.role=='财务决策'}">selected="selected"</c:if>>财务决策

                                    </option>
                                    <option value="使用人" <c:if test="${contact.role=='使用人'}">selected="selected"</c:if>>使用人
                                    </option>
                                    <option value="意见影响人"
                                            <c:if test="${contact.role=='意见影响人'}">selected="selected"</c:if>>意见影响人

                                    </option>
                                </select>
                            </div>
                        </div>

                        <div class="layui-form-item" lay-filter="sex">
                            <label class="layui-form-label">尊称</label>
                            <div class="layui-input-block">
                                <c:set var="callname" scope="request" value="${contact.callname}"/>

                                <input type="radio" name="callname" value="先生" title="先生"
                                       <c:if test="${callname == '先生' || callname == undefined}">checked</c:if>>
                                <input type="radio" name="callname" value="女士" title="女士"
                                       <c:if test="${callname == '女士'}">checked</c:if>>
                            </div>
                        </div>

                        <div class="layui-form-item">
                            <label class="layui-form-label">职位</label>
                            <div class="layui-input-inline">
                                <input type="text" name="position" value="${contact.position}" placeholder="请输入职位"
                                       autocomplete="off"
                                       class="layui-input">
                            </div>
                        </div>

                        <div class="layui-form-item">
                            <label class="layui-form-label">手机<span style="color: red">*</span></label>
                            <div class="layui-input-inline">
                                <input type="text" name="phone" value="${contact.phone}"
                                       placeholder="请输入手机号" lay-verify="phone" autocomplete="off"
                                       class="layui-input">
                            </div>
                        </div>

                        <div class="layui-form-item">
                            <label class="layui-form-label">QQ/MSN</label>
                            <div class="layui-input-inline">
                                <input type="text" name="qq" value="${contact.qq}" placeholder="请输入QQ/MSN"
                                       autocomplete="off"
                                       class="layui-input">
                            </div>
                        </div>

                        <div class="layui-form-item">
                            <label class="layui-form-label">邮箱</label>
                            <div class="layui-input-inline">
                                <input type="text" name="email"   value="${contact.email}" placeholder="请输入邮箱"
                                             autocomplete="off"
                                       class="layui-input">
                            </div>
                        </div>

                        <div class="layui-form-item">
                            <label class="layui-form-label">邮编</label>
                            <div class="layui-input-inline">
                                <input type="text" name="postcode" value="${contact.postcode}" placeholder="请输入邮编"
                                       autocomplete="off"
                                       class="layui-input">
                            </div>
                        </div>

                        <div class="layui-form-item">
                            <label class="layui-form-label">所在地区</label>
                            <div class="layui-input-block ">
                            <textarea name="address" placeholder="请输入地址"
                                      class="layui-textarea">${contact.address}</textarea>
                            </div>
                        </div>

                        <div class="layui-form-item ">
                            <label class="layui-form-label">备注</label>
                            <div class="layui-input-block ">
                                <textarea name="ch2" placeholder="请输入备注"
                                          class="layui-textarea">${contact.ch2} </textarea>
                            </div>
                        </div>

                        <div class="layui-form-item">
                            <div class="layui-input-block">
                                <input type="button" lay-submit lay-filter="LAY-contact-submit" class="layui-btn layui-btn-normal" value="提交">

                                <input type="reset" class="layui-btn layui-btn-primary" value="重置"/>
                            </div>
                        </div>

                    </div>

                </div>
            </div>
        </div>


    </div>
    </form>

    <script>

        function selectLeader() {
            layer.open({
                title: "选择所属客户",
                type: 2,
                area: ['700px', '450px'],
                maxmin: true,
                content: '${baseurl}/contact/createrPage'
            });
        }

        function cancel1() {
            var index = parent.layer.getFrameIndex(window.name);
            parent.layer.close(index);
            parent.location.reload();
        }


        layui.use('form', function () {
            var form = layui.form;

            form.on('submit(LAY-contact-submit)', function (data) {
                var field = data.field; //获取提交的字段]
                console.log(field);

                if (field.firstContact != undefined) {
                        field.firstContact = 1;
                } else {
                        field.firstContact = 0;
                }

                console.log(field);

                console.log(${contact.id == undefined} ? 'save' : 'update');
                //提交 Ajax 成功后，更新表格中的数据
                $.ajax({
                    type: 'post',
                    url: '${baseurl}/contact/' + (${contact.id == undefined} ? 'save' : 'update'),
                    data: field,
                    success: function (data) {
                        var code = JSON.parse(data).code;
                        if (code == 1) {
                            parent.layer.msg(JSON.parse(data).msg, {
                                icon: 1,
                                time: 800,
                            }, function (index) {
                                cancel1();
                            });

                        } else if (code == 0) {
                            layer.alert("操作失败！" + JSON.parse(data).msg);
                        }
                    }
                });
            });
        });


    </script>
</div>
</body>

</html>