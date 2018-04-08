{{ partial('custom_ui/server_select') }}
<script type="text/javascript" charset="utf-8">
webix.ready(function () {

var event_handler = {
    onSubmitGetPlayerInfo: function() {
        var form = $$("form:player_info");
        if (form.validate() === false) {
            return;
        }

        webix.ajax().sync().get(
            "{{ url('player/get_brief_info') }}",
            form.getValues(),
            function (text, data) {
                var ret = data.json();
                if (!ret) {
                    return;
                }
                if (ret.brief_info) {
                    $$("property:player_info").setValues(ret.brief_info);
                    webix.alert("조회 성공");
                } else if (ret.error_code) {
                    webix.alert(
                        enjoymi.getErrorMessage(ret.error_code));
                }
            }
        );
    },
};

var player_info_form = {
    id: "form:player_info",
    view: "form",
    width: 600,
    elements: [
        { view: "custom_server_select", name: "server_id",
          label: "서버", required: true },
        { cols: [
            { view: "select", name: "player_key_type",
              width: 100, options: [
                { id: 1, value: "유저명" },
                { id: 2, value: "계정" },
                { id: 3, value: "유저ID" },
            ]},
            { view: "text", name: "player_key", required: true },
        ]},
        { view: "button", label: "조회", width: 100, align: "right",
          click: event_handler.onSubmitGetPlayerInfo },
    ],
};

var player_info_property = {
    id: "property:player_info",
    view: "property",
    autoheight: true,
    nameWidth: 200,
    elements: [
        { label: "유저ID", id: "player_id" },
        { label: "유저명", id: "nickname" },
        { label: "계정", id: "account" },
        { label: "레벨", id: "level" },
        { label: "VIP 레벨", id: "vip_level" },
        { label: "전투력", id: "fight_score" },
        { label: "등급포인트", id: "grade" },
        { label: "협력포인트", id: "team_high_score" },
        { label: "총 결제 금액", id: "total_pay_amount" },
        { label: "일반던전 진도", id: "level1_max_copy" },
        { label: "정예던전 진도", id: "level2_max_copy" },
        { label: "마지막 접속 시간", id: "last_logout_time" },
        { label: "캐릭터 생성 시간", id: "create_time" },
        { label: "계정 블락/해제 시간", id: "ban_until_time" },
    ],
};

var layout = {
    rows: [
        player_info_form,
        player_info_property,
    ],
};

$$("app:main_content").addView(layout);

});
</script>
