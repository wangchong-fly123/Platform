{{ partial('custom_ui/date_select') }}
{{ partial('custom_ui/server_select') }}
<script type="text/javascript" charset="utf-8">
webix.ready(function () {

var event_handler = {
    onSubmitGetOnlinePlayer: function() {
        var form = $$("form:get_online_player");
        if (form.validate() === false) {
            return;
        }

        webix.ajax().sync().get(
            "{{ url('stat/get_online_player') }}",
            form.getValues(),
            function (text, data) {
                var ret = data.json();
                if (!ret) {
                    return;
                }
                if (ret.online_player) {
                    $$("chart:online_player").clearAll();
                    $$("chart:online_player").parse(ret.online_player);
                    webix.alert("查询成功");
                } else if (ret.error_code) {
                    webix.alert(
                        enjoymi.getErrorMessage(ret.error_code));
                }
            }
        );
    },
};

var get_online_player_form = {
    id: "form:get_online_player",
    view: "form",
    width: 600,
    elements: [
        { view: "custom_server_select", name: "server_id",
          label: "服务器", required: true },
        { view: "custom_date_select", name: "query_date",
          label: "查询日期", required: true },
        { view: "button", label: "查询", width: 100, align: "right",
          click: event_handler.onSubmitGetOnlinePlayer },
    ],
};

var online_player_chart = {
    id: "chart:online_player",
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
            get_online_player_form,
            {},
        ]},
        { height: 10 },
        online_player_chart,
    ],
};

$$("app:main_content").addView(layout);

});
</script>
