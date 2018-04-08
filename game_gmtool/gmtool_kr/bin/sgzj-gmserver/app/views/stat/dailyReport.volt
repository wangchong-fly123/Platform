{{ partial('custom_ui/date_select') }}
{{ partial('custom_ui/server_select') }}
<script type="text/javascript" charset="utf-8">
webix.ready(function () {

var event_handler = {
    onSubmitGetDailyReport: function() {
        var form = $$("form:get_daily_report");
        if (form.validate() === false) {
            return;
        }

        webix.ajax().sync().get(
            "{{ url('stat/get_daily_report') }}",
            form.getValues(),
            function (text, data) {
                var ret = data.json();
                if (!ret) {
                    return;
                }
                if (ret.daily_report_list) {
                    $$("table:daily_report").clearAll();
                    $$("table:daily_report").parse(ret.daily_report_list);
                    $$("table:daily_report").getFilter("channel").value = "";
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

var get_daily_report_form = {
    id: "form:get_daily_report",
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
          click: event_handler.onSubmitGetDailyReport },
    ],
};

var daily_report_list_pager = {
    id: "pager:daily_report_list",
    view: "pager",
    template: "{common.first()} {common.prev()} " +
              "{common.pages()} " +
              "{common.next()} {common.last()}",
};

var daily_report_list = {
    id: "table:daily_report",
    view: "datatable",
    width: 1024,
    columns: [
        { id: "timestamp", header: "일자", width: 100 },
        { id: "channel", header: ["플랫폼", { content: "selectFilter" }],
          width: 200 },
        { id: "daily_new_users", header: "일신규유저수" },
        { id: "daily_active_old_users", header: "신규 제거 DAU" },
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
        { id: "max_online", header: "최고접속인원", width: 120 },
        { id: "daily_avg_online_time", header: "일평균 사용시간(분)", width: 150 },
        { id: "new_user_login_times", header: "신규유저 로그인 횟수", width: 130 },
        { id: "old_user_login_times", header: "기존유저 로그인 횟수", width: 130 },
        { id: "daily_one_session_users", header: "일1회채팅유저수", width: 150 },
    ],
    pager: "pager:daily_report_list",
    autoheight: true,
};

var daily_report_list_export = {
    view: "button",
    label: "Excel에 저장",
    type: "icon",
    icon: "save",
    width: 100,
    click: function() {
        var filename = "일데이터표";

        var start_date = $$("datepicker:start_date").getValue();
        if (start_date) {
            filename += "_" + start_date;
        }
        var end_date = $$("datepicker:end_date").getValue();
        if (end_date) {
            filename += "_" + end_date;
        }

        webix.toExcel("table:daily_report", {
            name: filename,
        });
    },
};

var layout = {
    rows: [
        { cols: [
            {},
            get_daily_report_form,
            {},
        ]},
        daily_report_list_export,
        daily_report_list,
        daily_report_list_pager,
    ],
};

$$("app:main_content").addView(layout);

});
</script>
