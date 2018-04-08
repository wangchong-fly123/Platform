<?php 
use yii\helpers\Url;
?>
		<div class="content-wrap">
		<!--内容块1-->
			<div class="content-box clearfix">
				<!--下载区块-->
				<div class="download-module pull-left">
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
				<!--新闻区块-->
				<div class="news-module pull-left">
					<div class="tab-wrap">
						<ul class="tab-list">
							<li class="tab active">最新</li>
							<li class="tab">新闻</li>
							<li class="tab">公告</li>
							<li class="tab">活动</li>
						</ul>
						<a class="more pull-right" href="<?=Url::toRoute(['site/list'])?>">+</a>
						<div class="tab-content">
							<div class="unit" style="display: block;">
								<?php foreach($all_article as $key=>$article){?>
									<?php if($key==0){?>
										<div class="top-one">
											<!-- <div class="date"><?=date('Y-m-d H:i:s',$article->time)?></div> -->
											<div class="top-one-tit" style="text-align:center;"><a href="<?=Url::toRoute(['site/article','id'=>$article->item_id])?>"><?=$article->title?></a></div>
											<div class="top-one-info">
												<?=$article->short?>
											</div>
										</div>
									<?php }?>
								<?php }?>
								<ul class="top-three">
								<?php foreach($all_article as $key=>$article){?>
									<?php if($key!=0){?>
										<li><a href="<?=Url::toRoute(['site/article','id'=>$article->item_id])?>"><?=$article->title?></a></li>
									<?php }?>
								<?php }?>
								</ul>
							</div>
							<div class="unit">
								<?php foreach($news as $key=>$article){?>
									<?php if($key==0){?>
										<div class="top-one">
											<!-- <div class="date"><?=date('Y-m-d H:i:s',$article->time)?></div> -->
											<div class="top-one-tit" style="text-align:center;"><a href="<?=Url::toRoute(['site/article','id'=>$article->item_id])?>"><?=$article->title?></a></div>
											<div class="top-one-info">
												<?=$article->short?>
											</div>
										</div>
									<?php }?>
								<?php }?>
								<ul class="top-three">
								<?php foreach($news as $key=>$article){?>
									<?php if($key!=0){?>
										<li><a href="<?=Url::toRoute(['site/article','id'=>$article->item_id])?>"><?=$article->title?></a></li>
									<?php }?>
								<?php }?>
								</ul>
							</div>
							<div class="unit">
								<?php foreach($board as $key=>$article){?>
									<?php if($key==0){?>
										<div class="top-one">
											<!-- <div class="date"><?=date('Y-m-d H:i:s',$article->time)?></div> -->
											<div class="top-one-tit" style="text-align:center;"><a href="<?=Url::toRoute(['site/article','id'=>$article->item_id])?>"><?=$article->title?></a></div>
											<div class="top-one-info">
												<?=$article->short?>
											</div>
										</div>
									<?php }?>
								<?php }?>
								<ul class="top-three">
								<?php foreach($board as $key=>$article){?>
									<?php if($key!=0){?>
										<li><a href="<?=Url::toRoute(['site/article','id'=>$article->item_id])?>"><?=$article->title?></a></li>
									<?php }?>
								<?php }?>
								</ul>
							</div>
							
							<div class="unit">
								<?php foreach($campaign as $key=>$article){?>
									<?php if($key==0){?>
										<div class="top-one">
											<!-- <div class="date"><?=date('Y-m-d H:i:s',$article->time)?></div> -->
											<div class="top-one-tit" style="text-align:center;"><a href="<?=Url::toRoute(['site/article','id'=>$article->item_id])?>"><?=$article->title?></a></div>
											<div class="top-one-info">
												<?=$article->short?>
											</div>
										</div>
									<?php }?>
								<?php }?>
								<ul class="top-three">
								<?php foreach($campaign as $key=>$article){?>
									<?php if($key!=0){?>
										<li><a href="<?=Url::toRoute(['site/article','id'=>$article->item_id])?>"><?=$article->title?></a></li>
									<?php }?>
								<?php }?>
								</ul>
							</div>
						</div>
					</div>
				</div>
				<!--轮播区块-->
				

				<div class="banner-module pull-left">
					<div class="swiper-container banner-swiper">
					    <div class="swiper-wrapper">
					        <?php foreach($hero_intro as $hero_img){
					        	$h = explode('|', $hero_img->description);
					        	$h_url = $h[1];
					        	$h_str = $h[0];
					        	?>
                                <div class="swiper-slide">
                                    <a href="<?=$h_url?>"><img src="<?=$hero_img->image?>" alt=""></a>
                                </div>
                            <?php }?>
					    </div>
					    <div class="swiper-pagination"></div>
					</div>	
					<div>
						
							<?php $temp_f = 1;
							foreach($hero_intro as $hero_img){
					        	$h = explode('|', $hero_img->description);
					        	$h_url = $h[1];
					        	$h_str = $h[0];
					        	
					        	?>
					        <div class="banner-info" <?=$temp_f?'style="display:block;"':''?>>
                                <p><a href="<?=$h_url?>"><?=$h_str?><span class="link-arr"></span></a></p>
                            </div>
                            <?php $temp_f = 0;}?>
							<!-- <p>我是第一页</p>
							<p><a href="">亮点抢先看 <span class="link-arr"></span></a></p> -->
						
					</div>					
				</div>

			</div>
		<!--内容块2-->
			<div class="content-box clearfix">	
				<div class="latest-activity pull-left">
					<div class="module-tit">
						最新活动
					</div>
					<a href="<?=$three_pic[0]->short?>">
						<div class="activity activity_01" style="background:#fff url(<?=$three_pic[0]->image?>) center bottom no-repeat;">
						</div>
					</a>
					<a href="<?=$three_pic[1]->short?>">
						<div class="activity activity_02" style="background:#fff url(<?=$three_pic[1]->image?>) center bottom no-repeat;">
						</div>
					</a>
					<a href="<?=$three_pic[2]->short?>">
						<div class="activity activity_03" style="background:#fff url(<?=$three_pic[2]->image?>) center bottom no-repeat;">
						</div>
					</a>
				</div>
				<div class="pull-right">
					<div class="module-tit">
						<a class="more pull-right" href="<?=Url::toRoute(['site/list'])?>">+</a>
						新手攻略
					</div>		
					<div class="novice-raiders">
						<?php foreach($new_guide as $guide){?>
						<a href="<?=Url::toRoute(['site/article','id'=>$guide->item_id])?>"><?=$guide->title?></a>
						<?php }?>
					</div>		
				</div>
			</div>	
		<!--内容块3-->
			<div class="content-box clearfix">
				<div class="module-tit">
					角色介绍
				</div>				
				<div class="introduce-box">
					<div class="introduce">
						<?php foreach($heros as $key=>$hero){?>
							<?=($key==0)?'<div class="introduce-content fadein">':'<div class="introduce-content">'?>
								<div class="left-intro">
									<strong class="red">武将简介：</strong>
									<?=$hero->hero_intro?>			
									<strong class="red">武将技能：</strong>
									<?=$hero->skill_intro?>			
								</div>
								<div class="center-intro">
									<img style="width:625px;height:280px;" src="<?=$hero->bg_image?>" alt="">
								</div>
								<!-- <div class="right-intro">
									<img src="<?=$hero->attribute_image?>" alt="">
								</div> -->
							</div>
						<?php }?>
						<!--<div class="introduce-content">
							<div class="left-intro">
								<strong class="red">武将简介：</strong>
								<p>五虎上将之二，勇猛刚强、喝退百万曹军，圆眼一旦怒睁，便是敌军魂断矛下之时！</p>				
								<strong class="red">武将技能：</strong>
								<p>狂风弑化身狂风向前横扫目标，对目标造成伤害。</p>
								<p>狂风弑化身狂风向前横扫目标，对目标造成伤害。</p>	
		
							</div>
							<div class="center-intro">
								<img src="images/hero-info02.png" alt="">
							</div>
							<div class="right-intro">
								<img src="images/hero-info03.png" alt="">
							</div>
						</div>-->
					</div>
					<div class="introduce-hover">
						<?php foreach($heros as $hero){?>
							<a class="hover-link" href="<?=Url::toRoute(['site/hero','id'=>$hero->item_id])?>">
								<img src="<?=$hero->head?>" alt="">
								<p><?=$hero->hero_name?></p>
							</a>
						<?php }?>
					</div>
					<a  class="more-hero" href="<?=Url::toRoute(['site/hero'])?>">更多英雄 >></a>
				</div>
			</div>
		<!--内容块4-->
			<div class="content-box clearfix">
				<div class="module-tit">
					游戏特色
				</div>	
				<div class="swiper-container feature-banner">
				    <div class="swiper-wrapper">
				        <?php foreach($special as $special_img){?>
                                <div class="swiper-slide">
                                    <!--<a href=""><img src="<?=$special_img->image?>" alt=""></a>-->
									<img src="<?=$special_img->image?>" alt="">
                                </div>
                        <?php }?>
				    </div>
				    <div class="swiper-pagination"></div>
				</div>					
			</div>
		<!--内容块5-->
			<div class="content-box clearfix">
				<div class="home-bottom-tab pull-left">
					<div class="module-tit">
						<a class="more pull-right" href="<?=Url::toRoute(['site/list'])?>">+</a>
						游戏攻略
					</div>	
					<div class="tab-wrap">
						<ul class="tab-list">
							<li class="tab active">最新</li>
							<li class="tab">新手</li>
							<li class="tab">玩法</li>
						</ul>
						<div class="tab-content">
							<div class="unit" style="display: block;">
								<div class="pic-link">
									<img src="/images/index_07.jpg" alt="">
									<img src="/images/index_09.jpg" alt="">
									<!--<a href=""><img src="/images/index_09.jpg" alt=""></a>-->
								</div>
								<ul class="text-link-list">
									<?php 
									// foreach ($articles as $model) {
									//     echo $model->title;
									// }
									// echo LinkPager::widget([
									//     'pagination' => $pagination,
									// ]);
									?>
									<?php foreach($all_guide as $model){?>
										<li><span class="pull-right"><?php echo date("Y/m/d",$model->time);?></span><a href="<?=Url::toRoute(['site/article','id'=>$model->item_id])?>"><?php echo $model->title?></a></li>
									<?php }?>
								</ul>
							</div>
							<div class="unit">
								<div class="pic-link">
									<img src="/images/index_07.jpg" alt="">
									<img src="/images/index_09.jpg" alt="">
								</div>
								<ul class="text-link-list">
									<?php foreach($new_guide as $model){?>
										<li><span class="pull-right"><?php echo date("Y/m/d",$model->time);?></span><a href="<?=Url::toRoute(['site/article','id'=>$model->item_id])?>"><?php echo $model->title?></a></li>
									<?php }?>								
								</ul>
							</div>
							<div class="unit">
								<div class="pic-link">
									<img src="/images/index_07.jpg" alt="">
									<img src="/images/index_09.jpg" alt="">
								</div>
								<ul class="text-link-list">
									<?php foreach($wanfa_guide as $model){?>
										<li><span class="pull-right"><?php echo date("Y/m/d",$model->time);?></span><a href="<?=Url::toRoute(['site/article','id'=>$model->item_id])?>"><?php echo $model->title?></a></li>
									<?php }?>												
								</ul>
							</div>
						</div>
					</div>										
				</div>
				<div class="home-bottom-tab pull-right">
					<div class="module-tit">
						<!--<a class="more pull-right" href="<?=Url::toRoute(['site/list'])?>">+</a>-->
						视频中心
					</div>	
					<div class="tab-wrap">
						<ul class="tab-list">
							<li class="tab active">最新</li>
							<li class="tab">新手</li>
							<li class="tab">玩法</li>
						</ul>
						<div class="tab-content">
							<div class="unit" style="display:block;">
								<div class="video-link">
								<?php foreach($all_video as $video){?>
									<a href="<?=$video->text?>">


										<?php

/*
										<!--<img src="/images/index_11.jpg" alt="">-->
										<!--<iframe height=125 width=270 src='http://player.youku.com/embed/XNzAwNjA3MzY4' frameborder=0 'allowfullscreen'></iframe>-->


										<!--<img src="/images/index_11.jpg" alt="">-->
										<!--<iframe height=125 width=270 src='http://player.youku.com/embed/XNzAwNjA3MzY4' frameborder=0 'allowfullscreen'></iframe>-->										

										<!--<img src="/images/index_11.jpg" alt="">-->
										<!--<iframe height=125 width=270 src='http://player.youku.com/embed/XNzAwNjA3MzY4' frameborder=0 'allowfullscreen'></iframe>-->
										
*/
										?>
										<?=$video->short?>
										<p><?=$video->title?></p>
									</a>
								<?php }?>
								</div>
							</div>		
							<div class="unit">
								<div class="video-link">
								<?php foreach($new_video as $video){?>
									<a href="<?=$video->text?>">

										<?=$video->short?>
										<p><?=$video->title?></p>
									</a>
								<?php }?>
								</div>
							</div>	
							<div class="unit">
								<div class="video-link">
								<?php foreach($play_video as $video){?>
									<a href="<?=$video->text?>">

										<?=$video->short?>
										<p><?=$video->title?></p>
									</a>
								<?php }?>
								</div>
							</div>						
						</div>
					</div>										
				</div>
			</div>
		</div>
