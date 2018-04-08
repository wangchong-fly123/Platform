{{ partial('custom_ui/channel_select') }}
<script type="text/javascript" charset="utf-8">
webix.ready(function () {

var platform_list_url = "{{ url('platform/get_platform_list') }}";

var event_handler = {
    onPlatformListSelect: function() {
        $$("button:remove_platform").show();
    },

    onPlatformListUnselect: function() {
        $$("button:remove_platform").hide();
    },

    onAddPlatform: function() {
        $$("form:add_platform").clear();
        $$("form:add_platform").clearValidation();
        $$("dialog:add_platform").show();
    },

    onSubmitAddPlatform: function() {
        var form = $$("form:add_platform");
        if (form.validate() === false) {
            return;
        }
        var form_data = form.getValues();

        webix.ajax().sync().get(
            "{{ url('platform/add_platform') }}",
            form_data,
            function(text, data) {
                var ret = data.json();
                if (ret && ret.success) {
                    webix.alert("添加成功");
                    $$("table:platform_list").clearAll();
                    $$("table:platform_list").load(platform_list_url);
                    return;
                }
                webix.alert("添加失败, 请检查平台是否已存在");
            });
        $$("dialog:add_platform").hide();
    },

    onRemovePlatform: function() {
        var list = $$("table:platform_list");
        if (!list.getSelectedId()) {
            return;
        }

        webix.confirm({
            text: "确认删除该平台?",
            callback: function(result) {
                if (result) {
                    webix.ajax().sync().get(
                        "{{ url('platform/remove_platform') }}",
                        { id: list.getSelectedItem().id });
                    list.remove(list.getSelectedId());
                }
            }
        });
    },

};

var platform_list_pager = {
    id: "pager:platform_list",
    view: 'pager',
    template: "{common.first()} {common.prev()} " + 
              "{common.pages()} " +
              "{common.next()} {common.last()}",
};

var platform_list = {
    id: "table:platform_list",
    view: "datatable",
    columns: [
        { id: "id", header: "平台ID", width: 200 },
        { id: "desc",
          header: "平台名",
          width: 550 },
    ],
    pager: "pager:platform_list",
    autoheight: true,
    autowidth: true,
    select: "row",
    url: platform_list_url,
    on: {
        'onAfterSelect': event_handler.onPlatformListSelect,
        'onAfterUnselect': event_handler.onPlatformListUnselect,
    }
};

var add_platform_form = {
    id: "form:add_platform",
    view: "form",
    width: 400,
    elementsConfig: {
        labelPosition: "top",
        invalidMessage: "格式错误",
    },
    elements: [
        { view: "text", name: "id", label: "平台号(2位数字ID)",
          required: true },
        { view: "text", name: "desc", label: "平台名(平台描述)",
          required: true },
        { view: "button", label: "保存", width: 100, align: "right",
          required: true,
          click: event_handler.onSubmitAddPlatform },
    ],
};

var add_platform_dialog = webix.ui({
    id: "dialog:add_platform",
    view: "window",
    position: "center",
    move: true,
    modal: true,
    head: {
        view: "toolbar",
        elements: [
            { view: "label", label: "新增平台" },
            { view: "button", label: "X", align: "left", width: 50,
              click: function() { $$("dialog:add_platform").hide(); }
            },
        ],
    },
    body: add_platform_form,
});

var layout = {
    rows: [
        { cols: [
            { id: "button:add_platform",
              view: "button", label: "新增平台", width: 100,
              click: event_handler.onAddPlatform
            },
            { id: "button:remove_platform",
              view: "button", label: "删除平台", width: 100,
              hidden: true,
              click: event_handler.onRemovePlatform
            },
        ]},
        platform_list,
        platform_list_pager,
    ],
};

$$("app:main_content").addView(layout);

});
</script>
