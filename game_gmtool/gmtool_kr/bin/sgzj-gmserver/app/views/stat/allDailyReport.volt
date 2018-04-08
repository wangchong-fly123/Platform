{{ partial('custom_ui/channel_select') }}
{{ partial('custom_ui/date_select') }}
<script type="text/javascript" charset="utf-8">
webix.ready(function () {

var event_handler = {
    onSubmitGetDailyReport: function() {
        var form = $$("form:get_all_daily_report");
        if (form.validate() === false) {
            return;
        }

        webix.ajax().sync().get(
            "{{ url('stat/get_all_daily_report') }}",
            form.getValues(),
            function (text, data) {
                var ret = data.json();
                if (!ret) {
                    return;
                }
                if (ret.all_daily_report_list) {
                    $$("table:all_daily_report").clearAll();
                    $$("table:all_daily_report").parse(ret.all_daily_report_list);
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

var get_all_daily_report_form = {
    id: "form:get_all_daily_report",
    view: "form",
    width: 600,
    elements: [
        { id: "datepicker:start_date",
          view: "custom_date_select", name: "start_date",
          label: "시작날자", required: true, value: start_date },
        { id: "datepicker:end_date",
          view: "custom_date_select", name: "end_date",
          label: "종료날자", required: true, value: end_date },
        { view: "custom_channel_select", name: "channel",
          label: "플랫폼", required: true },
        { view: "button", label: "조회", width: 100, align: "right",
          click: event_handler.onSubmitGetDailyReport },
    ],
};

var all_daily_report_list_pager = {
    id: "pager:all_daily_report_list",
    view: "pager",
    template: "{common.first()} {common.prev()} " +
              "{common.pages()} " +
              "{common.next()} {common.last()}",
};

var all_daily_report_list = {
    id: "table:all_daily_report",
    view: "datatable",
    width: 1024,
    columns: [
        { id: "timestamp", header: "날자", width: 100 },
        { id: "daily_new_users", header: "일신규유저수" },
        { id: "daily_active_old_users", header: "신규 제거 DAU" },
        { id: "daily_active_users", header: "DAU" },
        { id: "daily_active_pay_users", header: "액티브 결제유저", width: 120 },
        { id: "daily_revenue", header: "일충전금액" },
        { id: "daily_pay_times", header: "일충전횟수" },
        { id: "daily_pay_users", header: "일충전유저수", width: 120 },
        { id: "new_pay_users", header: "신규충전유저수", width: 120 },
        { id: "daily_pay_rate", header: "일결제율" },
        { id: "daily_new_user_revenue", header: "일신규유저충전금액", width: 150 },
        { id: "daily_new_user_pay_times", header: "일신규유저충전횟수", width: 150 },
        { id: "daily_new_user_pay_users", header: "일신규유저 충전 유저수", width: 160 },
        { id: "daily_new_user_pay_rate", header: "일신규유저 결제율", width: 130 },
        { id: "daily_avg_online_time", header: "일평균 사용시간(분)", width: 150 },
        { id: "daily_arpu", header: "ARPU" },
        { id: "daily_arppu", header: "ARPPU" },
        { id: "day1_retention_ratio", header: "익일 잔존율" },
        { id: "day2_retention_ratio", header: "3일 잔존율" },
        { id: "day3_retention_ratio", header: "4일 잔존율" },
        { id: "day4_retention_ratio", header: "5일 잔존율" },
        { id: "day5_retention_ratio", header: "6일 잔존율" },
        { id: "day6_retention_ratio", header: "7일 잔존율" },
        { id: "day14_retention_ratio", header: "15일 잔존율", width: 120 },
        { id: "day29_retention_ratio", header: "월 잔존율" },
        { id: "new_user_login_times", header: "신규유저 로그인 횟수", width: 130 },
        { id: "old_user_login_times", header: "기존유저 로그인 횟수", width: 130 },
    ],
    pager: "pager:all_daily_report_list",
    autoheight: true,
};

var all_daily_report_list_export = {
    view: "button",
    label: "Excel에 저장",
    type: "icon",
    icon: "save",
    width: 100,
    click: function() {
        var filename = "일데이트표";

        var start_date = $$("datepicker:start_date").getValue();
        if (start_date) {
            filename += "_" + start_date;
        }
        var end_date = $$("datepicker:end_date").getValue();
        if (end_date) {
            filename += "_" + end_date;
        }

        webix.toExcel("table:all_daily_report", {
            name: filename,
        });
    },
};

var layout = {
    rows: [
        { cols: [
            {},
            get_all_daily_report_form,
            {},
        ]},
        { cols: [
            {},
            { view: "label", css: "warnings", width: 600,
              label: "*경고*해당 기능은 게임서버 성능에 영향을 줄 수 있습니다, " +
                     "게임 피크타임에 빈번하게 조회하지 마시고 날자간격을 너무 길게 해서 조회하지 마세요." },
            {},
        ]},
        all_daily_report_list_export,
        all_daily_report_list,
        all_daily_report_list_pager,
    ],
};

$$("app:main_content").addView(layout);

});
</script>
