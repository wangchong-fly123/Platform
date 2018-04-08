{{ partial('custom_ui/server_select') }}
<script type="text/javascript" charset="utf-8">
webix.ready(function () {

var event_handler = {
    onMailListSelect: function() {
        $$("button:remove_mail").show();
        $$("button:show_mail").show();
    },

    onMailListUnselect: function() {
        $$("button:remove_mail").hide();
        $$("button:show_mail").hide();
    },

    onRemoveMail: function() {
        var form = $$("form:get_timing_mail");
        if (form.validate() === false) {
            return;
        }
        var list = $$("table:timing_mail_list");
        var values = form.getValues();
        values["id"] = list.getSelectedItem().id;
        
        if (!list.getSelectedId()) {
            return;
        }

        webix.confirm({
            text: "是否确定删除该邮件?",
            callback: function(result) {
                if (result) {
                    webix.ajax().sync().get(
                        "{{ url('mail/remove_timing_mail') }}",
                        values
                        );
                    list.remove(list.getSelectedId());
                }
            }
        });
    },

    onShowMail: function() {
        var list = $$("table:timing_mail_list");
        if (!list.getSelectedId()) {
            return;
        }
        $$("form:show_mail").clearValidation();
        $$("form:show_mail").parse(list.getSelectedItem());
        $$("text:title").disable();
        $$("text:player_count").disable();
        $$("text:start_send_time").disable();
        
        $$("textarea:content").disable();
        $$("textarea:item").disable();
        $$("textarea:players_id").disable();
        $$("dialog:show_mail").show();
    },

    onSubmitGetMailReport: function() {
        var form = $$("form:get_timing_mail");
        if (form.validate() === false) {
            return;
        }

        webix.ajax().sync().get(
            "{{ url('mail/get_timing_mail_list') }}",
            form.getValues(),
            function (text, data) {
                var ret = data.json();
                if (!ret) {
                    return;
                }
                if (ret.timing_mail_list) {
                    $$("table:timing_mail_list").clearAll();
                    $$("table:timing_mail_list").parse(ret.timing_mail_list);
                    webix.alert("查询成功");
                } else if (ret.error_code) { 
                    webix.alert(
                        enjoymi.getErrorMessage(ret.error_code));
                }
            }
        );
    },
}

var timing_mail_list_pager = {
    id: "pager:timing_mail_list",
    view: 'pager',
    template: "{common.first()} {common.prev()} " + 
              "{common.pages()} " +
              "{common.next()} {common.last()}",
};

var timing_mail_list = {
    id: "table:timing_mail_list",
    view: "datatable",
    width: 1024,
    columns: [
        { id: "id", header: "序号", width: 100 },
        { id: "title", header: "邮件名称", width: 300 },
        { id: "player_count", header: "发送人数", width: 200 },
        { id: "start_send_time", header: "发送时间", width: 200 }
    ],
    pager: "pager:timing_mail_list",
    autoheight: true,
    autowidth: true,
    select: "row",
    on: {
        'onAfterSelect': event_handler.onMailListSelect,
        'onAfterUnselect': event_handler.onMailListUnselect,
    }
};

var get_timing_mail_form = {
    id: "form:get_timing_mail",
    view: "form",
    width: 600,
    elementsConfig: {
        labelPosition: "top",
        on: {
            'onChange': function() {
                this.validate();
            }
        }
    },
    elements: [
        { view: "custom_server_select", name: "server_id",
            label: "服务器", required: true },
        { view: "button", label: "查询", width: 100, align: "right",
            click: event_handler.onSubmitGetMailReport 
        },    
    ],
};

var show_mail_form = {
    id: "form:show_mail",
    view: "form",
    width: 420,
    elements: [
        { id: "text:title", view: "text", name: "title", 
            label: "邮件名称"},
        { id: "text:player_count", view: "text", 
            name: "player_count", label: "发送人数"},
        { id: "text:start_send_time", view: "text", 
            name: "start_send_time", label: "发送时间"},
        { id: "textarea:content", view: "textarea", 
            name: "content", label: "邮件内容", 
            height: 100,labelPosition: "top"},
        { id: "textarea:item", view: "textarea", 
            name: "item", label: "道具奖励", 
            height: 100, labelPosition: "top"},
        { id: "textarea:players_id", view: "textarea", 
            name: "players_id", label: "发送名单",
            height: 100, labelPosition: "top"},
        { view: "button", label: "确定", width: 100, 
            align: "center",
            click: function() { $$("dialog:show_mail").hide();}},
    ],
};

var show_mail_dialog = webix.ui({
    id: "dialog:show_mail",
    view: "window",
    position: "center",
    move: true,
    modal: true,
    head: {
        view: "toolbar",
        elements: [
            { view: "label", label: "邮件", align: "center" }
        ],
    },
    body: show_mail_form,
});

var layout = {
    rows: [
        { cols: [
            {},
            get_timing_mail_form,
            {},
        ]},      
        { cols: [
            {},
            { view: "label", css: "warnings", width: 600,
              label: "*警告* 本功能可能影响游戏服务器的性能, " +
                     "请勿在游戏高峰期频繁查询" },
            {},
        ]},          
        { cols: [
                { id: "button:remove_mail",
                      view: "button", label: "删除", width: 100,
                      hidden: true,
                      click: event_handler.onRemoveMail
                },
                { id: "button:show_mail",
                      view: "button", label: "查看", width: 100,
                      hidden: true,
                      click: event_handler.onShowMail
                },
        ]},
        timing_mail_list,
        timing_mail_list_pager,
    ],
};

$$("app:main_content").addView(layout);

});
</script>
