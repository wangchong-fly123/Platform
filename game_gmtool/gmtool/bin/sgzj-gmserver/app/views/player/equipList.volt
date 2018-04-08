{{ partial('custom_ui/date_select') }}
{{ partial('custom_ui/player_select') }}
{{ partial('custom_ui/server_select') }}
<script type="text/javascript" charset="utf-8">
webix.ready(function () {

var event_handler = {
    onSubmitGetEquipList: function() {
        var form = $$("form:get_equip_list");
        if (form.validate() === false) {
            return;
        }

        webix.ajax().sync().get(
            "{{ url('player/get_equip_list') }}",
            form.getValues(),
            function (text, data) {
                var ret = data.json();
                if (!ret) {
                    return;
                }
                if (ret.equip_list) {
                    $$("table:equip_list").clearAll();
                    $$("table:equip_list").parse(ret.equip_list);
                    $$("table:equip_list").sort("level", "desc", "int");
                    webix.alert("查询成功");
                } else if (ret.error_code) { 
                    webix.alert(
                        enjoymi.getErrorMessage(ret.error_code));
                }
            }
        );
    },
};

var get_equip_list_form = {
    id: "form:get_equip_list",
    view: "form",
    width: 600,
    elements: [
        { view: "custom_server_select", name: "server_id",
          label: "服务器", required: true },
        { id: "text:player_id",
          view: "text", name: "player_id",
          label: "玩家ID", required: true },
        { view: "button", label: "查询", width: 100, align: "right",
          click: event_handler.onSubmitGetEquipList },
    ],
};

var equip_list_pager = {
    id: "pager:equip_list",
    view: "pager",
    template: "{common.first()} {common.prev()} " +
              "{common.pages()} " +
              "{common.next()} {common.last()}",
};

var equip_list = {
    id: "table:equip_list",
    view: "datatable",
    width: 1024,
    columns: [
        { id: "id", header: "ID", width: 60 },
        { id: "name", header: "名字", width: 160 },
        { id: "intensify_level", header: "强化等级", width: 150 },
        { id: "stone", header: "宝石", width: 260 },
        { id: "star", header: "星数", width: 160 },
    ],
    pager: "pager:equip_list",
    autoheight: true,
};

var equip_list_export = {
    view: "button",
    label: "导出Excel",
    type: "icon",
    icon: "save",
    width: 100,
    click: function() {
        var filename = "玩家装备列表";

        webix.toExcel("table:equip_list", {
            name: filename,
        });
    },
};

var layout = {
    rows: [
        { cols: [
            {},
            get_equip_list_form,
            {},
        ]},
        { cols: [
            {},
            { view: "label", css: "warnings", width: 600,
              label: "*警告* 本功能可能影响游戏服务器的性能, " +
                     "请勿在游戏高峰期频繁查询" },
            {},
        ]},
        equip_list_export,
        equip_list,
        equip_list_pager,
    ],
};

$$("app:main_content").addView(layout);

});
</script>
