<?php 
use yii\widgets\LinkPager;
use yii\helpers\Url;
?>

<style>




</style>
<body style="overflow-y: hidden">

	<div style="width:100%;text-align: center;margin-top: 100px;">
		<div class="jine"></div>
		<div class="yuanbao"></div>
		<div class="">请选择支付方式</div>
	</div>

	<div class="method-wrap" style="width: 100%;position: relative;margin-top: 100px;">
		<div class="bix" style="width: 200px;height: 100px;position: absolute;margin:auto;left: 0;right: 0;">

			<div class="channel1" style="float: left;" onclick="prepay_ali();">
				<img src="../../images/mobile/zfb.png" width="70px" alt="">
			</div>

			<div class="channel2" style="float: right;" onclick="prepay();">
				<img src="../../images/mobile/wx.png" width="70px" alt="">
			</div>


		</div>
	</div>
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

</body>





	<script src="/js/swiper.min.js"></script>
	<script src="/js/jquery.min.js"></script>
	<script src="/js/common.js"></script>
	<script>
		var amount = <?php echo $amount;?>;
		var serverid = <?php echo $serverid;?>;
		var guid = <?php echo $player_id;?>;
		var platform = '';
		platform = '<?php echo $platform;?>';

		var order_id = '';

		$(".fixed-top-warp").css('display','none');
		$(".jine").text('金额:'+<?php echo $amount;?>+'元')
		$(".yuanbao").text('元宝:'+<?php echo 10*$amount;?>)
		function prepay_ali(){
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

		function prepay(){
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
			    }
			});
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



	</script>