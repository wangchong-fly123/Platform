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

class MobileController extends Controller
{
    public $layout = "mobile";
	
	public function init()
    {
        $this->enableCsrfValidation = false;
    }
	
    public function actions()
    {
        return [
            'error' => [
                'class' => 'yii\web\ErrorAction',
            ],
        ];
    }

    public function actionCover(){
        return $this->render('cover',[
        ]);
    }

    public function actionArticle($id){
        $article        = Article::findOne($id);
        return $this->render('article',[
            'article'       =>  $article,
        ]);
    }

    public function actionHerolist(){
        $all_hero       = Hero::find()->where(['status' => 1])->orderBy('time desc')->all();
        return $this->render('hero_list',[
            'all_hero'   =>  $all_hero,
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
        return $this->render('hero',[
            'item_id'    =>  $id,
            'hero'       =>  $hero,
            'all_hero'   =>  $all_hero,
        ]);
    }

    public function actionIntro(){
        $this->layout = "intro";
        return $this->render('intro',[
            
        ]);
    }

    public function actionAlinotify(){
        
        require_once 'app/utils/alipay/wappay/service/AlipayTradeService.php';
		require_once 'app/utils/alipay/config_wap.php';

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

    public function actionAliwappay(){
        $order_id         = $_REQUEST['order_id'];
        if(!$order_id){
            return;
        }
        $my_order = Order::findOne(['order_id'=>$order_id]);
        $order_money = $my_order->order_money;


        require_once 'app/utils/wx/example/log.php';
        require_once 'app/utils/alipay/wappay/service/AlipayTradeService.php';
        require_once 'app/utils/alipay/wappay/buildermodel/AlipayTradeWapPayContentBuilder.php';
        require_once 'app/utils/alipay/pagepay/buildermodel/AlipayTradePagePayContentBuilder.php';
        require_once 'app/utils/alipay/config_wap.php';



        //商户订单号，商户网站订单系统中唯一订单号，必填
        $out_trade_no = trim($order_id);

        //订单名称，必填
        $subject = trim('三国战纪页面支付');

        //付款金额，必填
        $total_amount = trim($order_money);

        //商品描述，可空
        $body = trim('');
        $timeout_express="1m";
        //构造参数

        $payRequestBuilder = new \AlipayTradeWapPayContentBuilder();
        $payRequestBuilder->setBody($body);
        $payRequestBuilder->setSubject($subject);
        $payRequestBuilder->setOutTradeNo($out_trade_no);
        $payRequestBuilder->setTotalAmount($total_amount);
        $payRequestBuilder->setTimeExpress($timeout_express);

        $payResponse = new \AlipayTradeService($config);
        $result=$payResponse->wapPay($payRequestBuilder,$config['return_url'],$config['notify_url']);

        return ;
    }

    public function autologin($account='',$password=''){
        // $account ='18516280684';
        // $password = '15801832aq';
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
        // var_dump($sign);
        // exit;
        $defined_vars = get_defined_vars();
        // var_dump($defined_vars);
        // exit;
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

    }
    public function getAccountname($account){
        $res = $this->getFindpassword2($account);

        $res = json_decode($res,true);
        $account_name = $res['result']['account'];
        return $account_name;
    }
    public function getFindpassword2($account){
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

    public function actionGetclient(){
        header('Access-Control-Allow-Origin: *');
        header("Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept");
        header('Access-Control-Allow-Methods: GET, POST, PUT');

        // $content=file_get_contents("php://input");
        // var_dump($_GET);
        $content = $_REQUEST;
        // $content=$GLOBALS['HTTP_RAW_POST_DATA'];
        // $jcontent = json_decode($content,TRUE);
        // var_dump($content);
        // exit;
        $account = $content['account'];
        $password = $content['password'];
        //1 登录
        // var_dump($account);
        // var_dump($password);
        // exit;
        $this->autologin($account,$password);
        //2 接收用户信息
        $amount = $content['amount'];
        // var_dump($amount);
        // exit;
        $serverid = $content['serverid'];
        $player_id = $content['guid'];
        $platform = $content['platform'];
        // var_dump($platform);
        // exit;

        return $this->render('showpay',[
            'amount'     =>  $amount,
            'serverid'     =>  $serverid,
            'player_id'     =>  $player_id,
            'platform'     =>  $platform,
        ]);


    }

    public function actionRecharge(){
    //    $this->autologin();








        $ali = array();
        if(isset($_GET['out_trade_no_wx'])){
            $status = Wxpay::query($_GET['out_trade_no_wx']);
            $ali['order_id'] =  $_GET['out_trade_no_wx'];
            $ali['status'] = $status?1:'fail';
            $ali['total_amount'] = $_GET['total_amount'];
        }
        if(isset($_GET['out_trade_no'])){
            require_once("app/utils/alipay/config_wap.php");
            require_once 'app/utils/alipay/wappay/service/AlipayTradeService.php';
            require_once 'app/utils/alipay/wappay/buildermodel/AlipayTradeQueryContentBuilder.php';

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

        if(!Yii::$app->session['login_user']&&!isset($_GET['out_trade_no_wx'])){
            $this->redirect(array('mobile/accountcenter'));
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

        return $this->render('recharge',[
            'platform_list'=> $platform_list,
            'ali'=>$ali,
            // 'server_list' => $server_list['zoneinfo'],
        ]);
    }


    public function actionNewslist(){
        $currentType = $_REQUEST['type']?$_REQUEST['type']:1;
        $currentPage = $_REQUEST['page']?$_REQUEST['page']:1;
        // 创建一个 DB 查询来获得所有 status 为 1 的文章
        switch ($currentType) {
            case '1':
                $query = Article::find()->where(['status' => 1,category_id => [5,11,12,4,3]])->orderBy('time desc');
                break;
            case '2':
                $query = Article::find()->where(['status' => 1,category_id => 5])->orderBy('time desc');
                break;
            case '3':
                $query = Article::find()->where(['status' => 1,category_id => 4])->orderBy('time desc');
                break;
            case '4':
                $query = Article::find()->where(['status' => 1,category_id => 3])->orderBy('time desc');
                break;
            case '5':
                $query = Article::find()->where(['status' => 1,category_id => [11,12]])->orderBy('time desc');
                break;
            default:
                $query = Article::find()->where(['status' => 1,category_id => [5,11,12,4,3]])->orderBy('time desc');
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
        $banner     = Gallery::last( $limit = 5, $where = ['item_id'=>4] );
        return $this->render('article_list',[
            'articles'      =>  $articles,
            'pagination'    =>  $pagination,
            'currentPage'   =>  $currentPage,
            'pageCount'     =>  $pageCount,
            'currentType'   =>  $currentType,
            'banner'        =>  $banner,
        ]);
    }

    public function actionAccountcenter(){
        $login          = Yii::$app->session['login_user'];
        $action         = $_REQUEST['action']?$_REQUEST['action']:'login';
        //$three_pic      = Article::find()->where(['status' => 1,'category_id'=>13])->limit(3)->orderBy('time desc')->all();
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
            //'three_pic' =>  $three_pic,
            'action'    =>  $action,
            'login'     =>  $login,
            'account_name' => $account_name,
            'account_phone' => $account_phone,
        ]);
    }

    public function getFindpassword($account){
        $now=time();
        $password=sha1($password);
        $str ="passport.enjoymi.com/v2/get_account_info.phpaccount=$account"."ts=$now".'08bf3a057ed1cc89a6e73e3ef880f0de4cf8eb363865e71f4f29c88deade9578';
        // echo $str;
        $sign=sha1($str);


        $url = "http://passport.enjoymi.com/v2/get_account_info.php";
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
}
