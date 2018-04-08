{{ partial('custom_ui/platform_select') }}
<script type="text/javascript" charset="utf-8">
webix.ready(function () {

var user_list_url = "{{ url('user/get_user_list') }}";

var event_handler = {
    onUserListSelect: function() {
        $$("button:remove_user").show();
        $$("button:change_password").show();
    },

    onUserListUnselect: function() {
        $$("button:remove_user").hide();
        $$("button:change_password").hide();
    },

    onAddUser: function() {
        $$("form:add_user").clear();
        $$("form:add_user").clearValidation();
        $$("dialog:add_user").show();
    },

    onSubmitAddUser: function() {
        var form = $$("form:add_user");
        if (form.validate() === false) {
            return;
        }
        var form_data = form.getValues();
        delete form_data.password_confirm;

        webix.ajax().sync().get(
            "{{ url('user/add_user') }}",
            form_data,
            function(text, data) {
                var ret = data.json();
                if (ret && ret.success) {
                    webix.alert("추가성공");
                    $$("table:user_list").clearAll();
                    $$("table:user_list").load(user_list_url);
                    return;
                }
                webix.alert("추가실패! 유저명이 존재하는지 확인해보세요!");
            });
        $$("dialog:add_user").hide();
    },

    onRemoveUser: function() {
        var list = $$("table:user_list");
        if (!list.getSelectedId()) {
            return;
        }
        if (list.getSelectedItem().account_type <= {{ auth_account_type }}) {
            webix.alert("관리자 혹은 고급 권한 유저를 삭제할 수 없습니다.");
            return;
        }

        webix.confirm({
            text: "해당 유저를 삭제하시겠습니까?",
            callback: function(result) {
                if (result) {
                    webix.ajax().sync().get(
                        "{{ url('user/remove_user') }}",
                        { account: list.getSelectedItem().account });
                    list.remove(list.getSelectedId());
                }
            }
        });
    },

    onChangePassword: function() {
        var list = $$("table:user_list");
        if (!list.getSelectedId()) {
            return;
        }

        if (list.getSelectedItem().account === "{{ auth_account }}") {
            $$("text:change_password_form:old_password").show();
        } else {
            if (list.getSelectedItem().account_type <= {{ auth_account_type }}) {
                webix.alert("고급 권한 유저 비밀번호를 변경할 수 없습니다.");
                return;
            }
            $$("text:change_password_form:old_password").hide();
        }

        $$("form:change_password").clear();
        $$("form:change_password").clearValidation();
        $$("dialog:change_password").show();
    },

    onSubmitChangePassword: function() {
        var form = $$("form:change_password");
        if (form.validate() === false) {
            return;
        }
        var form_data = form.getValues();
        delete form_data.new_password_confirm;
        form_data.account = $$("table:user_list").getSelectedItem().account;

        webix.ajax().sync().get(
            "{{ url('user/change_password') }}",
            form_data,
            function(text, data) {
                var ret = data.json();
                if (ret && ret.success) {
                    webix.alert("변경성공");
                    return;
                }
                webix.alert("변경실패");
            });
        $$("dialog:change_password").hide();
    },
};

var user_list_pager = {
    id: "pager:user_list",
    view: 'pager',
    template: "{common.first()} {common.prev()} " + 
              "{common.pages()} " +
              "{common.next()} {common.last()}",
};

var user_list = {
    id: "table:user_list",
    view: "datatable",
    columns: [
        { id: "account", header: "계정", width: 200 },
        { id: "account_type",
          header: "계정유형(0-슈퍼관리자, 1-관리자, 2-슈퍼GM, 3-고급GM, 4-일반GM, 5-서버관리자)",
          width: 550 },
        { id: "platform_id", header: "소속 플랫폼" },
        { id: "exclude_channel", header: "제외 플랫폼 번호", width: 200},
        { id: "cps", header: "CPS표식" },
    ],
    pager: "pager:user_list",
    autoheight: true,
    autowidth: true,
    select: "row",
    url: user_list_url,
    on: {
        'onAfterSelect': event_handler.onUserListSelect,
        'onAfterUnselect': event_handler.onUserListUnselect,
    }
};

var add_user_form = {
    id: "form:add_user",
    view: "form",
    width: 400,
    elementsConfig: {
        labelPosition: "top",
        invalidMessage: "격식오류",
    },
    elements: [
        { view: "text", name: "account", label: "유저명(4-20자 문자와 숫자의 결합)",
          required: true,
          validate: function(value) {
              return /^\w{4,20}$/.test(value);
          }},
        { view: "combo", name: "account_type", label: "계정유형",
          required: true,
          options: [
          {% if display_add_user_form_super_admin_option %}
              { id: 1, value: "1-관리자" },
          {% endif %}
              { id: 2, value: "2-슈퍼GM" },
              { id: 3, value: "3-고급GM" },
              { id: 4, value: "4-일반GM" },
              { id: 5, value: "5-서버관리자" },
          ],
        },
        { view: "combo", name: "platform_id", label: "소속 플랫폼",
          required: true, value: 0,
          suggest: {
              view: "suggest",
              template: "#id#-#desc#",
              body: {
                  view: "list",
                  template: "#id#-#desc#",
                  url: "{{ url('user/get_platform_suggest') }}",
              },
          },
          validate: webix.rules.isNotEmpty,
          invalidMessage: "플랫폼을 선택하세요",
        },
        { id: "text:add_user_form:password",
          view: "text", name: "password", label: "비밀번호(8-20자)",
          required: true, type:"password",
          validate: function(value) {
              return /^.{8,20}$/.test(value);
          }},
        { view: "text", name: "password_confirm", label: "비밀번호 확인",
          required: true, type:"password",
          invalidMessage: "두번 입력한 비밀번호가 일치하지 않습니다.",
          validate: function(value) {
              return value === $$("text:add_user_form:password").getValue();
          }},
        { view: "text", name: "exclude_channel", label: "제외 플랫폼 번호(여러개일 경우 ';'로 구분)",
          required: false },
        { view: "text", name: "cps", label: "CPS표식(해당 필드를 사용하는 사용자는 : 4-일반 GM계정유형)",
          required: false },
        { view: "button", label: "저장", width: 100, align: "right",
          required: true,
          click: event_handler.onSubmitAddUser },
    ],
};

var add_user_dialog = webix.ui({
    id: "dialog:add_user",
    view: "window",
    position: "center",
    move: true,
    modal: true,
    head: {
        view: "toolbar",
        elements: [
            { view: "label", label: "신규유저" },
            { view: "button", label: "X", align: "left", width: 50,
              click: function() { $$("dialog:add_user").hide(); }
            },
        ],
    },
    body: add_user_form,
});

var change_password_form = {
    id: "form:change_password",
    view: "form",
    width: 400,
    elementsConfig: {
        labelPosition: "top",
        invalidMessage: "격식오류",
    },
    elements: [
        { id: "text:change_password_form:old_password",
          view: "text", name: "old_password", label: "기존 비밀번호",
          required: true, type:"password",
        },
        { id: "text:change_password_form:new_password",
          view: "text", name: "new_password", label: "신규 비밀번호(8-20자)",
          required: true, type:"password",
          validate: function(value) {
              return /^.{8,20}$/.test(value);
          }},
        { view: "text", name: "new_password_confirm", label: "신규 비밀번호 재입력",
          required: true, type:"password",
          invalidMessage: "두번 입력한 비밀번호가 일치하지 않습니다.",
          validate: function(value) {
              return value ===
                  $$("text:change_password_form:new_password").getValue();
          }},
        { view: "button", label: "저장", width: 100, align: "right",
          required: true,
          click: event_handler.onSubmitChangePassword },
    ],
};

var change_password_dialog = webix.ui({
    id: "dialog:change_password",
    view: "window",
    position: "center",
    move: true,
    modal: true,
    head: {
        view: "toolbar",
        elements: [
            { view: "label", label: "비밀번호 변경" },
            { view: "button", label: "X", align: "left", width: 50,
              click: function() { $$("dialog:change_password").hide(); }
            },
        ],
    },
    body: change_password_form,
});

var layout = {
    rows: [
        { cols: [
            { id: "button:add_user",
              view: "button", label: "신규유저", width: 100,
              click: event_handler.onAddUser
            },
            { id: "button:remove_user",
              view: "button", label: "유저삭제", width: 100,
              hidden: true,
              click: event_handler.onRemoveUser
            },
            { id: "button:change_password",
              view: "button", label: "비밀번호 변경", width: 100,
              hidden: true,
              click: event_handler.onChangePassword
            },
        ]},
        user_list,
        user_list_pager,
    ],
};

$$("app:main_content").addView(layout);

});
</script>
