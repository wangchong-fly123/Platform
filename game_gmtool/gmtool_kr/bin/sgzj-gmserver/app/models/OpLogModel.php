<?php

use \Phalcon\Mvc\Model;

class OpLogModel extends Model
{
    public function initialize()
    {
        $this->setSource('tbl_op_log');
    }
}
