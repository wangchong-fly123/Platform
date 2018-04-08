{{ partial('custom_ui/server_select') }}
<script type="text/javascript" charset="utf-8">
webix.ready(function () {

var event_handler = {
    onSubmitGetGuildMemberReport: function() {
        var form = $$("form:get_guild_member");
        if (form.validate() === false) {
            return;
        }

        webix.ajax().sync().get(
            "{{ url('guild/get_guild_member') }}",
            form.getValues(),
            function (text, data) {
                var ret = data.json();
                if (!ret) {
                    return;
                }
                if (ret.member_list) {
                    $$("table:guild_member").clearAll();
                    $$("table:guild_member").parse(ret.member_list);
                    webix.alert("查询成功");
                } else if (ret.error_code) { 
                    webix.alert(
                        enjoymi.getErrorMessage(ret.error_code));
                }
            }
        );
    },
};

var get_guild_member_form = {
    id: "form:get_guild_member",
    view: "form",
    view: "form",
    width: 600,
    labelWidth: 200,
    elementsConfig: {
        labelPosition: "top",
    },
    elements: [
        { view: "custom_server_select", name: "server_id",
          label: "服务器", required: true },
        { view: "text", name: "guild_name", label: "军团名",
          required: true,
        },
        { view: "button", label: "查询", width: 100, align: "right",
          click: event_handler.onSubmitGetGuildMemberReport },
    ],
};

var guild_member_list_pager = {
    id: "pager:guild_member_list",
    view: "pager",
    template: "{common.first()} {common.prev()} " +
              "{common.pages()} " +
              "{common.next()} {common.last()}",
};

var guild_member_list = {
    id: "table:guild_member",
    view: "datatable",
    width: 1024,
    columns: [
        { id: "name", header: "玩家",
          width: 160 },
        { id: "player_id", header: "ID",
          width: 160 },
        { id: "level", header: "等级",
          sort: "int" },
        { id: "fight_score", header: "战力",
          sort: "int" },
        { id: "today_exp", header: "当日经验",
          sort: "int" },
        { id: "all_exp", header: "总经验",
          sort: "int" },
        { id: "title", header: "职务",
          width: 100 },
        { id: "online", header: "活跃",
          width: 100 },
    ],
    pager: "pager:guild_member_list",
    autoheight: true,
};

var guild_member_list_export = {
    view: "button",
    label: "导出Excel",
    type: "icon",
    icon: "save",
    width: 100,
    click: function() {
        var filename = "军团成员";
        webix.toExcel("table:guild_member", {
            name: filename,
        });
    },
};

var layout = {
    rows: [
        { cols: [
            {},
            get_guild_member_form,
            {},
        ]},
        { cols: [
            {},
            { view: "label", css: "warnings", width: 600,
              label: "*警告* 本功能可能影响游戏服务器的性能, " +
                     "请勿在游戏高峰期频繁查询" },
            {},
        ]},
        guild_member_list_export,
        guild_member_list,
        guild_member_list_pager,
    ],
};

$$("app:main_content").addView(layout);

});
</script>
