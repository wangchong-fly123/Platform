{{ partial('custom_ui/date_select') }}
{{ partial('custom_ui/player_select') }}
{{ partial('custom_ui/server_select') }}
<script type="text/javascript" charset="utf-8">
webix.ready(function () {

var event_handler = {
    onSubmitGetPayTmallTransaction: function() {
        var form = $$("form:get_pay_tmall_transaction");
        if (form.validate() === false) {
            return;
        }

        webix.ajax().sync().get(
            "{{ url('player/get_pay_tmall_transaction') }}",
            form.getValues(),
            function (text, data) {
                var ret = data.json();
                if (!ret) {
                    return;
                }
                if (ret.transaction_list) {
                    $$("table:transaction_list").clearAll();
                    $$("table:transaction_list").parse(ret.transaction_list);
                    webix.alert("조회성공");
                } else if (ret.error_code) { 
                    webix.alert(
                        enjoymi.getErrorMessage(ret.error_code));
                }
            }
        );
    },
};

var get_pay_tmall_transaction_form = {
    id: "form:get_pay_tmall_transaction",
    view: "form",
    width: 600,
    elements: [
        { view: "custom_server_select", name: "server_id",
          label: "서버", required: true },
        { id: "datepicker:start_date",
          view: "custom_date_select", name: "start_date",
          label: "시작날자" },
        { id: "datepicker:end_date",
          view: "custom_date_select", name: "end_date",
          label: "종료날자" },
        { id: "text:player_id",
          view: "text", name: "player_id", label: "유저ID" },
        { view: "text", name: "order_id", label: "주문ID" },
        { view: "button", label: "조회", width: 100, align: "right",
          click: event_handler.onSubmitGetPayTmallTransaction },
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
        { id: "order_id", header: "주문번호", width: 220 },
        { id: "player_id", header: "유저ID", width: 180 },
        { id: "transaction_time", header: "거래시간", width: 160 },
        { id: "amount", header: "충전금액" },
        { id: "product_id", header: "상품ID" },
        { id: "product_count", header: "상품수량" },
    ],
    pager: "pager:transaction_list",
    autoheight: true,
};

var transaction_list_export = {
    view: "button",
    label: "Excel에 저장",
    type: "icon",
    icon: "save",
    width: 100,
    click: function() {
        var filename = "충전주문";

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
            get_pay_tmall_transaction_form,
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
