{{ partial('custom_ui/date_select') }}
{{ partial('custom_ui/server_select') }}
<script type="text/javascript" charset="utf-8">
webix.ready(function () {

var event_handler = {
    onSubmitGetHourlyReport: function() {
        var form = $$("form:get_hourly_report");
        if (form.validate() === false) {
            return;
        }

        webix.ajax().sync().get(
            "{{ url('stat/get_hourly_report') }}",
            form.getValues(),
            function (text, data) {
                var ret = data.json();
                if (!ret) {
                    return;
                }
                if (ret.hourly_report_list) {
                    $$("table:hourly_report").clearAll();
                    $$("table:hourly_report").parse(ret.hourly_report_list);
                    $$("table:hourly_report").getFilter("channel").value = "";
                    webix.alert("查询成功");
                } else if (ret.error_code) { 
                    webix.alert(
                        enjoymi.getErrorMessage(ret.error_code));
                }
            }
        );
    },
};

var get_hourly_report_form = {
    id: "form:get_hourly_report",
    view: "form",
    width: 600,
    elements: [
        { view: "custom_server_select", name: "server_id",
          label: "服务器", required: true },
        { id: "datepicker:query_date",
          view: "custom_date_select", name: "query_date",
          label: "查询日期", required: true },
        { view: "button", label: "查询", width: 100, align: "right",
          click: event_handler.onSubmitGetHourlyReport },
    ],
};

var hourly_report_list_pager = {
    id: "pager:hourly_report_list",
    view: "pager",
    template: "{common.first()} {common.prev()} " +
              "{common.pages()} " +
              "{common.next()} {common.last()}",
};

var hourly_report_list = {
    id: "table:hourly_report",
    view: "datatable",
    columns: [
        { id: "timestamp", header: "时间", width: 300 },
        { id: "channel", header: ["渠道", { content: "selectFilter" }],
          width: 200 },
        { id: "new_users", header: "创角数", width: 200 },
        { id: "revenue", header: "充值金额" },
        { id: "pay_times", header: "充值次数" },
        { id: "pay_users", header: "充值用户数", width: 100 },
        { id: "max_online", header: "最高在线人数", width: 200 },
    ],
    pager: "pager:hourly_report_list",
    autowidth: true,
    autoheight: true,
};

var hourly_report_list_export = {
    view: "button",
    label: "导出Excel",
    type: "icon",
    icon: "save",
    width: 100,
    click: function() {
        var filename = "小时数据报表";

        var query_date = $$("datepicker:query_date").getValue();
        if (query_date) {
            filename += "_" + query_date;
        }

        webix.toExcel("table:hourly_report", {
            name: filename,
        });
    },
};

var layout = {
    rows: [
        { cols: [
            {},
            get_hourly_report_form,
            {},
        ]},
        hourly_report_list_export,
        hourly_report_list,
        hourly_report_list_pager,
    ],
};

$$("app:main_content").addView(layout);

});
</script>
