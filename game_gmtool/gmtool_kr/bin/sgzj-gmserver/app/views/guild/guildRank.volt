{{ partial('custom_ui/server_select') }}
<script type="text/javascript" charset="utf-8">
webix.ready(function () {

var event_handler = {
    onSubmitGetGuildRankReport: function() {
        var form = $$("form:get_guild_rank");
        if (form.validate() === false) {
            return;
        }

        webix.ajax().sync().get(
            "{{ url('guild/get_guild_rank') }}",
            form.getValues(),
            function (text, data) {
                var ret = data.json();
                if (!ret) {
                    return;
                }
                if (ret.rank_list) {
                    $$("table:guild_rank").clearAll();
                    $$("table:guild_rank").parse(ret.rank_list);
                    webix.alert("조회성공");
                } else if (ret.error_code) { 
                    webix.alert(
                        enjoymi.getErrorMessage(ret.error_code));
                }
            }
        );
    },
};

var get_guild_rank_form = {
    id: "form:get_guild_rank",
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
        { view: "combo", name: "rank_type", label: "랭킹 유형",
          required: true,
          options: [
              { id: 1, value: "레벨" },
              { id: 2, value: "전투력" },
          ],
        },
        { view: "button", label: "조회", width: 100, align: "right",
          click: event_handler.onSubmitGetGuildRankReport },
    ],
};

var guild_rank_list_pager = {
    id: "pager:guild_rank_list",
    view: "pager",
    template: "{common.first()} {common.prev()} " +
              "{common.pages()} " +
              "{common.next()} {common.last()}",
};

var guild_rank_list = {
    id: "table:guild_rank",
    view: "datatable",
    width: 1024,
    columns: [
        { id: "guild_id", header: "군단ID",
          width: 160 },
        { id: "nickname", header: "군단명",
          width: 160 },
        { id: "leader_name", header: "군단장",
          width: 160 },
        { id: "level", header: "레벨",
          sort: "int" },
        { id: "exp", header: "경험치",
          sort: "int" },
        { id: "fight_score", header: "전투력",
          sort: "int" },
        { id: "member_count", header: "인원",
          sort: "int" },
        { id: "gold", header: "군단물자",
          sort: "int" },
        { id: "create_time", header: "설립일자",
          width: 200 },
        { id: "leader_id", header: "군단장ID",
          width: 160 },
    ],
    pager: "pager:guild_rank_list",
    autoheight: true,
};

var guild_rank_list_export = {
    view: "button",
    label: "Excel출력",
    type: "icon",
    icon: "save",
    width: 100,
    click: function() {
        var filename = "레벨 랭킹";
        webix.toExcel("table:guild_rank", {
            name: filename,
        });
    },
};

var layout = {
    rows: [
        { cols: [
            {},
            get_guild_rank_form,
            {},
        ]},
        { cols: [
            {},
            { view: "label", css: "warnings", width: 600,
              label: "경고*본 기능은 게임서버 성능에 영향을 줄 수 있음, " +
                     "게임 피크타임에 빈번하게 조작하지 말 것" },
            {},
        ]},
        guild_rank_list_export,
        guild_rank_list,
        guild_rank_list_pager,
    ],
};

$$("app:main_content").addView(layout);

});
</script>
