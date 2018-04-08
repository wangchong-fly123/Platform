<?php 
use yii\widgets\LinkPager;
use yii\helpers\Url;
?>
    <div class="content-wrap">
			<div class="right-content">
				<div class="tab-wrap">
					<ul class="tab-list">
						<a href="<?=Url::toRoute(['site/list','type'=>1])?>"><li class="tab <?=$currentType==1?'active':''?>">最新</li></a>
						<a href="<?=Url::toRoute(['site/list','type'=>2])?>"><li class="tab <?=$currentType==2?'active':''?>">新闻</li></a>
						<a href="<?=Url::toRoute(['site/list','type'=>3])?>"><li class="tab <?=$currentType==3?'active':''?>">公告</li></a>
						<a href="<?=Url::toRoute(['site/list','type'=>4])?>"><li class="tab <?=$currentType==4?'active':''?>">活动</li></a>
						<a href="<?=Url::toRoute(['site/list','type'=>5])?>"><li class="tab <?=$currentType==5?'active':''?>">攻略</li></a>
					</ul>
					<div class="tab-content">
						<div class="unit" style="display:block;">
							<ul class="text-link-01list news-list">
                            <?php foreach($articles as $article){?>
                                <li><span class="pull-right">【<?=date('Y/m/d',$article->time)?>】</span><a href="<?=Url::toRoute(['site/article','id'=>$article->item_id])?>"><?=$article->title?></a></li>
                            <?php }?>					
							</ul>
						</div>
					</div>
				</div>	
				<!--<div class="pagination">-->
				<div class="pagination">
					<?php
					$firstPage = '<a href="'.Url::toRoute(['site/list','page'=>1,'type'=>$currentType]).'">第一页'.'</a>';
					$lastPage = '<a href="'.Url::toRoute(['site/list','page'=>$pageCount,'type'=>$currentType]).'">最后一页'.'</a>';
					$prevPage = '<a href="'.Url::toRoute(['site/list','page'=>$currentPage-1,'type'=>$currentType]).'">上一页'.'</a>';
					$nextPage = '<a href="'.Url::toRoute(['site/list','page'=>$currentPage+1,'type'=>$currentType]).'">下一页'.'</a>';
					$morePage = '<a class="disabled hidden-xs"><span>...</span></a>';

					if($currentPage > 1)
						echo $prevPage;

					if($currentPage > 3)
						echo $firstPage.$morePage;

					for($i = $currentPage-2; $i <= $currentPage+2; $i++) {

						$liStr = '<a href="'.Url::toRoute(['site/list','page'=>$i,'type'=>$currentType]).'">'.$i.'</a>';
						if($i<1 || $i>$pageCount)
							$liStr = '';

						if($currentPage == $i)
							$liStr = '<a href="'.Url::toRoute(['site/list','page'=>$i,'type'=>$currentType]).'">'.$i.'</a>';

						echo $liStr;
					}

					if($currentPage < $pageCount-2)
						echo $morePage;

					if($currentPage < $pageCount)
						echo $nextPage;
					?>
				</div>
					<!--<a href="">下一页</a>-->
				<!--</div>	-->
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

