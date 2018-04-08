<?php
$this->title = $model->hero_name;
?>
<?= $this->render('_menu', ['category' => $model->category]) ?>

<?php if($this->context->module->settings['enablePhotos']) echo $this->render('_submenu', ['model' => $model]) ?>

<?= $this->render('_form', ['model' => $model]) ?>
