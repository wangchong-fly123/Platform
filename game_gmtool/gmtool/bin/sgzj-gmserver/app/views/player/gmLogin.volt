{{ partial('custom_ui/player_select') }}
{{ partial('custom_ui/server_select') }}
<script type="text/javascript" charset="utf-8">
webix.ready(function () {

var event_handler = {
    onSubmitGmLogin: function() {
        var form = $$("form:gm_login");
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
                    "{{ url('player/do_gm_login') }}",
                    form.getValues(),
                    event_handler.onGmLoginResponse
                );
            }
        });
    },

    onGmLoginResponse: function(text, data) {
        do {
            var ret = data.json();
            if (!ret) {
                break;
            }
            if (ret.success) {
                webix.alert("操作完成");
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

var gm_login_form = {
    id: "form:gm_login",
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
        { view: "text", name: "login_switch",
          label: "GM登录开启/关闭(1/0 1:开启;0:关闭)",
          required: true,
          validate: function(value) {
              return webix.rules.isNumber(value) &&
                     value >=0;
          },
          invalidMessage: "请输入合法的数值" },
        { view: "button", label: "提交", width: 100, align: "right",
          click: event_handler.onSubmitGmLogin },
    ],
};

var layout = {
    rows: [
        gm_login_form,
    ],
};

$$("app:main_content").addView(layout);

});
</script>
