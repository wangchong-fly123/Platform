{{ partial('custom_ui/date_select') }}
{{ partial('custom_ui/player_select') }}
{{ partial('custom_ui/server_select') }}
<script type="text/javascript" charset="utf-8">
webix.ready(function () {

var event_handler = {
    onSubmitGetMailList: function() {
        var form = $$("form:get_mail_list");
        if (form.validate() === false) {
            return;
        }

        webix.ajax().sync().get(
            "{{ url('player/get_mail_list') }}",
            form.getValues(),
            function (text, data) {
                var ret = data.json();
                if (!ret) {
                    return;
                }
                if (ret.mail_list) {
                    $$("table:mail_list").clearAll();
                    $$("table:mail_list").parse(ret.mail_list);
                    $$("table:mail_list").sort("level", "desc", "int");
                    webix.alert("조회완료");
                } else if (ret.error_code) { 
                    webix.alert(
                        enjoymi.getErrorMessage(ret.error_code));
                }
            }
        );
    },
};

var get_mail_list_form = {
    id: "form:get_mail_list",
    view: "form",
    width: 600,
    elements: [
        { view: "custom_server_select", name: "server_id",
          label: "서버", required: true },
        { id: "text:player_id",
          view: "text", name: "player_id",
          label: "유저ID", required: true },
        { view: "button", label: "검색", width: 100, align: "right",
          click: event_handler.onSubmitGetMailList },
    ],
};

var mail_list_pager = {
    id: "pager:mail_list",
    view: "pager",
    template: "{common.first()} {common.prev()} " +
              "{common.pages()} " +
              "{common.next()} {common.last()}",
};

var mail_list = {
    id: "table:mail_list",
    view: "datatable",
    width: 1024,
    columns: [
        { id: "id", header: "ID", width: 60 },
        { id: "type", header: "타입", width: 60 },
        { id: "content", header: "내용", width: 150 },
        { id: "send_time", header: "발송시간", width: 160 },
        { id: "expired_time", header: "유효만기시간", width: 160 },
        { id: "item", header: "첨부내용", width: 600 },
    ],
    pager: "pager:mail_list",
    autoheight: true,
};

var mail_list_export = {
    view: "button",
    label: "익스포트Excel",
    type: "icon",
    icon: "save",
    width: 100,
    click: function() {
        var filename = "유저메일 리스트";

        webix.toExcel("table:mail_list", {
            name: filename,
        });
    },
};

var layout = {
    rows: [
        { cols: [
            {},
            get_mail_list_form,
            {},
        ]},
        { cols: [
            {},
            { view: "label", css: "warnings", width: 600,
              label: "*알림* 해당 기능은 게임서버 성능에 영항을 주실수가 있습니다, " +
                     "잠시 후에 다시 조회 바랍니다." },
            {},
        ]},
        mail_list_export,
        mail_list,
        mail_list_pager,
    ],
};

$$("app:main_content").addView(layout);

});
</script>
