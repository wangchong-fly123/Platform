{{ partial('custom_ui/server_select') }}
<script type="text/javascript" charset="utf-8">
webix.ready(function () {

var event_handler = {
    onSubmitGetWeeklyReport: function() {
        var form = $$("form:get_weekly_report");
        if (form.validate() === false) {
            return;
        }

        webix.ajax().sync().get(
            "{{ url('stat/get_weekly_report') }}",
            form.getValues(),
            function (text, data) {
                var ret = data.json();
                if (!ret) {
                    return;
                }
                if (ret.weekly_report_list) {
                    $$("table:weekly_report").clearAll();
                    $$("table:weekly_report").parse(ret.weekly_report_list);
                    $$("table:weekly_report").getFilter("channel").value = "";
                    webix.alert("조회성공");
                } else if (ret.error_code) { 
                    webix.alert(
                        enjoymi.getErrorMessage(ret.error_code));
                }
            }
        );
    },
};

var get_weekly_report_form = {
    id: "form:get_weekly_report",
    view: "form",
    width: 600,
    elements: [
        { view: "custom_server_select", name: "server_id",
          label: "서버", required: true },
        { view: "button", label: "조회", width: 100, align: "right",
          click: event_handler.onSubmitGetWeeklyReport },
    ],
};

var weekly_report_list_pager = {
    id: "pager:weekly_report_list",
    view: "pager",
    template: "{common.first()} {common.prev()} " +
              "{common.pages()} " +
              "{common.next()} {common.last()}",
};

var weekly_report_list = {
    id: "table:weekly_report",
    view: "datatable",
    width: 1024,
    columns: [
        { id: "timestamp", header: "날자", width: 180 },
        { id: "channel", header: ["랫폼", { content: "selectFilter" }],
          width: 200 },
        { id: "weekly_active_users", header: "WAU" },
        { id: "weekly_revenue", header: "주간충전금액" },
        { id: "weekly_pay_times", header: "주간충전횟수" },
        { id: "weekly_pay_users", header: "주간충전유저수", width: 120 },
        { id: "weekly_pay_rate", header: "주결제율" },
        { id: "weekly_arpu", header: "ARPU" },
        { id: "weekly_arppu", header: "ARPPU" },
    ],
    pager: "pager:weekly_report_list",
    autoheight: true,
    autowidth: true,
};

var weekly_report_list_export = {
    view: "button",
    label: "Excel에 저장",
    type: "icon",
    icon: "save",
    width: 100,
    click: function() {
        var filename = "주간데이터표";
        webix.toExcel("table:weekly_report", {
            name: filename,
        });
    },
};

var layout = {
    rows: [
        { cols: [
            {},
            get_weekly_report_form,
            {},
        ]},
        weekly_report_list_export,
        weekly_report_list,
        weekly_report_list_pager,
    ],
};

$$("app:main_content").addView(layout);

});
</script>
