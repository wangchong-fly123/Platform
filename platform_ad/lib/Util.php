<?php

final class Util
{
    private static $error_cb = null;

    public static function setErrorCallback($error_cb)
    {
        self::$error_cb = $error_cb;
    }

    public static function ClientErrorCallback($error_message, $error_code)
    {
        $ret = array(
            'result' => array(
                'error_code' => $error_code,
                'error_message'=> $error_message,
            ),
        );

        header('Content-type: application/json');
        echo json_encode($ret);
        exit();
    }

    public static function error($error_message, $error_code = -1)
    {
        if (self::$error_cb !== null) {
            call_user_func(self::$error_cb,
                $error_message, $error_code);
        } else {
            $ret = array(
                'ret' => $error_code,
                'msg'=> $error_message,
            );
            header('Content-type: application/json');
            echo json_encode($ret);
            exit();
        }
    }

    public static function response($response)
    {
        header('Content-type: application/json');
        echo json_encode($response);
        exit();
    }
}
