<?php
namespace app\models;
require_once "app/models/Order.php";
// use yii\db\ActiveRecord;
require_once "app/utils/wx/example/../lib/WxPay.Api.php";
require_once "app/utils/wx/example/WxPay.NativePay.php";
require_once 'app/utils/wx/example/log.php';

require_once 'app/utils/wx/lib/WxPay.Notify.php';
$logHandler= new \CLogFileHandler("app/utils/wx/logs/".date('Y-m-d').'.log');
$log = \Log::Init($logHandler, 15);
class PayNotifyCallBack extends \WxPayNotify
{
	//查询订单
	public function Queryorder($transaction_id)
	{
		
		$input = new \WxPayOrderQuery();
		$input->SetTransaction_id($transaction_id);
		$result = \WxPayApi::orderQuery($input);
		\Log::DEBUG("query:" . json_encode($result));
		if(array_key_exists("return_code", $result)
			&& array_key_exists("result_code", $result)
			&& $result["return_code"] == "SUCCESS"
			&& $result["result_code"] == "SUCCESS")
		{
			return true;
		}
		return false;
	}
	
	//重写回调处理函数
	public function NotifyProcess($data, &$msg)
	{
		\Log::DEBUG("call back:" . json_encode($data));
		$notfiyOutput = array();
		
		if(!array_key_exists("transaction_id", $data)){
			$msg = "输入参数不正确";
			return false;
		}
		//查询订单，判断订单真实性
		if(!$this->Queryorder($data["transaction_id"])){
			$msg = "订单查询失败";
			return false;
		}
		require_once "app/models/Order.php";
		$my_order_id = $data['out_trade_no'];
		$status = $data['result_code'];
		$my_order = Order::findOne(['order_id'=>$my_order_id]);
		$my_order->status = $status;
		$my_order->save();

		$url = "http://sdkcenter.enjoymi.com:8001/v5/ThirdpayPayNotice/payNotice/";
        $post_data = array(
            'Amount'=>$my_order->order_money,
            'GameUserId'=>$my_order->guid,
            'CpOrderId'=>$my_order->order_id,
            'OrderId'=>$my_order->prepay_id,
            'ProductId'=>$my_order->productid,
            'UserId'=>$my_order->uid,
            'Status'=>$status=='SUCCESS'?0:1,
            'Ext'=>$my_order->platform,
            'PayTime'=>time(),
            'ServerId'=>$my_order->serverid,
        );

        $secret_key = \Yii::$app->params['pay_result_secret'];
        ksort($post_data);
        $str = '';
        foreach ($post_data as $key => $value) {
            $str .= ($key.'='.$value);
        }
        $post_data['Sign'] = md5($str.$secret_key);

        

        $defined_vars = get_defined_vars();
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL,$url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $post_data);
        $result = curl_exec ($ch);
        \Log::DEBUG("call back:" . $result);
        $result = json_decode($result,true);
        


		return true;
	}
}

?>
