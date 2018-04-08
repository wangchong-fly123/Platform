<script type="text/javascript" charset="utf-8">
webix.ready(function () {

var event_handler = {
    onSubmitGlobalSearch: function() {
        var form = $$("form:global_search");
        if (form.validate() === false) {
            return;
        }

        webix.ajax().sync().get(
            "{{ url('player/do_global_search') }}",
            form.getValues(),
            function (text, data) {
                var ret = data.json();
                if (!ret) {
                    return;
                }
                if (ret.search_result) {
                    $$("table:search_result_list").clearAll();
                    $$("table:search_result_list").parse(ret.search_result);
                    webix.alert("조회 성공");
                } else if (ret.error_code) { 
                    webix.alert(
                        enjoymi.getErrorMessage(ret.error_code));
                }
            }
        );
    },
};

var global_search_form = {
    id: "form:global_search",
    view: "form",
    width: 600,
    elements: [
        { cols: [
            { view: "select", name: "player_key_type",
              width: 100, options: [
                { id: 1, value: "유저명" },
                { id: 2, value: "계정" },
            ]},
            { view: "text", name: "player_key", required: true },
        ]},
        { view: "button", label: "조회", width: 100, align: "right",
          click: event_handler.onSubmitGlobalSearch },
    ],
};

var search_result_list_pager = {
    id: "pager:search_result_list",
    view: "pager",
    template: "{common.first()} {common.prev()} " +
              "{common.pages()} " +
              "{common.next()} {common.last()}",
};

var search_result_list = {
    id: "table:search_result_list",
    view: "datatable",
    width: 1024,
    columns: [
	{ id: "server_name", header: "서버", width: 200 },
        { id: "player_id", header: "유저ID", width: 180 },
        { id: "nickname", header: "유저명", width: 150 },
        { id: "account", header: "계정", width: 320 },
        { id: "level", header: "레벨" },
        { id: "vip_level", header: "VIP레벨" },
        { id: "total_pay_amount", header: "총 결제금액" },
        { id: "last_logout_time", header: "마지막 접속 시간", width: 150 },
        { id: "ban_until_time", header: "계정 블락/해제 시간", width: 150 },
        { id: "create_time", header: "캐릭터 생성 시간", width: 150 },
    ],
    pager: "pager:search_result_list",
    autoheight: true,
};

var layout = {
    rows: [
        { cols: [
            {},
            global_search_form,
            {},
        ]},
        { height: 10 },
        search_result_list,
        search_result_list_pager,
    ],
};

$$("app:main_content").addView(layout);

});
</script>
