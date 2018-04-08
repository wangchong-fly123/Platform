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
                    webix.alert("添加成功");
                    $$("table:spread_list").clearAll();
                    $$("table:spread_list").load(spread_list_url);
                    return;
                }
                webix.alert("添加失败, 请检查推广是否已存在");
            });
        $$("dialog:add_spread").hide();
    },

    onRemoveSpread: function() {
        var list = $$("table:spread_list");
        if (!list.getSelectedId()) {
            return;
        }

        webix.confirm({
            text: "确认删除该推广?",
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
        { id: "url", header: "短链", width: 300 },
        { id: "desc", header: "推广名字", width: 300 },
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
        invalidMessage: "格式错误",
    },
    elements: [
        { view: "label", css: "warnings", width: 600,
          label: "Tips: 当日添加的短链，次日起产生统计数据;最多允许十条短链" },
        { view: "text", name: "url", label: "推广短链(例如:oo0sEl,gwZhw1)",
          required: true},
        { view: "text", name: "desc", label: "推广名字" },
        { view: "button", label: "保存", width: 100, align: "right",
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
            { view: "label", label: "新增推广" },
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
              view: "button", label: "新增推广", width: 100,
              click: event_handler.onAddSpread
            },
            { id: "button:remove_spread",
              view: "button", label: "删除推广", width: 100,
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
