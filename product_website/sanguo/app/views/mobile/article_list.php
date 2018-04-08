<?php 
use yii\helpers\Url;
?>
    <div class="main-warp">
		<div class="banner-wrap">
			<!-- Swiper -->
		    <div class="swiper-container">
		        <div class="swiper-wrapper">
					<?php foreach($banner as $b){?>
		            <div class="swiper-slide">
		            	<a href="<?=$b->description?>"><img src="<?=$b->image?>" alt=""></a>
		            </div>
					<?php }?>
		        </div>
		        <!-- Add Pagination -->
		        <div class="swiper-pagination"></div>
		    </div>
		</div>
		<div class="tab">
			<a href="<?=Url::toRoute(['mobile/newslist','type'=>1])?>" class="tab-list <?=$currentType==1?'active':''?>">综合</a>
			<a href="<?=Url::toRoute(['mobile/newslist','type'=>2])?>" class="tab-list <?=$currentType==2?'active':''?>">新闻</a>
			<a href="<?=Url::toRoute(['mobile/newslist','type'=>3])?>" class="tab-list <?=$currentType==3?'active':''?>">公告</a>
			<a href="<?=Url::toRoute(['mobile/newslist','type'=>4])?>" class="tab-list <?=$currentType==4?'active':''?>">活动</a>
			<a href="<?=Url::toRoute(['mobile/newslist','type'=>5])?>" class="tab-list <?=$currentType==5?'active':''?>">攻略</a>
		</div>
		<div class="tab-content">
			<ul class="new-lists">
				<?php foreach($articles as $article){?>
				<li><a href="<?=Url::toRoute(['mobile/article','id'=>$article->item_id])?>"><span class="date">【<?=date('m/d',$article->time)?>】</span><span class="new-tit"><?=$article->title?></span></a></li>
				<?php }?>
			</ul>
			<div class="page-wrap">
					<?php
					$firstPage = '<button class="page"><a href="'.Url::toRoute(['mobile/newslist','page'=>1,'type'=>$currentType]).'">第一页'.'</a></button>';
					$lastPage = '<button class="page"><a href="'.Url::toRoute(['mobile/newslist','page'=>$pageCount,'type'=>$currentType]).'">最后一页'.'</a></button>';
					$prevPage = '<button class="page"><a href="'.Url::toRoute(['mobile/newslist','page'=>$currentPage-1,'type'=>$currentType]).'">上一页'.'</a></button>';
					$nextPage = '<button class="page"><a href="'.Url::toRoute(['mobile/newslist','page'=>$currentPage+1,'type'=>$currentType]).'">下一页'.'</a></button>';
					$morePage = '<button class="page"><a class="disabled hidden-xs"><span>...</span></a>';

					// if($currentPage == 1)
					// 	echo '<button class="page"><a href="'.Url::toRoute(['mobile/newslist']).'">首页'.'</a></button>';;
					if($currentPage > 1)
						echo $prevPage;
					if($currentPage < $pageCount)
						echo $nextPage;
					?>
				</div>
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
	        pagination: '.swiper-pagination',
	        paginationClickable: true,
	        autoplay : 4000,
	    });
	</script>