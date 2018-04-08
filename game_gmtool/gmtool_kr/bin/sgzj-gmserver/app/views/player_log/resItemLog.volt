{{ partial('custom_ui/date_select') }}
{{ partial('custom_ui/player_select') }}
{{ partial('custom_ui/server_select') }}
<script type="text/javascript" charset="utf-8">
webix.ready(function () {

var event_handler = {
    onSubmitGetPlayerLog: function() {
        var form = $$("form:get_player_log");
        if (form.validate() === false) {
            return;
        }

        webix.ajax().sync().get(
            "{{ url('player_log/get_res_item_log') }}",
            form.getValues(),
            function (text, data) {
                var ret = data.json();
                if (!ret) {
                    return;
                }
                if (ret.log_list) {
                    $$("table:log_list").clearAll();
                    $$("table:log_list").parse(ret.log_list);
                    $$("table:log_list").getFilter("res_item_id").value = "";
                    $$("table:log_list").getFilter("res_item_name").value = "";
                    webix.alert("조회성공");
                } else if (ret.error_code) { 
                    webix.alert(
                        enjoymi.getErrorMessage(ret.error_code));
                }
            }
        );
    },
};

var get_player_log_form = {
    id: "form:get_player_log",
    view: "form",
    width: 600,
    elements: [
        { view: "custom_server_select", name: "server_id",
          label: "서버", required: true, value: {{ cache_server_id }} },
        { id: "text:player_id",
          view: "custom_player_select", name: "player_id",
          label: "유저ID", required: true, value: "{{ cache_player_id }}" },
        { id: "datepicker:query_date",
          view: "custom_date_select", name: "query_date",
          label: "조회날자", required: true },
        { view: "button", label: "조회", width: 100, align: "right",
          click: event_handler.onSubmitGetPlayerLog },
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
    columns: [
        { id: "log_type", header: "유형", width: 60 },
        { id: "timestamp", header: "시간", width: 160 },
        { id: "way", header: "途径", width: 200 },
        { id: "way_desc", header: "경로부가정보", width: 200 },
        { id: "res_item_id",
          header: ["자원아이템ID", { content: "selectFilter" }] },
        { id: "res_item_name",
          header: ["이름", { content: "selectFilter" }] },
        { id: "change_value", header: "변경값" },
        { id: "new_value", header: "신규값" },
    ],
    pager: "pager:log_list",
    autoheight: true,
    autowidth: true,
};

var log_list_export = {
    view: "button",
    label: "Excel에 저장",
    type: "icon",
    icon: "save",
    width:100,
    click: function() {
        var filename = "자원 아이템 로그";

        var player_id = $$("text:player_id").getValue();
        if (player_id) {
            filename += "_" + player_id;
        }
        var query_date = $$("datepicker:query_date").getValue();
        if (query_date) {
            filename += "_" + query_date;
        }

        webix.toExcel($$("table:log_list"), {
            name: filename,
        });
    },
};

var layout = {
    rows: [
        { cols: [
            {},
            get_player_log_form,
            {},
        ]},
        log_list_export,
        log_list,
        log_list_pager,
    ],
};

$$("app:main_content").addView(layout);

});
</script>
