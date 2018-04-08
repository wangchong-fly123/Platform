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
            text: "제출 성공?",
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
                    webix.alert("해제 성공");
                } else {
                    webix.alert("블락 성공, 해당 계정은 정지됨" +
                        enjoymi.formatTimestamp(ret.ban_until_time));
                }
                return;
            } else if (ret.error_code) {
                webix.alert(
                    enjoymi.getErrorMessage(ret.error_code));
                return;
            }

        } while (false);

        webix.alert("제출 실패");
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
         label: "서버", required: true, value: {{ cache_server_id }} },
        { view: "custom_player_select", name: "player_id",
          label: "유저ID", required: true, value: "{{ cache_player_id }}" },
        { view: "text", name: "ban_hours",
          label: "블락시간(0-00000시간, 0은 해제, 블락 시간은 현재 시간부터 계산되며 누적되지 않음)",
          required: true,
          validate: function(value) {
              return webix.rules.isNumber(value) &&
                     value >=0;
          },
          invalidMessage: "합법적인 수치를 입력하세요" },
        { view: "button", label: "제출", width: 100, align: "right",
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
