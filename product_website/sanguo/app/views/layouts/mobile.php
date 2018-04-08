<?php 
use yii\helpers\Url;
?>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
	<meta content="telephone=no" name="format-detection">
	<title>三国战纪-官方网站</title>
	<link rel="stylesheet" href="/css/mobile/style.css">
    <link rel="stylesheet" href="/css/mobile/swiper.min.css">
	<script src="/js/mobile/jquery.min.js"></script>
	<script> (function () {
						 var _53code=document.createElement("script");
						 _53code.src = "//tb.53kf.com/code/code/10155059/1";
						 var s = document.getElementsByTagName("script")[0];
						 s.parentNode.insertBefore(_53code, s);

						})(); </script>

</head>
<body>
	<div class="fixed-top-warp">
		<a href="http://dl.enjoymi.com:8089/common_download/get_enjoymi_sgzj_game.html" class="">
			<div class="logo">
				<img src="/images/mobile/logo.png" alt="">
			</div>
			<div class="download-btn"></div>
		</a>
	</div>
    <?php $this->beginBody() ?>
    <?= $content ?>
    <?php $this->endBody() ?>
    
</body>
</html>