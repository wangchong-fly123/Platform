{{ partial('custom_ui/pay_product_select') }}
{{ partial('custom_ui/player_select') }}
{{ partial('custom_ui/server_select') }}
<script type="text/javascript" charset="utf-8">
webix.ready(function () {

var event_handler = {
    onSubmitGmPay: function() {
        var form = $$("form:gm_pay");
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
                params.amount = $$("combo:pay_id").getInputNode().value.match(
                    /(\d+)K/)[1];

                webix.ajax().sync().get(
                    "{{ url('player/do_gm_pay') }}",
                    params,
                    event_handler.onGmPayResponse
                );
            }
        });
    },

    onGmPayResponse: function(text, data) {
        do {
            var ret = data.json();
            if (!ret) {
                break;
            }

            if (ret.success) {
                webix.alert("충전성공");
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

var gm_pay_form = {
    id: "form:gm_pay",
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
        { id: "combo:pay_id",
          view: "custom_pay_product_select", name: "pay_id",
          label: "충전상품", required: true },
        { view: "button", label: "제출", width: 100, align: "right",
          click: event_handler.onSubmitGmPay },
    ],
};

var layout = {
    rows: [
        { cols: [
            {},
            gm_pay_form,
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
