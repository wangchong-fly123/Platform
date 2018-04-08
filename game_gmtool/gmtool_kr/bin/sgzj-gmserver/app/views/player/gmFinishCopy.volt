{{ partial('custom_ui/player_select') }}
{{ partial('custom_ui/server_select') }}
<script type="text/javascript" charset="utf-8">
webix.ready(function () {

var event_handler = {
    onSubmitGmFinishCopy: function() {
        var form = $$("form:gm_finish_copy");
        if (form.validate() === false) {
            return;
        }

        webix.confirm({
            text: "제출확인?",
            callback: function(result) {
                if (!result) {
                    return;
                }
                webix.ajax().sync().get(
                    "{{ url('player/do_gm_finish_copy') }}",
                    form.getValues(),
                    event_handler.onGmFinishCopyResponse
                );
            }
        });
    },

    onGmFinishCopyResponse: function(text, data) {
        do {
            var ret = data.json();
            if (!ret) {
                break;
            }

            if (ret.success) {
                webix.alert("변경성공");
                return;
            } else if (ret.error_code) {
                webix.alert(
                    enjoymi.getErrorMessage(ret.error_code));
                return;
            }

        } while (false);

        webix.alert("제출실패");
    },
};

var gm_finish_copy_form = {
    id: "form:gm_finish_copy",
    view: "form",
    width: 600,
    elementsConfig: {
        labelPosition: "top",
    },
    elements: [
        { view: "custom_server_select", name: "server_id",
         label: "서버", required: true, value: {{ cache_server_id }} },
        { view: "custom_player_select", name: "player_id",
          label: "유저ID", required: true, value: "{{ cache_player_id }}" },
        { view: "text", name: "copy_id",
          label: "던전ID", required: true,
          validate: function(value) {
              return webix.rules.isNumber(value) &&
                     value >=0;
          },
          invalidMessage: "정확한 수치를 입력하세요" },
        { view: "button", label: "제출", width: 100, align: "right",
          click: event_handler.onSubmitGmFinishCopy },
    ],
};

var layout = {
    rows: [
        { cols: [
            {},
            gm_finish_copy_form,
            {},
        ]},
        { cols: [
            {},
            { view: "label", css: "warnings", width: 610,
              label: "*경고* 해당 기능은 신중하게 사용하세요" },
            {},
        ]},
    ],
};

$$("app:main_content").addView(layout);

});
</script>
