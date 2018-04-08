<?php
namespace app\models;

// use yii\db\ActiveRecord;
require_once "app/utils/wx/example/../lib/WxPay.Api.php";
require_once "app/utils/wx/example/WxPay.NativePay.php";
require_once 'app/utils/wx/example/log.php';

require_once 'app/utils/wx/lib/WxPay.Notify.php';

class Wxpay
{
	public static function query($out_trade_no){
		$input = new \WxPayOrderQuery();
		$input->SetOut_trade_no($out_trade_no);
		$result = \WxPayApi::orderQuery($input);
//var_dump($result);
//exit;
		if(array_key_exists("return_code", $result)
			&& array_key_exists("result_code", $result)
			&& $result["return_code"] == "SUCCESS"
			&& $result["result_code"] == "SUCCESS"){
			if($result["trade_state"] == "SUCCESS"){
			return true;
		}
	}
		return false;
	}

	public static function get_qrcode(){
		//模式二
		/**
		 * 流程：
		 * 1、调用统一下单，取得code_url，生成二维码
		 * 2、用户扫描二维码，进行支付
		 * 3、支付完成之后，微信服务器会通知支付成功
		 * 4、在支付成功通知中需要查单确认是否真正支付成功（见：notify.php）
		 */
		$timezone = "PRC";
		if(function_exists('date_default_timezone_set')){
		   date_default_timezone_set($timezone);
		}
		
		$notify = new \NativePay();
		$input = new \WxPayUnifiedOrder();
		$input->SetBody("test");
		$input->SetAttach("test");
		$input->SetOut_trade_no(\WxPayConfig::MCHID.date("YmdHis"));
		$input->SetTotal_fee("1");
		$input->SetTime_start(date("YmdHis"));
		$input->SetTime_expire(date("YmdHis", time() + 600));
		$input->SetGoods_tag("test");
		$input->SetNotify_url("http://paysdk.weixin.qq.com/example/notify.php");
		$input->SetTrade_type("NATIVE");
		$input->SetProduct_id("123456789");
		$result = $notify->GetPayUrl($input);
		$url2 = $result["code_url"];
		return $url2;
	}

	public static function my_prepay($order){
		$timezone = "PRC";
		if(function_exists('date_default_timezone_set')){
		   date_default_timezone_set($timezone);
		}

		$notify_url = \Yii::$app->params['notify_url'];
		$notify = new \NativePay();
		$input = new \WxPayUnifiedOrder();
		$input->SetBody("三国战纪充值");
		$input->SetAttach("页面充值");
		$input->SetOut_trade_no($order->order_id);
		$input->SetTotal_fee(100*$order->order_money);
		$input->SetTime_start(date("YmdHis"));
		$input->SetTime_expire(date("YmdHis", time() + 600));
		// $input->SetGoods_tag("test");
		$input->SetNotify_url($notify_url);
		$input->SetTrade_type("NATIVE");
		$input->SetProduct_id($order->channel_product_id);
		$result = $notify->GetPayUrl($input);
		$url = $result["code_url"];
		$prepay_id = $result["prepay_id"];
		$order->prepay_id = $prepay_id;
		$order->save();
		return $url;
	}

	public static function my_wap_prepay($order){
		$timezone = "PRC";
		if(function_exists('date_default_timezone_set')){
		   date_default_timezone_set($timezone);
		}

		$notify_url = \Yii::$app->params['notify_url'];
		

		$notify = new \NativePay();
		$input = new \WxPayUnifiedOrder();
		$input->SetBody("三国战纪充值");
		$input->SetAttach("页面充值");
		$input->SetOut_trade_no($order->order_id);
		$input->SetTotal_fee(100*$order->order_money);
		$input->SetTime_start(date("YmdHis"));
		$input->SetTime_expire(date("YmdHis", time() + 600));
		// $input->SetGoods_tag("test");
		$input->SetNotify_url($notify_url);
		$input->SetTrade_type("MWEB");
		$input->SetProduct_id($order->channel_product_id);
		$result = \WxPayApi::unifiedOrder($input);
		// $result = $notify->GetPayUrl($input);
		// var_dump($result);die;

		$prepay_id = $result["prepay_id"];
		$order->prepay_id = $prepay_id;
		$order->save();
		$redirect_url = \Yii::$app->params['redirect_url']."?out_trade_no_wx=".$order->order_id."&total_amount=".$order->order_money;
		$url = $result["mweb_url"].'&redirect_url='.urlencode($redirect_url);
		return $url;
	}
}


?>
