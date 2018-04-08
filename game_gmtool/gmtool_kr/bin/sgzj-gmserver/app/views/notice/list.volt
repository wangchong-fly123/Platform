{{ partial('custom_ui/server_select') }}
<script type="text/javascript" charset="utf-8">
webix.ready(function () {

var event_handler = {
    onSubmitGetNoticeList: function() {
        var form = $$("form:get_notice_list");
        if (form.validate() === false) {
            return;
        }

        webix.ajax().sync().get(
            "{{ url('notice/get_notice_list') }}",
            form.getValues(),
            function (text, data) {
                var ret = data.json();
                if (!ret) {
                    return;
                }
                if (ret.notice_list) {
                    $$("table:notice_list").clearAll();
                    $$("table:notice_list").parse(ret.notice_list);
                    webix.alert("조회 성공");
                } else if (ret.error_code) { 
                    webix.alert(
                        enjoymi.getErrorMessage(ret.error_code));
                }
            }
        );
    },

    onNoticeListSelect: function() {
        $$("button:remove_notice").show();
    },

    onNoticeListUnselect: function() {
        $$("button:remove_notice").hide();
    },

    onServerSelectChange: function() {
        $$("table:notice_list").clearAll();
        $$("button:remove_notice").hide();
    },

    onRemoveNotice: function() {
        var list = $$("table:notice_list");
        if (!list.getSelectedId()) {
            return;
        }

        webix.confirm({
            text: "해당 공지 삭제 확인?",
            callback: function(result) {
                if (!result) {
                    return;
                }
                webix.ajax().sync().get(
                    "{{ url('notice/remove_notice') }}",
                    {
                        server_id: $$("custom:server_select").getValue(),
                        notice_id: list.getSelectedItem().id,
                    },
                    function (text, data) {
                        var ret = data.json();
                        if (!ret) {
                            return;
                        }
                        if (ret.success) {
                            webix.alert("삭제 성공");
                            list.remove(list.getSelectedId());
                        } else if (ret.error_code) {
                            webix.alert(
                                enjoymi.getErrorMessage(ret.error_code));
                        }
                    }
                );
            }
        });
    },
};

var get_notice_list_form = {
    id: "form:get_notice_list",
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
        { view: "button", label: "조회", width: 100, align: "right",
          click: event_handler.onSubmitGetNoticeList },
    ],
};

var notice_list_pager = {
    id: "pager:notice_list",
    view: "pager",
    template: "{common.first()} {common.prev()} " +
              "{common.pages()} " +
              "{common.next()} {common.last()}",
};

var notice_list = {
    id: "table:notice_list",
    view: "datatable",
    width: 800,
    columns: [
        { id: "id", header: "공지번호" },
        { id: "start_send_time", header: "발송시간", width: 200,
          format: enjoymi.formatTimestamp },
        { id: "repeat_times", header: "발송횟수" },
        { id: "interval_second", header: "발송간격"},
        { id: "message", header: "공지내용", width: 700 },
    ],
    pager: "pager:notice_list",
    autoheight: true,
    autowidth: true,
    select: "row",
    on: {
        'onAfterSelect': event_handler.onNoticeListSelect,
        'onAfterUnselect': event_handler.onNoticeListUnselect,
    },
};

var layout = {
    rows: [
        { cols: [
            {},
            get_notice_list_form,
            {}, 
        ]},
        { height: 40,
          cols: [
            { id: "button:remove_notice",
              view: "button", label: "공지삭제", width: 100,
              hidden: true,
              click: event_handler.onRemoveNotice,
            },
        ]},
        notice_list,
        notice_list_pager,
    ],
};

$$("app:main_content").addView(layout);

});
</script>
