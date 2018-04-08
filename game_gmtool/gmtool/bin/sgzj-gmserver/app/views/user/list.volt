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
                    webix.alert("添加成功");
                    $$("table:user_list").clearAll();
                    $$("table:user_list").load(user_list_url);
                    return;
                }
                webix.alert("添加失败, 请检查用户是否已存在");
            });
        $$("dialog:add_user").hide();
    },

    onRemoveUser: function() {
        var list = $$("table:user_list");
        if (!list.getSelectedId()) {
            return;
        }
        if (list.getSelectedItem().account_type <= {{ auth_account_type }}) {
            webix.alert("无法删除超级管理员或高权限用户");
            return;
        }

        webix.confirm({
            text: "确认删除该用户?",
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
                webix.alert("无法修改高权限用户密码");
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
                    webix.alert("修改成功");
                    return;
                }
                webix.alert("修改失败");
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
        { id: "account", header: "帐号", width: 200 },
        { id: "account_type",
          header: "帐号类型(0-超级管理员, 1-管理员, 2-超级GM, 3-高级GM, 4-普通GM, 5-运维人员)",
          width: 550 },
        { id: "platform_id", header: "所属平台" },
        { id: "exclude_channel", header: "排除渠道号", width: 200},
        { id: "cps", header: "CPS标识" },
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
        invalidMessage: "格式错误",
    },
    elements: [
        { view: "text", name: "account", label: "用户名(4-20个字母数字组合)",
          required: true,
          validate: function(value) {
              return /^\w{4,20}$/.test(value);
          }},
        { view: "combo", name: "account_type", label: "帐号类型",
          required: true,
          options: [
          {% if display_add_user_form_super_admin_option %}
              { id: 1, value: "1-管理员" },
          {% endif %}
              { id: 2, value: "2-超级GM" },
              { id: 3, value: "3-高级GM" },
              { id: 4, value: "4-普通GM" },
              { id: 5, value: "5-运维人员" },
          ],
        },
        { view: "combo", name: "platform_id", label: "所属平台",
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
          invalidMessage: "请选择平台",
        },
        { id: "text:add_user_form:password",
          view: "text", name: "password", label: "密码(8-20个字符)",
          required: true, type:"password",
          validate: function(value) {
              return /^.{8,20}$/.test(value);
          }},
        { view: "text", name: "password_confirm", label: "重复密码",
          required: true, type:"password",
          invalidMessage: "两次密码不一致",
          validate: function(value) {
              return value === $$("text:add_user_form:password").getValue();
          }},
        { view: "text", name: "exclude_channel", label: "排除渠道号(多个渠道以';'分割)",
          required: false },
        { view: "text", name: "cps", label: "CPS标识(使用该字段的用户必须是:4-普通GM账号类型)",
          required: false },
        { view: "button", label: "保存", width: 100, align: "right",
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
            { view: "label", label: "新增用户" },
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
        invalidMessage: "格式错误",
    },
    elements: [
        { id: "text:change_password_form:old_password",
          view: "text", name: "old_password", label: "原密码",
          required: true, type:"password",
        },
        { id: "text:change_password_form:new_password",
          view: "text", name: "new_password", label: "新密码(8-20个字符)",
          required: true, type:"password",
          validate: function(value) {
              return /^.{8,20}$/.test(value);
          }},
        { view: "text", name: "new_password_confirm", label: "重复新密码",
          required: true, type:"password",
          invalidMessage: "两次密码不一致",
          validate: function(value) {
              return value ===
                  $$("text:change_password_form:new_password").getValue();
          }},
        { view: "button", label: "保存", width: 100, align: "right",
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
            { view: "label", label: "修改密码" },
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
              view: "button", label: "新增用户", width: 100,
              click: event_handler.onAddUser
            },
            { id: "button:remove_user",
              view: "button", label: "删除用户", width: 100,
              hidden: true,
              click: event_handler.onRemoveUser
            },
            { id: "button:change_password",
              view: "button", label: "修改密码", width: 100,
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
