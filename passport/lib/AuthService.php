<?php

final class AuthService
{
    private $server_app_ = null;
    
    const CLOSE_CAPTCHA_TEXT = 1;

    public function __construct($server_app)
    {
        $this->server_app_ = $server_app;
    }

    public function generateLoginToken($uid)
    {
        $redis = $this->server_app_->getRedisHandler();

        $token = bin2hex(openssl_random_pseudo_bytes(16));

        // expired in 5 hours
        $redis->set("login_token:$uid", $token, 5 * 3600);

        return $token;
    }

    public function checkLoginToken($uid, $token)
    {
        $redis = $this->server_app_->getRedisHandler();

        $db_token = $redis->get("login_token:$uid");
        if ($db_token === false) {
            return false;
        }

        return $token === $db_token;
    }

    public function clearLoginToken($uid) 
    {
        $redis = $this->server_app_->getRedisHandler();

        $redis->del("login_token:$uid");
    }

    public function setCaptchaText($captcha_text)
    {
        $this->server_app_->setSession('captcha_text', $captcha_text);
    }

    public function checkCaptchaText($captcha_text)
    {
        if (self::CLOSE_CAPTCHA_TEXT) {
            return true;
        }

        return $captcha_text ===
            $this->server_app_->getSession('captcha_text');
    }

    public function clearCaptchaText()
    {
        $this->server_app_->clearSession('captcha_text');
    }

    public function checkAndClearCaptchaText($captcha_text)
    {
        if (self::CLOSE_CAPTCHA_TEXT) {
            return true;
        }

        $session_captcha_text =
            $this->server_app_->getSession('captcha_text');
        $this->clearCaptchaText();

        return $session_captcha_text === $captcha_text;
    }

    public function generateMessageCode($mobile_phone)
    {
        $message_code = sprintf('%06ld', mt_rand(0, 999999));

        $this->server_app_->setSession('mobile_phone', $mobile_phone);
        $this->server_app_->setSession('message_code', $message_code);
        $this->server_app_->setSession('message_code_failed_times', 0);

        return $message_code;
    }

    public function clearMessageCode()
    {
        $this->server_app_->clearSession('mobile_phone');
        $this->server_app_->clearSession('message_code');
        $this->server_app_->clearSession('message_code_failed_times');
    }

    public function checkAndClearMessageCode($mobile_phone, $message_code)
    {
        $session_mobile_phone =
            $this->server_app_->getSession('mobile_phone');
        $session_message_code =
            $this->server_app_->getSession('message_code');
        $session_message_code_failed_times =
            $this->server_app_->getSession('message_code_failed_times');

        if ($session_mobile_phone === $mobile_phone &&
            $session_message_code === $message_code) {
            $this->clearMessageCode();
            return true;
        } else {
            if ($session_message_code_failed_times >= 10) {
                $this->clearMessageCode();
            } else {
                $this->server_app_->setSession('message_code_failed_times',
                    $session_message_code_failed_times + 1);
            }
            return false;
        }
    }

    public function generateResetPasswordCode($uid)
    {
        $message_code = sprintf('%06ld', mt_rand(0, 999999));
        $redis = $this->server_app_->getRedisHandler();

        // expired in 5 min
        $redis->set("reset_password:$uid", $message_code, 5 * 60);

        return $message_code;
    }

    public function checkResetPasswordCode($uid, $message_code)
    {
        $redis = $this->server_app_->getRedisHandler();

        $db_message_code = $redis->get("reset_password:$uid");
        if ($db_message_code === false) {
            return false;
        }

        return $db_message_code === $message_code;
    }

    public function clearResetPasswordCode($uid) 
    {
        $redis = $this->server_app_->getRedisHandler();

        $redis->del("reset_password:$uid");
    }

    public function addFailedResetPasswordCodeTimes($uid)
    {
        $redis = $this->server_app_->getRedisHandler();

        $failed_times = $redis->get("reset_password_failed_times:$uid");
        if ($failed_times === false) {
            $redis->set("reset_password_failed_times:$uid", 1, 10 * 60);
        } else {
            if ($failed_times >= 10) {
                $this->clearResetPasswordCode($uid);
                $this->clearFailedResetPasswordCodeTimes($uid);
            } else {
                $redis->set("reset_password_failed_times:$uid", 1+$failed_times, 10 * 60);
            }
        }
    }

    public function clearFailedResetPasswordCodeTimes($uid)
    {
        $redis = $this->server_app_->getRedisHandler();

        $redis->del("reset_password_failed_times:$uid");
    }

    public function generateRebindCode($uid)
    {
        $message_code = sprintf('%06ld', mt_rand(0, 999999));
        $redis = $this->server_app_->getRedisHandler();

        // expired in 5 min
        $redis->set("rebind_step_1:$uid", $message_code, 5 * 60);

        return $message_code;
    }

    public function checkRebindCode($uid, $message_code)
    {
        $redis = $this->server_app_->getRedisHandler();

        $db_message_code = $redis->get("rebind_step_1:$uid");
        if ($db_message_code === false) {
            return false;
        }

        return $db_message_code === $message_code;
    }

    public function clearRebindCode($uid) 
    {
        $redis = $this->server_app_->getRedisHandler();

        $redis->del("rebind_step_1:$uid");
    }

    public function setRebindFlag($uid)
    {
        $redis = $this->server_app_->getRedisHandler();

        // expired in 5 min
        $redis->set("rebind_step_2:$uid", $uid, 5 * 60);

        return $uid;
    }

    public function checkRebindFlag($uid)
    {
        $redis = $this->server_app_->getRedisHandler();

        $db_message_code = $redis->get("rebind_step_2:$uid");
        if ($db_message_code === false) {
            return false;
        }

        return true;
    }

    public function clearRebindFlag($uid) 
    {
        $redis = $this->server_app_->getRedisHandler();

        $redis->del("rebind_step_2:$uid");
    }

    public function generateRebindConfirmCode($uid)
    {
        $message_code = sprintf('%06ld', mt_rand(0, 999999));
        $redis = $this->server_app_->getRedisHandler();

        // expired in 5 min
        $redis->set("rebind_step_3:$uid", $message_code, 5 * 60);

        return $message_code;
    }

    public function checkRebindConfirmCode($uid, $message_code)
    {
        $redis = $this->server_app_->getRedisHandler();

        $db_message_code = $redis->get("rebind_step_3:$uid");
        if ($db_message_code === false) {
            return false;
        }

        return $db_message_code === $message_code;
    }

    public function clearRebindConfirmCode($uid) 
    {
        $redis = $this->server_app_->getRedisHandler();

        $redis->del("rebind_step_3:$uid");
    }

    public function generateMessageLoginCode($mobile_phone)
    {
        $message_code = sprintf('%04ld', mt_rand(0, 9999));
        $redis = $this->server_app_->getRedisHandler();

        // expired in 5 min
        $redis->set("message_login:$mobile_phone", $message_code, 5 * 60);

        return $message_code;
    }

    public function checkMessageLoginCode($mobile_phone, $message_code)
    {
        $redis = $this->server_app_->getRedisHandler();

        $db_message_code = $redis->get("message_login:$mobile_phone");
        if ($db_message_code === false) {
            return false;
        }

        return $db_message_code === $message_code;
    }

    public function clearMessageLoginCode($mobile_phone) 
    {
        $redis = $this->server_app_->getRedisHandler();

        $redis->del("message_login:$mobile_phone");
    }

    public function addFailedMessageLoginCodeTimes($mobile_phone)
    {
        $redis = $this->server_app_->getRedisHandler();

        $failed_times = $redis->get("message_login_failed_times:$mobile_phone");
        if ($failed_times === false) {
            $redis->set("message_login_failed_times:$mobile_phone", 1, 10 * 60);
        } else {
            if ($failed_times >= 10) {
                $this->clearMessageLoginCode($mobile_phone);
                $this->clearFailedMessageLoginCodeTimes($mobile_phone);
            } else {
                $redis->set("message_login_failed_times:$mobile_phone", 1+$failed_times, 10 * 60);
            }
        }
    }

    public function clearFailedMessageLoginCodeTimes($mobile_phone)
    {
        $redis = $this->server_app_->getRedisHandler();

        $redis->del("message_login_failed_times:$mobile_phone");
    }
}
