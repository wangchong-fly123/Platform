<?php

use \Phalcon\Mvc\Model;

class SpreadModel extends Model
{
    public function initialize()
    {
        $this->setSource('tbl_spread');
    }
}
