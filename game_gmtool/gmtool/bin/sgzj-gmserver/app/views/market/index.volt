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
                        webix.alert("查询成功");
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
            text: "确认删除该商品?",
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
            text: "确认删除所有商品?",
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
            webix.alert("商品ID重复");
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
            text: "确认保存当前商品列表?\n",
            callback: function(result) {
                if (result) {
                    webix.confirm({
                        text: "已进行过详细的配置检查?",
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
                    webix.alert("保存成功");
                    data_manager.loadMarketListData(true);
                    return;
                }
                webix.alert("保存失败");
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
          label: "服务器", required: true,
          on: {
              'onChange': event_handler.onServerSelectChange,
          },
        },
        { view: "button", label: "查询", width: 100, align: "right",
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
        { id: "tab_id", header: "页签ID" },
        { id: "tab_name", header: "页签名称" },
        { id: "id", header: "商品ID" },
        { id: "name", header: "商品名称", width: 200 },
        { id: "item_id", header: "道具ID" },
        { id: "item_count", header: "每组物品数量", width: 120 },
        { id: "count_max", header: "可购买次数", width: 120 },
        { id: "vip_change", header: "购买次数是否受VIP影响", width: 200 },
        { id: "money_type", header: "货币类型(1-金币;2-元宝)", width: 200 },
        { id: "price", header: "价格" },
        { id: "discount", header: "折扣" },
        { id: "refresh", header: "购买后是否会被刷新", width: 200 },
        { id: "start_time", header: "开始时间", width: 200 },
        { id: "end_time", header: "结束时间", width: 200 },
        { id: "min_level", header: "最小等级" },
        { id: "max_level", header: "最大等级" },
        { id: "vip_level", header: "VIP等级限制", width: 120 },
        { id: "section", header: "段位等级" },
        { id: "official", header: "官职等级" },
        { id: "recommend", header: "是否推荐" },
        { id: "hot", header: "是否热卖" },
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
        invalidMessage: "格式错误",
    },
    elements: [
        { cols: [
            { rows: [
                { view: "text", name: "tab_id",
                  label: "页签ID",
                  required: true, validate: enjoymi.validatePositiveNumber },
                { view: "text", name: "tab_name",
                  label: "页签名称",
                  required: true },
                { view: "text", name: "id",
                  label: "商品ID",
                  required: true, validate: enjoymi.validatePositiveNumber },
                { view: "text", name: "name",
                  label: "商品名称",
                  required: true },
                { view: "custom_item_select", name: "item_id",
                  label: "道具ID",
                  required: true },
                { view: "text", name: "item_count",
                  label: "每组物品数量",
                  required: true, validate: enjoymi.validatePositiveNumber },
                { view: "text", name: "count_max",
                  label: "可购买次数",
                  required: true, validate: webix.rules.isNumber },
                { view: "checkbox", name: "vip_change",
                  label: "购买次数是否受VIP影响",
                  required: true },
                { view: "combo", name: "money_type",
                  label: "货币类型",
                  required: true,
                  options: [
                      { id: 1, value: "1-金币" },
                      { id: 2, value: "2-元宝" },
                  ]},
                { view: "text", name: "price",
                  label: "价格",
                  required: true, validate: enjoymi.validatePositiveNumber },
                { view: "text", name: "discount",
                  label: "折扣",
                  required: true, validate: webix.rules.isNumber },
            ]},
            { rows: [
                { view: "checkbox", name: "refresh",
                  label: "购买后是否会被刷新",
                  required: true },
                { view: "datepicker", name: "start_time",
                  label: "开始时间",
                  format: "%Y:%m:%d-%H:%i:%s", timepicker: true },
                { view: "datepicker", name: "end_time",
                  label: "结束时间",
                  format: "%Y:%m:%d-%H:%i:%s", timepicker: true },
                { view: "text", name: "min_level",
                  label: "最小等级",
                  required: true, validate: webix.rules.isNumber },
                { view: "text", name: "max_level",
                  label: "最大等级",
                  required: true, validate: webix.rules.isNumber },
                { view: "text", name: "vip_level",
                  label: "VIP等级限制",
                  required: true, validate: webix.rules.isNumber },
                { view: "text", name: "section",
                  label: "段位等级",
                  required: true, validate: webix.rules.isNumber },
                { view: "text", name: "official",
                  label: "官职等级",
                  required: true, validate: webix.rules.isNumber },
                { view: "checkbox", name: "recommend",
                  label: "是否推荐",
                  required: true },
                { view: "checkbox", name: "hot",
                  label: "是否热卖",
                  required: true },
            ]},
        ]},
        { id: "button:submit_add_item",
          view: "button", label: "确定", width: 100, align: "right",
          required: true, hidden: true,
          click: event_handler.onSubmitAddItem },
        { id: "button:submit_edit_item",
          view: "button", label: "确定", width: 100, align: "right",
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
            { view: "label", label: "商品设置" },
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
              view: "button", label: "添加道具", width: 100,
              hidden: true,
              click: event_handler.onAddItem
            },
            { id: "button:remove_item",
              view: "button", label: "删除道具", width: 100,
              hidden: true,
              click: event_handler.onRemoveItem
            },
            { id: "button:remove_all_item",
              view: "button", label: "删除所有道具", width: 100,
              hidden: true,
              click: event_handler.onRemoveAllItem
            },
            { id: "button:edit_item",
              view: "button", label: "编辑道具", width: 100,
              hidden: true,
              click: event_handler.onEditItem
            },
            { id: "button:refresh_market_list",
              view: "button", label: "保存", width: 100,
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
