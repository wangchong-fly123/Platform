<script type="text/javascript" charset="utf-8">
webix.protoUI({
    name: "custom_player_select",
    defaults: {
        css: "webix_el_text",
        validate: function(value) {
            return /^\d+$/.test(value);
        },
        invalidMessage: "请输入合法的玩家ID",
    },
}, webix.ui.text);
</script>
