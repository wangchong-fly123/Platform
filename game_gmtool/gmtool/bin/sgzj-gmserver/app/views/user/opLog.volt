{{ partial('custom_ui/date_select') }}
{{ partial('custom_ui/user_select') }}
<script type="text/javascript" charset="utf-8">
webix.ready(function () {

var event_handler = {
    onSubmitGetOpLog: function() {
        var form = $$("form:get_op_log");
        if (form.validate() === false) {
            return;
        }

        webix.ajax().sync().get(
            "{{ url('user/get_op_log') }}",
            form.getValues(),
            function (text, data) {
                var ret = data.json();
                if (!ret) {
                    return;
                }
                if (ret.log_list) {
                    $$("table:log_list").clearAll();
                    $$("table:log_list").parse(ret.log_list);
                    $$("table:log_list").adjustRowHeight("log");
                    webix.alert("查询成功");
                } else if (ret.error_code) {
                    webix.alert(
                        enjoymi.getErrorMessage(ret.error_code));
                }
            }
        );
    },
};

var get_op_log_form = {
    id: "form:get_op_log",
    view: "form",
    width: 600,
    elements: [
        { view: "custom_date_select", name: "start_date",
          label: "起始日期", required: true },
        { view: "custom_date_select", name: "end_date",
          label: "结束日期", required: true },
        { view: "custom_user_select", name: "account",
          label: "用户" },
        { view: "button", label: "查询", width: 100, align: "right",
          click: event_handler.onSubmitGetOpLog },
    ],
};

var log_list_pager = {
    id: "pager:log_list",
    view: "pager",
    template: "{common.first()} {common.prev()} " +
              "{common.pages()} " +
              "{common.next()} {common.last()}",
};

var log_list = {
    id: "table:log_list",
    view: "datatable",
    width: 1024,
    columns: [
        { id: "timestamp", header: "时间", width: 160 },
        { id: "account", header: "用户", width: 100 },
        { id: "log", header: "日志信息", width: 2000 },
    ],
    pager: "pager:log_list",
    autoheight: true,
    fixedRowHeight: false,
    rowLineHeight: 25,
    rowHeight: 27,
    ready: function() {
        this.adjustRowHeight("log");
    }
};

var log_list_export = {
    view: "button",
    label: "导出Excel",
    type: "icon",
    icon: "save",
    width: 100,
    click: function() {
        var filename = "操作日志";
        webix.toExcel("table:log_list", {
            name: filename,
        });
    },
};

var layout = {
    rows: [
        { cols: [
            {},
            get_op_log_form,
            {},
        ]},
        { height: 10 },
        log_list_export,
        log_list,
        log_list_pager,
    ],
};

$$("app:main_content").addView(layout);

});
</script>
