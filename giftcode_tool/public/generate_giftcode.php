<?php
require('../base/Config.php');
Config::init();

if (isset($_GET['length']) === false ||
    isset($_GET['count']) === false ||
    isset($_GET['channel']) === false ||
    isset($_GET['gift_id']) === false ||
    isset($_GET['start']) === false ||
    isset($_GET['end']) === false ||
    isset($_GET['code_type']) === false) {
    die("param is invalid");
}

$length = $_GET['length'];
$count = $_GET['count'];
$channel = $_GET['channel'];
$gift_id = $_GET['gift_id'];
$code_type = $_GET['code_type'];
$start_time =date('Y-m-d H:i:s',strtotime($_GET['start'])) ;
$end_time =date('Y-m-d H:i:s',strtotime($_GET['end'])) ;


if (!is_numeric($length)) {
    die("length must be numeric!!!");
} elseif (!is_numeric($count)) {
    die("count must be numeric!!!");
} elseif (!is_numeric($gift_id)) {
    die("gift_id must be numeric!!!");
} elseif (!is_numeric($channel) || strlen($channel) != 6) {
    die("channel length must be 6");
} elseif ($code_type != 0 && $code_type != 1) {
    die("code_type must be 1 or 0");
}

$generate_count = $count;
$service = new CodeService();
$service->init();

$batch_id = $service->calculateBatchId();

$code_array = array();
while ($generate_count > 0) {
    $code = $service->generateOneCode($length, $channel, $gift_id, $batch_id, $code_type,$start_time,$end_time);
    
    if ($code === -1) {
        die("fatal error !!!");
    }

    $code_array[] = $code;
    if (count($code_array) === 1000) {
        $service->generateCodeSql($code_array, $channel, $gift_id, $batch_id, $code_type,$start_time,$end_time);
        $code_array = array();
    }
    $generate_count--;
}

if (count($code_array) > 0) {
    $service->generateCodeSql($code_array, $channel, $gift_id, $batch_id, $code_type,$start_time,$end_time);
}
echo "giftcode total count is: $count\n";
echo "giftcode txt file name is: ".
    'giftcode_'.$batch_id.'_'.$channel.'_'.$gift_id.'_'.$batch_id.'.txt'."\n";
echo "giftcode sql file name is: ".
    'giftcode_'.$channel.'_'.$gift_id.'_'.$batch_id.'.sql'."\n";
