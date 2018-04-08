{{ partial('custom_ui/date_select') }}
{{ partial('custom_ui/server_select') }}
<script type="text/javascript" charset="utf-8">
webix.ready(function () {

var event_handler = {
    onSubmitGetLevelDistribution: function() {
        var form = $$("form:get_level_distribution");
        if (form.validate() === false) {
            return;
        }

        webix.ajax().sync().get(
            "{{ url('stat/get_level_distribution') }}",
            form.getValues(),
            function (text, data) {
                var ret = data.json();
                if (!ret) {
                    return;
                }
                if (ret.level_distribution) {
                    $$("table:level_distribution").clearAll();
                    $$("table:level_distribution").parse(ret.level_distribution);
                    webix.alert("查询成功");
                } else if (ret.error_code) { 
                    webix.alert(
                        enjoymi.getErrorMessage(ret.error_code));
                }
            }
        );
    },
};

var yesterday = new Date();
yesterday.setDate(yesterday.getDate() - 1);

var get_level_distribution_form = {
    id: "form:get_level_distribution",
    view: "form",
    width: 600,
    elementsConfig: {
        labelWidth: 120,
    },
    elements: [
        { view: "custom_server_select", name: "server_id",
          label: "服务器", required: true },
        { id: "datepicker:start_date",
          view: "custom_date_select", name: "start_date",
          label: "创角开始日期", required: true, value: yesterday },
        { id: "datepicker:end_date",
          view: "custom_date_select", name: "end_date",
          label: "创角结束日期", required: true, value: yesterday },
        { view: "button", label: "查询", width: 100, align: "right",
          click: event_handler.onSubmitGetLevelDistribution},
    ],
};

var level_distribution_list_pager = {
    id: "pager:level_distribution_list",
    view: "pager",
    template: "{common.first()} {common.prev()} " +
              "{common.pages()} " +
              "{common.next()} {common.last()}",
};

var level_distribution_list = {
    id: "table:level_distribution",
    view: "datatable",
    columns: [
        { id: "level", header: "等级", width: 200 },
        { id: "player_number", header: "当前段人数", width: 200 },
        { id: "player_number_percent", header: "当前段比例" },
        { id: "player_number_relative_percent", header: "相对滞留比例" },
    ],
    pager: "pager:level_distribution_list",
    autoheight: true,
    autowidth: true,
};

var level_distribution_list_export = {
    view: "button",
    label: "导出Excel",
    type: "icon",
    icon: "save",
    width: 100,
    click: function() {
        var filename = "等级分布";

        var start_date = $$("datepicker:start_date").getValue();
        if (start_date) {
            filename += "_" + start_date;
        }
        var end_date = $$("datepicker:end_date").getValue();
        if (end_date) {
            filename += "_" + end_date;
        }

        webix.toExcel("table:level_distribution", {
            name: filename,
        });
    },
};

var layout = {
    rows: [
        { cols: [
            {},
            get_level_distribution_form,
            {},
        ]},
        { cols: [
            {},
            { view: "label", css: "warnings", width: 600,
              label: "*警告* 本功能可能影响游戏服务器的性能, " +
                     "请勿在游戏高峰期频繁查询, 跨大量天数查询" },
            {},
        ]},
        level_distribution_list_export,
        level_distribution_list,
        level_distribution_list_pager,
    ],
};

$$("app:main_content").addView(layout);

});
</script>
