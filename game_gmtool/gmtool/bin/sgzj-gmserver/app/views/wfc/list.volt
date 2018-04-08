{{ partial('custom_ui/server_select') }}
<script type="text/javascript" charset="utf-8">
webix.ready(function () {

var user_list_url = "{{ url('wfc/get_user_list') }}";

var event_handler = {
    onUserListSelect: function() {
        $$("button:remove_user").show();
        $$("button:change_round_win_times").show();
    },

    onUserListUnselect: function() {
        $$("button:remove_user").hide();
        $$("button:change_round_win_times").hide();
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

        webix.ajax().sync().get(
            "{{ url('wfc/add_user') }}",
            form_data,
            function(text, data) {
                var ret = data.json();
                if (ret && ret.success) {
                    webix.alert("添加成功");
                    $$("table:wfc_user_list").clearAll();
                    $$("table:wfc_user_list").load(user_list_url);
                    return;
                }
                webix.alert("添加失败, 请检查用户是否已存在");
            });
        $$("dialog:add_user").hide();
    },

    onCommitUserList: function() {
        webix.ajax().sync().get(
            "{{ url('wfc/commit_user_list') }}",
            {server_id: $$("custom:server_select").getValue(),
             is_on:$$("text:is_on").getValue(),
	     session:$$("text:session").getValue()},
            function(text, data) {
                var ret = data.json();
                if (ret && ret.success) {
                    webix.alert("提交成功");
                    return;
                }
                webix.alert("提交失败");
            });
    },

    onRemoveUser: function() {
        var list = $$("table:wfc_user_list");
        if (!list.getSelectedId()) {
            return;
        }

        webix.confirm({
            text: "确认删除该用户?",
            callback: function(result) {
                if (result) {
                    webix.ajax().sync().get(
                        "{{ url('wfc/remove_user') }}",
                        { account: list.getSelectedItem().account });
                    list.remove(list.getSelectedId());
                }
            }
        });
    },

    onChangeRoundWinTimes: function() {
        var list = $$("table:wfc_user_list");
        if (!list.getSelectedId()) {
            return;
        }

        $$("form:change_round_win_times").clear();
        $$("form:change_round_win_times").clearValidation();
        $$("dialog:change_round_win_times").show();
    },

    onSubmitChangeRoundWinTimes: function() {
        var form = $$("form:change_round_win_times");
        if (form.validate() === false) {
            return;
        }
        var form_data = form.getValues();
        form_data.account = $$("table:wfc_user_list").getSelectedItem().account;

        webix.ajax().sync().get(
            "{{ url('wfc/change_round_win_times') }}",
            form_data,
            function(text, data) {
                var ret = data.json();
                if (ret && ret.success) {
                    webix.alert("修改成功");

                    $$("table:wfc_user_list").clearAll();
                    $$("table:wfc_user_list").load(user_list_url);
                    return;
                }
                webix.alert("修改失败");
            });
        $$("dialog:change_round_win_times").hide();
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
    id: "table:wfc_user_list",
    view: "datatable",
    columns: [
        { id: "account", header: "帐号", width: 200 },
        { id: "server_info",
          header: "区服信息",
          width: 550 },
        { id: "round_win_times", header: "胜利轮次" },
        { id: "id", header: "编号" },
        { id: "is_out", header: "是否被淘汰" },
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
        { view: "text", name: "account", label: "用户名",
          required: true,
        },
        { id: "text:add_user_form:server_info",
          view: "text", name: "server_info", label: "区服信息",
          required: true
          },
        { id: "text:add_user_form:id",
          view: "text", name: "id", label: "编号",
          required: true, validate: function(value) {
              return /^[1-8]$/.test(value);
          }},
        { view: "button", label: "添加", width: 100, align: "right",
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

var change_round_win_times_form = {
    id: "form:change_round_win_times",
    view: "form",
    width: 400,
    elementsConfig: {
        labelPosition: "top",
        invalidMessage: "格式错误",
    },
    elements: [
       { id: "text:change_round_win_times_form:round_win_times",
          view: "text", name: "round_win_times", label: "胜利轮次",
          required: true,
        },
       { id: "text:change_round_win_times_form:is_out",
          view: "text", name: "is_out", label: "是否被淘汰",
          required: true,
        },
        { view: "button", label: "保存", width: 100, align: "right",
          required: true,
          click: event_handler.onSubmitChangeRoundWinTimes },
    ],
};

var change_round_win_times_dialog = webix.ui({
    id: "dialog:change_round_win_times",
    view: "window",
    position: "center",
    move: true,
    modal: true,
    head: {
        view: "toolbar",
        elements: [
            { view: "label", label: "修改胜利轮次" },
            { view: "button", label: "X", align: "left", width: 50,
              click: function() { $$("dialog:change_round_win_times").hide(); }
            },
        ],
    },
    body: change_round_win_times_form,
});

var layout = {
    rows: [
        { cols: [
            { id: "button:add_user",
              view: "button", label: "新增用户", width: 100,
              click: event_handler.onAddUser
            },
            { id: "button:commit_user_list",
              view: "button", label: "提交用户列表", width: 100,
              click: event_handler.onCommitUserList
            },
            { id: "button:remove_user",
              view: "button", label: "删除用户", width: 100,
              hidden: true,
              click: event_handler.onRemoveUser
            },
            { id: "button:change_round_win_times",
              view: "button", label: "修改胜利轮次", width: 100,
              hidden: true,
              click: event_handler.onChangeRoundWinTimes
            },
        ]},
        { id: "custom:server_select",
          view: "custom_server_select", name: "server_id",
          label: "服务器", required: true },
       { id: "text:session",
          view: "text", name: "session", label: "第几届",
          required: true,
        },
       { id: "text:is_on",
          view: "text", name: "is_on", label: "是否开启",
          required: true,
        },
        user_list,
        user_list_pager,
    ],
};

$$("app:main_content").addView(layout);

});
</script>
