{{ partial('custom_ui/server_select') }}
<script type="text/javascript" charset="utf-8">
webix.ready(function () {

var event_handler = {
    onSubmitGetPlayerInfo: function() {
        var form = $$("form:player_info");
        if (form.validate() === false) {
            return;
        }

        webix.ajax().sync().get(
            "{{ url('player/get_brief_info') }}",
            form.getValues(),
            function (text, data) {
                var ret = data.json();
                if (!ret) {
                    return;
                }
                if (ret.brief_info) {
                    $$("property:player_info").setValues(ret.brief_info);
                    webix.alert("查询成功");
                } else if (ret.error_code) {
                    webix.alert(
                        enjoymi.getErrorMessage(ret.error_code));
                }
            }
        );
    },
};

var player_info_form = {
    id: "form:player_info",
    view: "form",
    width: 600,
    elements: [
        { view: "custom_server_select", name: "server_id",
          label: "服务器", required: true },
        { cols: [
            { view: "select", name: "player_key_type",
              width: 100, options: [
                { id: 1, value: "玩家名" },
                { id: 2, value: "帐号" },
                { id: 3, value: "玩家ID" },
            ]},
            { view: "text", name: "player_key", required: true },
        ]},
        { view: "button", label: "查询", width: 100, align: "right",
          click: event_handler.onSubmitGetPlayerInfo },
    ],
};

var player_info_property = {
    id: "property:player_info",
    view: "property",
    autoheight: true,
    nameWidth: 200,
    elements: [
        { label: "玩家ID", id: "player_id" },
        { label: "玩家名", id: "nickname" },
        { label: "帐号", id: "account" },
        { label: "等级", id: "level" },
        { label: "VIP等级", id: "vip_level" },
        { label: "战斗力", id: "fight_score" },
        { label: "段位积分", id: "grade" },
        { label: "合作积分", id: "team_high_score" },
        { label: "充值总金额", id: "total_pay_amount" },
        { label: "普通副本进度", id: "level1_max_copy" },
        { label: "精英副本进度", id: "level2_max_copy" },
        { label: "上次下线时间", id: "last_logout_time" },
        { label: "创建角色时间", id: "create_time" },
        { label: "封号解封时间", id: "ban_until_time" },
        { label: "角色禁言时间", id: "silence_until_time" },
    ],
};

var layout = {
    rows: [
        player_info_form,
        player_info_property,
    ],
};

$$("app:main_content").addView(layout);

});
</script>
