<?php

use \Phalcon\Mvc\Application;

$root_dir = realpath(__DIR__.'/..').'/';

require_once $root_dir.'app/config/Config.php';

$config = new Config();
$config->init($root_dir);
$app = new Application($config->getDI());
echo $app->handle()->getContent();
