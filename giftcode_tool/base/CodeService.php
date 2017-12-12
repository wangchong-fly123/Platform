<?php

final class CodeService
{
    private $dbh_ = null;

    public function __construct()
    {
    }

    public function error($error_type, $error_code = -1)
    {
        header('Content-type: application/json');
        echo json_encode(array($error_type => "error,$error_code"));
        exit();
    }

    public function response($response)
    {
        header('Content-type: application/json');
        echo json_encode($response);
        exit();
    }

    public function init()
    {
        if (ServerConfig::init() === false) {
            $this->error("login", -1);
        }
    }

    public function getDBHandler()
    {   
        if ($this->dbh_ != null) {
            return $this->dbh_;
        }   

        $db_host = ServerConfig::$db_host;
        $db_port = ServerConfig::$db_port;
        $db_name = ServerConfig::$db_name;
        $db_user = ServerConfig::$db_user;
        $db_password = ServerConfig::$db_password;
        $db_source = "mysql:host=$db_host;port=$db_port;".
            "dbname=$db_name;charset=utf8";
        $this->dbh_ = new PDO($db_source, $db_user, $db_password);

        return $this->dbh_;
    }

    public function getCodeTableName($code_type)
    {
        if ($code_type == 1) {
            return 'tbl_giftcode_public';
        } else if ($code_type == 0) {
            return 'tbl_giftcode_unique';
        }
        return "";
    }

    public function checkCodeInTable($table_name, $code)
    {
        $dbh = $this->getDBHandler();

        $sth = $dbh->prepare('select `code`'.
            ' from `'.$table_name.'`'.
            ' where `code`= :code');
        $sth->bindValue(':code', $code, PDO::PARAM_STR);
        $sth->execute();
        $res = $sth->fetch(PDO::FETCH_ASSOC);
        if (count($res)) {
            if ($res['code'] == $code) {
                return true;
            }
        }

        return false;
    }

    public function checkCodeExist($code)
    {
        if ($this->checkCodeInTable('tbl_giftcode_public', $code) ||
            $this->checkCodeInTable('tbl_giftcode_unique', $code)) {
            return  true;
        }
        return false;
    }

    public function generateOneCode($length, $channel, $gift_id, $batch_id, $code_type,$start_time='',$end_time='')
    {
        $dbh = $this->getDBHandler();

        $code = Common::createActiveCode($length);
        while ($this->checkCodeExist($code)) {
            $code = Common::createActiveCode($length);
        }
        $table_name = $this->getCodeTableName($code_type);
        $sth = $dbh->prepare(
            'insert ignore into `'.$table_name.'`'.
            ' (`code`,`channel`,`used`,`gift_id`,`batch_id`,`start_time`,`end_time`)'.
            ' values(:code, :channel, :used, :gift_id, :batch_id ,:start_time, :end_time)'.
            '');
        $used = 0;

        $sth->bindValue(':code', $code, PDO::PARAM_STR);
        $sth->bindValue(':channel', $channel, PDO::PARAM_STR);
        $sth->bindValue(':used', $used, PDO::PARAM_INT);
        $sth->bindValue(':gift_id', $gift_id, PDO::PARAM_INT);
        $sth->bindValue(':batch_id', $batch_id, PDO::PARAM_INT);
        $sth->bindValue(':start_time', $start_time, PDO::PARAM_STR);
        $sth->bindValue(':end_time', $end_time, PDO::PARAM_STR);
        if ($sth->execute() === false) {
            return -1;
        } else {
            return $code;
        }
    }

    public function generateCodeSql($codes=array(), $channel, $gift_id, $batch_id, $code_type,$start_time='',$end_time='')
    {
        $sql_file = Config::getSqlCodeDir().
            'giftcode_'.$channel.'_'.$gift_id.'_'.$batch_id.'.sql';
        $used = 0;
        $table_name = $this->getCodeTableName($code_type);
        $sql_string = " insert ignore into `".$table_name."`"."\n".
            " (`code`,`channel`,`used`,`gift_id`,`batch_id`,`start_time`,`end_time`)".
            " values"."\n";
        $index = 1;
        foreach ($codes as $code) {
            if ($index == count($codes)) {
                $sql_string .= " ('$code', '$channel', $used, $gift_id, $batch_id, '$start_time', '$end_time');"."\n";
            } else {
                $sql_string .= " ('$code', '$channel', $used, $gift_id, $batch_id, '$start_time', '$end_time'),"."\n";
            }

            $this->generateTxtCode($code, $channel, $gift_id, $batch_id);

            $index++;
        }

        file_put_contents($sql_file, $sql_string."\n", FILE_APPEND);
    }

    public function generateTxtCode($code, $channel, $gift_id, $batch_id)
    {
        $txt_file = Config::getTxtOutPutDir().
            'giftcode_'.$batch_id.'_'.$channel.'_'.$gift_id.'_'.$batch_id.'.txt';
        $code_string = $code;
        file_put_contents($txt_file, $code_string."\n", FILE_APPEND);
    }

    public function getBatchIdByFileName($file_name)
    {
        // file_name is like giftcode_000000_13_12.sql
        // and 12 is the target
        $first_array = explode('.', $file_name);
        $second_array = explode('_', $first_array[0]);
        return intval($second_array[3]);
    }

    public function calculateBatchId()
    {
        $batchs = array();
        $dir = Config::getSqlCodeDir();
        $handle = opendir($dir.".");
        while (false !== ($file = readdir($handle))) {
            if ($file != "." && $file != "..") {
                $batchs[] = $this->getBatchIdByFileName($file);
            }
        }
        closedir($handle);
        if (count($batchs) > 0 ) {
            return max($batchs) + 1;
        } else {
            return 1;
        }
    }

}
