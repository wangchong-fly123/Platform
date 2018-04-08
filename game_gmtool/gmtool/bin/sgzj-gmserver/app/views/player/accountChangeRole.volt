{{ partial('custom_ui/player_select') }}
{{ partial('custom_ui/server_select') }}
{{ partial('custom_ui/channel_select') }}
<script type="text/javascript" charset="utf-8">
webix.ready(function () {

var event_handler = {
    onChangeRoleAccount: function() {
        var form = $$("form:change_role_account");
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
                    "{{ url('player/change_role_account') }}",
                    form.getValues(),
                    event_handler.onChangeRoleAccountResponse
                );
            }
        });
    },

    onChangeRoleAccountResponse: function(text, data) {
        do {
            var ret = data.json();
            console.log(ret);
            if (!ret) {
                break;
            }
            if (ret.success) {
                webix.alert("账号转移成功，请在【玩家基本信息查询】中查询玩家基本信息是否正确。");
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

var change_role_account_form = {
    id: "form:change_role_account",
    view: "form",
    width: 600,
    elementsConfig: {
        labelPosition: "top",
    },
    elements: [
        { view: "custom_server_select", name: "server_id",
         label: "服务器", required: true },
        { view: "text", name: "old_server_id",
         label: "玩家原区号", required: true },
        { view: "text", name: "old_uid",
         label: "旧uid", required: true },
        { view: "custom_channel_select", name: "src_channel",
         label: "原渠道号", required: true },
        { view: "text", name: "uid",
          label: "新uid", required: true },
        { view: "custom_channel_select", name: "dest_channel",
          label: "新渠道号", required: true },
        { view: "button", label: "提交", width: 100, align: "right",
          click: event_handler.onChangeRoleAccount },
    ],
};

var layout = {
    rows: [
        change_role_account_form,
    ],
};

$$("app:main_content").addView(layout);

});
</script>
