{{ partial('custom_ui/server_select') }}
<script type="text/javascript" charset="utf-8">
webix.ready(function () {

var event_handler = {
    onSubmitGetPlayerRankReport: function() {
        var form = $$("form:get_player_rank");
        if (form.validate() === false) {
            return;
        }

        webix.ajax().sync().get(
            "{{ url('player/get_player_rank') }}",
            form.getValues(),
            function (text, data) {
                var ret = data.json();
                if (!ret) {
                    return;
                }
                if (ret.rank_list) {
                    $$("table:player_rank").clearAll();
                    $$("table:player_rank").parse(ret.rank_list);
                    webix.alert("회성공");
                } else if (ret.error_code) { 
                    webix.alert(
                        enjoymi.getErrorMessage(ret.error_code));
                }
            }
        );
    },
};

var get_player_rank_form = {
    id: "form:get_player_rank",
    view: "form",
    view: "form",
    width: 600,
    labelWidth: 200,
    elementsConfig: {
        labelPosition: "top",
    },
    elements: [
        { view: "custom_server_select", name: "server_id",
          label: "서버", required: true },
        { view: "combo", name: "rank_type", label: "랭킹유형",
          required: true,
          options: [
              { id: 1, value: "레벨" },
              { id: 2, value: "전투력" },
              { id: 3, value: "등급" },
              { id: 101, value: "충전총금액" },
          ],
        },
        { view: "button", label: "조회", width: 100, align: "right",
          click: event_handler.onSubmitGetPlayerRankReport },
    ],
};

var player_rank_list_pager = {
    id: "pager:player_rank_list",
    view: "pager",
    template: "{common.first()} {common.prev()} " +
              "{common.pages()} " +
              "{common.next()} {common.last()}",
};

var player_rank_list = {
    id: "table:player_rank",
    view: "datatable",
    width: 1024,
    columns: [
        { id: "player_id", header: "유저ID",
          width: 160 },
        { id: "nickname", header: "유저명",
          width: 160 },
        { id: "account", header: "게정",
          width: 400 },
        { id: "level", header: "레벨",
          sort: "int" },
        { id: "fight_score", header: "전투력",
          sort: "int" },
        { id: "total_pay_amount", header: "전투총금액",
          sort: "int" },
        { id: "grade", header: "등급",
          sort: "int" },
        { id: "vip_level", header: "VIP레벨",
          sort: "int" },
        { id: "level1_max_copy", header: "일반던전진도",
          width: 160, sort: "int" },
        { id: "level2_max_copy", header: "정예던전진도",
          width: 160, sort: "int" },
        { id: "last_logout_time", header: "이전 오프라인 시간",
          width: 160 },
        { id: "create_time", header: "캐릭터 생성 시간",
          width: 160 },
        { id: "is_online", header: "온라인 여부" },
        { id: "diamond", header: "현재원보수량",
          sort: "int" },
        { id: "online_time", header: "총접속시간(분)",
          width: 150, sort: "int" },
        { id: "net_type", header: "네트워크 유형" },
        { id: "device_model", header: "디바이스", width: 500 },
        { id: "device_os", header: "OS", width: 500 },
    ],
    pager: "pager:player_rank_list",
    autoheight: true,
};

var player_rank_list_export = {
    view: "button",
    label: "Excel에 저장",
    type: "icon",
    icon: "save",
    width: 100,
    click: function() {
        var filename = "레벨 랭킹";
        webix.toExcel("table:player_rank", {
            name: filename,
        });
    },
};

var layout = {
    rows: [
        { cols: [
            {},
            get_player_rank_form,
            {},
        ]},
        { cols: [
            {},
            { view: "label", css: "warnings", width: 600,
              label: "*경고*해당 기능은 게임서버 성능에 영향을 줄 수 있습니다, " +
                     "게임접속율이 높을 때 조회를 빈번하게 하지 마세요" },
            {},
        ]},
        player_rank_list_export,
        player_rank_list,
        player_rank_list_pager,
    ],
};

$$("app:main_content").addView(layout);

});
</script>
