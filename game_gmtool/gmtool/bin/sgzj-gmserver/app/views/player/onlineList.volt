{{ partial('custom_ui/date_select') }}
{{ partial('custom_ui/player_select') }}
{{ partial('custom_ui/server_select') }}
<script type="text/javascript" charset="utf-8">
webix.ready(function () {

var event_handler = {
    onSubmitGetOnlineList: function() {
        var form = $$("form:get_online_list");
        if (form.validate() === false) {
            return;
        }

        webix.ajax().sync().get(
            "{{ url('player/get_online_list') }}",
            form.getValues(),
            function (text, data) {
                var ret = data.json();
                if (!ret) {
                    return;
                }
                if (ret.online_list) {
                    $$("table:online_list").clearAll();
                    $$("table:online_list").parse(ret.online_list);
                    $$("table:online_list").sort("level", "desc", "int");
                    webix.alert("查询成功");
                } else if (ret.error_code) { 
                    webix.alert(
                        enjoymi.getErrorMessage(ret.error_code));
                }
            }
        );
    },
};

var get_online_list_form = {
    id: "form:get_online_list",
    view: "form",
    width: 600,
    elements: [
        { view: "custom_server_select", name: "server_id",
          label: "服务器", required: true },
        { view: "button", label: "查询", width: 100, align: "right",
          click: event_handler.onSubmitGetOnlineList },
    ],
};

var online_list_pager = {
    id: "pager:online_list",
    view: "pager",
    template: "{common.first()} {common.prev()} " +
              "{common.pages()} " +
              "{common.next()} {common.last()}",
};

var online_list = {
    id: "table:online_list",
    view: "datatable",
    width: 1024,
    columns: [
        { id: "player_id", header: "玩家ID", width: 160 },
        { id: "nickname", header: "角色名", width: 160 },
        { id: "account", header: "账号", width: 400 },
        { id: "level", header: "等级", width: 60, sort: "int" },
        { id: "total_pay_amount", header: "充值总金额", sort: "int" },
        { id: "diamond", header: "当前元宝数", sort: "int" },
        { id: "online_time", header: "总在线时间(分钟)",
          width: 150, sort: "int" },
        { id: "create_time", header: "创建角色时间", width: 150 },
        { id: "net_type", header: "网络类型" },
        { id: "device_model", header: "设备", width: 500 },
        { id: "device_os", header: "操作系统", width: 500 },
    ],
    pager: "pager:online_list",
    autoheight: true,
};

var online_list_export = {
    view: "button",
    label: "导出Excel",
    type: "icon",
    icon: "save",
    width: 100,
    click: function() {
        var filename = "在线玩家列表";

        webix.toExcel("table:online_list", {
            name: filename,
        });
    },
};

var layout = {
    rows: [
        { cols: [
            {},
            get_online_list_form,
            {},
        ]},
        { cols: [
            {},
            { view: "label", css: "warnings", width: 600,
              label: "*警告* 本功能可能影响游戏服务器的性能, " +
                     "请勿在游戏高峰期频繁查询" },
            {},
        ]},
        online_list_export,
        online_list,
        online_list_pager,
    ],
};

$$("app:main_content").addView(layout);

});
</script>
