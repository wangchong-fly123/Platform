<?php
namespace app\modules\hero\controllers;

use Yii;
use yii\easyii\behaviors\SortableDateController;
use yii\easyii\behaviors\StatusController;
use yii\web\UploadedFile;

use yii\easyii\components\Controller;
use app\modules\hero\models\Category;
use app\modules\hero\models\Item;
use yii\easyii\helpers\Image;
use yii\widgets\ActiveForm;

class ItemsController extends Controller
{
    public function behaviors()
    {
        return [
            [
                'class' => SortableDateController::className(),
                'model' => Item::className(),
            ],
            [
            'class' => StatusController::className(),
            'model' => Item::className()
            ]
        ];
    }

    public function actionIndex($id)
    {
        if(!($model = Category::findOne($id))){
            return $this->redirect(['/admin/'.$this->module->id]);
        }

        return $this->render('index', [
            'model' => $model
        ]);
    }


    public function actionCreate($id)
    {
        if(!($category = Category::findOne($id))){
            return $this->redirect(['/admin/'.$this->module->id]);
        }

        $model = new Item;

        if ($model->load(Yii::$app->request->post())) {
            if(Yii::$app->request->isAjax){
                Yii::$app->response->format = \yii\web\Response::FORMAT_JSON;
                return ActiveForm::validate($model);
            }
            else {
                $model->category_id = $category->primaryKey;

                if (isset($_FILES) && $this->module->settings['articleThumb']) {
                    $model->head = UploadedFile::getInstance($model, 'head');
                    if ($model->head && $model->validate(['image'])) {
                        $model->head = Image::upload($model->head, 'hero');
                    } else {
                        $model->head = '';
                    }

                    $model->bg_image = UploadedFile::getInstance($model, 'bg_image');
                    if ($model->bg_image && $model->validate(['image'])) {
                        $model->bg_image = Image::upload($model->bg_image, 'hero');
                    } else {
                        $model->bg_image = '';
                    }

                    $model->attribute_image = UploadedFile::getInstance($model, 'attribute_image');
                    if ($model->attribute_image && $model->validate(['image'])) {
                        $model->attribute_image = Image::upload($model->attribute_image, 'hero');
                    } else {
                        $model->attribute_image = '';
                    }
                }

                if ($model->save()) {
                    $this->flash('success', Yii::t('easyii/hero', 'Article created'));
                    return $this->redirect(['/admin/'.$this->module->id.'/items/edit', 'id' => $model->primaryKey]);
                } else {
                    $this->flash('error', Yii::t('easyii', 'Create error. {0}', $model->formatErrors()));
                    return $this->refresh();
                }
            }
        }
        else {
            return $this->render('create', [
                'model' => $model,
                'category' => $category,
            ]);
        }
    }

    public function actionEdit($id)
    {
        if(!($model = Item::findOne($id))){
            return $this->redirect(['/admin/'.$this->module->id]);
        }

        if ($model->load(Yii::$app->request->post())) {
            if(Yii::$app->request->isAjax){
                Yii::$app->response->format = \yii\web\Response::FORMAT_JSON;
                return ActiveForm::validate($model);
            }
            else {
                if (isset($_FILES) && $this->module->settings['articleThumb']) {
                    $model->head = UploadedFile::getInstance($model, 'head');
                    if ($model->head && $model->validate(['image'])) {
                        $model->head = Image::upload($model->head, 'hero');
                    } else {
                        $model->head = $model->oldAttributes['head'];
                    }

                    $model->bg_image = UploadedFile::getInstance($model, 'bg_image');
                    if ($model->bg_image && $model->validate(['image'])) {
                        $model->bg_image = Image::upload($model->bg_image, 'hero');
                    } else {
                        $model->bg_image = $model->oldAttributes['bg_image'];
                    }

                    $model->attribute_image = UploadedFile::getInstance($model, 'attribute_image');
                    if ($model->attribute_image && $model->validate(['image'])) {
                        $model->attribute_image = Image::upload($model->attribute_image, 'hero');
                    } else {
                        $model->attribute_image = $model->oldAttributes['attribute_image'];
                    }
                }

                if ($model->save()) {
                    $this->flash('success', Yii::t('easyii/hero', 'Article updated'));
                    return $this->redirect(['/admin/'.$this->module->id.'/items/edit', 'id' => $model->primaryKey]);
                } else {
                    $this->flash('error', Yii::t('easyii', 'Update error. {0}', $model->formatErrors()));
                    return $this->refresh();
                }
            }
        }
        else {
            return $this->render('edit', [
                'model' => $model,
            ]);
        }
    }

    public function actionPhotos($id)
    {
        if(!($model = Item::findOne($id))){
            return $this->redirect(['/admin/'.$this->module->id]);
        }

        return $this->render('photos', [
            'model' => $model,
        ]);
    }

    public function actionClearImage($id)
    {
        $model = Item::findOne($id);

        if($model === null){
            $this->flash('error', Yii::t('easyii', 'Not found'));
        }
        elseif($model->image){
            $model->image = '';
            if($model->update()){
                $this->flash('success', Yii::t('easyii', 'Image cleared'));
            } else {
                $this->flash('error', Yii::t('easyii', 'Update error. {0}', $model->formatErrors()));
            }
        }
        return $this->back();
    }

    public function actionDelete($id)
    {
        if(($model = Item::findOne($id))){
            $model->delete();
        } else {
            $this->error = Yii::t('easyii', 'Not found');
        }
        return $this->formatResponse(Yii::t('easyii/hero', 'Article deleted'));
    }

    public function actionUp($id, $category_id)
    {
        return $this->move($id, 'up', ['category_id' => $category_id]);
    }

    public function actionDown($id, $category_id)
    {
        return $this->move($id, 'down', ['category_id' => $category_id]);
    }

    public function actionOn($id)
    {
        return $this->changeStatus($id, Item::STATUS_ON);
    }

    public function actionOff($id)
    {
        return $this->changeStatus($id, Item::STATUS_OFF);
    }
}