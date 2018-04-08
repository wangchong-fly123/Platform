<script type="text/javascript" charset="utf-8">
webix.protoUI({
    name: "custom_player_select",
    defaults: {
        css: "webix_el_text",
        validate: function(value) {
            return /^\d+$/.test(value);
        },
        invalidMessage: "합법적인 유저ID를 입력하세요",
    },
}, webix.ui.text);
</script>
