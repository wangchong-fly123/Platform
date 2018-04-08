var enjoymi = {
    error_message: {
        "-1":    "服务器内部错误",
        "0":     "成功",
        "1":     "玩家不存在",
        "2":     "日志文件不存在",
        "3":     "商城刷新失败",
        "4":     "商品ID无效",
        "5":     "商品金额无效",
        "7":     "玩家不在线",
        "8":     "名称长度在2-6个中文之间!",
        "9":     "名称已存在",
        "10":    "名称含有非法字符",
        "11":    "时间已过期",
        "3405":  "军团不存在",
        "20001": "用户名或密码无效",
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
