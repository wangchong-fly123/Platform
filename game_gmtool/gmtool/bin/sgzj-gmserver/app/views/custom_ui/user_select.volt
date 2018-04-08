<script type="text/javascript" charset="utf-8">
webix.protoUI({
    name: "custom_user_select",
    defaults: {
        css: "webix_el_combo",
        suggest: {
            view: "suggest",
            template: "#account#",
            body: {
                view:"list",
                template: "#account#",
                url: "{{ url('suggest/get_user_suggest') }}",
            },
        },
    },
    getValue: function() {
        if (this.getInputNode()) {
            return this.getInputNode().value;
        }
    }
}, webix.ui.combo);
</script>
