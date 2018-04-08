{{ partial('custom_ui/platform_select') }}
<script type="text/javascript" charset="utf-8">
webix.ready(function () {

var channel_list_url = "{{ url('channel/get_channel_list') }}";

var event_handler = {
    onChannelListSelect: function() {
        $$("button:remove_channel").show();
        $$("button:disable_channel").show();
        $$("button:enable_channel").show();
    },

    onChannelListUnselect: function() {
        $$("button:remove_channel").hide();
        $$("button:disable_channel").hide();
        $$("button:enable_channel").hide();
    },

    onAddChannel: function() {
        $$("form:add_channel").clear();
        $$("form:add_channel").clearValidation();
        $$("dialog:add_channel").show();
    },

    onSubmitAddChannel: function() {
        var form = $$("form:add_channel");
        if (form.validate() === false) {
            return;
        }
        var form_data = form.getValues();

        webix.ajax().sync().get(
            "{{ url('channel/add_channel') }}",
            form_data,
            function(text, data) {
                var ret = data.json();
                if (ret && ret.success) {
                    webix.alert("添加成功");
                    $$("table:channel_list").clearAll();
                    $$("table:channel_list").load(channel_list_url);
                    return;
                }
                webix.alert("添加失败, 请检查渠道是否已存在");
            });
        $$("dialog:add_channel").hide();
    },

    onRemoveChannel: function() {
        var list = $$("table:channel_list");
        if (!list.getSelectedId()) {
            return;
        }

        webix.confirm({
            text: "确认删除该渠道?",
            callback: function(result) {
                if (result) {
                    webix.ajax().sync().get(
                        "{{ url('channel/remove_channel') }}",
                        { id: list.getSelectedItem().id });
                    list.remove(list.getSelectedId());
                }
            }
        });
    },

    onDisableChannel: function() {
        var list = $$("table:channel_list");
        if (!list.getSelectedId()) {
            return;
        }

        webix.confirm({
            text: "确认禁用该渠道?",
            callback: function(result) {
                if (result) {
                    webix.ajax().sync().get(
                        "{{ url('channel/disable_channel') }}",
                        { id: list.getSelectedItem().id });
			var sel = list.getSelectedId();
			if (!sel) return;
			var row = list.getItem(sel.row);
			row["state"] = 0;
		    list.updateItem(sel.row, row);
                }
            }
        });
    },

    onEnableChannel: function() {
        var list = $$("table:channel_list");
        if (!list.getSelectedId()) {
            return;
        }

        webix.confirm({
            text: "确认启用该渠道?",
            callback: function(result) {
                if (result) {
                    webix.ajax().sync().get(
                        "{{ url('channel/enable_channel') }}",
                        { id: list.getSelectedItem().id });
			var sel = list.getSelectedId();
			if (!sel) return;
			var row = list.getItem(sel.row);
			row["state"] = 1;
		    list.updateItem(sel.row, row);
                }
            }
        });
    },
};

var channel_list_pager = {
    id: "pager:channel_list",
    view: 'pager',
    template: "{common.first()} {common.prev()} " + 
              "{common.pages()} " +
              "{common.next()} {common.last()}",
};

var channel_list = {
    id: "table:channel_list",
    view: "datatable",
    columns: [
        { id: "id", header: "渠道ID", width: 200 },
        { id: "desc",
          header: "渠道名",
          width: 550 },
        { id: "state", header: "状态" },
        { id: "platform_id", header: "所属平台" },
    ],
    pager: "pager:channel_list",
    autoheight: true,
    autowidth: true,
    select: "row",
    url: channel_list_url,
    on: {
        'onAfterSelect': event_handler.onChannelListSelect,
        'onAfterUnselect': event_handler.onChannelListUnselect,
    }
};

var add_channel_form = {
    id: "form:add_channel",
    view: "form",
    width: 400,
    elementsConfig: {
        labelPosition: "top",
        invalidMessage: "格式错误",
    },
    elements: [
        { view: "text", name: "id", label: "渠道号(6位数字ID)",
          required: true},
        { view: "text", name: "desc", label: "渠道名(渠道描述)" },
        { view: "combo", name: "platform_id", label: "所属平台",
          required: true, value: 0,
          suggest: {
              view: "suggest",
              template: "#id#-#desc#",
              body: {
                  view: "list",
                  template: "#id#-#desc#",
                  url: "{{ url('channel/get_platform_suggest') }}",
              },
          },
          validate: webix.rules.isNotEmpty,
          invalidMessage: "请选择平台",
        },
        { view: "button", label: "保存", width: 100, align: "right",
          required: true,
          click: event_handler.onSubmitAddChannel },
    ],
};

var add_channel_dialog = webix.ui({
    id: "dialog:add_channel",
    view: "window",
    position: "center",
    move: true,
    modal: true,
    head: {
        view: "toolbar",
        elements: [
            { view: "label", label: "新增渠道" },
            { view: "button", label: "X", align: "left", width: 50,
              click: function() { $$("dialog:add_channel").hide(); }
            },
        ],
    },
    body: add_channel_form,
});

var layout = {
    rows: [
        { cols: [
            { id: "button:add_channel",
              view: "button", label: "新增渠道", width: 100,
              click: event_handler.onAddChannel
            },
            { id: "button:remove_channel",
              view: "button", label: "删除渠道", width: 100,
              hidden: true,
              click: event_handler.onRemoveChannel
            },
            { id: "button:disable_channel",
              view: "button", label: "禁用渠道", width: 100,
              hidden: true,
              click: event_handler.onDisableChannel
            },
            { id: "button:enable_channel",
              view: "button", label: "启用渠道", width: 100,
              hidden: true,
              click: event_handler.onEnableChannel
            },
       ]},
        channel_list,
        channel_list_pager,
    ],
};

$$("app:main_content").addView(layout);

});
</script>
