{{ partial('custom_ui/player_select') }}
{{ partial('custom_ui/server_select') }}
<script type="text/javascript" charset="utf-8">
webix.ready(function () {

var event_handler = {
    onSubmitBanAccount: function() {
        var form = $$("form:ban_account");
        if (form.validate() === false) {
            return;
        }

        webix.confirm({
            text: "确认提交?",
            callback: function(result) {
                if (!result) {
                    return;
                }

                webix.ajax().sync().get(
                    "{{ url('player/ban_account') }}",
                    form.getValues(),
                    event_handler.onBanAccountResponse
                );
            }
        });
    },

    onBanAccountResponse: function(text, data) {
        do {
            var ret = data.json();
            if (!ret) {
                break;
            }
            if (ret.success) {
                if (ret.ban_until_time == 0) {
                    webix.alert("解封成功");
                } else {
                    webix.alert("封号成功, 该帐号将被封停直到" +
                        enjoymi.formatTimestamp(ret.ban_until_time));
                }
                return;
            } else if (ret.error_code) {
                webix.alert(
                    enjoymi.getErrorMessage(ret.error_code));
                return;
            }

        } while (false);

        webix.alert("提交失败");
    },
};

var ban_account_form = {
    id: "form:ban_account",
    view: "form",
    width: 600,
    elementsConfig: {
        labelPosition: "top",
    },
    elements: [
        { view: "custom_server_select", name: "server_id",
         label: "服务器", required: true, value: {{ cache_server_id }} },
        { view: "custom_player_select", name: "player_id",
          label: "玩家ID", required: true, value: "{{ cache_player_id }}" },
        { view: "text", name: "ban_hours",
          label: "封号时间(0-99999小时, 0表示解封, 封号时间从当前时间开始, 不累计)",
          required: true,
          validate: function(value) {
              return webix.rules.isNumber(value) &&
                     value >=0;
          },
          invalidMessage: "请输入合法的数值" },
        { view: "button", label: "提交", width: 100, align: "right",
          click: event_handler.onSubmitBanAccount },
    ],
};

var layout = {
    rows: [
        ban_account_form,
    ],
};

$$("app:main_content").addView(layout);

});
</script>
