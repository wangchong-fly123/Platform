<?php
namespace app\modules\hero\models;

class Category extends \yii\easyii\components\CategoryModel
{
    public static function tableName()
    {
        return 'app_hero_categories';
    }

    public function getItems()
    {
        return $this->hasMany(Item::className(), ['category_id' => 'category_id'])->sortDate();
    }

    public function afterDelete()
    {
        parent::afterDelete();

        foreach ($this->getItems()->all() as $item) {
            $item->delete();
        }
    }
}