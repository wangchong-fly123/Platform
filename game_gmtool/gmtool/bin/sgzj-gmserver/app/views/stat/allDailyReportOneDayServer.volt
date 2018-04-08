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
            "{{ url('stat/get_all_daily_report_one_day_server') }}",
            form.getValues(),
            function (text, data) {
                var ret = data.json();
                if (!ret) {
                    return;
                }
                if (ret.all_daily_report_list) {
                    $$("table:all_daily_report").clearAll();
                    $$("table:all_daily_report").parse(ret.all_daily_report_list);
                    webix.alert("查询成功");
                } else if (ret.error_code) { 
                    webix.alert(
                        enjoymi.getErrorMessage(ret.error_code));
                }
            }
        );
    },
};

var query_date = new Date();
query_date.setDate(query_date.getDate() - 1);

var get_all_daily_report_form = {
    id: "form:get_all_daily_report",
    view: "form",
    width: 600,
    elements: [
        { id: "datepicker:start_date",
          view: "custom_date_select", name: "query_date",
          label: "日期", required: true, value: query_date },
        { view: "button", label: "查询", width: 100, align: "right",
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
        { id: "server_name", header: "服务器", width: 300 },
        { id: "daily_new_users", header: "日新增用户数",
          sort: "int" },
        { id: "daily_active_old_users", header: "去新DAU",
          sort: "int" },
        { id: "daily_active_users", header: "DAU",
          sort: "int" },
        { id: "daily_revenue", header: "日充值金额",
          sort: "int" },
        { id: "daily_pay_times", header: "日充值次数",
          sort: "int" },
        { id: "daily_pay_users", header: "日充值用户数",
          width: 120, sort: "int" },
        { id: "new_pay_users", header: "新充值用户数",
          width: 120, sort: "int" },
        { id: "daily_pay_rate", header: "日付费率",
          sort: enjoymi.percentSortFunc("daily_pay_rate") },
        { id: "daily_new_user_revenue", header: "日新用户充值金额",
          width: 150, sort: "int" },
        { id: "daily_new_user_pay_times", header: "日新用户充值次数",
          width: 150, sort: "int" },
        { id: "daily_new_user_pay_users", header: "日新用户充值用户数",
          width: 160, sort: "int" },
        { id: "daily_new_user_pay_rate", header: "日新用户付费率", width: 130,
          sort: enjoymi.percentSortFunc("daily_new_user_pay_rate") },
        { id: "daily_avg_online_time", header: "日均使用时长(分钟)",
          width: 150, sort: "int" },
        { id: "daily_arpu", header: "ARPU",
          sort: "int" },
        { id: "daily_arppu", header: "ARPPU",
          sort: "int" },
        { id: "production", header: "日元宝产出",
          sort: "int" },
        { id: "consumption", header: "日元宝消耗",
          sort: "int" },
        { id: "new_user_login_times", header: "新用户登录次数",
          width: 130, sort: "int" },
        { id: "old_user_login_times", header: "老用户登录次数",
          width: 130, sort: "int" },
    ],
    pager: "pager:all_daily_report_list",
    autoheight: true,
};

var all_daily_report_list_export = {
    view: "button",
    label: "导出Excel",
    type: "icon",
    icon: "save",
    width: 100,
    click: function() {
        var filename = "日数据总表";

        var start_date = $$("datepicker:start_date").getValue();
        if (start_date) {
            filename += "_" + start_date;
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
              label: "*警告* 本功能可能影响游戏服务器的性能, " +
                     "请勿在游戏高峰期频繁查询, 跨大量天数查询" },
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
