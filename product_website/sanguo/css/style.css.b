@charset "utf-8";
/* CSS Document */
html,body {height:100%;font-family:'微软雅黑',Arial, Helvetica, sans-serif;background-color:#f2f2f2;color:#333;}
body,ul,ol,h1,h2,h3,h4,h5,h6,p,span{margin:0;padding:0;}
ul ,ol {list-style-type:none;}
input,select,button {font-family:'微软雅黑',Arial, Helvetica, sans-serif;}
.blue {color:#009dde;}
.red {color:#e21c19;}
.green {color:#008d53;}
.hide {display:none;}
.text-center {text-align: center;}
/*顶部固定*/
.fixed-top-warp {position:fixed;top:0;left:0;right:0;height:48px;background-color:#fff;box-sizing:border-box;box-shadow:0 0 6px #ccc;}
.logo {display:inline-block;padding: 8px 0 8px 10px;height:100%;box-sizing:border-box;}
.logo img {height: 100%;width: auto;}
.download-btn {background:url(/images/mobile/download.png);position:absolute;right:10px;top:10px;height:28px;width:85px;background-size:cover;}
/*底部固定*/
.fixed-bottom-warp {position:fixed;bottom:0;left: 0;right:0;height: 48px;border-top: 1px solid #ddd;box-sizing:border-box;background-color:#fff;}
.nav {padding:4px 0;display:-webkit-box;-webkit-flex;display:flex;}
.nav a {-webkit-box-flex:1;-webkit-flex:1;flex:1;text-decoration:none;text-align:center;line-height:40px;font-size:14px;color:#333;}
.nav a + a {border-left:1px solid #dadada;}
.nav a .icon2 {display:inline-block;margin-right:3px;width:14px;height:14px;vertical-align:middle;background:url(/images/mobile/nav-icon.png) 0 -16px no-repeat;background-size:100% auto;}
.nav a.active {color:#e21c19;}
.nav a.active .icon2 {background-position:0px -1px;}

/*main 内容*/
.main-warp {position:absolute;top:48px;bottom:48px;width:100%;overflow-x:hidden;overflow-y:auto;}
.banner-wrap {width:100%;}
.banner-wrap img {max-width:100%;height:auto;display:block;}
.swiper-pagination {text-align:right!important;}
.swiper-pagination-bullet-active {background-color:#bd3005!important;}
.swiper-pagination-bullet {opacity: 1!important;}
.tab {display:-webkit-box;-webkit-flex;display:flex;background-color:#fff;border-bottom:1px solid #ddd;border-top:1px solid #ddd;}
.tab-list {-webkit-box-flex:1;-webkit-flex:1;flex:1;padding:6px 0;font-size: 15px;text-align: center;text-decoration:none;color:#333;}
.tab-list.active {border-bottom:2px solid #e21c19;color:#e21c19;}
.new-lists li {margin:0 5px;padding:6px 8px;}
.new-lists li a {color: inherit;text-decoration:none;}
.new-lists li + li {border-top: 1px dotted #dadada;}
.new-lists li .date {float:right;}
.new-lists li .new-tit {display:block;overflow:hidden;white-space:nowrap;text-overflow:ellipsis;box-sizing:border-box;}
.page-wrap {margin:30px 0 20px; text-align:center;}
.page {margin:0 10px;width:68px;border:none;background-color:#bd3005;color:#fff;padding:5px 0;border-radius:20px;}
.contact-us {padding:15px 15px 50px 15px;background-color:#333;color:#dfdfdf;line-height:1.8;}
.contact-us p {font-size:14px;text-align: center;}
.follow {margin-bottom:20px;text-align:center;}
.follow .icon {display:block;margin:0 auto 5px;width:50px;height:50px;background:url(/images/mobile/icon.png) no-repeat;background-size:100% auto;}
.wechat .icon {background-position:0px 0px;}
.webo .icon {background-position:0px -61px;}
.tel,.qq {padding-left:25px;background:url(/images/mobile/icon.png) no-repeat;background-size:44px auto;text-align: center;}
.tel {background-position:60px -105px;}
.qq {background-position:80px -130px;}

.hero-list {padding:15px 10px 0;overflow:hidden;}
.hero {float:left;display:inline-block;margin-bottom:15px;width:25%;text-align:center;}
.hero img {width:70%;height:auto;padding:2px;box-shadow:0 0 5px #555;box-sizing:border-box;}
.hero span {display:block;overflow:hidden;white-space:nowrap;text-overflow:ellipsis;text-align:center;font-size:14px;}
.hero-tab-wrap {position:relative;}
.wrap-tit {position:absolute;top:0;left:0;width:80px;text-align:center;line-height:36px;background-color:#555;color:#fff;}
.swiper-container.hero-tab-box {height:36px;margin-left:80px;overflow:hidden;background-color:#999;}
.hero-tab .swiper-slide{line-height:36px;text-align:center;padding:0 10px;width:auto;position:relative;margin-right:-1px;}
.hero-tab .swiper-slide + .swiper-slide:before {
	content:" ";
	width:0;
	height: 14px;
	position:absolute;
	left:0;
	top: 12px;
	border-left:1px solid #333;
}
.swiper-slide.active {background-color:#af0000;color:#fff;}
.hero-tab-box .swiper-button-next, .hero-tab-box .swiper-button-prev {width:20px;height: 36px;top:0;margin-top:0;background-size: 50%;background-color: rgba(0,0,0,.4);}
.hero-tab-box .swiper-button-next {right:0;}
.hero-tab-box .swiper-button-prev {left:0;}
.hero-intro {padding:0 20px 20px 20px;}
.intro-tit {margin-top:20px;font-weight:bold;}
.intro {font-size:14px;}
.skill {color:#e21c19;font-size:14px;}
.analysis-pic img {display:block;margin:20px auto;width:70%;height:auto;}
.cover {position:absolute;top:0;right:0;left:0;bottom:0;background:url(/images/mobile/cover.jpg) center no-repeat;background-size:cover;}
.btn-group {padding:2px 0;display:-webkit-box;-webkit-flex;display:flex;box-sizing:border-box;height:48px;}
.btn-group div {-webkit-box-flex:1;-webkit-flex:1;flex:1;padding:2px 0;text-align:center;box-sizing:border-box;height:44px;}
.btn-group div img {height:40px;}
.btn-group div + div {border-left:1px solid #ccc;}
.new-content {padding:0 15px 20px;}
.new-content h4 {margin:20px 0 5px;text-align:center;}
.new-date {color:#999;font-size:12px;margin:0 0 10px;padding-bottom:5px;text-align:center;border-bottom:1px dashed #ddd;}
.new-content p {margin-bottom:5px;text-indent:2em;font-size:13px;}
.new-content p img {display:block;margin:10px auto 0;max-width:60%;}
.new-content p span {display:block;color:#999;font-size:12px;text-align:center;text-indent:0;}
.form {margin: 30px 0 20px;font-size:16px;}
.form table tr td {padding: 5px 6px;}
.form table tr td label {white-space:nowrap;padding-left: 5px;text-align:right;display:block;}
.form input, .form select {box-sizing: border-box;height: 28px;width: 85%;font-size: 16px;padding-left: 5px;border: 1px solid #dfdfdf;font-family: '微软雅黑',Arial, Helvetica, sans-serif;vertical-align: middle;}
.form .money {
    display: inline-block;
    margin: 10px 10px 0 0;
    padding: 0 10px;
    line-height: 26px;
    box-sizing: border-box;
    height: 28px;
    background-color: #eaeaea;
    border: 1px solid #dfdfdf;
    cursor: pointer;
    vertical-align: middle;}
.form .money.active, .form .pay-method.active {
    border-color: red;
    position: relative;
}
.form .money-input {
    width: 80px;
    vertical-align: middle;
}
.form .pay-method {
    display: inline-block;
    margin-right: 15px;
    width: 80px;
    line-height: 26px;
    box-sizing: border-box;
    height: 28px;
    background-color: #eaeaea;
    border: 1px solid #dfdfdf;
    cursor: pointer;
    text-indent: -9999px;
}
.alipay {
    background: url(../images/alipay.png) center no-repeat;background-size:contain;
}
.weChat {
    background: url(../images/weChat.png) center no-repeat;background-size:contain;
}
.form .money.active:before, .form .pay-method.active:before {
    content: " ";
    position: absolute;
    right: 0;
    bottom: 3px;
    z-index: 2;
    width: 8px;
    height: 3px;
    border: 2px solid #fff;
    border-top: none;
    border-right: none;
    transform: rotate(-45deg);
}

.form .money.active:after, .form .pay-method.active:after {
    content: " ";
    position: absolute;
    right: 0;
    bottom: 0;
    width: 0;
    height: 0;
    border-width: 8px;
    border-style: solid;
    border-color: transparent red red transparent;
}
.btn {
	color: #fff;border:none;background-color:#e21c19;padding:5px 20px;border-radius:5px;
}
.mark {
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background-color: rgba(0,0,0,.5);
}
.content-body {padding:15px 10px;}
.v-code {margin-left:5px;height:26px;width:50%;border:1px solid #dfdfdf;vertical-align:middle;display:inline-block;text-decoration:none;text-align:center;line-height:24px;color:#333;}
.hide {display:none;}
.logined {margin:20px 0;font-size: 18px;}
.logined div {line-height:1.8;}
.logined .red {margin-left:10px;}
.btn-grounp button {display: inline-block;margin-right:10px;padding:4px 15px;color:#fff;font-size:16px;background-color:#e51702;border:none;border-radius:5px;}
.btn-grounp .log-off {background-color:#333!important;}
.mark {position:fixed;top:0;left:0;right:0;bottom:0;background-color:rgba(0,0,0,.5);}
.pop-wrap {position:fixed;top:100px;left:50%;background-color:#fff;width:80%;transform:translateX(-50%);z-index:99;}
.pop-header {padding:10px 15px;background-color:#666;color:#fff;font-size:16px;}
.pop-body {text-align:center;}
.pop-body table {font-size:14px;}
.close {float:right;cursor:pointer;font-size:30px;margin-top:-10px;}
.pop-footer {padding:5px 0 20px;text-align:center;}
.pop-footer button , .account .btn-grounp button {display: inline-block;margin:0 5x;padding:5px 18px;color:#fff;font-size:16px;background-color:#e51702;border:none;border-radius:5px;}
.pop-footer .log-off {background-color:#333;}
.content-tit {padding:15px;text-align:center;border-bottom:1px dashed #dfdfdf;}
.tit-box {display:inline-block;text-align:left;vertical-align:middle;}
.icon-tit {display:inline-block;margin-right:10px;width:40px;height:40px;vertical-align: middle;background:url(../images/icon-2.png) no-repeat;background-size:100% auto;}
.text-tit {font-size:16px;margin-top:1px;}
.tishi {font-size:14px;}
.chongzhi {font-size:18px;}
.pop-body table {margin:10px auto;text-align:left;}
.pop-body table td {padding:2px;}
.icon-tit-01 {background-position:0 0px;}
.icon-tit-02 {background-position:0 -42px;}
.icon-tit-03 {background-position:0 -83px;}
.no-border {border:none;}
.content-box {padding:20px 0;font-size:18px;}
.content-box div {line-height: 1.8;}
.account .btn-grounp button {margin: 0 5px 0 0;}
.account-info {font-size: 24px;margin: 4px 0px 12px;width:290px;overflow:hidden;white-space:nowrap;text-overflow:ellipsis;}
.account-info  span {float:left;margin-left: 10px;}
.account-info  span.red {width:190px;overflow:hidden;white-space:nowrap;text-overflow:ellipsis;}
.content-tit-box {padding:0 10px 20px;}
.content-body .form input,.content-body .form select {width:100%;}
.content-body .form {font-size:14px;}
.content-body .form table tr td {padding:2px 0;white-space:nowrap;}
.crumb {margin:15px 0;padding:3px 0 3px 15px;border-left:25px solid #af0000;font-size:15px;}
.crumb a {color:#333;text-decoration:none;}
.crumb a.curr,.crumb a:hover {color:#af0000;}