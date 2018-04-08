<?php

namespace app\controllers;

use Yii;
use yii\web\Controller;
use yii\data\Pagination;
use app\models\Article;
use yii\easyii\modules\gallery\api\Gallery;
use app\models\Hero;
use app\models\Order;
use app\models\Wxpay;
use app\models\PayNotifyCallBack;

class SiteController extends Controller
{
    public function actions()
    {
        return [
            'error' => [
                'class' => 'yii\web\ErrorAction',
            ],
        ];
    }

    public function actionIndex()
    {
        $all_guide      = Article::find()->where(['status' => 1,'category_id'=>[11,12]])->limit(6)->orderBy('time desc')->all();
        $new_guide      = Article::find()->where(['status' => 1,'category_id'=>11])->limit(6)->orderBy('time desc')->all();
        $wanfa_guide    = Article::find()->where(['status' => 1,'category_id'=>12])->limit(6)->orderBy('time desc')->all();
        $hero_intro     = Gallery::last( $limit = 3, $where = ['item_id'=>2] );
        $special        = Gallery::last( $limit = 3, $where = ['item_id'=>3] );
        $heros          = Hero::find()->where(['status' => 1])->limit(2)->orderBy('time desc')->all();

        $all_article    = Article::find()->where(['status' => 1,'category_id'=>[3,4,5]])->limit(4)->orderBy('time desc')->all();
        $news           = Article::find()->where(['status' => 1,'category_id'=>5])->limit(4)->orderBy('time desc')->all();
        $board          = Article::find()->where(['status' => 1,'category_id'=>4])->limit(4)->orderBy('time desc')->all();
        $campaign       = Article::find()->where(['status' => 1,'category_id'=>3])->limit(4)->orderBy('time desc')->all();

        $three_pic      = Article::find()->where(['status' => 1,'category_id'=>13])->limit(3)->orderBy('time desc')->all();

        $all_video      = Article::find()->where(['status' => 1,'category_id'=>[15,16]])->limit(4)->orderBy('time desc')->all();
        $new_video      = Article::find()->where(['status' => 1,'category_id'=>15])->limit(4)->orderBy('time desc')->all();
        $play_video      = Article::find()->where(['status' => 1,'category_id'=>16])->limit(4)->orderBy('time desc')->all();
        foreach ($all_video as $key => $value) {
            preg_match("/src=\'(.*?)\'/is", $value->short, $matches);
            $value->text = $matches[1];
        }
        foreach ($new_video as $key => $value) {
            preg_match("/src=\'(.*?)\'/is", $value->short, $matches);
            $value->text = $matches[1];
        }
        foreach ($play_video as $key => $value) {
            preg_match("/src=\'(.*?)\'/is", $value->short, $matches);
            $value->text = $matches[1];
        }
        // // 创建一个 DB 查询来获得所有 status 为 1 的文章
        // $query = Article::find()->where(['status' => 1]);

        // // 得到文章的总数（但是还没有从数据库取数据）
        // $count = $query->count();

        // // 使用总数来创建一个分页对象
        // $pagination = new Pagination(['totalCount' => $count]);
        // $pagination->setPageSize(3);
        // // 使用分页对象来填充 limit 子句并取得文章数据
        // $articles = $query->offset($pagination->offset)
        //     ->limit($pagination->limit)
        //     ->all();

        return $this->render('index',[
            'all_guide'     =>  $all_guide,
            'new_guide'     =>  $new_guide,
            'wanfa_guide'   =>  $wanfa_guide,
            'hero_intro'    =>  $hero_intro,
            'special'       =>  $special,
            'heros'         =>  $heros,
            'all_article'   =>  $all_article,
            'news'          =>  $news,
            'board'         =>  $board,
            'campaign'      =>  $campaign,
            'three_pic'     =>  $three_pic,
            'all_video'     =>  $all_video,
            'new_video'     =>  $new_video,
            'play_video'    =>  $play_video,
            // 'pagination'    =>  $pagination,
        ]);
    }

    public function actionArticle($id){
        $article        = Article::findOne($id);
        $three_pic      = Article::find()->where(['status' => 1,'category_id'=>17])->limit(3)->orderBy('time desc')->all();
        return $this->render('article',[
            'three_pic'     =>  $three_pic,
            'article'       =>  $article,
        ]);
    }

    public function actionHero($id=null){
        if(!$id){
            $hero        = Hero::findOne(['status'=>1]);
        }else{
            $hero        = Hero::findOne($id);
        }
        if(!$hero){
            $hero        = Hero::findOne(['status'=>1]);
        }
        $all_hero       = Hero::find()->where(['status' => 1])->orderBy('time desc')->all();
        $three_pic      = Article::find()->where(['status' => 1,'category_id'=>17])->limit(3)->orderBy('time desc')->all();
        return $this->render('hero_info',[
            'three_pic'  =>  $three_pic,
            'hero'       =>  $hero,
            'all_hero'   =>  $all_hero,
        ]);
    }

    public function actionAliprepay(){
        $amount         = $_REQUEST['amount'];
        $guid           = $_REQUEST['guid'];
        $serverid       = $_REQUEST['serverid'];
        $platform = $_REQUEST['platform'];
        $product_array  = array(
            25=>1,
            6=>2,
            30=>3,
            60=>4,
            98=>5,
            168=>6,
            328=>7,
            648=>8,
        );
        $productid = $product_array[$amount];
        if(!$productid){
            return;
        }
        $url = "http://sdkcenter.enjoymi.com:8001/web/thirdpay/getOrderId/";
        $post_data = array(
            'Amount'=>$amount,
            'GameUserId'=>$guid,
            'ServerId'=>$serverid,
            'ProductId'=>$productid,
            'ProductName'=>$amount,
            'UserId'=>Yii::$app->session['uid'],
            'AppKey'=>Yii::$app->params['appkey'],
            'AppSecrect'=>Yii::$app->params['appsecret'],
            'PluginId'=>618,
            'Ext'=>$platform,
        );
        $sign = $this->generate_sign($post_data);
        $post_data['Sign'] = $sign;

        $defined_vars = get_defined_vars();
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL,$url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $post_data);
        $result = curl_exec ($ch);
        $result = json_decode($result,true);
        curl_close($ch);
        if($result['status']==0){
            $order                      = new Order();
            $order->order_id            = $result['data']['order_id'];
            $order->order_name          = $result['data']['order_name'];
            $order->order_time          = $result['data']['order_time'];
            $order->order_money         = $result['data']['order_money'];
            $order->platform            = $platform;
            $order->guid                = $guid;
            $order->serverid            = $serverid;
            $order->productid           = $productid;
            $order->uid                 = Yii::$app->session['uid'];
            $order->channel_product_id  = $result['data']['channel_product_id'];
            $order->order_expand        = $result['data']['order_expand'];
            $order->time                = date('Y-m-d H:i:s');
            $order->save();
        }

        // $url = Wxpay::my_prepay($order);

        $ret = array(
            'order_id'=>$order->order_id,
        );
        echo json_encode($ret);return;
    }

    public function actionAlipagepay(){
        $order_id         = $_REQUEST['order_id'];
        if(!$order_id){
            return;
        }
        $my_order = Order::findOne(['order_id'=>$order_id]);
        $order_money = $my_order->order_money;


        require_once 'app/utils/wx/example/log.php';
        require_once 'app/utils/alipay/config.php';
        require_once 'app/utils/alipay/pagepay/service/AlipayTradeService.php';
        require_once 'app/utils/alipay/pagepay/buildermodel/AlipayTradePagePayContentBuilder.php';

        //商户订单号，商户网站订单系统中唯一订单号，必填
        $out_trade_no = trim($order_id);

        //订单名称，必填
        $subject = trim('三国战纪页面支付');

        //付款金额，必填
        $total_amount = trim($order_money);

        //商品描述，可空
        $body = trim('');

        //构造参数
        $payRequestBuilder = new \AlipayTradePagePayContentBuilder();
        $payRequestBuilder->setBody($body);
        $payRequestBuilder->setSubject($subject);
        $payRequestBuilder->setTotalAmount($total_amount);
        $payRequestBuilder->setOutTradeNo($out_trade_no);

        $aop = new \AlipayTradeService($config);

        /**
         * pagePay 电脑网站支付请求
         * @param $builder 业务参数，使用buildmodel中的对象生成。
         * @param $return_url 同步跳转地址，公网可以访问
         * @param $notify_url 异步通知地址，公网可以访问
         * @return $response 支付宝返回的信息
        */
        $response = $aop->pagePay($payRequestBuilder,$config['return_url'],$config['notify_url']);

        // $url = Wxpay::my_prepay($order);

        // $ret = array(
        //     'url'=>$url,
        //     'order_id'=>$order->order_id,
        // );
        // echo json_encode($ret);return;

        //输出表单
        var_dump($response);
    }

    private function generate_sign($params){
        $secret_key = Yii::$app->params['create_order_secret'];
        ksort($params);
        $str = '';
        foreach ($params as $key => $value) {
            $str .= ($key.'='.$value);
        }
        return md5($str.$secret_key);
    }

    private function generate_notice_sign($params){
        $secret_key = Yii::$app->params['pay_result_secret'];
        ksort($params);
        $str = '';
        foreach ($params as $key => $value) {
            $str .= ($key.'='.$value);
        }
        return md5($str.$secret_key);
    }

    public function actionTestqrcode(){
        require_once 'app/utils/wx/example/phpqrcode/phpqrcode.php';
        $url = urldecode($_GET["data"]);
        \QRcode::png($url);
        die;
    }

    public function actionTestpay(){
        $url = Wxpay::get_qrcode();
        var_dump($url);
    }

    public function init()
    {
        $this->enableCsrfValidation = false;
    }

    public function actionAlinotify(){
        require_once 'app/utils/alipay/config.php';
        require_once 'app/utils/alipay/pagepay/service/AlipayTradeService.php';

        $arr=$_POST;
        $alipaySevice = new \AlipayTradeService($config); 
        $alipaySevice->writeLog(var_export($_POST,true));
        $result = $alipaySevice->check($arr);

        /* 实际验证过程建议商户添加以下校验。
        1、商户需要验证该通知数据中的out_trade_no是否为商户系统中创建的订单号，
        2、判断total_amount是否确实为该订单的实际金额（即商户订单创建时的金额），
        3、校验通知中的seller_id（或者seller_email) 是否为out_trade_no这笔单据的对应的操作方（有的时候，一个商户可能有多个seller_id/seller_email）
        4、验证app_id是否为该商户本身。
        */
        if($result) {//验证成功
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //请在这里加上商户的业务逻辑程序代

            
            //——请根据您的业务逻辑来编写程序（以下代码仅作参考）——
            
            //获取支付宝的通知返回参数，可参考技术文档中服务器异步通知参数列表
            
            //商户订单号

            $out_trade_no = $_POST['out_trade_no'];

            //支付宝交易号

            $trade_no = $_POST['trade_no'];

            //交易状态
            $trade_status = $_POST['trade_status'];


            if($_POST['trade_status'] == 'TRADE_FINISHED') {

                //判断该笔订单是否在商户网站中已经做过处理
                    //如果没有做过处理，根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序
                    //请务必判断请求时的total_amount与通知时获取的total_fee为一致的
                    //如果有做过处理，不执行商户的业务程序
                        
                //注意：
                //退款日期超过可退款期限后（如三个月可退款），支付宝系统发送该交易状态通知
            }
            else if ($_POST['trade_status'] == 'TRADE_SUCCESS') {
                //判断该笔订单是否在商户网站中已经做过处理
                    //如果没有做过处理，根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序
                    //请务必判断请求时的total_amount与通知时获取的total_fee为一致的
                    //如果有做过处理，不执行商户的业务程序            
                //注意：
                //付款完成后，支付宝系统发送该交易状态通知
                $my_order_id = $out_trade_no;
                $status = $trade_status;
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
                    'Status'=>$status=='TRADE_SUCCESS'?0:1,
                    'Ext'=>$my_order->platform,
                    'PayTime'=>time(),
                    'ServerId'=>$my_order->serverid,
                );

                $secret_key = Yii::$app->params['pay_result_secret'];
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
            }
            //——请根据您的业务逻辑来编写程序（以上代码仅作参考）——
            echo "success"; //请不要修改或删除
        }else {
            //验证失败
            echo "fail";

        }
        return;
    }

    public function actionNotify(){
        $notify = new PayNotifyCallBack();
        $notify->Handle(false);
        die;
    }

    public function actionPaynotice(){
        $url = "http://sdkcenter.enjoymi.com:8001/v5/ThirdpayPayNotice/payNotice/";
        $post_data = array(
            'Amount'=>1,
            'GameUserId'=>30007000000007,
            'CpOrderId'=>123123,
            'OrderId'=>12312123,
            'ProductId'=>1,
            'UserId'=>Yii::$app->session['uid'],
            'Status'=>1,
            'Ext'=>'abc',
            'PayTime'=>time(),
            'ServerId'=>1,
        );
        $sign = $this->generate_notice_sign($post_data);
        $post_data['Sign'] = $sign;

        $defined_vars = get_defined_vars();
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL,$url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $post_data);
        $result = curl_exec ($ch);var_dump($result);die;
        $result = json_decode($result,true);
        var_dump($result);die;
        if($result['status']==0){
            $order                      = new Order();
            $order->order_id            = $result['data']['order_id'];
            $order->order_name          = $result['data']['order_name'];
            $order->order_time          = $result['data']['order_time'];
            $order->order_money         = $result['data']['order_money'];
            $order->channel_product_id  = $result['data']['channel_product_id'];
            $order->order_expand        = $result['data']['order_expand'];
            $order->time                = date('Y-m-d H:i:s');
            $order->save();
        }
        $url = Wxpay::my_prepay($order);
        //generate qr code
        require_once 'app/utils/wx/example/phpqrcode/phpqrcode.php';
        \QRcode::png($url);
        
        //echo $url;
        curl_close($ch);
    }

    public function actionCheckresult(){
        $order_id = $_REQUEST['order_id'];
        $order = Order::findOne(['order_id'=>$order_id]);
        $ret = array(
            'order_id'=>$order->order_id,
            'status'=>($order->status=='SUCCESS'||$order->status=='TRADE_SUCCESS')?1:0,
            'amount'=>$order->order_money,
        );
        echo json_encode($ret);
    }

    public function actionPayment(){
        $is_wap = $_REQUEST['is_wap'];
        $amount = $_REQUEST['amount'];
        $guid = $_REQUEST['guid'];
        $serverid = $_REQUEST['serverid'];
        $platform = $_REQUEST['platform'];
        $product_array = array(
            25=>1,
            6=>2,
            30=>3,
            60=>4,
            98=>5,
            168=>6,
            328=>7,
            648=>8,
        );
        $productid = $product_array[$amount];
        if(!$productid){
            return;
        }
        $url = "http://sdkcenter.enjoymi.com:8001/web/thirdpay/getOrderId/";
        $post_data = array(
            'Amount'=>$amount,
            'GameUserId'=>$guid,
            'ServerId'=>$serverid,
            'ProductId'=>$productid,
            'ProductName'=>$amount,
            'UserId'=>Yii::$app->session['uid'],
            'AppKey'=>Yii::$app->params['appkey'],
            'AppSecrect'=>Yii::$app->params['appsecret'],
            'PluginId'=>618,
            'Ext'=>$platform,
        );
        $sign = $this->generate_sign($post_data);
        $post_data['Sign'] = $sign;

        $defined_vars = get_defined_vars();
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL,$url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $post_data);
        $result = curl_exec ($ch);
        $result = json_decode($result,true);
        curl_close($ch);
        if($result['status']==0){
            $order                      = new Order();
            $order->order_id            = $result['data']['order_id'];
            $order->order_name          = $result['data']['order_name'];
            $order->order_time          = $result['data']['order_time'];
            $order->order_money         = $result['data']['order_money'];
            $order->platform            = $platform;
            $order->guid                = $guid;
            $order->serverid            = $serverid;
            $order->productid           = $productid;
            $order->uid                 = Yii::$app->session['uid'];
            $order->channel_product_id  = $result['data']['channel_product_id'];
            $order->order_expand        = $result['data']['order_expand'];
            $order->time                = date('Y-m-d H:i:s');
            $order->save();
        }
        if($is_wap){
            $url = Wxpay::my_wap_prepay($order);
        }else{
            $url = Wxpay::my_prepay($order);
        }
        

        $ret = array(
            'url'=>$url,
            'order_id'=>$order->order_id,
        );
        echo json_encode($ret);return;
        //generate qr code
        
    }

    public function actionQr(){
        $url = $_REQUEST['url'];
        require_once 'app/utils/wx/example/phpqrcode/phpqrcode.php';
        \QRcode::png($url);
        
        //echo $url;
        
        die;
    }

    public function actionRecharge(){
        $ali = array();
        if(isset($_GET['out_trade_no'])){
            require_once("app/utils/alipay/config.php");
            require_once 'app/utils/alipay/pagepay/service/AlipayTradeService.php';
            require_once 'app/utils/alipay/pagepay/buildermodel/AlipayTradeQueryContentBuilder.php';


            $arr=$_GET;
            $alipaySevice = new \AlipayTradeService($config); 
            $result = $alipaySevice->check($arr);

            /* 实际验证过程建议商户添加以下校验。
            1、商户需要验证该通知数据中的out_trade_no是否为商户系统中创建的订单号，
            2、判断total_amount是否确实为该订单的实际金额（即商户订单创建时的金额），
            3、校验通知中的seller_id（或者seller_email) 是否为out_trade_no这笔单据的对应的操作方（有的时候，一个商户可能有多个seller_id/seller_email）
            4、验证app_id是否为该商户本身。
            */
            if($result) {//验证成功
                /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                //请在这里加上商户的业务逻辑程序代码
                
                //——请根据您的业务逻辑来编写程序（以下代码仅作参考）——
                //获取支付宝的通知返回参数，可参考技术文档中页面跳转同步通知参数列表

                //商户订单号
                $out_trade_no = htmlspecialchars($_GET['out_trade_no']);

                //支付宝交易号
                $trade_no = htmlspecialchars($_GET['trade_no']);
                   
                $ali['order_id'] =  $out_trade_no;


                //构造参数
                $RequestBuilder = new \AlipayTradeQueryContentBuilder();
                $RequestBuilder->setOutTradeNo($out_trade_no);
                $RequestBuilder->setTradeNo($trade_no);

                $aop = new \AlipayTradeService($config);
                
                /**
                 * alipay.trade.query (统一收单线下交易查询)
                 * @param $builder 业务参数，使用buildmodel中的对象生成。
                 * @return $response 支付宝返回的信息
                 */
                $response = $aop->Query($RequestBuilder);
                


                $ali['status'] = $response->trade_status;
                $ali['total_amount'] = $_GET['total_amount'];
                //——请根据您的业务逻辑来编写程序（以上代码仅作参考）——
                
                /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            }else{
                $ali['order_id'] =  $_GET['out_trade_no'];
                $ali['status'] = 'fail';
                $ali['total_amount'] = $_GET['total_amount'];
            }
        }

        if(!Yii::$app->session['login_user']){
            $this->redirect(array('site/accountcenter'));
            return;
        }
        // $url = "http://external.enjoymi.com:9010/server_list.php?platform=test_web_pay";
        
        // $ch = curl_init();
        // curl_setopt($ch, CURLOPT_URL,$url);
        // curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        // $result = curl_exec ($ch);
        // curl_close($ch);
        // $server_list = json_decode($result, true);
        $platform_list = Yii::$app->params['platform_list'];
        $three_pic      = Article::find()->where(['status' => 1,'category_id'=>17])->limit(3)->orderBy('time desc')->all();
        return $this->render('recharge',[
            'platform_list'=> $platform_list,
            'ali'=>$ali,
            'server_list' => $server_list['zoneinfo'],
            'three_pic'     =>  $three_pic,
        ]);
    }

    public function actionGetserver(){
        $platform_id = $_REQUEST['platform_id'];

        $url = "http://external.enjoymi.com:9010/server_list.php?platform=$platform_id";
        
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL,$url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        $result = curl_exec ($ch);
        curl_close($ch);
        $server_list = json_decode($result, true);
        $str = '';
        if($server_list['zoneinfo']){
            foreach ($server_list['zoneinfo'] as $key => $value) {
                $str .= ('<option value="'.($value['status']==1?$value['zone']:-$value['zone']).'">'.$value['name'].'</option>');
            }
        }else{
            $str .='<option value="0">----------------</option>';
        }
        
        $ret = array();
        $ret['str'] = $str;
        echo json_encode($ret);
    }

    public function actionGetgamechar(){
        $zone_id = $_REQUEST['zone_id'];
        $uid     = Yii::$app->session['uid'];
        $platform = $_REQUEST['platform'];
// $uid = 100996177;
        $url = "http://external.enjoymi.com:9010/player_list.php?platform=$platform&server_id=$zone_id&uid=$uid";
        
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL,$url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        $result = curl_exec ($ch);
        curl_close($ch);
        $player_list = json_decode($result, true);
        if(isset($player_list['role_list']['error_code'])&&$player_list['role_list']['error_code']!==0){
            echo json_encode($player_list);
        }else{
            $player_list['gamechar'] = '';
            if($player_list['role_list']){
                foreach ($player_list['role_list'] as $key => $value) {
                    $player_list['gamechar'] .= '<option value="'.$value['player_id'].'">'.$value['nickname'].'</option>';
                }
            }else{
                $player_list['gamechar'] .= '<option value="0">----------------</option>';
            }
            echo json_encode($player_list);            
        }
        
    }

    public function actionList(){
        $currentType = $_REQUEST['type']?$_REQUEST['type']:1;
        $currentPage = isset($_REQUEST['page'])?$_REQUEST['page']:1;
        // 创建一个 DB 查询来获得所有 status 为 1 的文章
        switch ($currentType) {
            case '1':
                $query = Article::find()->where(['status' => 1,'category_id' => [5,11,12,4,3]])->orderBy('time desc');
                break;
            case '2':
                $query = Article::find()->where(['status' => 1,'category_id' => 5])->orderBy('time desc');
                break;
            case '3':
                $query = Article::find()->where(['status' => 1,'category_id' => 4])->orderBy('time desc');
                break;
            case '4':
                $query = Article::find()->where(['status' => 1,'category_id' => 3])->orderBy('time desc');
                break;
            case '5':
                $query = Article::find()->where(['status' => 1,'category_id' => [11,12]])->orderBy('time desc');
                break;
            default:
                $query = Article::find()->where(['status' => 1,'category_id' => [5,11,12,4,3]])->orderBy('time desc');
                break;
        }
        

        // 得到文章的总数（但是还没有从数据库取数据）
        $count = $query->count();
        

        // 使用总数来创建一个分页对象
        $pagination = new Pagination(['totalCount' => $count]);
        $pagination->setPageSize(6);
        $pageCount = ceil($count/6);
        // 使用分页对象来填充 limit 子句并取得文章数据
        $articles = $query->offset($pagination->offset)
            ->limit($pagination->limit)
            ->all();
        $three_pic      = Article::find()->where(['status' => 1,'category_id'=>17])->limit(3)->orderBy('time desc')->all();
        
        return $this->render('article_list',[
            'three_pic'     =>  $three_pic,
            'articles'      =>  $articles,
            'pagination'    =>  $pagination,
            'currentPage'   =>  $currentPage,
            'pageCount'     =>  $pageCount,
            'currentType'   =>  $currentType,
        ]);
    }

    public function actionAccountcenter(){
        $login          = Yii::$app->session['login_user'];
        $action         = isset($_REQUEST['action'])?$_REQUEST['action']:'login';
        $three_pic      = Article::find()->where(['status' => 1,'category_id'=>17])->limit(3)->orderBy('time desc')->all();
        $account_name = '';
        $account_phone = '';
        if($action=='find_password'){
            $account = $_REQUEST['account'];
            $res = $this->getFindpassword($account);
            $res = json_decode($res,true);
            $account_name = $res['result']['account'];
            $account_phone = $res['result']['mobile_phone'];
            $account_phone = substr($account_phone, 0,3).'***'.substr($account_phone, 6);
        }
        return $this->render('account_center',[
            'three_pic' =>  $three_pic,
            'action'    =>  $action,
            'login'     =>  $login,
            'account_name' => $account_name,
            'account_phone' => $account_phone,
        ]);
    }

    public function actionGetcaptcha(){
        header('Content-Type:image/png');
        $url = "http://passport.enjoymi.com/v2/get_captcha.php";
        $post_data = array();
        $defined_vars = get_defined_vars();
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL,$url);
        curl_setopt($ch,CURLOPT_HEADER,1);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $post_data);
        $content = curl_exec ($ch);
        $headerSize = curl_getinfo($ch, CURLINFO_HEADER_SIZE);
        $header = substr($content, 0, $headerSize);
        $body = substr($content, $headerSize);

        preg_match('/Set-Cookie:(.*);/iU',$content,$str); //正则匹配
        $cookie=$str[1];
        curl_close($ch);
        Yii::$app->session->open();
        Yii::$app->session['cf']=$cookie;
        echo $body;
        exit();
    }

    public function actionSendcode($phone_number,$captcha_text){
        $url = "http://passport.enjoymi.com/v2/get_message_code.php";
        $post_data = array(
            'captcha_text'=>$captcha_text,
            'mobile_phone'=>$phone_number,
        );
        $defined_vars = get_defined_vars();
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL,$url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $post_data);
        curl_setopt($ch, CURLOPT_COOKIE, Yii::$app->session['cf']);
        $result = curl_exec ($ch);
        echo $result;
        curl_close($ch);
    }

    public function actionSendresetcode($account,$captcha_text){
        $res = $this->getFindpassword($account);
        $res = json_decode($res,true);
        $account_phone = $res['result']['mobile_phone'];


        $url = "http://passport.enjoymi.com/v2/get_reset_message_code.php";
        $post_data = array(
            'captcha_text'=>$captcha_text,
            'mobile_phone'=>$account_phone,
        );
        $defined_vars = get_defined_vars();
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL,$url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $post_data);
        curl_setopt($ch, CURLOPT_COOKIE, Yii::$app->session['cf']);
        $result = curl_exec ($ch);
        echo $result;
        curl_close($ch);
    }

    public function actionResetpassword($account,$password,$message_code){        

        $res = $this->getFindpassword($account);
        $res = json_decode($res,true);
        $account_phone = $res['result']['mobile_phone'];


        $now=time();
        $password=sha1($password);
        $str ="passport.enjoymi.com/v2/reset_password.phpmessage_code=$message_code"."mobile_phone=$account_phone"."password=$password"."ts=$now".'08bf3a057ed1cc89a6e73e3ef880f0de4cf8eb363865e71f4f29c88deade9578';
        // echo $str;
        $sign=sha1($str);


        $url = "http://passport.enjoymi.com/v2/reset_password.php";
        $post_data = array(
            'mobile_phone'=>$account_phone,
            'password'=>$password,
            'message_code'=>$message_code,
            'ts'=>$now,
            'sign'=>$sign,
        );
        $defined_vars = get_defined_vars();
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL,$url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($post_data));
        curl_setopt($ch, CURLOPT_COOKIE, Yii::$app->session['cf']);
        // curl_setopt($ch, CURLOPT_COOKIE, Yii::$app->session['cf']);
        $result = curl_exec ($ch);
        $result = json_decode($result,true);
        if($result['result']['error_code']==0){
            //Yii::$app->session['login_user'] = 1;
            //$result['result']['gift_code'] = UserAccount::getGiftCode($phone_number);
        }
        echo json_encode($result);
        curl_close($ch);

    }

    public function actionReg($phone_number,$password,$message_code){        
        $now=time();
        $password=sha1($password);
        $str ="passport.enjoymi.com/v2/mobile_register.phpmessage_code=$message_code"."mobile_phone=$phone_number"."password=$password"."ts=$now".'08bf3a057ed1cc89a6e73e3ef880f0de4cf8eb363865e71f4f29c88deade9578';
        // echo $str;
        $sign=sha1($str);


        $url = "http://passport.enjoymi.com/v2/mobile_register.php";
        $post_data = array(
            'mobile_phone'=>$phone_number,
            'password'=>$password,
            'message_code'=>$message_code,
            'ts'=>$now,
            'sign'=>$sign,
        );
        $defined_vars = get_defined_vars();
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL,$url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($post_data));
        curl_setopt($ch, CURLOPT_COOKIE, Yii::$app->session['cf']);
        // curl_setopt($ch, CURLOPT_COOKIE, Yii::$app->session['cf']);
        $result = curl_exec ($ch);
        $result = json_decode($result,true);
        if($result['result']['error_code']==0){
            //Yii::$app->session['login_user'] = 1;
            //$result['result']['gift_code'] = UserAccount::getGiftCode($phone_number);
        }
        echo json_encode($result);
        curl_close($ch);

    }

    public function actionLogin($account,$password)
    {
        $now=time();
        $password=sha1($password);
        $str ="passport.enjoymi.com/v2/login.phpaccount=$account"."password=$password"."ts=$now".'08bf3a057ed1cc89a6e73e3ef880f0de4cf8eb363865e71f4f29c88deade9578';
        // echo $str;
        $sign=sha1($str);


        $url = "http://passport.enjoymi.com/v2/login.php";
        $post_data = array(
            'account'=>$account,
            'password'=>$password,
            'ts'=>$now,
            'sign'=>$sign,
        );
        $defined_vars = get_defined_vars();
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL,$url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($post_data));
        curl_setopt($ch, CURLOPT_COOKIE, Yii::$app->session['cf']);
        // curl_setopt($ch, CURLOPT_COOKIE, Yii::$app->session['cf']);
        $result = curl_exec ($ch);
        $result = json_decode($result,true);
        if($result['result']['error_code']==0){
            Yii::$app->session['login_user'] = $this->getAccountname($account);
            Yii::$app->session['uid'] = $result['result']['uid'];
            //$result['result']['gift_code'] = UserAccount::getGiftCode($account);
        }
        echo json_encode($result);
        curl_close($ch);
    }

    public function getFindpassword($account){
        $now=time();
        $password=sha1($password);
        $str ="passport.enjoymi.com/v2/get_account_brief_info.phpaccount=$account"."ts=$now".'08bf3a057ed1cc89a6e73e3ef880f0de4cf8eb363865e71f4f29c88deade9578';
        // echo $str;
        $sign=sha1($str);


        $url = "http://passport.enjoymi.com/v2/get_account_brief_info.php";
        $post_data = array(
            'account'=>$account,
            'ts'=>$now,
            'sign'=>$sign,
        );
        $defined_vars = get_defined_vars();
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL,$url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($post_data));
        curl_setopt($ch, CURLOPT_COOKIE, Yii::$app->session['cf']);
        // curl_setopt($ch, CURLOPT_COOKIE, Yii::$app->session['cf']);
        $result = curl_exec ($ch);
        $result = json_decode($result,true);
        if($result['result']['error_code']==0){
            //Yii::$app->session['login_user'] = 1;
            //$result['result']['gift_code'] = UserAccount::getGiftCode($account);
        }
        curl_close($ch);
        return json_encode($result);
        
    }

    public function getAccountname($account){
        $res = $this->getFindpassword($account);
        $res = json_decode($res,true);
        $account_name = $res['result']['account'];
        return $account_name;
    }

    public function actionFindpassword($account)
    {
        echo $this->getFindpassword($account);
    }

    public function actionLogout(){
        Yii::$app->session['login_user'] = 0;
        $result['result']['error_code'] = 0;
        echo json_encode($result);
    }
    public function actionJzjh()
    {
        $three_pic      = Article::find()->where(['status' => 1,'category_id'=>17])->limit(3)->orderBy('time desc')->all();
        return $this->render('jzjh',[
            'three_pic'     =>  $three_pic,
        ]);
    }
      public function actionJzjh1()
    {
        $three_pic      = Article::find()->where(['status' => 1,'category_id'=>17])->limit(3)->orderBy('time desc')->all();
        return $this->render('jzjh1',[
            'three_pic'     =>  $three_pic,
        ]);
    }
      public function actionJzjh2()
    {
        $three_pic      = Article::find()->where(['status' => 1,'category_id'=>17])->limit(3)->orderBy('time desc')->all();
        return $this->render('jzjh2',[
            'three_pic'     =>  $three_pic,
        ]);
    }
    public function actionYh()
        {
            return $this->render('yh',[
            ]);
        }
    public function actionKef()
    {
        $three_pic      = Article::find()->where(['status' => 1,'category_id'=>17])->limit(3)->orderBy('time desc')->all();
        return $this->render('kef',[
            'three_pic'     =>  $three_pic,
        ]);
    }
}
