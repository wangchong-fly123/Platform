{{ partial('custom_ui/date_select') }}
{{ partial('custom_ui/server_select') }}
<script type="text/javascript" charset="utf-8">
webix.ready(function () {

var event_handler = {
    onSubmitGetLevelDistribution: function() {
        var form = $$("form:get_level_distribution");
        if (form.validate() === false) {
            return;
        }

        webix.ajax().sync().get(
            "{{ url('stat/get_level_distribution') }}",
            form.getValues(),
            function (text, data) {
                var ret = data.json();
                if (!ret) {
                    return;
                }
                if (ret.level_distribution) {
                    $$("table:level_distribution").clearAll();
                    $$("table:level_distribution").parse(ret.level_distribution);
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

var get_level_distribution_form = {
    id: "form:get_level_distribution",
    view: "form",
    width: 600,
    elementsConfig: {
        labelWidth: 120,
    },
    elements: [
        { view: "custom_server_select", name: "server_id",
          label: "서버", required: true },
        { id: "datepicker:start_date",
          view: "custom_date_select", name: "start_date",
          label: "캐릭터생성 시작날자", required: true, value: yesterday },
        { id: "datepicker:end_date",
          view: "custom_date_select", name: "end_date",
          label: "캐릭터생성 종료날자", required: true, value: yesterday },
        { view: "button", label: "조회", width: 100, align: "right",
          click: event_handler.onSubmitGetLevelDistribution},
    ],
};

var level_distribution_list_pager = {
    id: "pager:level_distribution_list",
    view: "pager",
    template: "{common.first()} {common.prev()} " +
              "{common.pages()} " +
              "{common.next()} {common.last()}",
};

var level_distribution_list = {
    id: "table:level_distribution",
    view: "datatable",
    columns: [
        { id: "level", header: "레벨", width: 200 },
        { id: "player_number", header: "현단계인원수", width: 200 },
        { id: "player_number_percent", header: "현단계비율" },
        { id: "player_number_relative_percent", header: "상대 체류 비율" },
    ],
    pager: "pager:level_distribution_list",
    autoheight: true,
    autowidth: true,
};

var level_distribution_list_export = {
    view: "button",
    label: "Excel에 저장",
    type: "icon",
    icon: "save",
    width: 100,
    click: function() {
        var filename = "레벨분포";

        var start_date = $$("datepicker:start_date").getValue();
        if (start_date) {
            filename += "_" + start_date;
        }
        var end_date = $$("datepicker:end_date").getValue();
        if (end_date) {
            filename += "_" + end_date;
        }

        webix.toExcel("table:level_distribution", {
            name: filename,
        });
    },
};

var layout = {
    rows: [
        { cols: [
            {},
            get_level_distribution_form,
            {},
        ]},
        { cols: [
            {},
            { view: "label", css: "warnings", width: 600,
              label: "*경고*해당 기능은 게임서버 성능에 영향을 줄 수 있습니다, " +
                     "게임 피크타임에 빈번하게 조회하지 마시고 날자간격을 너무 길게 해서 조회하지 마세요." },
            {},
        ]},
        level_distribution_list_export,
        level_distribution_list,
        level_distribution_list_pager,
    ],
};

$$("app:main_content").addView(layout);

});
</script>
