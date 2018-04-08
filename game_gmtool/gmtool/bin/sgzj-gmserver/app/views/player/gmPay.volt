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
            text: "确认提交?",
            callback: function(result) {
                if (!result) {
                    return;
                }

                var params = form.getValues();
                params.amount = $$("combo:pay_id").getInputNode().value.match(
                    /(\d+)元/)[1];

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
                webix.alert("充值成功");
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

var gm_pay_form = {
    id: "form:gm_pay",
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
        { id: "combo:pay_id",
          view: "custom_pay_product_select", name: "pay_id",
          label: "充值商品", required: true },
        { view: "button", label: "提交", width: 100, align: "right",
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
              label: "*警告* 请谨慎使用该功能" },
            {},
        ]},
    ],
};

$$("app:main_content").addView(layout);

});
</script>
