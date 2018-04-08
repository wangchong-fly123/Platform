<script type="text/javascript" charset="utf-8">
webix.ready(function () {

var event_handler = {
    onSubmitGetTmallWeeklyReport: function() {
        var form = $$("form:get_tmall_weekly_report");
        if (form.validate() === false) {
            return;
        }

        webix.ajax().sync().get(
            "{{ url('stat/get_all_tmall_weekly_report') }}",
            form.getValues(),
            function (text, data) {
                var ret = data.json();
                if (!ret) {
                    return;
                }
                if (ret.all_tmall_weekly_report_list) {
                    $$("table:tmall_weekly_report").clearAll();
                    $$("table:tmall_weekly_report").parse(ret.all_tmall_weekly_report_list);
                    $$("table:tmall_weekly_report").getFilter("timestamp").value = "";
                    $$("table:tmall_weekly_report").getFilter("channel").value = "";
                    webix.alert("查询成功");
                } else if (ret.error_code) { 
                    webix.alert(
                        enjoymi.getErrorMessage(ret.error_code));
                }
            }
        );
    },
};

var get_tmall_weekly_report_form = {
    id: "form:get_tmall_weekly_report",
    view: "form",
    width: 600,
    elements: [
        { view: "button", label: "查询", width: 100, align: "right",
          click: event_handler.onSubmitGetTmallWeeklyReport },
    ],
};

var tmall_weekly_report_list_pager = {
    id: "pager:tmall_weekly_report_list",
    view: "pager",
    template: "{common.first()} {common.prev()} " +
              "{common.pages()} " +
              "{common.next()} {common.last()}",
};

var tmall_weekly_report_list = {
    id: "table:tmall_weekly_report",
    view: "datatable",
    width: 1024,
    columns: [
        { id: "timestamp", header: ["日期", { content: "selectFilter" }],
          width: 100 },
        { id: "channel", header: ["渠道", { content: "selectFilter" }],
          width: 200 },
        { id: "weekly_revenue", header: "周充值金额",
          sort: "int" },
        { id: "weekly_pay_times", header: "周充值次数",
          sort: "int" },
        { id: "weekly_pay_users", header: "周充值用户数",
          width: 120, sort: "int" },
    ],
    pager: "pager:tmall_weekly_report_list",
    autoheight: true,
    autowidth: true,
};

var tmall_weekly_report_list_export = {
    view: "button",
    label: "导出Excel",
    type: "icon",
    icon: "save",
    width: 100,
    click: function() {
        var filename = "天猫周数据报表";
        webix.toExcel("table:tmall_weekly_report", {
            name: filename,
        });
    },
};

var layout = {
    rows: [
        { cols: [
            {},
            get_tmall_weekly_report_form,
            {},
        ]},
        tmall_weekly_report_list_export,
        tmall_weekly_report_list,
        tmall_weekly_report_list_pager,
    ],
};

$$("app:main_content").addView(layout);

});
</script>
