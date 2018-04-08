{{ partial('custom_ui/item_select') }}
{{ partial('custom_ui/player_select') }}
{{ partial('custom_ui/server_select') }}
{{ partial('custom_ui/date_select') }}
<script type="text/javascript" charset="utf-8">
webix.ready(function () {

var event_handler = {
    onMailAwardListSelect: function() {
        $$("button:remove_mail_award").show();
    },

    onMailAwardListUnselect: function() {
        $$("button:remove_mail_award").hide();
    },

    onAddMailAward: function() {
        $$("form:add_mail_award").clear();
        $$("form:add_mail_award").clearValidation();
        $$("dialog:add_mail_award").show();
    },

    onRemoveMailAward: function() {
        var list = $$("table:mail_award_list");
        if (!list.getSelectedId()) {
            return;
        }
        list.remove(list.getSelectedId());
    },

    onSubmitAddMailAward: function() {
        var form = $$("form:add_mail_award");
        if (form.validate() === false) {
            return;
        }
        $$("table:mail_award_list").add(
            webix.extend(form.getValues(), {
               item_desc: $$("custom:item_select").getText()
            })
        );
        $$("dialog:add_mail_award").hide();
    },

    onSubmitSendMail: function() {
        var form = $$("form:send_timing_mail");
        if (form.validate() === false) {
            return;
        }
        webix.confirm({
            text: "确认发送?",
            callback: function(result) {
                if (!result) {
                    return;
                }

                var values = form.getValues();
                values["start_send_time"] = Date.parse(
                    values["start_send_time"].toString()) / 1000;

                var awards = [];
                $$("table:mail_award_list").data.each(function(obj) {
                    awards.push({
                        item_template_id: obj.item_template_id,
                        item_count: obj.item_count,
                    });
                });

                webix.extend(values, {mail_awards: awards});
                webix.ajax().sync().get(
                    "{{ url('mail/send_timing_mail') }}", values,
                    function(text, data) {
                        do {
                            var ret = data.json();
                            if (!ret) {
                                break;
                            }
                            if (ret.success) {
                                webix.alert("发送成功");
                                return;
                            } else if (ret.error_code) {
                                webix.alert(
                                   enjoymi.getErrorMessage(ret.error_code));
                                return;
                            }

                        } while (false);

                        webix.alert("发送失败");
                    }
                );
            }
        });
    },
};

var mail_award_list_pager = {
    id: "pager:mail_award_list",
    view: 'pager',
    template: "{common.prev()}{common.pages()}{common.next()}",
    size: 5,
}

var mail_award_list = {
    id: "table:mail_award_list",
    view: "datatable",
    columns: [
        { id: "item_desc", header: "道具描述", width: 200 },
        { id: "item_template_id", header: "道具模板ID" },
        { id: "item_count", header: "道具数量" },
    ],
    pager: "pager:mail_award_list",
    autoheight: true,
    autowidth: true,
    select: "row",
    on: {
        'onAfterSelect': event_handler.onMailAwardListSelect,
        'onAfterUnselect': event_handler.onMailAwardListUnselect,
    }
};

var add_mail_award_form = {
    id: "form:add_mail_award",
    view: "form",
    width: 400,
    elements: [
        { id: "custom:item_select",
          view: "custom_item_select", name: "item_template_id",
          label: "道具", required: true },
        { view: "text", name: "item_count", label: "数量",
          required: true, invalidMessage: "请输入数量",
          validate: function(value) {
              return /\d+/.test(value);
          }},
        { view: "button", label: "添加", width: 100, align: "right",
          click: event_handler.onSubmitAddMailAward },
    ],
};

var add_mail_award_dialog = webix.ui({
    id: "dialog:add_mail_award",
    view: "window",
    position: "center",
    move: true,
    modal: true,
    head: {
        view: "toolbar",
        elements: [
            { view: "label", label: "添加道具" },
            { view: "button", label: "X", align: "left", width: 50,
              click: function() { $$("dialog:add_mail_award").hide(); }
            },
        ],
    },
    body: add_mail_award_form,
});

var send_timing_mail_form = {
    id: "form:send_timing_mail",
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
        { view: "textarea", name: "players_id",
            label: "玩家ID1,玩家ID2,玩家ID3 最多可以输入500个玩家ID; (0表示全服邮件)", 
            required: true, validate: webix.rules.IsNotEmpty,
            invalidMessage: "请输入玩家ID", height: 150},
        { view: "text", name: "mail_title",
            label: "邮件标题", required: true,
            validate: webix.rules.IsNotEmpty,
            invalidMessage: "请输入邮件标题" },
        { view: "textarea", name: "mail_content",
            label: "邮件正文", height: 150, },
        { view: "text", name: "expired_minute",
            label: "邮件失效时间(单位分钟, 0表示无失效时间)",
            required: true, value: "0",
            validate: function(value) {
            return webix.rules.isNumber(value) &&
                     value >=0;
            },
            invalidMessage: "请输入合法的数值" },
        {view:"radio", name: "immediately_send",label:"发送时间", value:1, options:[
            { id:1, value:"立即发送" }, //the initially selected item
            { id:0, value:"定时发送" }]},
        { view: "datepicker", name: "start_send_time",
            label: "开始发送时间", required: true,
            format: "%Y-%m-%d %H:%i",
            value: new Date(),
            suggest: {
              type: "calendar", body: {
                  timepicker: true,
                  calendarTime: "%H:%i",
                  blockDates: enjoymi.blockDatesBeforeToday,
              },
            }},
        {
            rows: [
                { cols: [
                    { id: "button:add_mail_award",
                      view: "button", label: "添加道具", width: 100,
                      click: event_handler.onAddMailAward,
                    },
                    { id: "button:remove_mail_award",
                      view: "button", label: "删除道具", width: 100,
                      hidden: true,
                      click: event_handler.onRemoveMailAward,
                    },
                ]},
                { cols: [ 
                    mail_award_list,
                ]},
                mail_award_list_pager,
            ],
        },
        { view: "button", label: "发送", width: 100, align: "right",
            click: event_handler.onSubmitSendMail },
    ],
};

var layout = {
    rows: [
        send_timing_mail_form,
    ],
};

$$("app:main_content").addView(layout);

});
</script>
