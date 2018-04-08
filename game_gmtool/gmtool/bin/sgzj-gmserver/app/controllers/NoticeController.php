<?php

final class NoticeController extends ControllerBase
{
    public function instantNoticeAction()
    {
    }

    public function timingNoticeAction()
    {
    }

    public function platformTimingNoticeAction()
    {
    }

    public function listAction() 
    {
    }

    public function platformRemoveNoticeAction()
    {
    }

    public function sendInstantNoticeAction()
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
        $message = $this->request->get('message');
        if ($message === null) {
            return $this->error('`message` is required');
        }
        $repeat_times = $this->request->get('repeat_times');
        if ($repeat_times === null) {
            return $this->error('`repeat_times` is required');
        }
        $interval_second = $this->request->get('interval_second');
        if ($interval_second === null) {
            return $this->error('`interval_second` is required');
        }

        // check server id
        $server_model = $this->getVisableServerModel($server_id);
        if ($server_model === false) {
            return $this->error('`server_id` is invalid');
        }

        $ret = $this->slaveServerRequest(
            $server_model->addr, $server_model->secret_key,
            '/send_notice.php', array(
                'start_send_time' => 0,
                'message' => $message,
                'repeat_times' => $repeat_times,
                'interval_second' => $interval_second,
            ));
        if ($ret === false) {
            return $this->error('request slave server failed');
        }

        // op log
        $server_desc = $server_model->desc;
        $notice_id = $ret['notice_id'];
        $this->opLog("[发送即时公告] 服务器: $server_desc ".
                     "公告ID: $notice_id ".
                     "发送次数: $repeat_times 发送间隔: $interval_second</br>".
                     "公告信息: $message");

        return $this->success($ret);
    }

    public function sendTimingNoticeAction()
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
        $start_send_time = $this->request->get('start_send_time');
        if ($start_send_time === null) {
            return $this->error('`start_send_time` is required');
        }
        $message = $this->request->get('message');
        if ($message === null) {
            return $this->error('`message` is required');
        }
        $repeat_times = $this->request->get('repeat_times');
        if ($repeat_times === null) {
            return $this->error('`repeat_times` is required');
        }
        $interval_second = $this->request->get('interval_second');
        if ($interval_second === null) {
            return $this->error('`interval_second` is required');
        }

        // check server id
        $server_model = $this->getVisableServerModel($server_id);
        if ($server_model === false) {
            return $this->error('`server_id` is invalid');
        }

        $ret = $this->slaveServerRequest(
            $server_model->addr, $server_model->secret_key,
            '/send_notice.php', array(
                'start_send_time' => $start_send_time,
                'message' => $message,
                'repeat_times' => $repeat_times,
                'interval_second' => $interval_second,
            ));
        if ($ret === false) {
            return $this->error('request slave server failed');
        }

        // op_log
        $server_desc = $server_model->desc;
        $start_send_time_fmt = DataFormatter::timestamp($start_send_time);
        $notice_id = $ret['notice_id'];
        $this->opLog("[发送定时公告] 服务器: $server_desc ".
                     "公告ID: $notice_id ".
                     "开始发送时间: $start_send_time_fmt ".
                     "发送次数: $repeat_times 发送间隔: $interval_second</br>".
                     "公告信息: $message");

        return $this->success($ret);
    }

    public function sendPlatformTimingNoticeAction()
    {
        $this->view->disable();

        // check auth
        if ($this->hasAuth(AccountType::ADVANCED_GM) == false) {
            return $this->error('not allowed');
        }

        $platform_id = $this->request->get('platform_id');
        if ($platform_id === null) {
            return $this->error('`platform_id` is required');
        }
        $start_send_time = $this->request->get('start_send_time');
        if ($start_send_time === null) {
            return $this->error('`start_send_time` is required');
        }
        $message = $this->request->get('message');
        if ($message === null) {
            return $this->error('`message` is required');
        }
        $repeat_times = $this->request->get('repeat_times');
        if ($repeat_times === null) {
            return $this->error('`repeat_times` is required');
        }
        $interval_second = $this->request->get('interval_second');
        if ($interval_second === null) {
            return $this->error('`interval_second` is required');
        }

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
                'uri' => '/send_notice.php',
                'params' => array(
                    'start_send_time' => $start_send_time,
                    'message' => $message,
                    'repeat_times' => $repeat_times,
                    'interval_second' => $interval_second,
                ),
            ));
        }
        $ret_list = $this->multiSlaveServerRequest($request_list);

        // op_log
        $start_send_time_fmt = DataFormatter::timestamp($start_send_time);
        $this->opLog("[发送定时公告(按平台)] 平台: $platform_id ".
                     "开始发送时间: $start_send_time_fmt ".
                     "发送次数: $repeat_times 发送间隔: $interval_second</br>".
                     "公告信息: $message");

        return $this->success(array(
            'success' => true,
        ));
    }

    public function getNoticeListAction()
    {
        $this->view->disable();

        // check auth
        if ($this->hasAuth(AccountType::ADVANCED_GM) == false) {
            return $this->error('not allowed');
        }

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
            '/notice_list.php');
        if ($ret === false) {
            return $this->error('request slave server failed');
        }

        return $this->success($ret);
    }

    public function removeNoticeAction()
    {
        $this->view->disable();

        // check auth
        if ($this->hasAuth(AccountType::ADVANCED_GM) == false) {
            return $this->error('not allowed');
        }

        $server_id = $this->request->get('server_id');
        if ($server_id === null) {
            return $this->error('`server_id` is required');
        }
        $notice_id = $this->request->get('notice_id');
        if ($notice_id === null) {
            return $this->error('`notice_id` is required');
        }

        // check server id
        $server_model = $this->getVisableServerModel($server_id);
        if ($server_model === false) {
            return $this->error('`server_id` is invalid');
        }

        $ret = $this->slaveServerRequest(
            $server_model->addr, $server_model->secret_key,
            '/remove_notice.php', array(
                'notice_id' => $notice_id,
            ));
        if ($ret === false) {
            return $this->error('request slave server failed');
        }

        // op log
        $server_desc = $server_model->desc;
        $this->opLog("[删除公告] 服务器: $server_desc 公告ID: $notice_id");

        return $this->success($ret);
    }

    public function doPlatformRemoveNoticeAction()
    {
        $this->view->disable();

        // check auth
        if ($this->hasAuth(AccountType::ADVANCED_GM) == false) {
            return $this->error('not allowed');
        }

        $platform_id = $this->request->get('platform_id');
        if ($platform_id === null) {
            return $this->error('`platform_id` is required');
        }
        $notice_id = $this->request->get('notice_id');
        if ($notice_id === null) {
            return $this->error('`notice_id` is required');
        }

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
                'uri' => '/remove_notice.php',
                'params' => array(
                    'notice_id' => $notice_id,
                ),
            ));
        }
        $ret_list = $this->multiSlaveServerRequest($request_list);

        // op_log
        $this->opLog("[删除公告(按平台)] 平台: $platform_id ".
                     "公告id: $notice_id");

        return $this->success(array(
            'success' => true,
        ));
    }
}
