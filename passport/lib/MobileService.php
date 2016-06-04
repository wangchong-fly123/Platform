<?php

final class MobileService
{
    private $server_app_ = null;

    private $sms_url = 'http://61.145.229.28:8027/MWGate/wmgw.asmx/MongateCsSpSendSmsNew';
    private $sms_user_id = 'M10238';
    private $sms_password = '152103';

    public function __construct($server_app)
    {
        $this->server_app_ = $server_app;
    }

    public function sendMessage($mobile_phone, $message)
    {
        error_log($mobile_phone.':'.$message);
        Util::httpRequest($this->sms_url, array(
            'userId' => $this->sms_user_id,
            'password' => $this->sms_password,
            'pszMobis' => $mobile_phone,
            'pszMsg' => $message,
            'iMobiCount' => 1,
            'pszSubPort' => '*',
        ));
    }

    public function sendMessageCode($mobile_phone, $message_code)
    {
        $message = "注册验证码: $message_code";
        $this->sendMessage($mobile_phone, $message);
    }

    public function sendResetPasswordMessageCode($mobile_phone, $message_code)
    {
        $message = "找回密码验证码: $message_code";
        $this->sendMessage($mobile_phone, $message);
    }
}
