<?php

use \Phalcon\Mvc\Model;

class PlatformModel extends Model
{
    public function initialize()
    {
        $this->setSource('tbl_platform');
    }
}
