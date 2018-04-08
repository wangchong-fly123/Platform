<?php
use yii\helpers\Url;
use yii\widgets\LinkPager;

$this->title = '三国';
foreach ($articles as $model) {
    echo $model->title;
}
echo LinkPager::widget([
    'pagination' => $pagination,
]);
?>
<!--<div class="container vertical-align-parent">
    <div class="col-md-12 vertical-align-child text-center">
        <h1>Welcome to <a href="http://easyiicms.com" target="_blank">EasyiiCMS</a> start page</h1>
        <?php if(!Yii::$app->getModule('admin')->installed) : ?>
            <a class="circle" href="<?= Url::base() . '/requirements.php' ?>">
                <i class="glyphicon glyphicon-list-alt"></i>
                <br>
                Requirements
            </a>
            <a class="circle" href="<?= Url::to(['/admin/install']) ?>">
                <i class="glyphicon glyphicon-save"></i>
                <br>
                Install EasyiiCMS
            </a>
        <?php else : ?>
            <a class="circle" href="<?= Url::to(['/admin/']) ?>">
                <i class="glyphicon glyphicon-wrench"></i>
                <br>
                Control Panel
            </a>
        <?php endif; ?>
        <a class="circle" href="http://easyiicms.com/docs" target="_blank">
            <i class="glyphicon glyphicon-book"></i>
            <br>
            Documentation
        </a>
        <a class="circle" href="http://easyiicms.com/demo" target="_blank">
            <i class="glyphicon glyphicon-globe"></i>
            <br>
            Demo website
        </a>
    </div>
</div>-->

        <!--footer-->
        <!-- <div class="footer">
            <div class="footer-info" style="font-style: normal;font-size: 12px;color:#888;">
                <p>电话： 021-5135 7781  传真：021-5135 7781 </p>
                <p>地址：中国·上海浦东新区博霞路22号</p>
                <p>健康游戏忠告：抵制不良游戏 拒绝盗版游戏 注意自我保护 谨防受骗上当</p>
                <p style="margin-left: 7em">适度游戏益脑 沉迷游戏伤身 合理安排时间 享受健康生活</p>
                <p>▍适龄提示： 游戏适合18岁（含）以上玩家娱乐   <a href="<?=Url::toRoute(['site/jzjh'])?>" style="color:red;">家长监护</a></p>
                <p>Copyright ©2017 上海魔克信息科技有限公司 沪ICP备15034776 沪网文(2016)3920-290号</p>
            </div>
            <div class="content-footer clearfix">
                <div class="qr-code-wrap pull-left">
                    <div class="qr-code-box">
                        <p>官方微信号：</p>
                        <img src="/images/qr-code1.jpg" alt="">
                    </div>
                    <div class="qr-code-box">
                        <p>官方微博：</p>
                        <img src="/images/qr-code2.jpg" alt="">
                    </div>
                </div>
                <div class="contact-box pull-right">
                    
                    <div class="contact qq">
                        <span class="icon"></span>
                        <div>
                             客服QQ群号：<span>677593285</span>
                        </div>
                    </div>
                </div>
            </div>
        </div> -->
