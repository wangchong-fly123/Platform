{{ partial('custom_ui/date_select') }}
{{ partial('custom_ui/server_select') }}
<script type="text/javascript" charset="utf-8">
webix.ready(function () {

var event_handler = {
    onSubmitGetResourceChange: function() {
        var form = $$("form:get_resource_change");
        if (form.validate() === false) {
            return;
        }

        webix.ajax().sync().get(
            "{{ url('stat/get_resource_change') }}",
            form.getValues(),
            function (text, data) {
                var ret = data.json();
                if (!ret) {
                    return;
                }
                if (ret.resource_change_list) {
                    $$("table:resource_change").clearAll();
                    $$("table:resource_change").parse(ret.resource_change_list);
                    $$("table:resource_change").sort("production", "desc", "int");
                    webix.alert("조회성공");
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

var get_resource_change_form = {
    id: "form:get_resource_change",
    view: "form",
    width: 600,
    elements: [
        { view: "custom_server_select", name: "server_id",
          label: "서버", required: true },
        { id: "datepicker:query_date",
          view: "custom_date_select", name: "query_date",
          label: "조회날자", required: true, value: yesterday },
        { view: "combo", name: "resource_id", label: "자원유형",
          required: true,
          options: [
              { id: 7, value: "금화" },
              { id: 6, value: "원보" },
          ],
          value: 7,
        },
        { view: "button", label: "조회", width: 100, align: "right",
          click: event_handler.onSubmitGetResourceChange },
    ],
};

var resource_change_list_pager = {
    id: "pager:resource_change_list",
    view: "pager",
    template: "{common.first()} {common.prev()} " +
              "{common.pages()} " +
              "{common.next()} {common.last()}",
};

var resource_change_list = {
    id: "table:resource_change",
    view: "datatable",
    columns: [
        { id: "way_type", header: "경로", width: 300 },
        { id: "production", header: "획득", width: 200,
          sort: "int", css:{'text-align':'right'} },
        { id: "consumption", header: "소모", width: 200,
          sort: "int", css:{'text-align':'right'} },
        { id: "production_percent", header: "획득점유율" },
        { id: "consumption_percent", header: "소모점유율" },
    ],
    pager: "pager:resource_change_list",
    autowidth: true,
    autoheight: true,
};

var resource_change_list_export = {
    view: "button",
    label: "Excel에 저장",
    type: "icon",
    icon: "save",
    width: 100,
    click: function() {
        var filename = "자원획득소모";

        var query_date = $$("datepicker:query_date").getValue();
        if (query_date) {
            filename += "_" + query_date;
        }

        webix.toExcel("table:resource_change", {
            name: filename,
        });
    },
}

var layout = {
    rows: [
        { cols: [
            {},
            get_resource_change_form,
            {},
        ]},
        resource_change_list_export,
        resource_change_list,
        resource_change_list_pager,
    ],
};

$$("app:main_content").addView(layout);

});
</script>
