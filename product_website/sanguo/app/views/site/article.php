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
				<div class="content-header">
					<h2 class="new-tit"><?=$article->title?></h2>
					<p class="new-date">
                        <span>日期：<?=date('Y-m-d',$article->time)?></span> 
                        <!--<span>浏览次数：82</span>-->
                    </p>
				</div>
				<div class="content-body">
					<div class="new-wrap">
                    	<?=$article->text?>
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

		<!--fixed nav-->
		<div class="fixed-nav">
				<ul class="nav">
				<li><a href="<?=Url::toRoute(['site/index'])?>">官网首页</a></li>
				<li><a href="<?=Url::toRoute(['site/list','type'=>1])?>">新闻资讯</a></li>
				<li><a href="<?=Url::toRoute(['site/list','type'=>5])?>">游戏攻略</a></li>
				<!-- <li><a href="<?=Url::toRoute(['site/index'])?>">截图及视频</a></li>
				<li><a href="<?=Url::toRoute(['site/index'])?>">游戏充值</a></li> -->
				<li><a href="<?=Url::toRoute(['site/accountcenter'])?>">账户中心</a></li>
				<li><a href="<?=Url::toRoute(['site/jzjh'])?>">家长监护</a></li>
				<li><a href="<?=Url::toRoute(['site/kef'])?>">客服中心</a></li>
				<!-- <li><a href="<?=Url::toRoute(['site/index'])?>">客服及关注</a></li> -->
			</ul>
			<div class="fixed-download">
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
				</div>
			</div>
			<div class="campaign">
				<a href="http://gift.sgzj.enjoymi.com:8003/index.php?r=account/regpage"><img src="/images/campaign.jpg" alt="领取礼包" target="_blank"></a>
			</div>
		</div>
		<script src="/js/swiper.min.js"></script>
		<script src="/js/jquery.min.js"></script>
		<script src="/js/common.js"></script>