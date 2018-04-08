<?php 
use yii\widgets\LinkPager;
use yii\helpers\Url;
?>
		<div class="content-wrap">
			<div class="right-content">
					<ul class="clearfix dy">
						<li><a href="<?=Url::toRoute(['site/jzjh'])?>">工程体系</a></li>
						<a href="<?=Url::toRoute(['site/jzjh1'])?>"><li style="background:#e51702;color:#fff">服务申请</li></a>
						<li><a href="<?=Url::toRoute(['site/jzjh2'])?>">常见问题</a></li>
					</ul>
				<div class="content-1">
                    <div class="jiaz_wz">
							<h2 style="font-size:16px;"> &gt;&gt; 监护申请流程</h2>
							<p><img src="/images/guardianship.jpg" style="width:620px"></p>
							<h2 style="font-size:16px;"> &gt;&gt; 流程介绍详细说明</h2>
							<h2 style="font-size:14px;"> 监护人提出申请</h2>
							<p>在监护人发现被监护人有沉溺上海魔克网络游戏的情况下，监护人可向上海魔克公司申请发起未成年人家长监护机制。
							监护人 需亲自通过邮寄方式 向我司提供有效材料，向上海魔克公司提出未成年人账户监控的申请。在收到邮件后，我司即开始启动监护机制审核流程，首先进入疑似账号身份确认期。</p>
							<h2 style="font-size:14px;"> 疑似账号身份确认期（15 个自然日）</h2>
							<p>
							在判断申请材料完整的情况下，我司将通过官方邮箱联系疑似帐号归属者，告知其在 15 个自然日内将按照监护人需求对其账号进行相关操作，并要求疑似账号归属者提供身份材料以便我司判定其与监护人监护关系；<br>
							若疑似账号归属者在 15 个自然日内不能提供有效身份证明或逾期提供，则默认为疑似账号归属者与被监护人身份相符。我司即按照监护人申请要求，对其游戏账号纳入防沉迷系统；<br>
							若疑似账号归属者在 15 个自然日内提供的身份证明与被监护人相符，我司即按照监护人申请要求，对其游戏账号纳入防沉迷系统；<br>
							若疑似账号归属者在 15 个自然日内提供的身份证明与被监护人不符，我司则无法判定其与被监护人的身份关系。在此情况下，为保障用户游戏账号安全，我司将通知监护人通过公安机关出具账号找回协查证明，由我司协助被监护人找回游戏账号后再进行后续操作；
							</p>
							<h2 style="font-size:14px;"> 监护服务申请书</h2>
							<p>
							表单1：<a href="/img/jzjh.zip" style="color:#419a5a;" target="_blank">上海魔克游戏未成年人用户家长监控服务申请书</a><br> 
							温馨提醒，您在邮寄申请书时，要记得一起提供如下资料：<br> 
							附件1：申请人的身份证（复印件） <br>
							附件2：被申请人的身份证（复印件）<br> 
							附件3：申请人与被申请人的监护法律关系证明文件（户口簿或者其他合法有效证明文件）
							</p>
							<h2 style="font-size:14px;">家长监护专线电话</h2>
							<p>
							客服服务电话：021-5135 7781<br>
							客服服务QQ：
							677593285<br>
							</p>
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