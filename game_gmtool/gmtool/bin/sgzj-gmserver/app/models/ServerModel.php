<?php

use \Phalcon\Mvc\Model;

class ServerModel extends Model
{
    public function initialize()
    {
        $this->setSource('tbl_server');
    }
}
