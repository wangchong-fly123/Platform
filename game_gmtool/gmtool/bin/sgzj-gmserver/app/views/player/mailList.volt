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
                    webix.alert("查询成功");
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
          label: "服务器", required: true },
        { id: "text:player_id",
          view: "text", name: "player_id",
          label: "玩家ID", required: true },
        { view: "button", label: "查询", width: 100, align: "right",
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
        { id: "type", header: "类型", width: 60 },
        { id: "content", header: "内容", width: 150 },
        { id: "send_time", header: "发送时间", width: 160 },
        { id: "expired_time", header: "过期时间", width: 160 },
        { id: "item", header: "附件", width: 600 },
    ],
    pager: "pager:mail_list",
    autoheight: true,
};

var mail_list_export = {
    view: "button",
    label: "导出Excel",
    type: "icon",
    icon: "save",
    width: 100,
    click: function() {
        var filename = "玩家邮件列表";

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
              label: "*警告* 本功能可能影响游戏服务器的性能, " +
                     "请勿在游戏高峰期频繁查询" },
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
