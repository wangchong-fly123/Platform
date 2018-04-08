{{ partial('custom_ui/item_select') }}
{{ partial('custom_ui/server_select') }}
<script type="text/javascript" charset="utf-8">
webix.ready(function () {

var data_manager = {
    resetAddItemFormData: function() {
        var form = $$("form:add_item");
        form.clear();
        form.clearValidation();
        form.setValues({
            item_count: 1,
            count_max: 1,
            money_type: 2,
            discount: "0",
            min_level: 1,
            max_level: 80,
            vip_level: "0",
            section: "0",
            official: "0",
        });
    },

    getAddItemFormData: function() {
        var form_data = $$("form:add_item").getValues();
        if (form_data.start_time) {
            form_data.start_time = enjoymi.formatDate(
                form_data.start_time);
        }
        if (form_data.end_time) {
            form_data.end_time = enjoymi.formatDate(
                form_data.end_time);
        }

        return form_data;
    },

    loadMarketListData: function(reload) {
        webix.ajax().sync().get(
            "{{ url('market/get_market_list') }}",
            $$("form:get_market_list").getValues(),
            function (text, data) {
                var ret = data.json();
                if (!ret) {
                    return;
                }
                if (ret.market_info) {
                    $$("table:market_list").clearAll();
                    $$("table:market_list").parse(ret.market_info);
                    $$("table:market_list").sort("#id#", "asc", "int");
                    $$("pager:market_list").show();
                    $$("button:add_item").show();
                    $$("button:remove_item").hide();
                    $$("button:remove_all_item").show();
                    $$("button:edit_item").hide();
                    $$("button:refresh_market_list").show();
                    if (!reload) {
                        webix.alert("조회 성공");
                    }
                } else if (ret.error_code) { 
                    webix.alert(
                        enjoymi.getErrorMessage(ret.error_code));
                }
            }
        );
    },
};

var event_handler = {
    onSubmitGetMarketList: function() {
        var form = $$("form:get_market_list");
        if (form.validate() === false) {
            return;
        }

        data_manager.loadMarketListData();
    },

    onMarketListSelect: function() {
        $$("button:remove_item").show();
        $$("button:edit_item").show();
    },

    onMarketListUnselect: function() {
        $$("button:remove_item").hide();
        $$("button:edit_item").hide();
    },

    onServerSelectChange: function() {
        $$("table:market_list").clearAll();
        $$("pager:market_list").hide();
        $$("button:add_item").hide();
        $$("button:remove_item").hide();
        $$("button:remove_all_item").hide();
        $$("button:edit_item").hide();
        $$("button:refresh_market_list").hide();
    },

    onAddItem: function() {
        data_manager.resetAddItemFormData();
        $$("button:submit_add_item").show();
        $$("button:submit_edit_item").hide();
        $$("dialog:add_item").show();
    },

    onRemoveItem: function() {
        var list = $$("table:market_list");
        if (!list.getSelectedId()) {
            return;
        }

        webix.confirm({
            text: "해당 상품 제거 확인?",
            callback: function(result) {
                if (result) {
                    list.remove(list.getSelectedId());
                }
            }
        });
    },

    onRemoveAllItem: function() {
        var list = $$("table:market_list");

        webix.confirm({
            text: "모든 상품 제거 확인?",
            callback: function(result) {
                if (result) {
                    list.clearAll();
                }
            }
        });
    },

    onEditItem: function() {
        var list = $$("table:market_list");
        if (!list.getSelectedId()) {
            return;
        }

        data_manager.resetAddItemFormData();
        $$("form:add_item").parse(list.getSelectedItem());

        $$("button:submit_add_item").hide();
        $$("button:submit_edit_item").show();
        $$("dialog:add_item").show();
    },

    onSubmitAddItem: function() {
        if ($$("form:add_item").validate() === false) {
            return;
        }
        var list = $$("table:market_list");
        var form_data = data_manager.getAddItemFormData();

        if (list.getItem(form_data.id)) {
            webix.alert("상품 ID 중복");
            return;
        }

        var row_id = list.add(form_data);
        list.addRowCss(row_id, "row_modify_mark");
        list.sort("#id#", "asc", "int");

        $$("dialog:add_item").hide();
    },

    onSubmitEditItem: function() {
        var list = $$("table:market_list");
        if (!list.getSelectedId()) {
            return;
        }

        if ($$("form:add_item").validate() === false) {
            return;
        }

        var form_data = data_manager.getAddItemFormData();
        list.remove(list.getSelectedId());
        var row_id = list.add(form_data);
        list.addRowCss(row_id, "row_modify_mark");
        list.sort("#id#", "asc", "int");

        $$("dialog:add_item").hide();
    },

    onSubmitRefreshMarketList: function() {
        webix.confirm({
            text: "현재 상품 리스트 저장 확인?\n",
            callback: function(result) {
                if (result) {
                    webix.confirm({
                        text: "상세 사양 검사 실시했음?",
                        callback: function(result) {
                            if (result) {
                                event_handler.onConfirmSubmitRefreshMarketList();
                            }
                        }
                    });
                }
            }
        });
    },

    onConfirmSubmitRefreshMarketList: function() {
        webix.ajax().sync().post(
            "{{ url('market/refresh_market_list') }}",
            { 
                server_id: $$("custom:server_select").getValue(),
                market_info: webix.ajax().stringify(
                    $$("table:market_list").serialize()),
            },
            function (text, data) {
                var ret = data.json();
                if (ret && ret.success) {
                    webix.alert("저장 성공");
                    data_manager.loadMarketListData(true);
                    return;
                }
                webix.alert("저장 실패");
            });
    },
};

var get_market_list_form = {
    id: "form:get_market_list",
    view: "form",
    width: 600,
    elements: [
        { id: "custom:server_select",
          view: "custom_server_select", name: "server_id",
          label: "서버", required: true,
          on: {
              'onChange': event_handler.onServerSelectChange,
          },
        },
        { view: "button", label: "조회 ", width: 100, align: "right",
          click: event_handler.onSubmitGetMarketList },
    ],
};

var market_list_pager = {
    id: "pager:market_list",
    view: "pager",
    template: "{common.first()} {common.prev()} " +
              "{common.pages()} " +
              "{common.next()} {common.last()}",
};

var market_list = {
    id: "table:market_list",
    view: "datatable",
    width: 1024,
    columnWidth: 90,
    columns: [
        { id: "tab_id", header: "탭ID" },
        { id: "tab_name", header: "탭 명칭" },
        { id: "id", header: "상품 ID" },
        { id: "name", header: "상품명칭", width: 200 },
        { id: "item_id", header: "아이템ID " },
        { id: "item_count", header: "각 세트 아이템 수량", width: 120 },
        { id: "count_max", header: "구매 가능 횟수", width: 120 },
        { id: "vip_change", header: "구매 횟수가 VIP 영향을 받는지 여부", width: 200 },
        { id: "money_type", header: "화폐 유형(1-금화; 2-원보)", width: 200 },
        { id: "price", header: "가격" },
        { id: "discount", header: "할인" },
        { id: "refresh", header: "구매 후 새로고침 되는지 여부", width: 200 },
        { id: "start_time", header: "시작시간", width: 200 },
        { id: "end_time", header: "종료시간", width: 200 },
        { id: "min_level", header: "최소레벨" },
        { id: "max_level", header: "최대레벨" },
        { id: "vip_level", header: "VIP레벨 제한", width: 120 },
        { id: "section", header: "등급레벨" },
        { id: "official", header: "관직레벨" },
        { id: "recommend", header: "추천여부" },
        { id: "hot", header: "인기판매여부" },
    ],
    pager: "pager:market_list",
    autoheight: true,
    select: "row",
    on: {
        'onAfterSelect': event_handler.onMarketListSelect,
        'onAfterUnselect': event_handler.onMarketListUnselect,
    },
};

var add_item_form = {
    id: "form:add_item",
    view: "form",
    width: 800,
    elementsConfig: {
        labelWidth: 200,
        invalidMessage: "양식오류",
    },
    elements: [
        { cols: [
            { rows: [
                { view: "text", name: "tab_id",
                  label: "탭ID",
                  required: true, validate: enjoymi.validatePositiveNumber },
                { view: "text", name: "tab_name",
                  label: "탭 명칭",
                  required: true },
                { view: "text", name: "id",
                  label: "상품ID",
                  required: true, validate: enjoymi.validatePositiveNumber },
                { view: "text", name: "name",
                  label: "상품명칭",
                  required: true },
                { view: "custom_item_select", name: "item_id",
                  label: "아이템ID",
                  required: true },
                { view: "text", name: "item_count",
                  label: "각 세트 아이템 수량",
                  required: true, validate: enjoymi.validatePositiveNumber },
                { view: "text", name: "count_max",
                  label: "구매 가능 횟수",
                  required: true, validate: webix.rules.isNumber },
                { view: "checkbox", name: "vip_change",
                  label: "구매 횟수가 VIP 영향을 받는지 여부",
                  required: true },
                { view: "combo", name: "money_type",
                  label: "화폐유형",
                  required: true,
                  options: [
                      { id: 1, value: "1-금화" },
                      { id: 2, value: "2-원보" },
                  ]},
                { view: "text", name: "price",
                  label: "가격",
                  required: true, validate: enjoymi.validatePositiveNumber },
                { view: "text", name: "discount",
                  label: "할인",
                  required: true, validate: webix.rules.isNumber },
            ]},
            { rows: [
                { view: "checkbox", name: "refresh",
                  label: "구매 후 새로고침 되는지 여부",
                  required: true },
                { view: "datepicker", name: "start_time",
                  label: "开시작시간",
                  format: "%Y:%m:%d-%H:%i:%s", timepicker: true },
                { view: "datepicker", name: "end_time",
                  label: "종료시간",
                  format: "%Y:%m:%d-%H:%i:%s", timepicker: true },
                { view: "text", name: "min_level",
                  label: "최소레벨",
                  required: true, validate: webix.rules.isNumber },
                { view: "text", name: "max_level",
                  label: "최대레벨",
                  required: true, validate: webix.rules.isNumber },
                { view: "text", name: "vip_level",
                  label: "VIP레벨 제한",
                  required: true, validate: webix.rules.isNumber },
                { view: "text", name: "section",
                  label: "등급레벨",
                  required: true, validate: webix.rules.isNumber },
                { view: "text", name: "official",
                  label: "관직레벨",
                  required: true, validate: webix.rules.isNumber },
                { view: "checkbox", name: "recommend",
                  label: "추천여부",
                  required: true },
                { view: "checkbox", name: "hot",
                  label: "인기판매여부",
                  required: true },
            ]},
        ]},
        { id: "button:submit_add_item",
          view: "button", label: "확정", width: 100, align: "right",
          required: true, hidden: true,
          click: event_handler.onSubmitAddItem },
        { id: "button:submit_edit_item",
          view: "button", label: "확정", width: 100, align: "right",
          required: true, hidden: true,
          click: event_handler.onSubmitEditItem },
    ],
};

var add_item_dialog = webix.ui({
    id: "dialog:add_item",
    view: "window",
    position: "center",
    move: true,
    modal: true,
    head: {
        view: "toolbar",
        elements: [
            { view: "label", label: "상품설정" },
            { view: "button", label: "X", align: "left", width: 50,
              click: function() { $$("dialog:add_item").hide(); }
            },
        ],
    },
    body: add_item_form,
});

var layout = {
    rows: [
        { cols: [
            {},
            get_market_list_form,
            {},
        ]},
        { height: 40,
          cols: [
            { id: "button:add_item",
              view: "button", label: "아이템 추가", width: 100,
              hidden: true,
              click: event_handler.onAddItem
            },
            { id: "button:remove_item",
              view: "button", label: "아이템 제거 ", width: 100,
              hidden: true,
              click: event_handler.onRemoveItem
            },
            { id: "button:remove_all_item",
              view: "button", label: "모든 아이템 제거", width: 100,
              hidden: true,
              click: event_handler.onRemoveAllItem
            },
            { id: "button:edit_item",
              view: "button", label: "아이템 편집", width: 100,
              hidden: true,
              click: event_handler.onEditItem
            },
            { id: "button:refresh_market_list",
              view: "button", label: "저장", width: 100,
              hidden: true,
              click: event_handler.onSubmitRefreshMarketList
            },
        ]},
        market_list,
        market_list_pager,
    ],
};

$$("app:main_content").addView(layout); 

});
</script>
