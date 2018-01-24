<?php

final class MobileService
{
    private $server_app_ = null;

    private $sms_aliyun_url = 'http://message.enjoymi.com/sms_service.php';

    public function __construct($server_app)
    {
        $this->server_app_ = $server_app;
    }

    public function sendMessage($mobile_phone, $message, $message_type)
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
        $this->sendMessage($mobile_phone, $message_code, 'register');
    }

    public function sendResetPasswordMessageCode($mobile_phone, $message_code)
    {
        $this->sendMessage($mobile_phone, $message_code, 'find_password');
    }

    public function sendRebindMessageCode($mobile_phone, $message_code)
    {
        $this->sendMessage($mobile_phone, $message_code, 'change_phone');
    }

    public function sendRebindConfirmMessageCode($mobile_phone, $message_code)
    {
        $this->sendMessage($mobile_phone, $message_code, 'change_phone_confirm');
    }

    public function sendMessageLoginMessageCode($mobile_phone, $message_code)
    {
        $this->sendMessage($mobile_phone, $message_code, 'login');
    }
}
