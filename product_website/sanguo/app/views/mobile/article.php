<?php 
use yii\helpers\Url;
?>
    <div class="main-warp">
		<!-- <div class="banner-wrap">
			<img src="/images/mobile/banner02.jpg" alt="">
		</div> -->
		<div class="new-content">
			<h4><?=$article->title?></h4>
			<div class="new-date"><?=date('Y-m-d',$article->time)?></div>
			<?=$article->text?>
		</div>
		<div class="contact-us">
            <div class="follow wechat">
                <img src="/images/mobile/footer.jpg" alt="">
            </div>
        </div>
	</div>
	<div class="fixed-bottom-warp">
		<div class="nav">
			<a href="<?=Url::toRoute(['mobile/cover'])?>"><span class="icon2"></span>首页</a>
			<a href="<?=Url::toRoute(['mobile/newslist','type'=>1])?>"><span class="icon2"></span>公告</a>
			<a href="<?=Url::toRoute(['mobile/intro'])?>"><span class="icon2"></span>简介</a>
			<a href="<?=Url::toRoute(['mobile/herolist'])?>"><span class="icon2"></span>英雄</a>
			<a href="<?=Url::toRoute(['mobile/accountcenter','type'=>1])?>"><span class="icon2"></span>我的</a>
		</div>
	</div>
	<script src="/js/mobile/swiper.min.js"></script>
	<script>
	    var swiper = new Swiper('.swiper-container', {
	    	freeMode : true,
	    	slidesPerView : 'auto',
	    	nextButton:'.swiper-button-next',
	    });
	    $(function(){
	    	var $heroNav = $(".hero-tab .swiper-slide");
	    	$heroNav.click(function(){
	    		var $index = $(this).index();
	    		$heroNav.removeClass("active");
	    		$(this).addClass("active");
	    		$(".hero-tab-content").addClass("hide");
	    		$(".hero-tab-content").eq($index).removeClass("hide");
	    	})
	    })
	</script>