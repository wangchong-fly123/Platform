<?php

use \Phalcon\Mvc\Model;

class WfcAccountModel extends Model
{
    public function initialize()
    {
        $this->setSource('tbl_wfc_account');
    }
}
