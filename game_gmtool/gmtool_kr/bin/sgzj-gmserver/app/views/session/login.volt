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
        { view: "label", label: "삼국전기GM툴", align: "center" },
        { view: "text", name: "account", label: "계정",
          validate: webix.rules.isNotEmpty, invalidMessage: "계정을 입력하세요" },
        { view: "text", name: "password", label: "비밀번호", type: "password",
          validate: webix.rules.isNotEmpty, invalidMessage: "비밀번호를 입력하세요",
          on: {
              'onKeyPress': function(code, e) {
                if (code === 13 && !e.ctrlKey && !e.shiftKey && !e.altKey) {
                    event_handler.onSubmitLogin();
                }
              },
          },
        },
        { id: "button:login",
          view: "button", label: "로그인", width: 150, align: "right",
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
