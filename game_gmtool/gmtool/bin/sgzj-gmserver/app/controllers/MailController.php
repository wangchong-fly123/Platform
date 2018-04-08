<?php

final class MailController extends ControllerBase
{
    public function mailAction()
    {
    }

    public function platformMailAction()
    {
    }

    public function timingMailAction()
    {
    }

    public function timingMailListAction()
    {
    }

    public function sendMailAction()
    {
        $this->view->disable();

        // check auth
        if ($this->hasAuth(AccountType::SUPER_GM) == false) {
            return $this->error('not allowed');
        }

        // get params
        $server_id = $this->request->get('server_id');
        if ($server_id === null) {
            return $this->error('`server_id` is required');
        }
        $player_id = $this->request->get('player_id');
        if ($player_id === null) {
            return $this->error('`player_id` is required');
        }
        $mail_title = $this->request->get('mail_title');
        if ($mail_title === null) {
            return $this->error('`mail_title` is required');
        }
        $expired_minute = $this->request->get('expired_minute');
        if ($expired_minute === null) {
            return $this->error('`expired_minute` is required');
        }
        $mail_content = $this->request->get('mail_content', null, '');
        $mail_awards = $this->request->get('mail_awards', null, '');

        // check server id
        $server_model = $this->getVisableServerModel($server_id);
        if ($server_model === false) {
            return $this->error('`server_id` is invalid');
        }

        $ret = $this->slaveServerRequest(
            $server_model->addr, $server_model->secret_key,
            '/send_mail.php', array(
                'player_id' => $player_id,
                'mail_title' => $mail_title,
                'mail_content' => $mail_content,
                'mail_awards' => $mail_awards,
                'expired_second' => $expired_minute * 60,
            ));
        if ($ret === false) {
            return $this->error('request slave server failed');
        }

        if (isset($ret['error_code'])) {
            return $this->success($ret);
        }

        // op log
        $server_desc = $server_model->desc;
        $mail_awards_fmt = preg_replace('/^\[/', '', $mail_awards);
        $mail_awards_fmt = preg_replace('/\]$/', '', $mail_awards_fmt);
        $mail_awards_fmt = preg_replace('/},/', '}</br>', $mail_awards_fmt);
        $this->opLog("[发送邮件] 服务器: $server_desc ".
                     "玩家ID: $player_id</br>".
                     "邮件标题: $mail_title</br>".
                     "邮件正文: $mail_content</br>".
                     "邮件失效时间: $expired_minute</br>".
                     "邮件奖励:</br>$mail_awards_fmt");

        return $this->success($ret);
    }

    public function sendPlatformMailAction()
    {
        $this->view->disable();

        // check auth
        if ($this->hasAuth(AccountType::SUPER_GM) == false) {
            return $this->error('not allowed');
        }

        $platform_id = $this->request->get('platform_id');
        if ($platform_id === null) {
            return $this->error('`platform_id` is required');
        }
        $mail_title = $this->request->get('mail_title');
        if ($mail_title === null) {
            return $this->error('`mail_title` is required');
        }
        $expired_minute = $this->request->get('expired_minute');
        if ($expired_minute === null) {
            return $this->error('`expired_minute` is required');
        }
        $mail_content = $this->request->get('mail_content', null, '');
        $mail_awards = $this->request->get('mail_awards', null, '');

        // check platform_id
        if ($this->getAccountPlatformId() != 0 &&
            $this->getAccountPlatformId() != $platform_id) {
            return $this->error('`platform_id` is invalid');
        }

        $request_list = array();
        $server_model_list = ServerModel::find(array(
            'conditions' => 'platform_id = :platform_id:',
            'bind' => array(
                'platform_id' => $platform_id,
            ),
        ));
        foreach ($server_model_list as $server_model) {
            array_push($request_list, array(
                'addr' => $server_model->addr,
                'secret_key' => $server_model->secret_key,
                'uri' => '/send_mail.php',
                'params' => array(
                    'player_id' => 0,
                    'mail_title' => $mail_title,
                    'mail_content' => $mail_content,
                    'mail_awards' => $mail_awards,
                    'expired_second' => $expired_minute * 60,
                ),
            ));
        }
        $ret_list = $this->multiSlaveServerRequest($request_list);

        // op_log
        $mail_awards_fmt = preg_replace('/^\[/', '', $mail_awards);
        $mail_awards_fmt = preg_replace('/\]$/', '', $mail_awards_fmt);
        $mail_awards_fmt = preg_replace('/},/', '}</br>', $mail_awards_fmt);
        $this->opLog("[发送邮件(按平台)] 平台: $platform_id ".
                     "邮件标题: $mail_title</br>".
                     "邮件正文: $mail_content</br>".
                     "邮件失效时间: $expired_minute</br>".
                     "邮件奖励:</br>$mail_awards_fmt");

        return $this->success(array(
            'success' => true,
        ));
    }

    public function sendTimingMailAction()
    {
        $this->view->disable();

        // check auth
        if ($this->hasAuth(AccountType::SUPER_GM) == false) {
            return $this->error('not allowed');
        }

        // get params
        $server_id = $this->request->get('server_id');
        if ($server_id === null) {
            return $this->error('`server_id` is required');
        }
        $players_id = $this->request->get('players_id');
        if ($players_id === null) {
            return $this->error('`players_id` is required');
        }
        $mail_title = $this->request->get('mail_title');
        if ($mail_title === null) {
            return $this->error('`mail_title` is required');
        }
        $expired_minute = $this->request->get('expired_minute');
        if ($expired_minute === null) {
            return $this->error('`expired_minute` is required');
        }
        $immediately_send = $this->request->get('immediately_send');
        if ($immediately_send === null) {
            return $this->error('`immediately_send` is required');
        }
        $start_send_time = $this->request->get('start_send_time');
        if ($start_send_time === null) {
            return $this->error('`start_send_time` is required');
        }
        $mail_content = $this->request->get('mail_content', null, '');
        $mail_awards = $this->request->get('mail_awards', null, '');

        // check server id
        $server_model = $this->getVisableServerModel($server_id);
        if ($server_model === false) {
            return $this->error('`server_id` is invalid');
        }

        $ret = $this->slaveServerRequest(
            $server_model->addr, $server_model->secret_key,
            '/send_timing_mail.php', array(
                'players_id' => $players_id,
                'mail_title' => $mail_title,
                'mail_content' => $mail_content,
                'mail_awards' => $mail_awards,
                'expired_second' => $expired_minute * 60,
                'immediately_send' => $immediately_send,
                'start_send_time' => $start_send_time,
            ));
        if ($ret === false) {
            return $this->error('request slave server failed');
        }

        if (isset($ret['error_code'])) {
            return $this->success($ret);
        }

        // op log
        $server_desc = $server_model->desc;
        $mail_awards_fmt = preg_replace('/^\[/', '', $mail_awards);
        $mail_awards_fmt = preg_replace('/\]$/', '', $mail_awards_fmt);
        $mail_awards_fmt = preg_replace('/},/', '}</br>', $mail_awards_fmt);
        $this->opLog("[发送定时邮件] 服务器: $server_desc ".
                     "玩家ID: $players_id</br>".
                     "邮件标题: $mail_title</br>".
                     "邮件正文: $mail_content</br>".
                     "邮件失效时间: $expired_minute</br>".
                     "邮件奖励:</br>$mail_awards_fmt".
                     "立即发送:$immediately_send".
                     "开始发送时间:$start_send_time");

        return $this->success($ret);
    }

    public function getTimingMailListAction()
    {
        $this->view->disable();

        // check auth
        if ($this->hasAuth(AccountType::ADVANCED_GM) == false) {
            return $this->error('not allowed');
        }

        // get params
        $server_id = $this->request->get('server_id');
        if ($server_id === null) {
            return $this->error('`server_id` is required');
        }

        // check server id
        $server_model = $this->getVisableServerModel($server_id);
        if ($server_model === false) {
            return $this->error('`server_id` is invalid');
        }

        $ret = $this->slaveServerRequest(
            $server_model->addr, $server_model->secret_key,
            '/timing_mail_list.php');
        if ($ret === false) {
            return $this->error('request slave server failed');
        }

        if (isset($ret['error_code'])) {
            return $this->success($ret);
        }

        foreach ($ret['timing_mail_list'] as &$row) {
            $row['start_send_time'] =
                DataFormatter::timestamp($row['start_send_time']);
            $row['expired_time'] =
                DataFormatter::timestamp($row['expired_time']);
        }

        return $this->success($ret);
    }

    public function removeTimingMailAction()
    {
        $this->view->disable();

        // check auth
        if ($this->hasAuth(AccountType::ADVANCED_GM) == false) {
            return $this->error('not allowed');
        }

        // get params
        $server_id = $this->request->get('server_id');
        if ($server_id === null) {
            return $this->error('`server_id` is required');
        }
        $timing_mail_id = $this->request->get('id');
        if ($timing_mail_id === null) {
            return $this->error('`timing_mail_id` is required');
        }

        // check server id
        $server_model = $this->getVisableServerModel($server_id);
        if ($server_model === false) {
            return $this->error('`server_id` is invalid');
        }

        $ret = $this->slaveServerRequest(
            $server_model->addr, $server_model->secret_key,
            '/remove_timing_mail.php', array(
                'timing_mail_id' => $timing_mail_id,
            ));

        if ($ret === false) {
            return $this->error('request slave server failed');
        }

        if (isset($ret['error_code'])) {
            return $this->success($ret);
        }

        return $this->success($ret);
    }
}
