<?php 
use yii\widgets\LinkPager;
use yii\helpers\Url;
?>
		<div class="content-wrap">
			<div class="right-content">
					<ul class="clearfix dy">
						<a href="<?=Url::toRoute(['site/jzjh'])?>"><li style="background:#e51702;color:#fff">工程体系</li></a>
						<li><a href="<?=Url::toRoute(['site/jzjh1'])?>">服务申请</a></li>
						<li><a href="<?=Url::toRoute(['site/jzjh2'])?>">常见问题</a></li>
					</ul>
				<div class="content-1">
                    <div class="jiaz_wz">
							<h2 style="font-size:16px;"> &gt;&gt; 工程介绍</h2>
							<p>"网络游戏未成年人家长监护工程"是一项由完美时空、腾讯、盛大游戏、网易、搜狐畅游、巨人网络六家网络游戏企业共同发起并参与实施，由中华人民共和国文化部指导，旨在加强家长对未成年人参与网络游戏的监护，引导未成年人健康、绿色参与网络游戏，和谐家庭关系的社会性公益行动。它提供了一种切实可行的方法，一种家长实施监控的管道，使家长纠正部分未成年子女沉迷游戏的行为成为可能。
							　　该项社会公益行动充分反映了中国网络游戏行业高度的社会责任感，对未成年玩家合法权益的关注及对用实际行动营造和谐社会的愿望。</p>
							<h2 style="font-size:16px;"> &gt;&gt; 未成年人健康参与网络游戏提示</h2>
							<p>随着网络在青少年中的普及，未成年人接触网络游戏已经成为普遍现象。为保护未成年人健康参与游戏，在政府进一步加强行业管理的前提下，家长也应当加强监护引导。为此，我们为未成年人参与网络游戏提供以下意见：</p>
							<p>1.主动控制游戏时间。游戏只是学习、生活的调剂，要积极参与线下的各类活动，并让父母了解自己在网络游戏中的行为和体验。</p>
							<p>2.不参与可能耗费较多时间的游戏设置。不玩大型角色扮演类游戏，不玩有PK类设置的游戏。在校学生每周玩游戏不超过2小时，每月在游戏中的花费不超过10元。</p>
							<p>3.不要将游戏当作精神寄托。尤其在现实生活中遇到压力和挫折时，应多与家人朋友交流倾诉，不要只依靠游戏来缓解压力。</p>
							<p>4.养成积极健康的游戏心态。克服攀比、炫耀、仇恨和报复等心理，避免形成欺凌弱小、抢劫他人等不良网络行为习惯。</p>
							<p>5.注意保护个人信息。包括个人家庭、朋友身份信息，家庭、学校、单位地址，电话号码等，防范网络陷阱和网络犯罪。
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
