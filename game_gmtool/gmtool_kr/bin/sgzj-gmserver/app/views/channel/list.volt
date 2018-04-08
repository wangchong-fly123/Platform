{{ partial('custom_ui/platform_select') }}
<script type="text/javascript" charset="utf-8">
webix.ready(function () {

var channel_list_url = "{{ url('channel/get_channel_list') }}";

var event_handler = {
    onChannelListSelect: function() {
        $$("button:remove_channel").show();
    },

    onChannelListUnselect: function() {
        $$("button:remove_channel").hide();
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
                    webix.alert("추가 성공");
                    $$("table:channel_list").clearAll();
                    $$("table:channel_list").load(channel_list_url);
                    return;
                }
                webix.alert("추가 실패. 이미 존재하는 채널인지 확인하십시오. ");
            });
        $$("dialog:add_channel").hide();
    },

    onRemoveChannel: function() {
        var list = $$("table:channel_list");
        if (!list.getSelectedId()) {
            return;
        }

        webix.confirm({
            text: "해당 채널 삭제 확인?",
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
        { id: "id", header: "채널ID", width: 200 },
        { id: "desc",
          header: "채널명",
          width: 550 },
        { id: "platform_id", header: "소속 플랫폼" },
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
        invalidMessage: "양식 오류",
    },
    elements: [
        { view: "text", name: "id", label: "채널번호(6자리 숫자ID)",
          required: true},
        { view: "text", name: "desc", label: "채널명(채널설명)" },
        { view: "combo", name: "platform_id", label: "소속 플랫폼",
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
          invalidMessage: "플랫폼을 선택하십시오",
        },
        { view: "button", label: "저장", width: 100, align: "right",
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
            { view: "label", label: "채널 추가" },
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
              view: "button", label: "채널 추가", width: 100,
              click: event_handler.onAddChannel
            },
            { id: "button:remove_channel",
              view: "button", label: "채널 삭제", width: 100,
              hidden: true,
              click: event_handler.onRemoveChannel
            },
        ]},
        channel_list,
        channel_list_pager,
    ],
};

$$("app:main_content").addView(layout);

});
</script>
