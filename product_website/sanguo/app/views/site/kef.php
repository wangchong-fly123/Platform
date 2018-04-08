<?php 
use yii\widgets\LinkPager;
use yii\helpers\Url;
?>
        <!--<div class="top-wrap">
			<div class="header">
				<div class="pull-left">
					<a class="logo" href="">
						<img src="images/logo.png" alt="">
					</a>
				</div>
				<div class="pull-right link-btn-box">
					<a href="" class="link-btn recharge">游戏充值</a>
					<a href="" class="link-btn user-center">账户中心</a>
				</div>
			</div>
		</div>-->
		<div class="content-wrap">
			<div class="right-content">
					<ul class="clearfix dy">
						<li style="background:#e51702; color:#fff">客服中心</li>
					</ul>
				<div class="content-1">
                    <div class="kf">
						    <p>客服中心</<p>
						    <div class="kf_1">
						        <img src="/images/kf1.png" alt="" >
						        <img src="/images/kf2.png" alt="">
						        <img src="/images/kf3.png" alt="">
						    </div>         
						</div>
				</div>
				<div class="content-footer clearfix">
					<div class="qr-code-wrap pull-left">
						<div class="qr-code-box">
							<span>官方微信号：</span>
							<img src="/images/qr-code1.jpg" alt="">
						</div>
						<div class="qr-code-box">
							<span>官方微博：</span>
							<img src="/images/qr-code2.jpg" alt="">
						</div>
					</div>
					<div class="contact-box pull-right">
						<div class="contact qq">
							<span class="icon"></span>
							<div>
							 客服QQ群号：<span>677593285</span>
						</div>
						</div>
					</div>
				</div>
			</div>
			<div class="left-content">
				<!--下载区块-->
				<div class="download-module">
					<div class="module-bg"></div>
					<div class="download">
						<div class="qr-code">
							<img src="/images/qr-code.jpg" alt="">
						</div>
						<div class="mobile-download">
							<a href="https://itunes.apple.com/cn/app/id1187917222?mt=8" class="ios">
								<span class="ios-icon"></span>
								APP Store下载
							</a>
							<a href="http://dl.enjoymi.com:8089/common_download/get_enjoymi_sgzj_game.html" class="android">
								<span class="android-icon"></span>
								Android 下载
							</a>
						</div>
						<div class="channel">
							关注我们：
							<a class="wechat" href="">
								<span><img src="/images/qr-code1.jpg" alt=""></span>
							</a>
							<a class="webo" href="http://weibo.com/u/6056895319"></a>
						</div>
					</div>
				</div>
				<!--活动-->
				<div class="latest-activity">
					<a href="<?=$three_pic[0]->short?>">
					<div class="activity activity_01" style="background: #fff url(<?=$three_pic[0]->image?>) center bottom no-repeat;">
						<!--<div class="activity-tit">最新活动</div>
						<div class="activity-info">官网正式开启活动奖励领取</div>
						<a class="link" href="">了解详情</a>-->
					</div>
					</a>
					<a href="<?=$three_pic[1]->short?>">
					<div class="activity activity_02" style="background: #fff url(<?=$three_pic[1]->image?>) center bottom no-repeat;">
						<!--<div class="activity-tit">最新活动</div>
						<div class="activity-info">官网正式开启活动奖励领取</div>
						<a class="link" href="">了解详情</a>-->
					</div>
					</a>
					<a href="<?=$three_pic[2]->short?>">
					<div class="activity activity_03" style="background: #fff url(<?=$three_pic[2]->image?>) center bottom no-repeat;">
						<!--<div class="activity-tit">最新活动</div>
						<div class="activity-info">官网正式开启活动奖励领取</div>
						<a class="link" href="">了解详情</a>-->
					</div>
					</a>
				</div>
			</div>
		</div>

