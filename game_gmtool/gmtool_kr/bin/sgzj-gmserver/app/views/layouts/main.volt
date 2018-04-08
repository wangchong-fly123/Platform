<div id="app_container" width="100%"></div>
<script type="text/javascript" charset="utf-8">
webix.ready(function () {

var main_menu = {
    id: "app:main_menu",
    view: "menu",
    width: 1250,
    submenuConfig: {
        width: 250,
        template:"<span class='webix_icon fa-square-o'></span> #value#",
    },
    data: [
    {% if display_menu_user %}
        { value: "유저 관리", submenu: [
            { value: "유저 리스트", href: "{{ url('user/list') }}" },
            { value: "조작 일지", href: "{{ url('user/op_log') }}" },
        ]},
    {% endif %}
    {% if display_menu_platform %}
        { value: "플랫폼 관리", submenu: [
            { value: "플랫폼 리스트", href: "{{ url('platform/list') }}" },
        ]},
    {% endif %}
    {% if display_menu_channel %}
        { value: "채널 관리", submenu: [
            { value: "채널 리스트", href: "{{ url('channel/list') }}" },
        ]},
    {% endif %}
    {% if display_menu_server %}
        { value: "서버관리", submenu: [
        {% if display_menu_server_list %}
            { value: "서버리스트", href: "{{ url('server/list') }}" },
        {% endif %}
            { value: "서버정보조회", href: "{{ url('server/brief_info') }}" },
        ]},
    {% endif %}
    {% if display_menu_player %}
        { value: "유저관리", submenu: [
            { value: "유저 기본정보 조회", href: "{{ url('player/brief_info') }}" },
            { value: "유저 검색", href: "{{ url('player/global_search') }}" },
        {% if display_menu_player_account_banning %}
            { value: "계정블락/해제", href: "{{ url('player/account_banning') }}" },
        {% endif %}
        {% if display_menu_player_gm_login %}
            { value: "GM로그인 설정", href: "{{ url('player/gm_login') }}" },
        {% endif %}
            { value: "유저 자원,아이템일지 조회", href: "{{ url('player_log/res_item_log') }}" },
            { value: "유저 행위일지 조회", href: "{{ url('player_log/action_log') }}" },
        {% if display_menu_player_pay_transaction %}
            { value: "유저 결제내역 조회", href: "{{ url('player/pay_transaction') }}" },
        {% endif %}
        {% if display_menu_player_online_list %}
            { value: "접속중인 유저 리스트", href: "{{ url('player/online_list') }}" },
        {% endif %}
        {% if display_menu_player_rank %}
            { value: "유저 랭킹", href: "{{ url('player/player_rank') }}" },
        {% endif %}
        {% if display_menu_player_gm_pay %}
            { value: "GM결제", href: "{{ url('player/gm_pay') }}" },
        {% endif %}
        {% if display_menu_player_gm %}
            { value: "GM던전완료", href: "{{ url('player/gm_finish_copy') }}" },
            { value: "GM정예던전 완료", href: "{{ url('player/gm_finish_elite_copy') }}" },
            { value: "GM원보 공제", href: "{{ url('player/gm_consume_diamond') }}" },
            { value: "최대육성", href: "{{ url('player/onekey_develop') }}" },
        {% endif %}
        {% if display_menu_player_pay_tmall_transaction %}
            { value: "TIANMAO 결제내역 조회", href: "{{ url('player/pay_tmall_transaction') }}" },
        {% endif %}
        {% if display_menu_player_mail_list %}
            { value: "유저 우편 조회", href: "{{ url('player/mail_list') }}" },
        {% endif %}
        {% if display_menu_player_buddy_list %}
            { value: "유저 무장 조회", href: "{{ url('player/buddy_list') }}" },
        {% endif %}
        {% if display_menu_player_equip_list %}
            { value: "유저 장비 조회", href: "{{ url('player/equip_list') }}" },
        {% endif %}
        {% if display_menu_player_soul_list %}
            { value: "유저 전혼 조회", href: "{{ url('player/soul_list') }}" },
        {% endif %}
        ]},
    {% endif %}
    {% if display_menu_guild %}
        { value: "군단관리", submenu: [
        {% if display_menu_guild_rank %}
            { value: "군단랭킹", href: "{{ url('guild/guild_rank') }}" },
        {% endif %}
        ]},
    {% endif %}
    {% if display_menu_notice %}
        { value: "공지", submenu: [
            { value: "실시간 공지 발송", href: "{{ url('notice/instant_notice') }}" },
            { value: "정시 공지 발송", href: "{{ url('notice/timing_notice') }}" },
            { value: "정시 공지 발송(플랫폼별)", href: "{{ url('notice/platform_timing_notice') }}" },
            { value: "공지 리스트", href: "{{ url('notice/list') }}" },
            { value: "공지 삭제(플랫폼별)", href: "{{ url('notice/platform_remove_notice') }}" },
        ]},
    {% endif %}
    {% if display_menu_mail %}
        { value: "우편발송", submenu: [
            { value: "우편발송", href: "{{ url('mail/mail') }}" },
            { value: "우편발송(플랫폼별)", href: "{{ url('mail/platform_mail') }}" },
            { value: "예약우편", href: "{{ url('mail/timing_mail') }}" },
            { value: "발송목록", href: "{{ url('mail/timing_mail_list') }}" },
        ]},
    {% endif %}
    {% if display_menu_market %}
        { value: "상점 아이템", href: "{{ url('market') }}" },
    {% endif %}
    {% if display_menu_stat %}
        { value: "통계데이터", submenu: [
            { value: "접속중인 인원수 곡선", href: "{{ url('stat/online_player') }}" },
            { value: "전체 접속중인 인원수 곡선", href: "{{ url('stat/all_online_player') }}" },
            { value: "유저 레벨 분포", href: "{{ url('stat/level_distribution') }}" },
            { value: "자원 생성 소모", href: "{{ url('stat/resource_change') }}" },
            { value: "일간 데이터 보고", href: "{{ url('stat/daily_report') }}" },
            { value: "일간 데이터 집계", href: "{{ url('stat/all_daily_report') }}" },
            { value: "일간 데이터 집계(단일채널)", href: "{{ url('stat/all_daily_report_one_day') }}" },
            { value: "일간 데이터 집계(단일서버)", href: "{{ url('stat/all_daily_report_one_day_server') }}" },
            { value: "주간 데이터 보고 ", href: "{{ url('stat/weekly_report') }}" },
            { value: "주간 데이터 집계", href: "{{ url('stat/all_weekly_report') }}" },
            { value: "월간 데이터 보계", href: "{{ url('stat/monthly_report') }}" },
            { value: "월간 데이터 집계", href: "{{ url('stat/all_monthly_report') }}" },
            {% if display_menu_stat_tmall %}
                { value: "TIANMAO 일간 결제 집계", href: "{{ url('stat/all_tmall_daily_report') }}" },
                { value: "TIANMAO 월간 결제 집계", href: "{{ url('stat/all_tmall_monthly_report') }}" },
            {% endif %}
        ]},
    {% endif %}
    {% if display_menu_spread %}
        { value: "프로모션 통계", submenu: [
            { value: "프로모션 리스트 관리", href: "{{ url('spread/list') }}" },
            { value: "일간 데이터 보고", href: "{{ url('stat/spread_daily_report') }}" },
            { value: "일간 데이터 집계", href: "{{ url('stat/spread_all_daily_report') }}" },
            { value: "일간 데이터 집계(단일프로모션)", href: "{{ url('stat/spread_all_daily_report_one_day') }}" },
            { value: "월간 데이터 보고 ", href: "{{ url('stat/spread_monthly_report') }}" },
            { value: "월간 데이터 집계", href: "{{ url('stat/spread_all_monthly_report') }}" },
        ]},
    {% endif %}
    {% if display_menu_cps_stat %}
        { value: "CPS 통계데이터", submenu: [
            { value: "일간 데이터 집계", href: "{{ url('stat/all_cps_daily_report') }}" },
            { value: "월간 데이터 집계", href: "{{ url('stat/all_cps_monthly_report') }}" },
            { value: "결제내역 조회", href: "{{ url('player/cps_pay_transaction') }}" },
        ]},
    {% endif %}
    ],
};

var main_toolbar = {
    id: "app:main_toolbar",
    view: "toolbar",
    elements: [
        { view: "label", label: "삼국전기 GM 도구", width: 200 },
        main_menu,
        { view: "label", label: "{{ auth_account }}",
          align: "right"
        },
        { view: "button", label: "로그아웃", align: "right", width: 80,
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
            text: "로그인이 유효하지 않습니다. 재로그인하세요",
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
