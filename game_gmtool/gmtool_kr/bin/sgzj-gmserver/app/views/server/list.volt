<script type="text/javascript" charset="utf-8">
webix.ready(function () {

var server_list_url = "{{ url('server/get_server_list') }}";

var event_handler = {
    onServerListSelect: function() {
        $$("button:remove_server").show();
        $$("button:edit_server").show();
    },

    onServerListUnselect: function() {
        $$("button:remove_server").hide();
        $$("button:edit_server").hide();
    },

    onAddServer: function() {
        $$("form:add_server").clear();
        $$("form:add_server").clearValidation();
        $$("text:platform_id").enable();
        $$("text:server_id").enable();
        $$("dialog:add_server").show();
    },

    onSubmitAddServer: function() {
        if ($$("form:add_server").validate() === false) {
            return;
        }
        var url = $$("text:platform_id").isEnabled() ?
                  "{{ url('server/add_server') }}" :
                  "{{ url('server/update_server') }}";
        webix.ajax().sync().get(url,
            $$("form:add_server").getValues(),
            function(text, data) {
                var ret = data.json();
                if (ret && ret.success) {
                    webix.alert("저장성공");
                    $$("table:server_list").clearAll();
                    $$("table:server_list").load(server_list_url);
                    return;
                }
                webix.alert("저장실패");
            });
        $$("dialog:add_server").hide();
    },

    onRemoveServer: function() {
        var list = $$("table:server_list");
        if (!list.getSelectedId()) {
            return;
        }

        webix.confirm({
            text: "해당 서버를 삭제하시겠습니까?",
            callback: function(result) {
                if (result) {
                    webix.ajax().sync().get(
                        "{{ url('server/remove_server') }}",
                        { id: list.getSelectedItem().id });
                    list.remove(list.getSelectedId());
                }
            }
        });
    },

    onEditServer: function() {
        var list = $$("table:server_list");
        if (!list.getSelectedId()) {
            return;
        }
        $$("form:add_server").clearValidation();
        $$("form:add_server").parse(list.getSelectedItem());
        $$("text:platform_id").disable();
        $$("text:server_id").disable();
        $$("dialog:add_server").show();
    },
}

var server_list_pager = {
    id: "pager:server_list",
    view: 'pager',
    template: "{common.first()} {common.prev()} " + 
              "{common.pages()} " +
              "{common.next()} {common.last()}",
};

var server_list = {
    id: "table:server_list",
    view: "datatable",
    columns: [
        { id: "id", header: ["서버번호", { content: "textFilter" }] },
        { id: "platform_id", header: "플랫폼ID", width: 100 },
        { id: "server_id", header: "서버ID", width: 100 },
        { id: "desc", header: ["설명", { content: "textFilter" }], width: 250 },
        { id: "addr", header: "서버주소", width: 160 },
        { id: "secret_key", header: "암호키", width: 400 },
    ],
    pager: "pager:server_list",
    autoheight: true,
    autowidth: true,
    select: "row",
    url: server_list_url,
    on: {
        'onAfterSelect': event_handler.onServerListSelect,
        'onAfterUnselect': event_handler.onServerListUnselect,
    }
};

var add_server_form = {
    id: "form:add_server",
    view: "form",
    width: 400,
    elementsConfig: {
        labelPosition: "top",
        invalidMessage: "격식오류",
        on: {
            'onChange': function() {
                this.validate();
            }
        },
    },
    elements: [
        { id: "text:platform_id",
          view: "text", name: "platform_id", label: "플랫폼ID (0-999)",
          required: true,
          validate: function(value) {
              return /^\d{1,3}$/.test(value);
          }},
        { id: "text:server_id",
          view: "text", name: "server_id", label: "서버ID (0-999)",
          required: true,
          validate: function(value) {
              return /^\d{1,3}$/.test(value);
          }},
        { view: "text", name: "desc", label: "설명" },
        { view: "text", name: "addr", label: "서버주소 (ip_addr:port)",
          required: true,
          validate: function(value) {
              return /^(\d{1,3}\.){3}\d{1,3}:\d{1,5}$/.test(value);
          }},
        { view: "text", name: "secret_key", label: "암호키",
          required: true },
        { view: "button", label: "저장", width: 100, align: "right",
          click: event_handler.onSubmitAddServer },
    ],
};

var add_server_dialog = webix.ui({
    id: "dialog:add_server",
    view: "window",
    position: "center",
    move: true,
    modal: true,
    head: {
        view: "toolbar",
        elements: [
            { view: "label", label: "서버설정" },
            { view: "button", label: "X", align: "left", width: 50,
              click: function() { $$("dialog:add_server").hide(); }
            },
        ],
    },
    body: add_server_form,
});

var layout = {
    rows: [
        { cols: [
            { id: "button:add_server",
              view: "button", label: "서버증설", width: 100,
              click: event_handler.onAddServer
            },
            { id: "button:remove_server",
              view: "button", label: "서버삭제", width: 100,
              hidden: true,
              click: event_handler.onRemoveServer
            },
            { id: "button:edit_server",
              view: "button", label: "서버편집", width: 100,
              hidden: true,
              click: event_handler.onEditServer
            },
        ]},
        server_list,
        server_list_pager,
    ],
};

$$("app:main_content").addView(layout);

});
</script>
