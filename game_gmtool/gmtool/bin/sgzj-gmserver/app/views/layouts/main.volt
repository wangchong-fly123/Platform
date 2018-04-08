<div id="app_container" width="100%"></div>
<script type="text/javascript" charset="utf-8">
webix.ready(function () {

var main_menu = {
    id: "app:main_menu",
    view: "menu",
    width: 1200,
    submenuConfig: {
        width: 250,
        template:"<span class='webix_icon fa-square-o'></span> #value#",
    },
    data: [
    {% if display_menu_user %}
        { value: "用户管理", submenu: [
            { value: "用户列表", href: "{{ url('user/list') }}" },
            { value: "操作日志", href: "{{ url('user/op_log') }}" },
        ]},
    {% endif %}
    {% if display_menu_platform %}
        { value: "平台管理", submenu: [
            { value: "平台列表", href: "{{ url('platform/list') }}" },
        ]},
    {% endif %}
    {% if display_menu_channel %}
        { value: "渠道管理", submenu: [
            { value: "渠道列表", href: "{{ url('channel/list') }}" },
        ]},
    {% endif %}
    {% if display_menu_server %}
        { value: "服务器管理", submenu: [
        {% if display_menu_server_list %}
            { value: "服务器列表", href: "{{ url('server/list') }}" },
        {% endif %}
            { value: "服务器信息查询", href: "{{ url('server/brief_info') }}" },
        ]},
    {% endif %}
    {% if display_menu_player %}
        { value: "玩家管理", submenu: [
            { value: "玩家基本信息查询", href: "{{ url('player/brief_info') }}" },
            { value: "全局搜索玩家", href: "{{ url('player/global_search') }}" },
        {% if display_menu_player_account_banning %}
            { value: "封号解封", href: "{{ url('player/account_banning') }}" },
        {% endif %}
        {% if display_menu_change_role_account %}
            { value: "账号转移", href: "{{ url('player/account_change_role') }}" },
        {% endif %}
        {% if display_menu_player_player_silence %}
            { value: "禁言解禁", href: "{{ url('player/player_silence') }}" },
        {% endif %}
        {% if display_menu_player_gm_login %}
            { value: "设置GM登录", href: "{{ url('player/gm_login') }}" },
        {% endif %}
            { value: "玩家资源道具日志查询", href: "{{ url('player_log/res_item_log') }}" },
            { value: "玩家行为日志查询", href: "{{ url('player_log/action_log') }}" },
        {% if display_menu_player_pay_transaction %}
            { value: "玩家充值订单查询", href: "{{ url('player/pay_transaction') }}" },
        {% endif %}
        {% if display_menu_player_online_list %}
            { value: "在线玩家列表", href: "{{ url('player/online_list') }}" },
        {% endif %}
        {% if display_menu_player_rank %}
            { value: "玩家排行榜", href: "{{ url('player/player_rank') }}" },
        {% endif %}
        {% if display_menu_player_gm %}
            { value: "GM充值", href: "{{ url('player/gm_pay') }}" },
            { value: "GM完成副本", href: "{{ url('player/gm_finish_copy') }}" },
            { value: "GM完成精英副本", href: "{{ url('player/gm_finish_elite_copy') }}" },
            { value: "GM扣元宝", href: "{{ url('player/gm_consume_diamond') }}" },
            { value: "一键培养", href: "{{ url('player/onekey_develop') }}" },
            { value: "GM玩家强制改名", href: "{{ url('player/gm_rename') }}" },
        {% endif %}
        {% if display_menu_player_pay_tmall_transaction %}
            { value: "天猫充值订单查询", href: "{{ url('player/pay_tmall_transaction') }}" },
        {% endif %}
        {% if display_menu_player_mail_list %}
            { value: "玩家邮件查询", href: "{{ url('player/mail_list') }}" },
        {% endif %}
        {% if display_menu_player_buddy_list %}
            { value: "玩家武将查询", href: "{{ url('player/buddy_list') }}" },
        {% endif %}
        {% if display_menu_player_equip_list %}
            { value: "玩家装备查询", href: "{{ url('player/equip_list') }}" },
        {% endif %}
        {% if display_menu_player_soul_list %}
            { value: "玩家战魂查询", href: "{{ url('player/soul_list') }}" },
        {% endif %}
        ]},
    {% endif %}
    {% if display_menu_guild %}
        { value: "军团管理", submenu: [
        {% if display_menu_guild_rank %}
            { value: "军团排行榜", href: "{{ url('guild/guild_rank') }}" },
        {% endif %}
        {% if display_menu_guild_member %}
            { value: "军团成员", href: "{{ url('guild/guild_member') }}" },
        {% endif %}
        ]},
    {% endif %}
    {% if display_menu_notice %}
        { value: "公告", submenu: [
            { value: "发送即时公告", href: "{{ url('notice/instant_notice') }}" },
            { value: "发送定时公告", href: "{{ url('notice/timing_notice') }}" },
            { value: "发送定时公告(按平台)", href: "{{ url('notice/platform_timing_notice') }}" },
            { value: "公告列表", href: "{{ url('notice/list') }}" },
            { value: "删除公告(按平台)", href: "{{ url('notice/platform_remove_notice') }}" },
        ]},
    {% endif %}
    {% if display_menu_mail %}
        { value: "发送邮件", submenu: [
            { value: "发送邮件", href: "{{ url('mail/mail') }}" },
            { value: "发送邮件(按平台)", href: "{{ url('mail/platform_mail') }}" },
            { value: "定时邮件", href: "{{ url('mail/timing_mail') }}" },
            { value: "发送列表", href: "{{ url('mail/timing_mail_list') }}" },
        ]},
    {% endif %}
    {% if display_menu_market %}
        { value: "商城道具", href: "{{ url('market') }}" },
    {% endif %}
    {% if display_menu_stat %}
        { value: "统计数据", submenu: [
            { value: "在线人数曲线", href: "{{ url('stat/online_player') }}" },
            { value: "总在线人数曲线", href: "{{ url('stat/all_online_player') }}" },
            { value: "玩家等级分布", href: "{{ url('stat/level_distribution') }}" },
            { value: "资源产出消耗", href: "{{ url('stat/resource_change') }}" },
            { value: "资源产出消耗(按平台)", href: "{{ url('stat/platform_resource_change') }}" },
            { value: "每日数据报表", href: "{{ url('stat/daily_report') }}" },
            { value: "每日数据总表", href: "{{ url('stat/all_daily_report') }}" },
            { value: "每日数据总表(单日渠道)", href: "{{ url('stat/all_daily_report_one_day') }}" },
            { value: "每日数据总表(单日服务器)", href: "{{ url('stat/all_daily_report_one_day_server') }}" },
            { value: "每周数据报表", href: "{{ url('stat/weekly_report') }}" },
            { value: "每周数据总表", href: "{{ url('stat/all_weekly_report') }}" },
            { value: "每月数据报表", href: "{{ url('stat/monthly_report') }}" },
            { value: "每月数据总表", href: "{{ url('stat/all_monthly_report') }}" },
            {% if display_menu_stat_tmall %}
                { value: "天猫每日充值总表", href: "{{ url('stat/all_tmall_daily_report') }}" },
                { value: "天猫每周充值总表", href: "{{ url('stat/all_tmall_weekly_report') }}" },
                { value: "天猫每月充值总表", href: "{{ url('stat/all_tmall_monthly_report') }}" },
            {% endif %}
        ]},
    {% endif %}
    {% if display_menu_spread %}
        { value: "推广统计", submenu: [
            { value: "推广列表管理", href: "{{ url('spread/list') }}" },
            { value: "每日数据报表", href: "{{ url('stat/spread_daily_report') }}" },
            { value: "每日数据总表", href: "{{ url('stat/spread_all_daily_report') }}" },
            { value: "每日数据总表(单日推广)", href: "{{ url('stat/spread_all_daily_report_one_day') }}" },
            { value: "每月数据报表", href: "{{ url('stat/spread_monthly_report') }}" },
            { value: "每月数据总表", href: "{{ url('stat/spread_all_monthly_report') }}" },
        ]},
    {% endif %}
    {% if display_menu_cps_stat %}
        { value: "CPS统计数据", submenu: [
            { value: "每日数据总表", href: "{{ url('stat/all_cps_daily_report') }}" },
            { value: "每月数据总表", href: "{{ url('stat/all_cps_monthly_report') }}" },
            { value: "充值订单查询", href: "{{ url('player/cps_pay_transaction') }}" },
        ]},
    {% endif %}
    {% if display_menu_wfc %}
        { value: "赛事管理", submenu: [
            { value: "wfc用户管理", href: "{{ url('wfc/list') }}" },
        ]},
    {% endif %}
    ],
};

var main_toolbar = {
    id: "app:main_toolbar",
    view: "toolbar",
    elements: [
        { view: "label", label: "三国战纪GM工具", width: 200 },
        main_menu,
        { view: "label", label: "{{ auth_account }}",
          align: "right"
        },
        { view: "button", label: "登出", align: "right", width: 80,
          click: function() { webix.send("{{ url('session/end') }}"); }
        },
    ],
};

var main_content = {
    id: "app:main_content",
    rows: [
    ],
};

var app_container = webix.ui({
    container: "app_container",
    autoheight: true,
    autowidth: true,
    rows: [
        main_toolbar,
        { height: 10 },
        { cols: [
            {},
            main_content,
            {},
        ]},
    ],
});

webix.event(window, "resize", function() {
    app_container.adjust();
});

webix.attachEvent("onBeforeAjax", function(mode, url, data, request, headers) {
    headers["X-Requested-With"] = "XMLHttpRequest"; 
});

webix.attachEvent("onAjaxError", function(request_obj) {
    if (request_obj.status === 403) {
        webix.confirm({
            text: "登陆已失效, 请重新登陆",
            callback: function(result) {
                if (!result) {
                    return;
                }
                window.location.href = "{{ url('session/login') }}";
            }
        });
    }
});

});
</script>
{{ content() }}
