{{ partial('custom_ui/player_select') }}
{{ partial('custom_ui/server_select') }}
<script type="text/javascript" charset="utf-8">
webix.ready(function () {

var event_handler = {
    onSubmitGmConsumeDiamond: function() {
        var form = $$("form:gm_consume_diamond");
        if (form.validate() === false) {
            return;
        }

        webix.confirm({
            text: "제출확인?",
            callback: function(result) {
                if (!result) {
                    return;
                }

                var params = form.getValues();
                webix.ajax().sync().get(
                    "{{ url('player/do_gm_consume_diamond') }}",
                    params,
                    event_handler.onGmConsumeDiamondResponse
                );
            }
        });
    },

    onGmConsumeDiamondResponse: function(text, data) {
        do {
            var ret = data.json();
            if (!ret) {
                break;
            }

            if (ret.success) {
                webix.alert("원보차감성공");
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

var gm_consume_diamond_form = {
    id: "form:gm_consume_diamond",
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

        { view: "text", name: "amount",
          label: "원보차감수량", required: true,
          validate: function(value) {
              return webix.rules.isNumber(value) &&
                     value >=0;
          },
          invalidMessage: "정확한 수치를 입력하세요" },

        { view: "button", label: "제출", width: 100, align: "right",
          click: event_handler.onSubmitGmConsumeDiamond },
    ],
};

var layout = {
    rows: [
        { cols: [
            {},
            gm_consume_diamond_form,
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
