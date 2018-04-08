<?php

use \Phalcon\Mvc\Model;

class ChannelModel extends Model
{
    public function initialize()
    {
        $this->setSource('tbl_channel');
    }
}
