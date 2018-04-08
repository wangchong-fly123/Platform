{{ partial('custom_ui/date_select') }}
{{ partial('custom_ui/player_select') }}
{{ partial('custom_ui/server_select') }}
<script type="text/javascript" charset="utf-8">
webix.ready(function () {

var event_handler = {
    onSubmitGetOnlineList: function() {
        var form = $$("form:get_online_list");
        if (form.validate() === false) {
            return;
        }

        webix.ajax().sync().get(
            "{{ url('player/get_online_list') }}",
            form.getValues(),
            function (text, data) {
                var ret = data.json();
                if (!ret) {
                    return;
                }
                if (ret.online_list) {
                    $$("table:online_list").clearAll();
                    $$("table:online_list").parse(ret.online_list);
                    $$("table:online_list").sort("level", "desc", "int");
                    webix.alert("조회성공");
                } else if (ret.error_code) { 
                    webix.alert(
                        enjoymi.getErrorMessage(ret.error_code));
                }
            }
        );
    },
};

var get_online_list_form = {
    id: "form:get_online_list",
    view: "form",
    width: 600,
    elements: [
        { view: "custom_server_select", name: "server_id",
          label: "서버", required: true },
        { view: "button", label: "조회", width: 100, align: "right",
          click: event_handler.onSubmitGetOnlineList },
    ],
};

var online_list_pager = {
    id: "pager:online_list",
    view: "pager",
    template: "{common.first()} {common.prev()} " +
              "{common.pages()} " +
              "{common.next()} {common.last()}",
};

var online_list = {
    id: "table:online_list",
    view: "datatable",
    width: 1024,
    columns: [
        { id: "player_id", header: "유저ID", width: 160 },
        { id: "nickname", header: "캐릭터명", width: 160 },
        { id: "account", header: "계정", width: 400 },
        { id: "level", header: "레벨", width: 60, sort: "int" },
        { id: "total_pay_amount", header: "충전총금액", sort: "int" },
        { id: "diamond", header: "현재원보수량", sort: "int" },
        { id: "online_time", header: "총접속시간(분)",
          width: 150, sort: "int" },
        { id: "create_time", header: "캐릭터생성시간", width: 150 },
        { id: "net_type", header: "네트워크 유형" },
        { id: "device_model", header: "디바이스", width: 500 },
        { id: "device_os", header: "OS", width: 500 },
    ],
    pager: "pager:online_list",
    autoheight: true,
};

var online_list_export = {
    view: "button",
    label: "Excel에 저장",
    type: "icon",
    icon: "save",
    width: 100,
    click: function() {
        var filename = "온라인 플레이어 목록";

        webix.toExcel("table:online_list", {
            name: filename,
        });
    },
};

var layout = {
    rows: [
        { cols: [
            {},
            get_online_list_form,
            {},
        ]},
        { cols: [
            {},
            { view: "label", css: "warnings", width: 600,
              label: "*경고*해당 기능은 게임서버 성능에 영향을 줄 수 있습니다., " +
                     "게임접속율이 높을 때 조회를 빈번하게 하지 마세요" },
            {},
        ]},
        online_list_export,
        online_list,
        online_list_pager,
    ],
};

$$("app:main_content").addView(layout);

});
</script>
