<?php

final class MobileService
{
    private $server_app_ = null;

    private $sms_url = 'http://61.145.229.28:8027/MWGate/wmgw.asmx/MongateCsSpSendSmsNew';
    private $sms_user_id = 'M10238';
    private $sms_password = '152103';

    private $sms_aliyun_url = 'http://message.enjoymi.com/sms_service.php';
    private $use_aliyun = 0;

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

    public function sendMessage2($mobile_phone, $message, $message_type)
    {
        error_log($mobile_phone.':'.$message);
        Util::httpRequest($this->sms_aliyun_url, array(
            'message_type' => $message_type,
            'message_code' => $message,
            'phone_num'    => $mobile_phone,
        ));
    }

    public function sendMessageCode($mobile_phone, $message_code)
    {
        if ($this->use_aliyun == 0) {
            $message = "注册验证码: $message_code";
            $this->sendMessage($mobile_phone, $message);
        } else {
            $this->sendMessage2($mobile_phone, $message_code, 'register');
        }
    }

    public function sendResetPasswordMessageCode($mobile_phone, $message_code)
    {
        if ($this->use_aliyun == 0) {
            $message = "找回密码验证码: $message_code";
            $this->sendMessage($mobile_phone, $message);
        } else {
            $this->sendMessage2($mobile_phone, $message_code, 'find_password');
        }
    }

    public function sendRebindMessageCode($mobile_phone, $message_code)
    {
        if ($this->use_aliyun == 0) {
            $message = "换绑手机验证码: $message_code";
            $this->sendMessage($mobile_phone, $message);
        } else {
            $this->sendMessage2($mobile_phone, $message_code, 'change_phone');
        }
    }

    public function sendRebindConfirmMessageCode($mobile_phone, $message_code)
    {
        if ($this->use_aliyun == 0) {
            $message = "换绑手机确认验证码: $message_code";
            $this->sendMessage($mobile_phone, $message);
        } else {
            $this->sendMessage2($mobile_phone, $message_code, 'change_phone_confirm');
        }
    }
}
