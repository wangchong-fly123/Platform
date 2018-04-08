var enjoymi = {
    error_message: {
        "-1":    "Server internal error",
        "0":     "success",
        "1":     "The player does not exist",
        "2":     "The log file does not exist",
        "3":     "Mall failed to refresh",
        "4":     "Invalid product ID",
        "5":     "Invalid amount of goods",
        "7":     "Players are not online",
        "11":    "The time has expired",
        "20001": "invalid username or password",
    },

    getErrorMessage: function(error_code) {
        return this.error_message[error_code.toString()];
    },

    formatTimestamp: function(ts) {
        return enjoymi.formatDate(new Date(ts * 1000));
    },

    formatDate: function(date) {
        var pad = function(n) {
            return n < 10 ? '0' + n : n;
        };

        return date.getFullYear() + ":" +
               pad(date.getMonth() + 1) + ":" +
               pad(date.getDate()) + "-" +
               pad(date.getHours()) + ":" +
               pad(date.getMinutes()) + ":" +
               pad(date.getSeconds());
    },

    blockDatesBeforeToday: function(date) {
        var now = new Date();
        if (now.getFullYear() != date.getFullYear()) {
            return now.getFullYear() > date.getFullYear();
        }
        if (now.getMonth() != date.getMonth()) {
            return now.getMonth() > date.getMonth();
        }
        return now.getDate() > date.getDate();
    },

    validatePositiveNumber: function(value) {
        return webix.rules.isNumber(value) && value > 0;
    },

    percentSortFunc: function(field_name) {
        return function(a, b) {
            a = +(a[field_name].replace("%", ""));
            b = +(b[field_name].replace("%", ""));
            return a > b ? 1 : (a < b ? -1 : 0);
        };
    }
};
