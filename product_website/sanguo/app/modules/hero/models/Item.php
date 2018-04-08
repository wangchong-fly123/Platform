<?php
namespace app\modules\hero\models;

use Yii;
use yii\behaviors\SluggableBehavior;
use yii\easyii\behaviors\SeoBehavior;
use yii\easyii\behaviors\Taggable;
use yii\easyii\models\Photo;
use yii\helpers\StringHelper;

class Item extends \yii\easyii\components\ActiveRecord
{
    const STATUS_OFF = 0;
    const STATUS_ON = 1;

    public static function tableName()
    {
        return 'app_hero_items';
    }

    public function rules()
    {
        return [
            [['hero_intro','skill_intro'], 'required'],
            [['hero_intro', 'skill_intro'], 'trim'],
            ['hero_name', 'string', 'max' => 128],
            [['bg_image','attribute_image','head'], 'image'],
            [['category_id', 'views', 'time', 'status'], 'integer'],
            ['time', 'default', 'value' => time()],
            ['slug', 'match', 'pattern' => self::$SLUG_PATTERN, 'message' => Yii::t('easyii', 'Slug can contain only 0-9, a-z and "-" characters (max: 128).')],
            ['slug', 'default', 'value' => null],
            ['status', 'default', 'value' => self::STATUS_ON],
            ['tagNames', 'safe']
        ];
    }

    public function attributeLabels()
    {
        return [
            'hero_name' => Yii::t('easyii', 'Hero name'),
            'head' => Yii::t('easyii', 'Hero head image'),
            'attribute_image' => Yii::t('easyii', 'Hero attribute image'),
            'bg_image' => Yii::t('easyii', 'Hero background image'),
            'hero_intro' => Yii::t('easyii/hero', 'Hero introduction'),
            'skill_intro' => Yii::t('easyii/hero', 'Hero skill introduction'),
            'time' => Yii::t('easyii', 'Date'),
            'slug' => Yii::t('easyii', 'Slug'),
            'tagNames' => Yii::t('easyii', 'Tags'),
        ];
    }

    public function behaviors()
    {
        return [
            'seoBehavior' => SeoBehavior::className(),
            'taggabble' => Taggable::className(),
            'sluggable' => [
                'class' => SluggableBehavior::className(),
                'attribute' => 'hero_name',
                'ensureUnique' => true
            ]
        ];
    }

    public function getCategory()
    {
        return $this->hasOne(Category::className(), ['category_id' => 'category_id']);
    }

    public function getPhotos()
    {
        return $this->hasMany(Photo::className(), ['item_id' => 'item_id'])->where(['class' => self::className()])->sort();
    }

    public function beforeSave($insert)
    {
        if (parent::beforeSave($insert)) {
            $settings = Yii::$app->getModule('admin')->activeModules['hero']->settings;
            $this->hero_intro = StringHelper::truncate($settings['enableShort'] ? $this->hero_intro : strip_tags($this->text), $settings['shortMaxLength']);

            if(!$insert && $this->head != $this->oldAttributes['head'] && $this->oldAttributes['head']){
                @unlink(Yii::getAlias('@webroot').$this->oldAttributes['head']);
            }

            if(!$insert && $this->bg_image != $this->oldAttributes['bg_image'] && $this->oldAttributes['bg_image']){
                @unlink(Yii::getAlias('@webroot').$this->oldAttributes['bg_image']);
            }

            if(!$insert && $this->attribute_image != $this->oldAttributes['attribute_image'] && $this->oldAttributes['attribute_image']){
                @unlink(Yii::getAlias('@webroot').$this->oldAttributes['attribute_image']);
            }

            return true;
        } else {
            return false;
        }
    }

    public function afterDelete()
    {
        parent::afterDelete();

        // if($this->image){
        //     @unlink(Yii::getAlias('@webroot').$this->image);
        // }

        foreach($this->getPhotos()->all() as $photo){
            $photo->delete();
        }
    }
}