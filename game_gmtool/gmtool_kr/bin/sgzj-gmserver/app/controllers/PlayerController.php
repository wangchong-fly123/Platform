<?php

final class PlayerController extends ControllerBase
{
    public function briefInfoAction()
    {
    }

    public  function globalSearchAction()
    {
    }

    public function accountBanningAction()
    {
        $this->fetchPlayerManagementCache();
    }

    public function gmLoginAction()
    {
        $this->fetchPlayerManagementCache();
    }

    public function payTransactionAction()
    {
        $this->fetchPlayerManagementCache();
    }

    public function payTmallTransactionAction()
    {
        $this->fetchPlayerManagementCache();
    }

    public function cpsPayTransactionAction()
    {
        $this->fetchPlayerManagementCache();
    }

    public function onlineListAction()
    {
    }

    public function mailListAction()
    {
        $this->fetchPlayerManagementCache();
    }

    public function buddyListAction()
    {
        $this->fetchPlayerManagementCache();
    }

    public function equipListAction()
    {
        $this->fetchPlayerManagementCache();
    }

    public function soulListAction()
    {
        $this->fetchPlayerManagementCache();
    }

    public function playerRankAction()
    {
    }
    
    public function gmPayAction()
    {
        $this->fetchPlayerManagementCache();
    }

    public function gmConsumeDiamondAction()
    {
        $this->fetchPlayerManagementCache();
    }
   
    public function gmFinishCopyAction()
    {
        $this->fetchPlayerManagementCache();
    }

    public function gmFinishEliteCopyAction()
    {
        $this->fetchPlayerManagementCache();
    }

    public function onekeyDevelopAction()
    {
        $this->fetchPlayerManagementCache();
    }

    public function getBriefInfoAction()
    {
        $this->view->disable();

        // check auth
        if ($this->hasAuth(AccountType::GM) == false) {
            return $this->error('not allowed');
        }

        // get params
        $server_id = $this->request->get('server_id');
        if ($server_id === null) {
            return $this->error('`server_id` is required');
        }
        $player_key_type = $this->request->get('player_key_type');
        if ($player_key_type === null) {
            return $this->error('`player_key_type` is required');
        }
        $player_key = $this->request->get('player_key');
        if ($player_key === null) {
            return $this->error('`player_key` is required');
        }

        // check server id
        $server_model = $this->getVisableServerModel($server_id);
        if ($server_model === false) {
            return $this->error('`server_id` is invalid');
        }

        $ret = $this->slaveServerRequest(
            $server_model->addr, $server_model->secret_key,
            '/player_brief_info.php', array(
                'player_key_type' => $player_key_type,
                'player_key' => $player_key,
            ));
        if ($ret === false) {
            return $this->error('request slave server failed');
        }

        if (isset($ret['brief_info'])) {
            $brief_info = &$ret['brief_info'];

            $brief_info['last_logout_time'] = DataFormatter::timestamp(
                $brief_info['last_logout_time']);
            $brief_info['create_time'] = DataFormatter::timestamp(
                $brief_info['create_time']);
            $brief_info['ban_until_time'] = DataFormatter::timestamp(
                $brief_info['ban_until_time']);
            $brief_info['total_pay_amount'] = sprintf("%.2f",
                $brief_info['total_pay_amount'] / 100.0);

            unset($brief_info);

            // set player management cache
            $this->session->set('player_management_cache', array(
                'server_id' => $server_id,
                'player_id' => $ret['brief_info']['player_id'],
            ));
        }

        return $this->success($ret);
    }

    public function doGlobalSearchAction()
    {
        $this->view->disable();

        // check auth
        if ($this->hasAuth(AccountType::GM) == false) {
            return $this->error('not allowed');
        }

        // get params
        $player_key_type = $this->request->get('player_key_type');
        if ($player_key_type === null) {
            return $this->error('`player_key_type` is required');
        }
        $player_key = $this->request->get('player_key');
        if ($player_key === null) {
            return $this->error('`player_key` is required');
        }

        $request_list = array();
        $server_model_list = $this->getVisableServerModelList();
        foreach ($server_model_list as $server_model) {
            array_push($request_list, array(
                'addr' => $server_model->addr,
                'secret_key' => $server_model->secret_key,
                'uri' => '/player_brief_info.php',
                'params' => array(
                    'player_key_type' => $player_key_type,
                    'player_key' => $player_key,
                ),
            ));
        }
        $ret_list = $this->multiSlaveServerRequest($request_list);

        for ($i = 0; $i < count($ret_list); ++$i) {
            $ret_list[$i]['server_name'] = $server_model_list[$i]->desc;
        }

        $search_result = array();
        foreach ($ret_list as $ret) {
            if ($ret === false) {
                continue;
            }
            if (isset($ret['error_code'])) {
                continue;
            }

            $brief_info = &$ret['brief_info'];

            $brief_info['server_name'] = $ret['server_name'];
            $brief_info['last_logout_time'] = DataFormatter::timestamp(
                $brief_info['last_logout_time']);
            $brief_info['create_time'] = DataFormatter::timestamp(
                $brief_info['create_time']);
            $brief_info['ban_until_time'] = DataFormatter::timestamp(
                $brief_info['ban_until_time']);
            $brief_info['total_pay_amount'] = sprintf("%.2f",
                $brief_info['total_pay_amount'] / 100.0);

            unset($brief_info);

            array_push($search_result, $ret['brief_info']);
        }

        return $this->success(array(
            'search_result' => $search_result,
        ));
    }

    public function banAccountAction()
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
        $player_id = $this->request->get('player_id');
        if ($player_id === null) {
            return $this->error('`player_id` is required');
        }
        $ban_hours = $this->request->get('ban_hours');
        if ($ban_hours === null) {
            return $this->error('`ban_hours` is required');
        }

        // check server id
        $server_model = $this->getVisableServerModel($server_id);
        if ($server_model === false) {
            return $this->error('`server_id` is invalid');
        }

        $ret = $this->slaveServerRequest(
            $server_model->addr, $server_model->secret_key,
            '/player_ban.php', array(
                'player_id' => $player_id,
                'ban_hours' => $ban_hours,
            ));
        if ($ret === false) {
            return $this->error('request slave server failed');
        }

        if (isset($ret['error_code'])) {
            return $this->success($ret);
        }

        // op log
        $server_desc = $server_model->desc;
        if ($ban_hours == 0) {
            $this->opLog("[Unlock account] server: $server_desc player_ID: $player_id");
        } else {
            $this->opLog("[Closed account] server: $server_desc player_ID: $player_id ".
                         "Closed  time: ${ban_hours}hour");
        }

        return $this->success($ret);
    }

    public function doGmLoginAction()
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
        $player_id = $this->request->get('player_id');
        if ($player_id === null) {
            return $this->error('`player_id` is required');
        }
        $login_switch = $this->request->get('login_switch');
        if ($login_switch === null) {
            return $this->error('`login_switch` is required');
        }

        // check server id
        $server_model = $this->getVisableServerModel($server_id);
        if ($server_model === false) {
            return $this->error('`server_id` is invalid');
        }

        $ret = $this->slaveServerRequest(
            $server_model->addr, $server_model->secret_key,
            '/player_gm_login.php', array(
                'player_id' => $player_id,
                'login_switch' => $login_switch,
            ));
        if ($ret === false) {
            return $this->error('request slave server failed');
        }

        if (isset($ret['error_code'])) {
            return $this->success($ret);
        }

        // op log
        $server_desc = $server_model->desc;
        if ($login_switch == 0) {
            $this->opLog("[GMLogin settings are closed] server: $server_desc player_ID: $player_id");
        } else {
            $this->opLog("[GMLogin settings are on] server: $server_desc player_ID: $player_id");
        }

        return $this->success($ret);
    }

    public function getPayTransactionAction()
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
        $start_date = $this->request->get('start_date');
        if ($start_date === null) {
            return $this->error('`start_date` is required');
        }
        $end_date = $this->request->get('end_date');
        if ($end_date === null) {
            return $this->error('`end_date` is required');
        }
        $player_id = $this->request->get('player_id');
        if ($player_id === null) {
            return $this->error('`player_id` is required');
        }
        $order_id = $this->request->get('order_id');
        if ($order_id === null) {
            return $this->error('`order_id` is required');
        }

        // check server id
        $server_model = $this->getVisableServerModel($server_id);
        if ($server_model === false) {
            return $this->error('`server_id` is invalid');
        }

        $ret = $this->slaveServerRequest(
            $server_model->addr, $server_model->secret_key,
            '/pay_transaction.php', array(
                'start_date' => $start_date,
                'end_date' => $end_date,
                'player_id' => $player_id,
                'order_id' => $order_id,
            ));
        if ($ret === false) {
            return $this->error('request slave server failed');
        }

        if (isset($ret['error_code'])) {
            return $this->success($ret);
        }

        foreach ($ret as &$row) {
            $row['transaction_time'] = DataFormatter::timestamp(
                $row['transaction_time']);
            $row['amount'] = sprintf("%.2f",
                $row['amount'] / 100.0);
        }

        return $this->success(array(
            'transaction_list' => $ret,
        ));
    }

    public function getPayTmallTransactionAction()
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
        $start_date = $this->request->get('start_date');
        if ($start_date === null) {
            return $this->error('`start_date` is required');
        }
        $end_date = $this->request->get('end_date');
        if ($end_date === null) {
            return $this->error('`end_date` is required');
        }
        $player_id = $this->request->get('player_id');
        if ($player_id === null) {
            return $this->error('`player_id` is required');
        }
        $order_id = $this->request->get('order_id');
        if ($order_id === null) {
            return $this->error('`order_id` is required');
        }

        // check server id
        $server_model = $this->getVisableServerModel($server_id);
        if ($server_model === false) {
            return $this->error('`server_id` is invalid');
        }

        $ret = $this->slaveServerRequest(
            $server_model->addr, $server_model->secret_key,
            '/tmall_pay_transaction.php', array(
                'start_date' => $start_date,
                'end_date' => $end_date,
                'player_id' => $player_id,
                'order_id' => $order_id,
            ));
        if ($ret === false) {
            return $this->error('request slave server failed');
        }

        if (isset($ret['error_code'])) {
            return $this->success($ret);
        }

        foreach ($ret as &$row) {
            $row['transaction_time'] = DataFormatter::timestamp(
                $row['transaction_time']);
            $row['amount'] = sprintf("%.2f",
                $row['amount'] / 100.0);
        }

        return $this->success(array(
            'transaction_list' => $ret,
        ));
    }

    public function getCpsPayTransactionAction()
    {
        $this->view->disable();

        // check auth
        if ($this->hasAuth(AccountType::GM) == false) {
            return $this->error('not allowed');
        }

        // get params
        $server_id = $this->request->get('server_id');
        if ($server_id === null) {
            return $this->error('`server_id` is required');
        }
        $start_date = $this->request->get('start_date');
        if ($start_date === null) {
            return $this->error('`start_date` is required');
        }
        $end_date = $this->request->get('end_date');
        if ($end_date === null) {
            return $this->error('`end_date` is required');
        }
        $player_id = $this->request->get('player_id');
        if ($player_id === null) {
            return $this->error('`player_id` is required');
        }
        $order_id = $this->request->get('order_id');
        if ($order_id === null) {
            return $this->error('`order_id` is required');
        }

        $account_cps = $this->getAccountCps();
        $account_cps = ($account_cps == '' ? 'ALL' : $account_cps);

        // check server id
        $server_model = $this->getVisableServerModel($server_id);
        if ($server_model === false) {
            return $this->error('`server_id` is invalid');
        }

        $ret = $this->slaveServerRequest(
            $server_model->addr, $server_model->secret_key,
            '/cps_pay_transaction.php', array(
                'start_date' => $start_date,
                'end_date' => $end_date,
                'player_id' => $player_id,
                'order_id' => $order_id,
                'cps' => $account_cps,
            ));
        if ($ret === false) {
            return $this->error('request slave server failed');
        }

        if (isset($ret['error_code'])) {
            return $this->success($ret);
        }

        foreach ($ret as &$row) {
            $row['transaction_time'] = DataFormatter::timestamp(
                $row['transaction_time']);
            $row['amount'] = sprintf("%.2f",
                $row['amount'] / 100.0);
        }

        return $this->success(array(
            'transaction_list' => $ret,
        ));
    }

    public function getOnlineListAction()
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
            '/player_online_list.php');
        if ($ret === false) {
            return $this->error('request slave server failed');
        }

        if (isset($ret['error_code'])) {
            return $this->success($ret);
        }

        foreach ($ret['online_list'] as &$row) {
            $row['online_time'] =
                (int)($row['online_time'] / 60);
            $row['total_pay_amount'] = sprintf("%.2f",
                $row['total_pay_amount'] / 100.0);
            $row['create_time'] = DataFormatter::timestamp(
                $row['create_time']);
        }

        return $this->success($ret);
    }

    public function getMailListAction()
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
        $player_id = $this->request->get('player_id');
        if ($player_id === null) {
            return $this->error('`player_id` is required');
        }

        // check server id
        $server_model = $this->getVisableServerModel($server_id);
        if ($server_model === false) {
            return $this->error('`server_id` is invalid');
        }

        $ret = $this->slaveServerRequest(
            $server_model->addr, $server_model->secret_key,
            '/player_mail_list.php', array(
                'player_id' => $player_id,
             ));
        if ($ret === false) {
            return $this->error('request slave server failed');
        }

        if (isset($ret['error_code'])) {
            return $this->success($ret);
        }

        foreach ($ret['mail_list'] as &$row) {
            $row['send_time'] =
                DataFormatter::timestamp($row['send_time']);
            $row['expired_time'] =
                DataFormatter::timestamp($row['expired_time']);
        }

        return $this->success($ret);
    }

    public function getBuddyListAction()
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
        $player_id = $this->request->get('player_id');
        if ($player_id === null) {
            return $this->error('`player_id` is required');
        }

        // check server id
        $server_model = $this->getVisableServerModel($server_id);
        if ($server_model === false) {
            return $this->error('`server_id` is invalid');
        }

        $ret = $this->slaveServerRequest(
            $server_model->addr, $server_model->secret_key,
            '/player_buddy_list.php', array(
                'player_id' => $player_id,
             ));
        if ($ret === false) {
            return $this->error('request slave server failed');
        }

        if (isset($ret['error_code'])) {
            return $this->success($ret);
        }

        return $this->success($ret);
    }

    public function getEquipListAction()
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
        $player_id = $this->request->get('player_id');
        if ($player_id === null) {
            return $this->error('`player_id` is required');
        }

        // check server id
        $server_model = $this->getVisableServerModel($server_id);
        if ($server_model === false) {
            return $this->error('`server_id` is invalid');
        }

        $ret = $this->slaveServerRequest(
            $server_model->addr, $server_model->secret_key,
            '/player_equip_list.php', array(
                'player_id' => $player_id,
             ));
        if ($ret === false) {
            return $this->error('request slave server failed');
        }

        if (isset($ret['error_code'])) {
            return $this->success($ret);
        }

        return $this->success($ret);
    }

    public function getSoulListAction()
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
        $player_id = $this->request->get('player_id');
        if ($player_id === null) {
            return $this->error('`player_id` is required');
        }

        // check server id
        $server_model = $this->getVisableServerModel($server_id);
        if ($server_model === false) {
            return $this->error('`server_id` is invalid');
        }

        $ret = $this->slaveServerRequest(
            $server_model->addr, $server_model->secret_key,
            '/player_soul_list.php', array(
                'player_id' => $player_id,
             ));
        if ($ret === false) {
            return $this->error('request slave server failed');
        }

        if (isset($ret['error_code'])) {
            return $this->success($ret);
        }

        return $this->success($ret);
    }

    public function getPlayerRankAction()
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
        $rank_type = $this->request->get('rank_type');
        if ($rank_type === null) {
            return $this->error('`rank_type` is required');
        }

        // check server id
        $server_model = $this->getVisableServerModel($server_id);
        if ($server_model === false) {
            return $this->error('`server_id` is invalid');
        }

        $ret = $this->slaveServerRequest(
            $server_model->addr, $server_model->secret_key,
            '/player_rank.php', array(
                'rank_type' => $rank_type,
            ));
        if ($ret === false) {
            return $this->error('request slave server failed');
        }

        if (isset($ret['error_code'])) {
            return $this->success($ret);
        }

        foreach ($ret as &$row) {
            $row['last_logout_time'] = DataFormatter::timestamp(
                $row['last_logout_time']);
            $row['create_time'] = DataFormatter::timestamp(
                $row['create_time']);
            $row['is_online'] = $row['is_online'] ? 'Y' : 'N';
            if (isset($row['online_time'])) {
                $row['online_time'] =
                    (int)($row['online_time'] / 60);
            }
            $row['total_pay_amount'] = sprintf("%.2f",
                $row['total_pay_amount'] / 100.0);
        }

        return $this->success(array(
            'rank_list' => $ret,
        ));
    }

    public function doGmPayAction()
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
        $pay_id = $this->request->get('pay_id');
        if ($pay_id === null) {
            return $this->error('`pay_id` is required');
        }
        $amount = $this->request->get('amount');
        if ($amount === null) {
            return $this->error('`amount` is required');
        }

        // check server id
        $server_model = $this->getVisableServerModel($server_id);
        if ($server_model === false) {
            return $this->error('`server_id` is invalid');
        }

        $ret = $this->slaveServerRequest(
            $server_model->addr, $server_model->secret_key,
            '/gm_pay.php', array(
                'player_id' => $player_id,
                'pay_id' => $pay_id,
                'amount' => $amount,
            ));
        if ($ret === false) {
            return $this->error('request slave server failed');
        }

        if (isset($ret['error_code'])) {
            return $this->success($ret);
        }

        // op log
        $server_desc = $server_model->desc;
        $this->opLog("[GM Recharge] server: $server_desc ".
                     "player_ID: $player_id Amount of money: ${amount}");

        return $this->success($ret);
    }


    public function doGmConsumeDiamondAction()
    {
        $this->view->disable();

        // check auth
        if ($this->hasAuth(AccountType::ADMIN) == false) {
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
        $amount = $this->request->get('amount');
        if ($amount === null) {
            return $this->error('`amount` is required');
        }

        // check server id
        $server_model = $this->getVisableServerModel($server_id);
        if ($server_model === false) {
            return $this->error('`server_id` is invalid');
        }

        $ret = $this->slaveServerRequest(
            $server_model->addr, $server_model->secret_key,
            '/gm_consume_diamond.php', array(
                'player_id' => $player_id,
                'amount' => $amount,
            ));
        if ($ret === false) {
            return $this->error('request slave server failed');
        }

        if (isset($ret['error_code'])) {
            return $this->success($ret);
        }

        // op log
        $server_desc = $server_model->desc;
        $this->opLog("[GMDeduct game currency] server: $server_desc ".
                     "player_ID: $player_id Amount of money: ${amount}");

        return $this->success($ret);
    }

    public function doGmFinishCopyAction()
    {
        $this->view->disable();

        // check auth
        if ($this->hasAuth(AccountType::ADMIN) == false) {
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
        $copy_id = $this->request->get('copy_id');
        if ($copy_id === null) {
            return $this->error('`copy_id` is required');
        }

        // check server id
        $server_model = $this->getVisableServerModel($server_id);
        if ($server_model === false) {
            return $this->error('`server_id` is invalid');
        }

        $ret = $this->slaveServerRequest(
            $server_model->addr, $server_model->secret_key,
            '/gm_finish_copy.php', array(
                'player_id' => $player_id,
                'copy_id' => $copy_id,
            ));
        if ($ret === false) {
            return $this->error('request slave server failed');
        }

        if (isset($ret['error_code'])) {
            return $this->success($ret);
        }

        // op log
        $server_desc = $server_model->desc;
        $this->opLog("[GM Complete the copy] server: $server_desc ".
                     "player_ID: $player_id copy_ID: $copy_id");

        return $this->success($ret);
    }

    public function doGmFinishEliteCopyAction()
    {
        $this->view->disable();

        // check auth
        if ($this->hasAuth(AccountType::ADMIN) == false) {
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
        $copy_id = $this->request->get('copy_id');
        if ($copy_id === null) {
            return $this->error('`copy_id` is required');
        }

        // check server id
        $server_model = $this->getVisableServerModel($server_id);
        if ($server_model === false) {
            return $this->error('`server_id` is invalid');
        }

        $ret = $this->slaveServerRequest(
            $server_model->addr, $server_model->secret_key,
            '/gm_finish_copy.php', array(
                'player_id' => $player_id,
                'copy_id' => $copy_id,
                'elite_copy' => 1,
            ));
        if ($ret === false) {
            return $this->error('request slave server failed');
        }

        if (isset($ret['error_code'])) {
            return $this->success($ret);
        }

        // op log
        $server_desc = $server_model->desc;
        $this->opLog("[GM Complete a copy of the elite] server: $server_desc ".
                     "player_ID: $player_id copy_ID: $copy_id");

        return $this->success($ret);
    }

    public function doOnekeyDevelopAction()
    {
        $this->view->disable();

        // check auth
        if ($this->hasAuth(AccountType::ADMIN) == false) {
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
        $develop_id = $this->request->get('develop_id');
        if ($develop_id === null) {
            return $this->error('`develop_id` is required');
        }

        // check server id
        $server_model = $this->getVisableServerModel($server_id);
        if ($server_model === false) {
            return $this->error('`server_id` is invalid');
        }

        $ret = $this->slaveServerRequest(
            $server_model->addr, $server_model->secret_key,
            '/onekey_develop.php', array(
                'player_id' => $player_id,
                'develop_id' => $develop_id,
            ));
        if ($ret === false) {
            return $this->error('request slave server failed');
        }

        if (isset($ret['error_code'])) {
            return $this->success($ret);
        }

        // op log
        $server_desc = $server_model->desc;
        $this->opLog("[A key culture] server: $server_desc ".
                     "player_ID: $player_id culture_ID: $develop_id");

        return $this->success($ret);
    }
}
