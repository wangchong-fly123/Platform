{{ partial('custom_ui/server_select') }}
<script type="text/javascript" charset="utf-8">
webix.ready(function () {

var event_handler = {
    onSubmitGetGuildRankReport: function() {
        var form = $$("form:get_guild_rank");
        if (form.validate() === false) {
            return;
        }

        webix.ajax().sync().get(
            "{{ url('guild/get_guild_rank') }}",
            form.getValues(),
            function (text, data) {
                var ret = data.json();
                if (!ret) {
                    return;
                }
                if (ret.rank_list) {
                    $$("table:guild_rank").clearAll();
                    $$("table:guild_rank").parse(ret.rank_list);
                    webix.alert("查询成功");
                } else if (ret.error_code) { 
                    webix.alert(
                        enjoymi.getErrorMessage(ret.error_code));
                }
            }
        );
    },
};

var get_guild_rank_form = {
    id: "form:get_guild_rank",
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
        { view: "combo", name: "rank_type", label: "排行榜类型",
          required: true,
          options: [
              { id: 1, value: "等级" },
              { id: 2, value: "战斗力" },
          ],
        },
        { view: "button", label: "查询", width: 100, align: "right",
          click: event_handler.onSubmitGetGuildRankReport },
    ],
};

var guild_rank_list_pager = {
    id: "pager:guild_rank_list",
    view: "pager",
    template: "{common.first()} {common.prev()} " +
              "{common.pages()} " +
              "{common.next()} {common.last()}",
};

var guild_rank_list = {
    id: "table:guild_rank",
    view: "datatable",
    width: 1024,
    columns: [
        { id: "guild_id", header: "军团ID",
          width: 160 },
        { id: "nickname", header: "军团名",
          width: 160 },
        { id: "leader_name", header: "军团长",
          width: 160 },
        { id: "level", header: "等级",
          sort: "int" },
        { id: "exp", header: "经验",
          sort: "int" },
        { id: "fight_score", header: "战斗力",
          sort: "int" },
        { id: "member_count", header: "成员数",
          sort: "int" },
        { id: "gold", header: "军资",
          sort: "int" },
        { id: "create_time", header: "创建时间",
          width: 200 },
        { id: "leader_id", header: "军团长ID",
          width: 160 },
    ],
    pager: "pager:guild_rank_list",
    autoheight: true,
};

var guild_rank_list_export = {
    view: "button",
    label: "导出Excel",
    type: "icon",
    icon: "save",
    width: 100,
    click: function() {
        var filename = "等级排行榜";
        webix.toExcel("table:guild_rank", {
            name: filename,
        });
    },
};

var layout = {
    rows: [
        { cols: [
            {},
            get_guild_rank_form,
            {},
        ]},
        { cols: [
            {},
            { view: "label", css: "warnings", width: 600,
              label: "*警告* 本功能可能影响游戏服务器的性能, " +
                     "请勿在游戏高峰期频繁查询" },
            {},
        ]},
        guild_rank_list_export,
        guild_rank_list,
        guild_rank_list_pager,
    ],
};

$$("app:main_content").addView(layout);

});
</script>
