<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "easyii_article_items".
 *
 * @property integer $item_id
 * @property integer $category_id
 * @property string $title
 * @property string $image
 * @property string $short
 * @property string $text
 * @property string $slug
 * @property integer $time
 * @property integer $views
 * @property integer $status
 */
class Article extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'easyii_article_items';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['category_id', 'time', 'views', 'status'], 'integer'],
            [['title', 'text'], 'required'],
            [['text'], 'string'],
            [['title', 'image', 'slug'], 'string', 'max' => 128],
            [['short'], 'string', 'max' => 1024],
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
            'title' => 'Title',
            'image' => 'Image',
            'short' => 'Short',
            'text' => 'Text',
            'slug' => 'Slug',
            'time' => 'Time',
            'views' => 'Views',
            'status' => 'Status',
        ];
    }
}
