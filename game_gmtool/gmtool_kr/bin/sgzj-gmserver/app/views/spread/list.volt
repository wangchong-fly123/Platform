{{ partial('custom_ui/spread_select') }}
<script type="text/javascript" charset="utf-8">
webix.ready(function () {

var spread_list_url = "{{ url('spread/get_spread_list') }}";

var event_handler = {
    onSpreadListSelect: function() {
        $$("button:remove_spread").show();
    },

    onSpreadListUnselect: function() {
        $$("button:remove_spread").hide();
    },

    onAddSpread: function() {
        $$("form:add_spread").clear();
        $$("form:add_spread").clearValidation();
        $$("dialog:add_spread").show();
    },

    onSubmitAddSpread: function() {
        var form = $$("form:add_spread");
        if (form.validate() === false) {
            return;
        }
        var form_data = form.getValues();

        webix.ajax().sync().get(
            "{{ url('spread/add_spread') }}",
            form_data,
            function(text, data) {
                var ret = data.json();
                if (ret && ret.success) {
                    webix.alert("추가성공");
                    $$("table:spread_list").clearAll();
                    $$("table:spread_list").load(spread_list_url);
                    return;
                }
                webix.alert("추가실패! 프로모션이 존재하는지 확인하세요.");
            });
        $$("dialog:add_spread").hide();
    },

    onRemoveSpread: function() {
        var list = $$("table:spread_list");
        if (!list.getSelectedId()) {
            return;
        }

        webix.confirm({
            text: "해당 프로모션을 삭제하시겠습니까?",
            callback: function(result) {
                if (result) {
                    webix.ajax().sync().get(
                        "{{ url('spread/remove_spread') }}",
                        { url: list.getSelectedItem().url });
                    list.remove(list.getSelectedId());
                }
            }
        });
    },

};

var spread_list_pager = {
    id: "pager:spread_list",
    view: 'pager',
    template: "{common.first()} {common.prev()} " + 
              "{common.pages()} " +
              "{common.next()} {common.last()}",
};

var spread_list = {
    id: "table:spread_list",
    view: "datatable",
    columns: [
        { id: "url", header: "링크", width: 300 },
        { id: "desc", header: "프로모션 이름", width: 300 },
    ],
    pager: "pager:spread_list",
    autoheight: true,
    autowidth: true,
    select: "row",
    url: spread_list_url,
    on: {
        'onAfterSelect': event_handler.onSpreadListSelect,
        'onAfterUnselect': event_handler.onSpreadListUnselect,
    }
};

var add_spread_form = {
    id: "form:add_spread",
    view: "form",
    width: 480,
    elementsConfig: {
        labelPosition: "top",
        invalidMessage: "격식오류",
    },
    elements: [
        { view: "label", css: "warnings", width: 600,
          label: "Tips: 당일 추가한 링크는 익일부터 데이터를 통계합니다. 최대 10개 허용 가능!" },
        { view: "text", name: "url", label: "프로모션 링크(예:oo0sEl,gwZhw1)",
          required: true},
        { view: "text", name: "desc", label: "프로모션명" },
        { view: "button", label: "저장", width: 100, align: "right",
          required: true,
          click: event_handler.onSubmitAddSpread },
    ],
};

var add_spread_dialog = webix.ui({
    id: "dialog:add_spread",
    view: "window",
    position: "center",
    move: true,
    modal: true,
    head: {
        view: "toolbar",
        elements: [
            { view: "label", label: "프로모션 추가" },
            { view: "button", label: "X", align: "left", width: 50,
              click: function() { $$("dialog:add_spread").hide(); }
            },
        ],
    },
    body: add_spread_form,
});

var layout = {
    rows: [
        { cols: [
            { id: "button:add_spread",
              view: "button", label: "프로모션 추가", width: 100,
              click: event_handler.onAddSpread
            },
            { id: "button:remove_spread",
              view: "button", label: "프로모션 삭제", width: 100,
              hidden: true,
              click: event_handler.onRemoveSpread
            },
        ]},
        spread_list,
        spread_list_pager,
    ],
};

$$("app:main_content").addView(layout);

});
</script>
