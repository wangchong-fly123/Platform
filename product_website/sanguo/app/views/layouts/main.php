<?php
use yii\helpers\Url;
use yii\web\View;
$this->registerCssFile('/css/style.css');
$this->registerCssFile('/css/swiper.min.css');

$this->registerJsFile('/js/jquery.min.js', ['position' => View::POS_END]);
$this->registerJsFile('/js/swiper.min.js', ['position' => View::POS_END]);
$this->registerJsFile('/js/common.js', ['position' => View::POS_END]);

/*
		<script src="/js/swiper.min.js"></script>
		<script src="/js/jquery.min.js"></script>
		<script src="/js/common.js"></script>


<!-- 		<link rel="stylesheet" href="/css/style.css">
		<link rel="stylesheet" href="/css/swiper.min.css"> -->
*/



?>
<?php $this->beginPage() ?>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<title>三国战纪-官方网站</title>
		<?php $this->head() ?>
		<script type="text/javascript">
			var mobileAgent = new Array("iphone", "ipod", "ipad", "android", "mobile", "blackberry", "webos", "incognito", "webmate", "bada", "nokia", "lg", "ucweb", "skyfire");
			var browser = navigator.userAgent.toLowerCase();
			var isMobile = false;for (var i=0; i<mobileAgent.length; i++){
				if (browser.indexOf(mobileAgent[i])!=-1){
					isMobile = true;
					location.href = '/mobile/cover';
					break;
				}
			}
		</script>
		<script> (function () {
		 var _53code=document.createElement("script");
		 _53code.src = "//tb.53kf.com/code/code/10155059/1";
		 var s = document.getElementsByTagName("script")[0];
		 s.parentNode.insertBefore(_53code, s);

		})(); </script>

	</head>
	<body>
		<div class="top-wrap">
			<div class="header">
				<div class="pull-left">
					<a class="logo" href="">
						<img src="/images/logo.png" alt="">
					</a>
				</div>
				<div class="pull-right link-btn-box">
					<!-- <a href="" class="link-btn recharge">游戏充值</a> -->
					<a href="<?=Url::toRoute(['site/accountcenter'])?>" class="link-btn user-center">账户中心</a>
				</div>
			</div>
		</div>

		<!--<div class="top-wrap">
			<div class="header">
				<div class="pull-left">
					<a class="logo" href="">
						<img src="images/logo.png" alt="">
					</a>
				</div>
				<div class="pull-right">
					<div class="account">
						<div class="account-info"><span>欢迎您</span><span class="red">包子大人阿斯顿阿斯顿阿斯顿</span></div>
						<div class="btn-grounp">
							<button>充值</button>
							<button>账户中心</button>
							<button class="log-off">注销</button>
						</div>
					</div>
				</div>
			</div>
		</div>-->

		<?php $this->beginBody() ?>
        <?= $content ?>

		<!-- Footer Start -->
        <?php $this->beginContent('@app/views/layouts/web_footer.php'); ?>

        <?php $this->endContent();?>
		<!-- Footer End -->
		
		<!-- FixNav Start -->
        <?php $this->beginContent('@app/views/layouts/web_fixnav.php'); ?>

        <?php $this->endContent();?>
		<!-- FixNav End -->

        <?php $this->endBody() ?>

	</body>
</html>
<?php $this->endPage() ?>