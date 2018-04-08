<script type="text/javascript" charset="utf-8">
webix.protoUI({
    name: "custom_date_select",
    defaults: {
        css: "webix_el_datepicker",
        format: "%Y-%m-%d",
        value: new Date(),
    },
    getValue: function() {
        return webix.ui.datepicker.prototype.getText
            .call(this).replace(/-/g, "");
    },
}, webix.ui.datepicker);
</script>
