<script type="text/javascript" charset="utf-8">
webix.protoUI({
    name: "custom_item_select",
    defaults: {
        css: "webix_el_combo",
        suggest: {
            view: "suggest",
            template: "#id#-#desc#",
            filter: function(item, value) {
                if (item.id.toString().indexOf(value) >= 0) {
                    return true;
                }
                if (item.desc.toString().indexOf(value) >= 0) {
                    return true;
                }
                return false;
            },
            body: {
                view:"list",
                template: "#id#-#desc#",
                url: "{{ url('data/item_suggest.json') }}",
            }
        },
        validate: webix.rules.isNotEmpty,
        invalidMessage: "아이템을 선텍하세요",
    },
}, webix.ui.combo);
</script>
