/** layuiAdmin.std-v1.1.0 LPPL License By http://www.layui.com/admin/ */ ;
layui.define(function (e) {
    var i = (layui.$, layui.layer, layui.laytpl, layui.setter, layui.view, layui.admin);
    i.events.logout = function () {
        // 询问层
        layer.confirm('确定退出登录？', {
            title: "提示",
            icon: 5
        }, function () {
            i.req({
                url: "http://wms.ruishunwl.com/rs-wms-zsc/maindata/getWareHouseList.do",
                type: "get",
                data: {},
                done: function (e) {
                    console.log(e)
                    i.exit(function () {
                        location.href = "user/login.html"
                    })
                }
            })
        });
    }, e("common", {})
});