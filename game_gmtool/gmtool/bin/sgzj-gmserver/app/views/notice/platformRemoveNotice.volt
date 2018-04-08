{{ partial('custom_ui/platform_select') }}
<script type="text/javascript" charset="utf-8">
webix.ready(function () {

var event_handler = {
    onSubmitSendTimingNotice: function() {
        var form = $$("form:remove_notice");
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

                webix.ajax().sync().get(
                    "{{ url('notice/do_platform_remove_notice') }}", values,
                    function (text, data) {
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

var remove_notice_form = {
    id: "form:remove_notice",
    view: "form",
    width: 600,
    elementsConfig: {
        labelPosition: "top",
    },
    elements: [
        { view: "custom_platform_select", name: "platform_id",
          label: "平台", required: true },
        { view: "text", name: "notice_id",
          label: "公告id", required: true, value: "1",
          validate: function(value) {
              return webix.rules.isNumber(value) && value >= 1;
          },
          invalidMessage: "请输入合法的数值" },
        { view: "button", label: "发送", width: 100, align: "right",
          click: event_handler.onSubmitSendTimingNotice },
    ],
};

var layout = {
    rows: [
        { cols: [
            {},
            remove_notice_form,
            {},
        ]},
        { cols: [
            {},
            { view: "label", css: "warnings", width: 680,
              label: "*警告* 请谨慎使用该功能, " + 
                     "**发送成功**并不代表所有服务器都发送成功" +
                     "(例如关闭的服务器将被忽略)" },
            {},
        ]},
    ],
};

$$("app:main_content").addView(layout);

});
</script>
