<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "app_hero_items".
 *
 * @property integer $item_id
 * @property integer $category_id
 * @property string $hero_name
 * @property string $head
 * @property string $bg_image
 * @property string $attribute_image
 * @property string $hero_intro
 * @property string $skill_intro
 * @property string $slug
 * @property integer $time
 * @property integer $views
 * @property integer $status
 */
class Hero extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'app_hero_items';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['category_id', 'time', 'views', 'status'], 'integer'],
            [['hero_name', 'skill_intro'], 'required'],
            [['skill_intro'], 'string'],
            [['hero_name', 'head', 'bg_image', 'attribute_image', 'slug'], 'string', 'max' => 128],
            [['hero_intro'], 'string', 'max' => 1024],
            [['slug'], 'unique']
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'item_id' => 'Item ID',
            'category_id' => 'Category ID',
            'hero_name' => 'Hero Name',
            'head' => 'Head',
            'bg_image' => 'Bg Image',
            'attribute_image' => 'Attribute Image',
            'hero_intro' => 'Hero Intro',
            'skill_intro' => 'Skill Intro',
            'slug' => 'Slug',
            'time' => 'Time',
            'views' => 'Views',
            'status' => 'Status',
        ];
    }
}
