{{ partial('custom_ui/date_select') }}
{{ partial('custom_ui/player_select') }}
{{ partial('custom_ui/server_select') }}
<script type="text/javascript" charset="utf-8">
webix.ready(function () {

var event_handler = {
    onSubmitGetSoulList: function() {
        var form = $$("form:get_soul_list");
        if (form.validate() === false) {
            return;
        }

        webix.ajax().sync().get(
            "{{ url('player/get_soul_list') }}",
            form.getValues(),
            function (text, data) {
                var ret = data.json();
                if (!ret) {
                    return;
                }
                if (ret.soul_list) {
                    $$("table:soul_list").clearAll();
                    $$("table:soul_list").parse(ret.soul_list);
                    $$("table:soul_list").sort("level", "desc", "int");
                    webix.alert("조회성공");
                } else if (ret.error_code) { 
                    webix.alert(
                        enjoymi.getErrorMessage(ret.error_code));
                }
            }
        );
    },
};

var get_soul_list_form = {
    id: "form:get_soul_list",
    view: "form",
    width: 600,
    elements: [
        { view: "custom_server_select", name: "server_id",
          label: "서버", required: true },
        { id: "text:player_id",
          view: "text", name: "player_id",
          label: "유저ID", required: true },
        { view: "button", label: "조회", width: 100, align: "right",
          click: event_handler.onSubmitGetSoulList },
    ],
};

var soul_list_pager = {
    id: "pager:soul_list",
    view: "pager",
    template: "{common.first()} {common.prev()} " +
              "{common.pages()} " +
              "{common.next()} {common.last()}",
};

var soul_list = {
    id: "table:soul_list",
    view: "datatable",
    width: 1024,
    columns: [
        { id: "id", header: "ID", width: 160 },
        { id: "name", header: "이름", width: 110 },
        { id: "status", header: "상태", width: 60 },
        { id: "quality", header: "품질", width: 150 },
        { id: "level", header: "레벨", width: 160 },
        { id: "exp", header: "경험치", width: 160 },
    ],
    pager: "pager:soul_list",
    autoheight: true,
};

var soul_list_export = {
    view: "button",
    label: "Excel에 저장",
    type: "icon",
    icon: "save",
    width: 100,
    click: function() {
        var filename = "유전전혼리스트";

        webix.toExcel("table:soul_list", {
            name: filename,
        });
    },
};

var layout = {
    rows: [
        { cols: [
            {},
            get_soul_list_form,
            {},
        ]},
        { cols: [
            {},
            { view: "label", css: "warnings", width: 600,
              label: "*경고*해당 기능은 게임서버 성능에 영향을 줄 수 있습니다, " +
                     "게임접속율이 높을 때 조회를 빈번하게 하지 마세요." },
            {},
        ]},
        soul_list_export,
        soul_list,
        soul_list_pager,
    ],
};

$$("app:main_content").addView(layout);

});
</script>
