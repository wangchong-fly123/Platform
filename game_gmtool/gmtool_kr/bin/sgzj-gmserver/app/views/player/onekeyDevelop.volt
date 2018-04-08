{{ partial('custom_ui/server_select') }}
{{ partial('custom_ui/player_select') }}
<script type="text/javascript" charset="utf-8">
webix.ready(function () {

var event_handler = {
    onSubmitSendTimingNotice: function() {
        var form = $$("form:onekey_develop");
        if (form.validate() === false) {
            return;
        }

        webix.confirm({
            text: "전송확인?",
            callback: function(result) {
                if (!result) {
                    return;
                }

                var values = form.getValues();

                webix.ajax().sync().get(
                    "{{ url('player/do_onekey_develop') }}", values,
                    function (text, data) {
                        do {
                            var ret = data.json();
                            if (!ret) {
                                break;
                            }
                            if (ret.success) {
                                webix.alert("전송완료");
                                return;
                            } else if (ret.error_code) {
                                webix.alert(
                                    enjoymi.getErrorMessage(ret.error_code));
                                return;
                            }

                        } while (false);

                        webix.alert("전송실패");
                    }
                );
            }
        });
    },
};

var onekey_develop_form = {
    id: "form:onekey_develop",
    view: "form",
    width: 600,
    elementsConfig: {
        labelPosition: "top",
    },
    elements: [
        { view: "custom_server_select", name: "server_id",
          label: "서버", required: true },
        { view: "text", name: "develop_id",
          label: "육성ID", required: true, value: "1",
          validate: function(value) {
              return webix.rules.isNumber(value) && value >= 1;
          },
          invalidMessage: "정확한 수치를 입력하세요" },
        { view: "custom_player_select", name: "player_id",
          label: "유저ID", required: true, value: "{{ cache_player_id }}" },
        { view: "button", label: "전송", width: 100, align: "right",
          click: event_handler.onSubmitSendTimingNotice },
    ],
};

var layout = {
    rows: [
        { cols: [
            {},
            onekey_develop_form,
            {},
        ]},
        { cols: [
            {},
            { view: "label", css: "warnings", width: 680,
              label: "*경고* 해당 기능은 신중하게 사용하세요, " + 
                     "**전송완료**모든 서버에 전송 성공했다고 의미할 수 없습니다" +
                     "(예를 들면 닫긴 서버)" },
            {},
        ]},
    ],
};

$$("app:main_content").addView(layout);

});
</script>
