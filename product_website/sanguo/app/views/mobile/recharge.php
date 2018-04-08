<?php 
use yii\widgets\LinkPager;
use yii\helpers\Url;
?>
	<div class="main-warp">
		<!-- <div class="banner-wrap">
			<img src="/images/mobile/banner02.jpg" alt="">
		</div> -->
		<div class="form">
			<table>
				<tr>
					<td>游戏平台：</td>
					<td>
						<select name="" id="select3">
							<option value="-1">----------------</option>
							<?php foreach ($platform_list as $key => $value) {?>
								<option value="<?=$key?>"><?=$value?></option>
							<?php }?>
						</select>
					</td>
				</tr>
				<tr>
					<td>游戏大区：</td>
					<td>
						<select name="" id="select1">
							<option value="0">----------------</option>
							
						</select>
					</td>
				</tr>
				<tr>
					<td>游戏角色：</td>
					<td>
						<select name="" id="select2">
							<option value="0">----------------</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>充值金额：</td>
					<td class="money-wrap">
						<span class="money">6</span>
						<span class="money">30</span>
						<span class="money">60</span>
						<span class="money">98</span>
						<span class="money">168</span>
						<span class="money">328</span>
						<span class="money">648</span>
					</td>
				</tr>
				<tr>
					<td>充值方式：</td>
					<td class="method-wrap">
						<span class="platform1 pay-method alipay">支付宝</span>
						<span class="platform2 pay-method weChat">微信支付</span>
					</td>
				</tr>
				<tr>
					<td colspan="2" class="text-center">
						<button class="btn" onclick="go_pay();">下一步</button>
					</td>
				</tr>
			</table>					
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
	<div class="mark" style="display:none;" id='mask1'></div>
		<!--弹窗-->
	<!-- <div class="pop-wrap">
		<div class="pop-header">
			<span class="close">&times;</span>
			订单确认
		</div>
		<div class="pop-body">
			<div class="content-tit">
				<span class="icon-tit icon-tit-01"></span>
				<div class="tit-box">
					<div class="text-tit blue">请确认您的充值信息</div>
					<div class="tishi">(适度娱乐、理性消费)</div>
				</div>
			</div>
			<table>
				<tr>
					<td class="text-right">支付方式：</td>
					<td>支付宝</td>
				</tr>
				<tr>
					<td class="text-right">订单号：</td>
					<td>12316546465165416</td>
				</tr>
				<tr>
					<td class="text-right">充值账号：</td>
					<td>包子</td>
				</tr>
				<tr>
					<td class="text-right">指定游戏：</td>
					<td>三国</td>
				</tr>
				<tr>
					<td class="text-right">充值金额：</td>
					<td>100元</td>
				</tr>
			</table>
		</div>
		<div class="pop-footer">
			<button>去付款</button>
		</div>
	</div> -->
	<!--弹窗-->
	<!-- <div class="pop-wrap">
		<div class="pop-header">
			<span class="close">&times;</span>
			订单确认
		</div>
		<div class="pop-body">
			<div class="content-tit">
				<span class="icon-tit icon-tit-03"></span>
				<div class="tit-box">
					<div class="text-tit red">充值渠道扣款尚未完成</div>
				</div>
			</div>
			<table>
				<tr>
					<td class="text-right">支付方式：</td>
					<td>支付宝</td>
				</tr>
				<tr>
					<td class="text-right">订单号：</td>
					<td>12316546465165416</td>
				</tr>
				<tr>
					<td class="text-right">充值账号：</td>
					<td>包子</td>
				</tr>
				<tr>
					<td class="text-right">指定游戏：</td>
					<td>三国</td>
				</tr>
				<tr>
					<td class="text-right">充值金额：</td>
					<td>100元</td>
				</tr>
			</table>
		</div>
		<div class="pop-footer">
			<button>重新支付</button>
			<button class="log-off">返回平台</button>
		</div>
	</div> -->
	<!--弹窗-->
	<!-- <div class="pop-wrap">
		<div class="pop-header">
			<span class="close">&times;</span>
			请在新页面完成付款操作
		</div>
		<div class="pop-body">
			<div class="content-tit no-border">
				<span class="icon-tit icon-tit-01"></span>
			</div>
			<div class="content-tit-box">
				<div class="text-tit blue">付款完成前请不要关闭或刷新此窗口</div>
				<div class="tishi">完成付款后根据您的情况点击下面的按钮</div>	
			</div>
		</div>
		<div class="pop-footer">
			<button>查看充值结果</button>
		</div>
	</div> -->
	<!--弹窗-->
	<!-- <div class="pop-wrap">
		<div class="pop-header">
			<span class="close">&times;</span>
			提示信息
		</div>
		<div class="pop-body">
			<div class="content-box">
				<div class="red">请选择游戏</div>
			</div>
		</div>
		<div class="pop-footer">
			<button>确定</button>
		</div>
	</div> -->
	<!--弹窗-->
	<div class="pop-wrap"  style="display:none;" id='window1'>
		<div class="pop-header">
			<span class="close"  onClick="window.location.href='/mobile/recharge';">&times;</span>
			订单确认
		</div>
		<div class="pop-body">
			<div class="content-tit">
				<span id="status_icon" class="icon-tit icon-tit-02"></span>
				<div class="tit-box">
					<div class="text-tit green" id="success_msg">恭喜，您已成功充值</div>
					<div class="chongzhi red" id='order_money1'>100元</div>
				</div>
			</div>
			<table>
				<tr>
					<td class="text-right">订单号：</td>
					<td id='order_id'>12316546465165416</td>
				</tr>
				<tr>
					<td class="text-right">指定游戏：</td>
					<td>三国战纪</td>
				</tr>
				<tr>
					<td class="text-right">充值金额：</td>
					<td id='order_money2'>100元</td>
				</tr>
			</table>
		</div>
		<div class="pop-footer">
			<button onClick="window.location.href='/mobile/recharge';">返回平台</button>
		</div>
	</div>
	<script src="/js/swiper.min.js"></script>
		<script src="/js/jquery.min.js"></script>
		<script src="/js/common.js"></script>
		<script>
			var amount = 0;
			var method = '';
			var order_id = '';
			var interval_id = '';
			var channel = -1;
			$(function(){
				$(".money").click(function() {
					$(".money-input").val("");
					var $parent = $(this).parents(".money-wrap");
					var $index = $(this).index();
					$parent.find(".money").removeClass("active");
					$(this).addClass("active");
					amount = $(this).html();
				});
				$(".money-input").click(function() {
					var $parent = $(this).parents(".money-wrap");
					var $index = $(this).index();
					$parent.find(".money").removeClass("active");
					$(this).addClass("active");
					amount = 0;
					//amount = $(this).html();
				});
				$(".platform1").click(function() {
					var check_flag = check_form();
					if(check_flag){
						var $parent = $(this).parents(".method-wrap");
						var $index = $(this).index();
						var zone_id = document.getElementById("select1").value;
						var player_id = document.getElementById("select2").value;
						$parent.find(".pay-method").removeClass("active");
						$(this).addClass("active");
						// prepay_ali(amount,zone_id,player_id);
						channel = 0;
					}else{
						alert("请选择支付金额和支付方式");
					}
				});
				$(".platform2").click(function() {
					var check_flag = check_form();
					if(check_flag){
						var $parent = $(this).parents(".method-wrap");
						var $index = $(this).index();
						var zone_id = document.getElementById("select1").value;
						var player_id = document.getElementById("select2").value;
						$parent.find(".pay-method").removeClass("active");
						$(this).addClass("active");
						// prepay(amount,zone_id,player_id);
						channel = 1;
					}else{
						alert("请选择支付金额和支付方式");
					}
				});
			})

			function prepay_ali(amount,serverid,guid){
				var platform = $('#select3').val();
				$.ajax({
				    type: "GET",
				    url: "/site/aliprepay",
				    dataType: 'json',
				    data: "amount="+amount+"&guid="+guid+"&serverid="+serverid+"&platform="+platform,
				    success: function(data){
				        order_id = data.order_id;
				        var timestamp = new Date().getTime();  
                		interval_id = setInterval("check_result()", 5000);
                		window.location.href = '/mobile/aliwappay?order_id='+order_id;
				    }
				});
			}

			function prepay(amount,serverid,guid){
				var platform = $('#select3').val();
				$.ajax({
				    type: "GET",
				    url: "/site/payment",
				    dataType: 'json',
				    data: "amount="+amount+"&guid="+guid+"&serverid="+serverid+"&is_wap=1"+"&platform="+platform,
				    success: function(data){
				        order_id = data.order_id;
				        if(data.url){
				        	interval_id = setInterval("check_result()", 5000);  
				        	window.location.href=data.url;
				        }
				        
				        // var timestamp = new Date().getTime();  
            //     		$('#id_img_qr').attr("src", "/site/qr?url="+data.url);
                		
				    }
				});
            }

            function go_pay(){
            	var zone_id = document.getElementById("select1").value;
				var player_id = document.getElementById("select2").value;
				if(channel==-1){
					alert("请选择支付金额和支付方式");
				}else if(channel ==0){
            		prepay_ali(amount,zone_id,player_id);
            	}else{
            		prepay(amount,zone_id,player_id);
            	}
            }

			function check_form(){
				var zone_id = document.getElementById("select1").value;
				var player_id = document.getElementById("select2").value;
				if(zone_id>0 && player_id>0 && amount>0){
					// alert(zone_id+' '+player_id+' '+amount);
					return true;
				}else{
					return false;
				}
			}

			function set_amount(){
				amount = document.getElementById("money-input").value;
			}

			function check_result(){
				$.ajax({
				    type: "GET",
				    url: "/site/checkresult",
				    dataType: 'json',
				    data: "order_id="+order_id,
				    success: function(data){
				        if(data.status==1){
				        	$("#order_id").html(data.order_id);
				        	$("#order_money1").html(data.amount+'元');
				        	$("#order_money2").html(data.amount+'元');
				        	$("#mask1").css('display','block');
							$("#window1").css('display','block');
							clearInterval(interval_id);
				        	// s2.html(window['data2']).show();
				        }
				    }
				});
			}



			var data1;
			var data2;
			var data3;

			$(function () {
				// 监听change事件
				$('#select3').change(function(){
					var platform_id = $(this).val();
					var s1 = $('#select1');

					$.ajax({
					    type: "GET",
					    url: "/site/getserver",
					    dataType: 'json',
					    data: "platform_id="+platform_id,
					    success: function(data){
					        data3 = data.str;
					        s1.html(window['data3']).show();
					        $('#select1').change();
					    }
					});
				});
			});

			 
			$(function () {
				// 监听change事件
				$('#select1').change(function(){
					var zone_id = $(this).val();
					var s2 = $('#select2');
					if(zone_id < 0){
						alert("服务器维护中 请稍后再充值");
						window.location.reload();
						return;
					}
					var platform = $('#select3').val();
					$.ajax({
					    type: "GET",
					    url: "/site/getgamechar",
					    dataType: 'json',
					    data: "zone_id="+zone_id+"&platform="+platform,
					    success: function(data){
					        if(data.error_code==0){
					        	if(data.gamechar){
					        		data2 = data.gamechar;
					        	}else{
					        		data2 = '<option value="0">----------------</option>';
					        	}
					        }else{
					            data2 = '<option value="0">----------------</option>';
					        }
					        s2.html(window['data2']).show();
					    }
					});
				});
			});

			<?php if($ali){
                           if($ali['status']=='TRADE_SUCCESS' || $ali['status']== 1 ){?>
					$("#success_msg").html("恭喜，您已成功充值");
			<?php	}else{?>
                                $("#status_icon").attr("class", "icon-tit icon-tit-03");
				$("#success_msg").html("充值失败");
			<?php }?>
				$("#order_id").html("<?=$ali['order_id']?>");
	        	$("#order_money1").html("<?=$ali['total_amount']?>"+'元');
	        	$("#order_money2").html("<?=$ali['total_amount']?>"+'元');
	        	$("#mask1").css('display','block');
				$("#window1").css('display','block');
			<?php }?>
		</script>
