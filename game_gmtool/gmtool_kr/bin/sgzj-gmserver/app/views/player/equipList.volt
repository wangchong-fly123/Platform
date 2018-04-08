{{ partial('custom_ui/date_select') }}
{{ partial('custom_ui/player_select') }}
{{ partial('custom_ui/server_select') }}
<script type="text/javascript" charset="utf-8">
webix.ready(function () {

var event_handler = {
    onSubmitGetEquipList: function() {
        var form = $$("form:get_equip_list");
        if (form.validate() === false) {
            return;
        }

        webix.ajax().sync().get(
            "{{ url('player/get_equip_list') }}",
            form.getValues(),
            function (text, data) {
                var ret = data.json();
                if (!ret) {
                    return;
                }
                if (ret.equip_list) {
                    $$("table:equip_list").clearAll();
                    $$("table:equip_list").parse(ret.equip_list);
                    $$("table:equip_list").sort("level", "desc", "int");
                    webix.alert("조회 성공");
                } else if (ret.error_code) { 
                    webix.alert(
                        enjoymi.getErrorMessage(ret.error_code));
                }
            }
        );
    },
};

var get_equip_list_form = {
    id: "form:get_equip_list",
    view: "form",
    width: 600,
    elements: [
        { view: "custom_server_select", name: "server_id",
          label: "서버", required: true },
        { id: "text:player_id",
          view: "text", name: "player_id",
          label: "유저ID", required: true },
        { view: "button", label: "조회", width: 100, align: "right",
          click: event_handler.onSubmitGetEquipList },
    ],
};

var equip_list_pager = {
    id: "pager:equip_list",
    view: "pager",
    template: "{common.first()} {common.prev()} " +
              "{common.pages()} " +
              "{common.next()} {common.last()}",
};

var equip_list = {
    id: "table:equip_list",
    view: "datatable",
    width: 1024,
    columns: [
        { id: "id", header: "ID", width: 60 },
        { id: "name", header: "이름", width: 160 },
        { id: "intensify_level", header: "강화레벨", width: 150 },
        { id: "stone", header: "보석", width: 260 },
        { id: "star", header: "별 수", width: 160 },
    ],
    pager: "pager:equip_list",
    autoheight: true,
};

var equip_list_export = {
    view: "button",
    label: "Excel로 출력",
    type: "icon",
    icon: "save",
    width: 100,
    click: function() {
        var filename = "유저 장비 리스트";

        webix.toExcel("table:equip_list", {
            name: filename,
        });
    },
};

var layout = {
    rows: [
        { cols: [
            {},
            get_equip_list_form,
            {},
        ]},
        { cols: [
            {},
            { view: "label", css: "warnings", width: 600,
              label: "*경고*본 기능은 게임서버 성능에 영향을 줄 수 있음, " +
                     "게임 피크타임에 빈번하게 조작하지 말 것" },
            {},
        ]},
        equip_list_export,
        equip_list,
        equip_list_pager,
    ],
};

$$("app:main_content").addView(layout);

});
</script>
