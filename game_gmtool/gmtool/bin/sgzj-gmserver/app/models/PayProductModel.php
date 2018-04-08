<?php

use \Phalcon\Mvc\Model;

class PayProductModel extends Model
{
    public function initialize()
    {
        $this->setSource('tbl_pay_product');
    }
}
