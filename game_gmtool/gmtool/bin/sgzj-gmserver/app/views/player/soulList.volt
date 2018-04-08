{{ partial('custom_ui/date_select') }}
{{ partial('custom_ui/player_select') }}
{{ partial('custom_ui/server_select') }}
<script type="text/javascript" charset="utf-8">
webix.ready(function () {

var event_handler = {
    onSubmitGetSoulList: function() {
        var form = $$("form:get_soul_list");
        if (form.validate() === false) {
            return;
        }

        webix.ajax().sync().get(
            "{{ url('player/get_soul_list') }}",
            form.getValues(),
            function (text, data) {
                var ret = data.json();
                if (!ret) {
                    return;
                }
                if (ret.soul_list) {
                    $$("table:soul_list").clearAll();
                    $$("table:soul_list").parse(ret.soul_list);
                    $$("table:soul_list").sort("level", "desc", "int");
                    webix.alert("查询成功");
                } else if (ret.error_code) { 
                    webix.alert(
                        enjoymi.getErrorMessage(ret.error_code));
                }
            }
        );
    },
};

var get_soul_list_form = {
    id: "form:get_soul_list",
    view: "form",
    width: 600,
    elements: [
        { view: "custom_server_select", name: "server_id",
          label: "服务器", required: true },
        { id: "text:player_id",
          view: "text", name: "player_id",
          label: "玩家ID", required: true },
        { view: "button", label: "查询", width: 100, align: "right",
          click: event_handler.onSubmitGetSoulList },
    ],
};

var soul_list_pager = {
    id: "pager:soul_list",
    view: "pager",
    template: "{common.first()} {common.prev()} " +
              "{common.pages()} " +
              "{common.next()} {common.last()}",
};

var soul_list = {
    id: "table:soul_list",
    view: "datatable",
    width: 1024,
    columns: [
        { id: "id", header: "ID", width: 160 },
        { id: "name", header: "名字", width: 110 },
        { id: "status", header: "状态", width: 60 },
        { id: "quality", header: "品质", width: 150 },
        { id: "level", header: "等级", width: 160 },
        { id: "exp", header: "经验", width: 160 },
    ],
    pager: "pager:soul_list",
    autoheight: true,
};

var soul_list_export = {
    view: "button",
    label: "导出Excel",
    type: "icon",
    icon: "save",
    width: 100,
    click: function() {
        var filename = "玩家战魂列表";

        webix.toExcel("table:soul_list", {
            name: filename,
        });
    },
};

var layout = {
    rows: [
        { cols: [
            {},
            get_soul_list_form,
            {},
        ]},
        { cols: [
            {},
            { view: "label", css: "warnings", width: 600,
              label: "*警告* 本功能可能影响游戏服务器的性能, " +
                     "请勿在游戏高峰期频繁查询" },
            {},
        ]},
        soul_list_export,
        soul_list,
        soul_list_pager,
    ],
};

$$("app:main_content").addView(layout);

});
</script>
