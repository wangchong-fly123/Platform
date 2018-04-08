{{ partial('custom_ui/date_select') }}
<script type="text/javascript" charset="utf-8">
webix.ready(function () {

var event_handler = {
    onSubmitGetOnlinePlayer: function() {
        var form = $$("form:get_all_online_player");
        if (form.validate() === false) {
            return;
        }

        webix.ajax().sync().get(
            "{{ url('stat/get_all_online_player') }}",
            form.getValues(),
            function (text, data) {
                var ret = data.json();
                if (!ret) {
                    return;
                }
                if (ret.all_online_player) {
                    $$("chart:all_online_player").clearAll();
                    $$("chart:all_online_player").parse(ret.all_online_player);
                    webix.alert("查询成功");
                } else if (ret.error_code) {
                    webix.alert(
                        enjoymi.getErrorMessage(ret.error_code));
                }
            }
        );
    },
};

var get_all_online_player_form = {
    id: "form:get_all_online_player",
    view: "form",
    width: 600,
    elements: [
        { view: "custom_date_select", name: "query_date",
          label: "查询日期", required: true },
        { view: "button", label: "查询", width: 100, align: "right",
          click: event_handler.onSubmitGetOnlinePlayer },
    ],
};

var all_online_player_chart = {
    id: "chart:all_online_player",
    view: "chart",
    value: "#online_player#",
    type: "line",
    width: 800,
    height: 400,
    borderless: true,
    offset: false,
    xAxis: {
        title: "时间(小时)",
        lines: false,
        value: function(obj) {
            return obj.time;
        },
        template: function(obj) {
            return obj.$unit % 60 ? "" : obj.$unit / 60 + "";
        },
        units: {
            start: 0,
            end: 1440,
            next: function(m) {
                return m + 1;
            }
        },
    },
    yAxis: {
        title: "在线人数",
        start: 0,
    },
    item: {
        radius: 0,
    },
    tooltip: {
        template: "#online_player#",
    },
};

var layout = {
    rows: [
        { cols: [
            {},
            get_all_online_player_form,
            {},
        ]},
        { cols: [
            {},
            { view: "label", css: "warnings", width: 600,
              label: "*警告* 本功能可能影响游戏服务器的性能, " +
                     "请勿在游戏高峰期频繁查询" },
            {},
        ]},
        { height: 10 },
        all_online_player_chart,
    ],
};

$$("app:main_content").addView(layout);

});
</script>
