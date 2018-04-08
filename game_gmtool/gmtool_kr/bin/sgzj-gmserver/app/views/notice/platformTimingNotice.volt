{{ partial('custom_ui/platform_select') }}
<script type="text/javascript" charset="utf-8">
webix.ready(function () {

var event_handler = {
    onSubmitSendTimingNotice: function() {
        var form = $$("form:send_timing_notice");
        if (form.validate() === false) {
            return;
        }

        webix.confirm({
            text: "발송 확인?",
            callback: function(result) {
                if (!result) {
                    return;
                }

                var values = form.getValues();
                values["start_send_time"] = Date.parse(
                    values["start_send_time"].toString()) / 1000;

                webix.ajax().sync().get(
                    "{{ url('notice/send_platform_timing_notice') }}", values,
                    function (text, data) {
                        do {
                            var ret = data.json();
                            if (!ret) {
                                break;
                            }
                            if (ret.success) {
                                webix.alert("전송 완료 됨");
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

var send_timing_notice_form = {
    id: "form:send_timing_notice",
    view: "form",
    width: 600,
    elementsConfig: {
        labelPosition: "top",
    },
    elements: [
        { view: "custom_platform_select", name: "platform_id",
          label: "플랫폼", required: true },
        { view: "datepicker", name: "start_send_time",
          label: "발송 시작 시간", required: true,
          format: "%Y-%m-%d %H:%i",
          value: new Date(),
          suggest: {
              type: "calendar", body: {
                  timepicker: true,
                  calendarTime: "%H:%i",
                  blockDates: enjoymi.blockDatesBeforeToday,
              },
          }},
        { view: "text", name: "message",
          label: "공지내용", required: true,
          invalidMessage: "공지내용을 입력하세요" },
        { view: "text", name: "repeat_times",
          label: "발송횟수", required: true, value: "1",
          validate: function(value) {
              return webix.rules.isNumber(value) && value >= 1;
          },
          invalidMessage: "합법적인 수치를 입력하세요" },
        { view: "text", name: "interval_second",
          label: "발송간격(초)", required: true, value: "10",
          validate: function(value) {
              return webix.rules.isNumber(value) && value >=1;
          },
          invalidMessage: "합법적인 수치를 입력하세요" },
        { view: "button", label: "발송", width: 100, align: "right",
          click: event_handler.onSubmitSendTimingNotice },
    ],
};

var layout = {
    rows: [
        { cols: [
            {},
            send_timing_notice_form,
            {},
        ]},
        { cols: [
            {},
            { view: "label", css: "warnings", width: 680,
              label: "경고*해당 기능을 신중하게 사용하십시오, " + 
                     "**발송성공**모든 서버에서 발송 성공인 것을 의미하지는 않음" +
                     "(예를 들어, 닫힌 서버는 무시됨)" },
            {},
        ]},
    ],
};

$$("app:main_content").addView(layout);

});
</script>
