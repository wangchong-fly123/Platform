{{ partial('custom_ui/date_select') }}
{{ partial('custom_ui/player_select') }}
{{ partial('custom_ui/server_select') }}
<script type="text/javascript" charset="utf-8">
webix.ready(function () {

var event_handler = {
    onSubmitGetBuddyList: function() {
        var form = $$("form:get_buddy_list");
        if (form.validate() === false) {
            return;
        }

        webix.ajax().sync().get(
            "{{ url('player/get_buddy_list') }}",
            form.getValues(),
            function (text, data) {
                var ret = data.json();
                if (!ret) {
                    return;
                }
                if (ret.buddy_list) {
                    $$("table:buddy_list").clearAll();
                    $$("table:buddy_list").parse(ret.buddy_list);
                    $$("table:buddy_list").sort("level", "desc", "int");
                    webix.alert("查询成功");
                } else if (ret.error_code) { 
                    webix.alert(
                        enjoymi.getErrorMessage(ret.error_code));
                }
            }
        );
    },
};

var get_buddy_list_form = {
    id: "form:get_buddy_list",
    view: "form",
    width: 600,
    elements: [
        { view: "custom_server_select", name: "server_id",
          label: "服务器", required: true },
        { id: "text:player_id",
          view: "text", name: "player_id",
          label: "玩家ID", required: true },
        { view: "button", label: "查询", width: 100, align: "right",
          click: event_handler.onSubmitGetBuddyList },
    ],
};

var buddy_list_pager = {
    id: "pager:buddy_list",
    view: "pager",
    template: "{common.first()} {common.prev()} " +
              "{common.pages()} " +
              "{common.next()} {common.last()}",
};

var buddy_list = {
    id: "table:buddy_list",
    view: "datatable",
    width: 1024,
    columns: [
        { id: "buddy_id", header: "ID", width: 160 },
        { id: "template_id", header: "武将ID", width: 70 },
        { id: "name", header: "名字", width: 150 },
        { id: "status", header: "状态", width: 160 },
        { id: "star", header: "星数", width: 160 },
        { id: "breakthrough", header: "突破等级", width: 160 },
        { id: "rouse", header: "觉醒等级", width: 160 },
    ],
    pager: "pager:buddy_list",
    autoheight: true,
};

var buddy_list_export = {
    view: "button",
    label: "导出Excel",
    type: "icon",
    icon: "save",
    width: 100,
    click: function() {
        var filename = "玩家武将列表";

        webix.toExcel("table:buddy_list", {
            name: filename,
        });
    },
};

var layout = {
    rows: [
        { cols: [
            {},
            get_buddy_list_form,
            {},
        ]},
        { cols: [
            {},
            { view: "label", css: "warnings", width: 600,
              label: "*警告* 本功能可能影响游戏服务器的性能, " +
                     "请勿在游戏高峰期频繁查询" },
            {},
        ]},
        buddy_list_export,
        buddy_list,
        buddy_list_pager,
    ],
};

$$("app:main_content").addView(layout);

});
</script>
