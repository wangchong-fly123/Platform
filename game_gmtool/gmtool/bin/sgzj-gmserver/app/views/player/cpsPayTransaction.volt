{{ partial('custom_ui/date_select') }}
{{ partial('custom_ui/player_select') }}
{{ partial('custom_ui/server_select') }}
<script type="text/javascript" charset="utf-8">
webix.ready(function () {

var event_handler = {
    onSubmitGetCpsPayTransaction: function() {
        var form = $$("form:get_cps_pay_transaction");
        if (form.validate() === false) {
            return;
        }

        webix.ajax().sync().get(
            "{{ url('player/get_cps_pay_transaction') }}",
            form.getValues(),
            function (text, data) {
                var ret = data.json();
                if (!ret) {
                    return;
                }
                if (ret.transaction_list) {
                    $$("table:transaction_list").clearAll();
                    $$("table:transaction_list").parse(ret.transaction_list);
                    webix.alert("查询成功");
                } else if (ret.error_code) { 
                    webix.alert(
                        enjoymi.getErrorMessage(ret.error_code));
                }
            }
        );
    },
};

var get_cps_pay_transaction_form = {
    id: "form:get_cps_pay_transaction",
    view: "form",
    width: 600,
    elements: [
        { view: "custom_server_select", name: "server_id",
          label: "服务器", required: true },
        { id: "datepicker:start_date",
          view: "custom_date_select", name: "start_date",
          label: "开始日期" },
        { id: "datepicker:end_date",
          view: "custom_date_select", name: "end_date",
          label: "结束日期" },
        { id: "text:player_id",
          view: "text", name: "player_id", label: "玩家ID" },
        { view: "text", name: "order_id", label: "订单ID" },
        { view: "button", label: "查询", width: 100, align: "right",
          click: event_handler.onSubmitGetCpsPayTransaction },
    ],
};

var transaction_list_pager = {
    id: "pager:transaction_list",
    view: "pager",
    template: "{common.first()} {common.prev()} " +
              "{common.pages()} " +
              "{common.next()} {common.last()}",
};

var transaction_list = {
    id: "table:transaction_list",
    view: "datatable",
    width: 1024,
    columns: [
        { id: "order_id", header: "订单号", width: 220 },
        { id: "player_id", header: "玩家ID", width: 180 },
        { id: "user_id", header: "平台用户ID", width: 300 },
        { id: "transaction_time", header: "交易时间", width: 160 },
        { id: "amount", header: "充值金额" },
        { id: "product_id", header: "商品ID" },
        { id: "product_count", header: "商品数量" },
        { id: "product_name", header: "商品名" },
        { id: "pay_time", header: "支付时间", width: 160 },
        { id: "order_type", header: "支付类型" },
        { id: "channel_number", header: "渠道编号" },
        { id: "channel_order_id", header: "渠道订单号", width: 350 },
    ],
    pager: "pager:transaction_list",
    autoheight: true,
};

var transaction_list_export = {
    view: "button",
    label: "导出Excel",
    type: "icon",
    icon: "save",
    width: 100,
    click: function() {
        var filename = "充值订单";

        var player_id = $$("text:player_id").getValue();
        if (player_id) {
            filename += "_" + player_id;
        }
        var start_date = $$("datepicker:start_date").getValue();
        if (start_date) {
            filename += "_" + start_date;
        }
        var end_date = $$("datepicker:end_date").getValue();
        if (end_date) {
            filename += "_" + end_date;
        }

        webix.toExcel("table:transaction_list", {
            name: filename,
        });
    },
};

var layout = {
    rows: [
        { cols: [
            {},
            get_cps_pay_transaction_form,
            {},
        ]},
        transaction_list_export,
        transaction_list,
        transaction_list_pager,
    ],
};

$$("app:main_content").addView(layout);

});
</script>
