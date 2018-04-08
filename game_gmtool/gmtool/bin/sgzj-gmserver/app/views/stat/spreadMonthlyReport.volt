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
                    webix.alert("查询成功");
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
          label: "服务器", required: true },
        { view: "button", label: "查询", width: 100, align: "right",
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
        { id: "timestamp", header: "日期", width: 100 },
        { id: "spread", header: ["推广", { content: "selectFilter" }],
          width: 200 },
        { id: "spread_monthly_new_users", header: "月新增" },
        { id: "spread_monthly_active_users", header: "MAU" },
        { id: "spread_monthly_revenue", header: "月充值金额" },
        { id: "spread_monthly_pay_times", header: "月充值次数" },
        { id: "spread_monthly_pay_users", header: "月充值用户数", width: 120 },
        { id: "spread_monthly_pay_rate", header: "月付费率" },
        { id: "spread_monthly_arpu", header: "ARPU" },
        { id: "spread_monthly_arppu", header: "ARPPU" },
    ],
    pager: "pager:spread_monthly_report_list",
    autoheight: true,
    autowidth: true,
};

var spread_monthly_report_list_export = {
    view: "button",
    label: "导出Excel",
    type: "icon",
    icon: "save",
    width: 100,
    click: function() {
        var filename = "月数据报表(推广)";
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
