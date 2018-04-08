{{ partial('custom_ui/item_select') }}
{{ partial('custom_ui/platform_select') }}
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
        if ($$("form:send_mail").validate() === false) {
            return;
        }
        webix.confirm({
            text: "발송 확인?",
            callback: function(result) {
                if (!result) {
                    return;
                }
                var awards = [];
                $$("table:mail_award_list").data.each(function(obj) {
                    awards.push({
                        item_template_id: obj.item_template_id,
                        item_count: obj.item_count,
                    });
                });

                webix.ajax().sync().get(
                    "{{ url('mail/send_platform_mail') }}",
                    webix.extend($$("form:send_mail").getValues(), {
                        mail_awards: awards,
                    }),
                    function(text, data) {
                        do {
                            var ret = data.json();
                            if (!ret) {
                                break;
                            }
                            if (ret.success) {
                                webix.alert("발송 성공");
                                return;
                            } else if (ret.error_code) {
                                webix.alert(
                                    enjoymi.getErrorMessage(ret.error_code));
                                return;
                            }

                        } while (false);

                        webix.alert("발송 실패");
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
        { id: "item_desc", header: "아이템 설명", width: 200 },
        { id: "item_template_id", header: "아이템 템플릿 ID" },
        { id: "item_count", header: "아이템 수량" },
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
          label: "아이템", required: true },
        { view: "text", name: "item_count", label: "수량",
          required: true, invalidMessage: "수량을 입력하세요",
          validate: function(value) {
              return /\d+/.test(value);
          }},
        { view: "button", label: "추가", width: 100, align: "right",
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
            { view: "label", label: "아이템 추가 " },
            { view: "button", label: "X", align: "left", width: 50,
              click: function() { $$("dialog:add_mail_award").hide(); }
            },
        ],
    },
    body: add_mail_award_form,
});

var send_mail_form = {
    id: "form:send_mail",
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
        { view: "custom_platform_select", name: "platform_id",
          label: "플랫폼", required: true },
        { view: "text", name: "mail_title",
          label: "우편 제목", required: true,
          validate: webix.rules.IsNotEmpty,
          invalidMessage: "우편 제목을 입력하세요" },
        { view: "textarea", name: "mail_content",
          label: "우편 본문", height: 150, },
        { view: "text", name: "expired_minute",
          label: "우편 효력 기한(분 단위, 0은 기한 없음을 의미)",
          required: true, value: "0",
          validate: function(value) {
              return webix.rules.isNumber(value) &&
                     value >=0;
          },
          invalidMessage: "합법적인 수치를 입력하세요" },
        {
            rows: [
                { cols: [
                    { id: "button:add_mail_award",
                      view: "button", label: "아이템 추가 ", width: 100,
                      click: event_handler.onAddMailAward,
                    },
                    { id: "button:remove_mail_award",
                      view: "button", label: "아이템 제거", width: 100,
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
        { view: "button", label: "발송", width: 100, align: "right",
          click: event_handler.onSubmitSendMail },
    ],
};

var layout = {
    rows: [
        { cols: [
            {},
            send_mail_form,
            {},
        ]},
        { cols: [
            {},
            { view: "label", css: "warnings", width: 680,
              label: "경고* 해당 기능을 신중하게 사용하십시오, " + 
                     "**발송 성공**모든 서버에서 발송 성공인 것을 의미하지는 않음" +
                     "(예를 들어, 닫힌 서버는 무시됨)" },
            {},
        ]},
    ],
};

$$("app:main_content").addView(layout);

});
</script>
