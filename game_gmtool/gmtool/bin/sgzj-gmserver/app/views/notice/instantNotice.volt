{{ partial('custom_ui/server_select') }}
<script type="text/javascript" charset="utf-8">
webix.ready(function () {

var event_handler = {
    onSubmitSendInstantNotice: function() {
        var form = $$("form:send_instant_notice");
        if (form.validate() === false) {
            return;
        }

        webix.confirm({
            text: "确认发送?",
            callback: function(result) {
                if (!result) {
                    return;
                }

                webix.ajax().sync().get(
                    "{{ url('notice/send_instant_notice') }}",
                    form.getValues(),
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

var send_instant_notice_form = {
    id: "form:send_instant_notice",
    view: "form",
    width: 600,
    elementsConfig: {
        labelPosition: "top",
    },
    elements: [
        { view: "custom_server_select", name: "server_id",
          label: "服务器", required: true },
        { view: "text", name: "message",
          label: "公告信息", required: true,
          invalidMessage: "请输入公告信息" },
        { view: "text", name: "repeat_times",
          label: "发送次数(1-30)", required: true, value: "1",
          validate: function(value) {
              return webix.rules.isNumber(value) &&
                     value >= 1 && value <= 30;
          },
          invalidMessage: "请输入合法的数值" },
        { view: "text", name: "interval_second",
          label: "发送间隔(1-10秒)", required: true, value: "10",
          validate: function(value) {
              return webix.rules.isNumber(value) &&
                     value >=1 && value <= 10;
          },
          invalidMessage: "请输入合法的数值" },
        { view: "button", label: "发送", width: 100, align: "right",
          click: event_handler.onSubmitSendInstantNotice },
    ],
};

var layout = {
    rows: [
        send_instant_notice_form,
    ],
};

$$("app:main_content").addView(layout);

});
</script>
