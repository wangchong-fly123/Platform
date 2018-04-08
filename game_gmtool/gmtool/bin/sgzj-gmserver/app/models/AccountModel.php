<?php

use \Phalcon\Mvc\Model;

class AccountModel extends Model
{
    public function initialize()
    {
        $this->setSource('tbl_account');
        $this->allowEmptyStringValues(array(
            'exclude_channel',
            'cps',
        ));
    }
}
