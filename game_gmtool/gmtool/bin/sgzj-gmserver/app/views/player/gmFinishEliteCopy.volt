{{ partial('custom_ui/player_select') }}
{{ partial('custom_ui/server_select') }}
<script type="text/javascript" charset="utf-8">
webix.ready(function () {

var event_handler = {
    onSubmitGmFinishEliteCopy: function() {
        var form = $$("form:gm_finish_elite_copy");
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
                    "{{ url('player/do_gm_finish_elite_copy') }}",
                    form.getValues(),
                    event_handler.onGmFinishEliteCopyResponse
                );
            }
        });
    },

    onGmFinishEliteCopyResponse: function(text, data) {
        do {
            var ret = data.json();
            if (!ret) {
                break;
            }

            if (ret.success) {
                webix.alert("修改成功");
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

var gm_finish_elite_copy_form = {
    id: "form:gm_finish_elite_copy",
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
        { view: "text", name: "copy_id",
          label: "副本ID", required: true,
          validate: function(value) {
              return webix.rules.isNumber(value) &&
                     value >=0;
          },
          invalidMessage: "请输入合法的数值" },
        { view: "button", label: "提交", width: 100, align: "right",
          click: event_handler.onSubmitGmFinishEliteCopy },
    ],
};

var layout = {
    rows: [
        { cols: [
            {},
            gm_finish_elite_copy_form,
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
