{{ partial('custom_ui/server_select') }}
<script type="text/javascript" charset="utf-8">
webix.ready(function () {

var event_handler = {
    onSubmitGetPlayerRankReport: function() {
        var form = $$("form:get_player_rank");
        if (form.validate() === false) {
            return;
        }

        webix.ajax().sync().get(
            "{{ url('player/get_player_rank') }}",
            form.getValues(),
            function (text, data) {
                var ret = data.json();
                if (!ret) {
                    return;
                }
                if (ret.rank_list) {
                    $$("table:player_rank").clearAll();
                    $$("table:player_rank").parse(ret.rank_list);
                    webix.alert("查询成功");
                } else if (ret.error_code) { 
                    webix.alert(
                        enjoymi.getErrorMessage(ret.error_code));
                }
            }
        );
    },
};

var get_player_rank_form = {
    id: "form:get_player_rank",
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
              { id: 3, value: "段位" },
              { id: 101, value: "充值总金额" },
          ],
        },
        { view: "button", label: "查询", width: 100, align: "right",
          click: event_handler.onSubmitGetPlayerRankReport },
    ],
};

var player_rank_list_pager = {
    id: "pager:player_rank_list",
    view: "pager",
    template: "{common.first()} {common.prev()} " +
              "{common.pages()} " +
              "{common.next()} {common.last()}",
};

var player_rank_list = {
    id: "table:player_rank",
    view: "datatable",
    width: 1024,
    columns: [
        { id: "player_id", header: "玩家ID",
          width: 160 },
        { id: "nickname", header: "玩家名",
          width: 160 },
        { id: "account", header: "帐号",
          width: 400 },
        { id: "level", header: "等级",
          sort: "int" },
        { id: "fight_score", header: "战斗力",
          sort: "int" },
        { id: "total_pay_amount", header: "充值总金额",
          sort: "int" },
        { id: "grade", header: "段位",
          sort: "int" },
        { id: "vip_level", header: "VIP等级",
          sort: "int" },
        { id: "level1_max_copy", header: "普通副本进度",
          width: 160, sort: "int" },
        { id: "level2_max_copy", header: "精英副本进度",
          width: 160, sort: "int" },
        { id: "last_logout_time", header: "上次下线时间",
          width: 160 },
        { id: "create_time", header: "创建角色时间",
          width: 160 },
        { id: "is_online", header: "是否在线" },
        { id: "diamond", header: "当前元宝数",
          sort: "int" },
        { id: "online_time", header: "总在线时间(分钟)",
          width: 150, sort: "int" },
        { id: "net_type", header: "网络类型" },
        { id: "device_model", header: "设备", width: 500 },
        { id: "device_os", header: "操作系统", width: 500 },
    ],
    pager: "pager:player_rank_list",
    autoheight: true,
};

var player_rank_list_export = {
    view: "button",
    label: "导出Excel",
    type: "icon",
    icon: "save",
    width: 100,
    click: function() {
        var filename = "等级排行榜";
        webix.toExcel("table:player_rank", {
            name: filename,
        });
    },
};

var layout = {
    rows: [
        { cols: [
            {},
            get_player_rank_form,
            {},
        ]},
        { cols: [
            {},
            { view: "label", css: "warnings", width: 600,
              label: "*警告* 本功能可能影响游戏服务器的性能, " +
                     "请勿在游戏高峰期频繁查询" },
            {},
        ]},
        player_rank_list_export,
        player_rank_list,
        player_rank_list_pager,
    ],
};

$$("app:main_content").addView(layout);

});
</script>
