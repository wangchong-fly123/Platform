{{ partial('custom_ui/date_select') }}
{{ partial('custom_ui/server_select') }}
<script type="text/javascript" charset="utf-8">
webix.ready(function () {

var event_handler = {
    onSubmitGetSpreadDailyReport: function() {
        var form = $$("form:get_spread_daily_report");
        if (form.validate() === false) {
            return;
        }

        webix.ajax().sync().get(
            "{{ url('stat/get_spread_daily_report') }}",
            form.getValues(),
            function (text, data) {
                var ret = data.json();
                if (!ret) {
                    return;
                }
                if (ret.spread_daily_report_list) {
                    $$("table:spread_daily_report").clearAll();
                    $$("table:spread_daily_report").parse(ret.spread_daily_report_list);
                    $$("table:spread_daily_report").getFilter("spread").value = "";
                    webix.alert("조회성공");
                } else if (ret.error_code) { 
                    webix.alert(
                        enjoymi.getErrorMessage(ret.error_code));
                }
            }
        );
    },
};

var start_date = new Date();
start_date.setDate(start_date.getDate() - 5);
var end_date = new Date();
end_date.setDate(end_date.getDate() - 1);

var get_spread_daily_report_form = {
    id: "form:get_spread_daily_report",
    view: "form",
    width: 600,
    elements: [
        { view: "custom_server_select", name: "server_id",
          label: "서버", required: true },
        { id: "datepicker:start_date",
          view: "custom_date_select", name: "start_date",
          label: "시작날자", required: true, value: start_date },
        { id: "datepicker:end_date",
          view: "custom_date_select", name: "end_date",
          label: "종료날자", required: true, value: end_date },
        { view: "button", label: "조회", width: 100, align: "right",
          click: event_handler.onSubmitGetSpreadDailyReport },
    ],
};

var spread_daily_report_list_pager = {
    id: "pager:spread_daily_report_list",
    view: "pager",
    template: "{common.first()} {common.prev()} " +
              "{common.pages()} " +
              "{common.next()} {common.last()}",
};

var spread_daily_report_list = {
    id: "table:spread_daily_report",
    view: "datatable",
    width: 1024,
    columns: [
        { id: "timestamp", header: "일자", width: 100 },
        { id: "spread", header: ["프로모션", { content: "selectFilter" }],
          width: 200 },
        { id: "daily_new_users", header: "일신규유저수" },
        { id: "daily_active_old_users", header: "신규제거DAU" },
        { id: "daily_active_users", header: "DAU" },
        { id: "daily_revenue", header: "일충전금액" },
        { id: "daily_pay_times", header: "일충전횟수" },
        { id: "daily_pay_users", header: "일충전유저수", width: 120 },
        { id: "new_pay_users", header: "신규충전유저수", width: 120 },
        { id: "daily_pay_rate", header: "일결제율" },
        { id: "daily_new_user_revenue", header: "일신규유저충전금액", width: 150 },
        { id: "daily_new_user_pay_times", header: "일신규유저충전횟수", width: 150 },
        { id: "daily_new_user_pay_users", header: "일신규유저 충전 유저수", width: 160 },
        { id: "daily_new_user_pay_rate", header: "일신규유저 결제율", width: 130 },
        { id: "daily_arpu", header: "ARPU" },
        { id: "daily_arppu", header: "ARPPU" },
        { id: "day1_retention_ratio", header: "익일잔존율" },
        { id: "day2_retention_ratio", header: "3일잔존율" },
        { id: "day3_retention_ratio", header: "4일잔존율" },
        { id: "day4_retention_ratio", header: "5일잔존율" },
        { id: "day5_retention_ratio", header: "6일잔존율" },
        { id: "day6_retention_ratio", header: "7일잔존율" },
        { id: "day14_retention_ratio", header: "15일잔존율", width: 120 },
        { id: "day29_retention_ratio", header: "월잔존율" },
        { id: "daily_avg_online_time", header: "일평균 사용시간(분)", width: 150 },
    ],
    pager: "pager:spread_daily_report_list",
    autoheight: true,
};

var spread_daily_report_list_export = {
    view: "button",
    label: "Excel에 저장",
    type: "icon",
    icon: "save",
    width: 100,
    click: function() {
        var filename = "일데이터표(프로모션)";

        var start_date = $$("datepicker:start_date").getValue();
        if (start_date) {
            filename += "_" + start_date;
        }
        var end_date = $$("datepicker:end_date").getValue();
        if (end_date) {
            filename += "_" + end_date;
        }

        webix.toExcel("table:spread_daily_report", {
            name: filename,
        });
    },
};

var layout = {
    rows: [
        { cols: [
            {},
            get_spread_daily_report_form,
            {},
        ]},
        spread_daily_report_list_export,
        spread_daily_report_list,
        spread_daily_report_list_pager,
    ],
};

$$("app:main_content").addView(layout);

});
</script>
