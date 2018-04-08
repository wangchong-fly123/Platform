<div id="login_window" width="100%"></div>
<script type="text/javascript" charset="utf-8">
webix.ready(function () {

var event_handler = {
    onSubmitLogin: function() {
        var form = $$("form:login_form");
        if (form.validate() === false) {
            return;
        }

        webix.ajax().sync().post(
            "{{ url('session/start') }}",
            form.getValues(),
            function (text, data) {
                var ret = data.json();
                if (ret && ret.success) {
                    webix.send('{{ url('') }}');
                }
                if (ret && ret.error_code) {
                    webix.alert(
                        enjoymi.getErrorMessage(ret.error_code));
                }
            }
        );
    },
};

var login_form = {
    view: "form",
    id: "form:login_form",
    width: 400,
    elements: [
        { view: "label", label: "三国战纪GM工具", align: "center" },
        { view: "text", name: "account", label: "帐号",
          validate: webix.rules.isNotEmpty, invalidMessage: "请输入帐号" },
        { view: "text", name: "password", label: "密码", type: "password",
          validate: webix.rules.isNotEmpty, invalidMessage: "请输入密码",
          on: {
              'onKeyPress': function(code, e) {
                if (code === 13 && !e.ctrlKey && !e.shiftKey && !e.altKey) {
                    event_handler.onSubmitLogin();
                }
              },
          },
        },
        { id: "button:login",
          view: "button", label: "登录", width: 150, align: "right",
          click: event_handler.onSubmitLogin },
    ],
};

var login_window = webix.ui({
    container: "login_window",
    height: 400,
    rows: [
        {},
        { cols: [
            {},
            login_form,
            {},
        ]},
        {},
    ],
});

webix.event(window, "resize", function(){
    login_window.adjust();
})

});
</script>
