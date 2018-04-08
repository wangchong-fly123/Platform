<?php

use \Phalcon\Mvc\Application;

$root_dir = realpath(__DIR__.'/..').'/';

require_once $root_dir.'app/config/Config.php';

Config::init($root_dir);
$app = new Application(Config::getDI());
echo $app->handle()->getContent();
