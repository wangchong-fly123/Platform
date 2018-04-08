{{ partial('custom_ui/server_select') }}
<script type="text/javascript" charset="utf-8">
webix.ready(function () {

var event_handler = {
    onSubmitGetSpreadMonthlyReport: function() {
        var form = $$("form:get_spread_monthly_report");
        if (form.validate() === false) {
            return;
        }

        webix.ajax().sync().get(
            "{{ url('stat/get_spread_monthly_report') }}",
            form.getValues(),
            function (text, data) {
                var ret = data.json();
                if (!ret) {
                    return;
                }
                if (ret.spread_monthly_report_list) {
                    $$("table:spread_monthly_report").clearAll();
                    $$("table:spread_monthly_report").parse(ret.spread_monthly_report_list);
                    $$("table:spread_monthly_report").getFilter("spread").value = "";
                    webix.alert("조회성공");
                } else if (ret.error_code) { 
                    webix.alert(
                        enjoymi.getErrorMessage(ret.error_code));
                }
            }
        );
    },
};

var get_spread_monthly_report_form = {
    id: "form:get_spread_monthly_report",
    view: "form",
    width: 600,
    elements: [
        { view: "custom_server_select", name: "server_id",
          label: "서버", required: true },
        { view: "button", label: "조회", width: 100, align: "right",
          click: event_handler.onSubmitGetSpreadMonthlyReport },
    ],
};

var spread_monthly_report_list_pager = {
    id: "pager:spread_monthly_report_list",
    view: "pager",
    template: "{common.first()} {common.prev()} " +
              "{common.pages()} " +
              "{common.next()} {common.last()}",
};

var spread_monthly_report_list = {
    id: "table:spread_monthly_report",
    view: "datatable",
    width: 1024,
    columns: [
        { id: "timestamp", header: "날자", width: 100 },
        { id: "spread", header: ["프로모션", { content: "selectFilter" }],
          width: 200 },
        { id: "spread_monthly_new_users", header: "월신규" },
        { id: "spread_monthly_active_users", header: "MAU" },
        { id: "spread_monthly_revenue", header: "월충전금액" },
        { id: "spread_monthly_pay_times", header: "월충전횟수" },
        { id: "spread_monthly_pay_users", header: "월충전유저수", width: 120 },
        { id: "spread_monthly_pay_rate", header: "월결제율" },
        { id: "spread_monthly_arpu", header: "ARPU" },
        { id: "spread_monthly_arppu", header: "ARPPU" },
    ],
    pager: "pager:spread_monthly_report_list",
    autoheight: true,
    autowidth: true,
};

var spread_monthly_report_list_export = {
    view: "button",
    label: "Excel에 저장",
    type: "icon",
    icon: "save",
    width: 100,
    click: function() {
        var filename = "월데이터표(프로모션)";
        webix.toExcel("table:spread_monthly_report", {
            name: filename,
        });
    },
};

var layout = {
    rows: [
        { cols: [
            {},
            get_spread_monthly_report_form,
            {},
        ]},
        spread_monthly_report_list_export,
        spread_monthly_report_list,
        spread_monthly_report_list_pager,
    ],
};

$$("app:main_content").addView(layout);

});
</script>
