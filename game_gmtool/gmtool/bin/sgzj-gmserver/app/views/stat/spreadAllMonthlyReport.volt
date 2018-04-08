<script type="text/javascript" charset="utf-8">
webix.ready(function () {

var event_handler = {
    onSubmitGetSpreadMonthlyReport: function() {
        var form = $$("form:get_monthly_report");
        if (form.validate() === false) {
            return;
        }

        webix.ajax().sync().get(
            "{{ url('stat/get_spread_all_monthly_report') }}",
            form.getValues(),
            function (text, data) {
                var ret = data.json();
                if (!ret) {
                    return;
                }
                if (ret.spread_all_monthly_report_list) {
                    $$("table:monthly_report").clearAll();
                    $$("table:monthly_report").parse(ret.spread_all_monthly_report_list);
                    $$("table:monthly_report").getFilter("timestamp").value = "";
                    $$("table:monthly_report").getFilter("spread").value = "";
                    webix.alert("查询成功");
                } else if (ret.error_code) { 
                    webix.alert(
                        enjoymi.getErrorMessage(ret.error_code));
                }
            }
        );
    },
};

var get_monthly_report_form = {
    id: "form:get_monthly_report",
    view: "form",
    width: 600,
    elements: [
        { view: "button", label: "查询", width: 100, align: "right",
          click: event_handler.onSubmitGetSpreadMonthlyReport },
    ],
};

var monthly_report_list_pager = {
    id: "pager:monthly_report_list",
    view: "pager",
    template: "{common.first()} {common.prev()} " +
              "{common.pages()} " +
              "{common.next()} {common.last()}",
};

var monthly_report_list = {
    id: "table:monthly_report",
    view: "datatable",
    width: 1024,
    columns: [
        { id: "timestamp", header: ["日期", { content: "selectFilter" }],
          width: 100 },
        { id: "spread", header: ["推广", { content: "selectFilter" }],
          width: 200 },
        { id: "monthly_new_users", header: "月新增",
          sort: "int" },
        { id: "monthly_active_users", header: "MAU",
          sort: "int" },
        { id: "monthly_revenue", header: "月充值金额",
          sort: "int" },
        { id: "monthly_pay_times", header: "月充值次数",
          sort: "int" },
        { id: "monthly_pay_users", header: "月充值用户数",
          width: 120, sort: "int" },
        { id: "monthly_pay_rate", header: "月付费率",
          sort: enjoymi.percentSortFunc("monthly_pay_rate") },
        { id: "monthly_arpu", header: "ARPU",
          sort: "int" },
        { id: "monthly_arppu", header: "ARPPU",
          sort: "int" },
    ],
    pager: "pager:monthly_report_list",
    autoheight: true,
    autowidth: true,
};

var monthly_report_list_export = {
    view: "button",
    label: "导出Excel",
    type: "icon",
    icon: "save",
    width: 100,
    click: function() {
        var filename = "月数据报表(推广)";
        webix.toExcel("table:monthly_report", {
            name: filename,
        });
    },
};

var layout = {
    rows: [
        { cols: [
            {},
            get_monthly_report_form,
            {},
        ]},
        monthly_report_list_export,
        monthly_report_list,
        monthly_report_list_pager,
    ],
};

$$("app:main_content").addView(layout);

});
</script>
