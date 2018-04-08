{{ partial('custom_ui/player_select') }}
{{ partial('custom_ui/server_select') }}
<script type="text/javascript" charset="utf-8">
webix.ready(function () {

var event_handler = {
    onSubmitGmRename: function() {
        var form = $$("form:gm_rename");
        if (form.validate() === false) {
            return;
        }

        webix.confirm({
            text: "确认提交?",
            callback: function(result) {
                if (!result) {
                    return;
                }

                var params = form.getValues();
                webix.ajax().sync().get(
                    "{{ url('player/do_gm_rename') }}",
                    params,
                    event_handler.onGmRenameResponse
                );
            }
        });
    },

    onGmRenameResponse: function(text, data) {
        do {
            var ret = data.json();
            if (!ret) {
                break;
            }

            if (ret.success) {
                webix.alert("玩家名修改完成");
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

var gm_rename_form = {
    id: "form:gm_rename",
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

        { view: "text", name: "name",
          label: "玩家名修改", required: true },

        { view: "button", label: "提交", width: 100, align: "right",
          click: event_handler.onSubmitGmRename },
    ],
};

var layout = {
    rows: [
        { cols: [
            {},
            gm_rename_form,
            {},
        ]},
        { cols: [
            {},
            { view: "label", css: "warnings", width: 610,
              label: "*警告* 请谨慎使用该功能" },
            {},
        ]},
    ],
};

$$("app:main_content").addView(layout);

});
</script>
