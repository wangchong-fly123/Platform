<?php
use yii\easyii\widgets\Photos;

$this->title = $model->hero_name;
?>

<?= $this->render('_menu', ['category' => $model->category]) ?>
<?= $this->render('_submenu', ['model' => $model]) ?>

<?= Photos::widget(['model' => $model])?>