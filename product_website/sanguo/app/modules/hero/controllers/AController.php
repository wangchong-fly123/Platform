<?php
namespace app\modules\hero\controllers;

use yii\easyii\components\CategoryController;

class AController extends CategoryController
{
    /** @var string  */
    public $categoryClass = 'app\modules\hero\models\Category';

    /** @var string  */
    public $moduleName = 'hero';
}