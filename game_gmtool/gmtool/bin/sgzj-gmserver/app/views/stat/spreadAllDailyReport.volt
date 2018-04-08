{{ partial('custom_ui/spread_select') }}
{{ partial('custom_ui/date_select') }}
<script type="text/javascript" charset="utf-8">
webix.ready(function () {

var event_handler = {
    onSubmitGetSpreadDailyReport: function() {
        var form = $$("form:get_spread_all_daily_report");
        if (form.validate() === false) {
            return;
        }

        webix.ajax().sync().get(
            "{{ url('stat/get_spread_all_daily_report') }}",
            form.getValues(),
            function (text, data) {
                var ret = data.json();
                if (!ret) {
                    return;
                }
                if (ret.spread_all_daily_report_list) {
                    $$("table:spread_all_daily_report").clearAll();
                    $$("table:spread_all_daily_report").parse(ret.spread_all_daily_report_list);
                    webix.alert("查询成功");
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

var get_spread_all_daily_report_form = {
    id: "form:get_spread_all_daily_report",
    view: "form",
    width: 600,
    elements: [
        { id: "datepicker:start_date",
          view: "custom_date_select", name: "start_date",
          label: "开始日期", required: true, value: start_date },
        { id: "datepicker:end_date",
          view: "custom_date_select", name: "end_date",
          label: "结束日期", required: true, value: end_date },
        { view: "custom_spread_select", name: "spread",
          label: "推广", required: true },
        { view: "button", label: "查询", width: 100, align: "right",
          click: event_handler.onSubmitGetSpreadDailyReport },
    ],
};

var spread_all_daily_report_list_pager = {
    id: "pager:spread_all_daily_report_list",
    view: "pager",
    template: "{common.first()} {common.prev()} " +
              "{common.pages()} " +
              "{common.next()} {common.last()}",
};

var spread_all_daily_report_list = {
    id: "table:spread_all_daily_report",
    view: "datatable",
    width: 1024,
    columns: [
        { id: "timestamp", header: "日期", width: 100 },
        { id: "daily_new_users", header: "日新增用户数" },
        { id: "daily_active_old_users", header: "去新DAU" },
        { id: "daily_active_users", header: "DAU" },
        { id: "daily_active_pay_users", header: "活跃付费用户", width: 120 },
        { id: "daily_revenue", header: "日充值金额" },
        { id: "daily_pay_times", header: "日充值次数" },
        { id: "daily_pay_users", header: "日充值用户数", width: 120 },
        { id: "new_pay_users", header: "新充值用户数", width: 120 },
        { id: "daily_pay_rate", header: "日付费率" },
        { id: "daily_new_user_revenue", header: "日新用户充值金额", width: 150 },
        { id: "daily_new_user_pay_times", header: "日新用户充值次数", width: 150 },
        { id: "daily_new_user_pay_users", header: "日新用户充值用户数", width: 160 },
        { id: "daily_new_user_pay_rate", header: "日新用户付费率", width: 130 },
        { id: "daily_avg_online_time", header: "日均使用时长(分钟)", width: 150 },
        { id: "daily_arpu", header: "ARPU" },
        { id: "daily_arppu", header: "ARPPU" },
        { id: "day1_retention_ratio", header: "次日留存率" },
        { id: "day2_retention_ratio", header: "三日留存率" },
        { id: "day3_retention_ratio", header: "四日留存率" },
        { id: "day4_retention_ratio", header: "五日留存率" },
        { id: "day5_retention_ratio", header: "六日留存率" },
        { id: "day6_retention_ratio", header: "七日留存率" },
        { id: "day14_retention_ratio", header: "十五日留存率", width: 120 },
        { id: "day29_retention_ratio", header: "月留存率" },
    ],
    pager: "pager:spread_all_daily_report_list",
    autoheight: true,
};

var spread_all_daily_report_list_export = {
    view: "button",
    label: "导出Excel",
    type: "icon",
    icon: "save",
    width: 100,
    click: function() {
        var filename = "日数据总表(推广)";

        var start_date = $$("datepicker:start_date").getValue();
        if (start_date) {
            filename += "_" + start_date;
        }
        var end_date = $$("datepicker:end_date").getValue();
        if (end_date) {
            filename += "_" + end_date;
        }

        webix.toExcel("table:spread_all_daily_report", {
            name: filename,
        });
    },
};

var layout = {
    rows: [
        { cols: [
            {},
            get_spread_all_daily_report_form,
            {},
        ]},
        { cols: [
            {},
            { view: "label", css: "warnings", width: 600,
              label: "*警告* 本功能可能影响游戏服务器的性能, " +
                     "请勿在游戏高峰期频繁查询, 跨大量天数查询" },
            {},
        ]},
        spread_all_daily_report_list_export,
        spread_all_daily_report_list,
        spread_all_daily_report_list_pager,
    ],
};

$$("app:main_content").addView(layout);

});
</script>
