<?php 
use yii\widgets\LinkPager;
use yii\helpers\Url;
?>

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
