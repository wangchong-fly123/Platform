<script type="text/javascript" charset="utf-8">
webix.protoUI({
    name: "custom_spread_select",
    defaults: {
        css: "webix_el_combo",
        suggest: {
            view: "suggest",
            template: "#url#-#desc#",
            body: {
                view:"list",
                template: "#url#-#desc#",
                url: "{{ url('suggest/get_spread_suggest') }}",
            }
        },
        validate: webix.rules.isNotEmpty,
        invalidMessage: "프로모션링크를 선택하세요",
    },
    getValue: function() {
        if (this.getInputNode()) {
            return this.getInputNode().value;
        }
    }
}, webix.ui.combo);
</script>
