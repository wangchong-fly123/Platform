{{ partial('custom_ui/server_select') }}
<script type="text/javascript" charset="utf-8">
webix.ready(function () {

var data_manager = {
    loadServerBriefInfoData: function(reload) {
        webix.ajax().sync().get(
            "{{ url('server/get_brief_info') }}",
            $$("form:server_info").getValues(),
            function (text, data) {
                var ret = data.json();
                if (!ret) {
                    return;
                }
                if (ret.brief_info) {
                    $$("property:server_info").setValues(ret.brief_info);

                    $$("button:login_switch").define("label",
                        ret.brief_info.forbid_login == 1 ?
                        "允许登陆" : "禁止登录");
                    $$("button:login_switch").refresh();

{% if display_func_list %}
                    $$("fieldset:func_button").show();
{% endif %}
                    if (!reload) {
                        webix.alert("查询成功");
                    }
                } else if (ret.error_code) {
                    webix.alert(
                        enjoymi.getErrorMessage(ret.error_code));
                }
            }
        );
    },
};

var event_handler = {
    onServerSelectChange: function() {
        $$("fieldset:func_button").hide();
        $$("property:server_info").setValues({});
    },

    onSubmitGetServerInfo: function() {
        var form = $$("form:server_info");
        if (form.validate() === false) {
            return;
        }

        data_manager.loadServerBriefInfoData();
    },

    onLoginSwitch: function() {
        webix.confirm({
            text: "确认变更该服务器登录设置?",
            callback: function(result) {
                if (!result) {
                    return;
                }
                webix.ajax().sync().get(
                    "{{ url('server/login_switch') }}",
                    {
                        server_id: $$("custom:server_select").getValue(),
                        forbid_login: !$$("property:server_info").getItem(
                            "forbid_login").value | 0,
                    },
                    function (text, data) {
                        var ret = data.json();
                        if (!ret) {
                            return;
                        }
                        if (ret.success) {
                            webix.alert("变更成功");
                            data_manager.loadServerBriefInfoData(true);
                        } else if (ret.error_code) {
                            webix.alert(
                                enjoymi.getErrorMessage(ret.error_code));
                        }
                    }
                );
            }
        });
    },
};

var server_info_form = {
    id: "form:server_info",
    view: "form",
    width: 600,
    elements: [
        { id: "custom:server_select",
          view: "custom_server_select", name: "server_id",
          label: "服务器", required: true,
          on: {
              'onChange': event_handler.onServerSelectChange,
          },
        },
        { view: "button", label: "查询", width: 100, align: "right",
          click: event_handler.onSubmitGetServerInfo },
    ],
};

var func_button_fieldset = {
    id: "fieldset:func_button",
    view: "fieldset",
    hidden: true,
    body: { cols: [
        { id: "button:login_switch",
          view: "button", width: 100,
          click: event_handler.onLoginSwitch },
    ]},
};

var server_info_property = {
    id: "property:server_info",
    view: "property",
    autoheight: true,
    nameWidth: 200,
    elements: [
        { label: "平台ID", id: "platform_id" },
        { label: "服务器ID", id: "server_id" },
        { label: "在线玩家人数", id: "online_player_number" },
        { label: "总玩家人数", id: "total_player_number" },
        { label: "24小时离线玩家人数", id: "today_offline_player_number" },
        { label: "48小时离线玩家人数", id: "yesterday_offline_player_number" },
        { label: "今日新增玩家人数", id: "day_new_player_number" },
        { label: "是否关闭登录", id: "forbid_login" },
    ],
};

var layout = {
    rows: [
        server_info_form,
        server_info_property,
        func_button_fieldset,
    ],
};

$$("app:main_content").addView(layout);

});
</script>
