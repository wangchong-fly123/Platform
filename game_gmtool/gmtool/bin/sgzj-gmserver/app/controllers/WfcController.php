<?php

final class WfcController extends ControllerBase
{
    public function listAction()
    {
        $this->view->setVar(
            'display_add_user_form_super_admin_option',
            $this->hasAuth(AccountType::SUPER_ADMIN));
    }

    public function getPlatformSuggestAction()
    {
        $this->view->disable();

        // check auth
        if ($this->hasAuth(AccountType::ADMIN) == false) {
            return $this->error('not allowed');
        }

        $ret = PlatformModel::find(array(
            'columns' => '[id], [desc]',
        ))->toArray();
        array_unshift($ret, array(
            'id' => '0',
            'desc' => '所有平台',
        ));

        return $this->success($ret);
    }

    public function getUserListAction()
    {
        $this->view->disable();

        // check auth
        if ($this->hasAuth(AccountType::ADMIN) == false) {
            return $this->error('not allowed');
        }

        return $this->success(WfcAccountModel::find(array(
            'columns' => '[id], [account], [server_info], [round_win_times], [is_out]',
            'order' => 'id',
        ))->toArray());
    }

    public function addUserAction()
    {
        $this->view->disable();

        // check auth
        if ($this->hasAuth(AccountType::ADMIN) == false) {
            return $this->error('not allowed');
        }

        // get params
        $account = $this->request->get('account');
        if ($account === null) {
            return $this->error('`account` is required');
        }
        $server_info = $this->request->get('server_info');
        if ($server_info === null) {
            return $this->error('`server_info` is required');
        }
        $id = $this->request->get('id');
        if ($id === null) {
            return $this->error('`id` is required');
        }

        $account_model = new WfcAccountModel();
        $account_model->account = $account;
        $account_model->server_info = $server_info;
        $account_model->id = $id;
        $account_model->is_out = 0;
        $account_model->round_win_times = 0;
        
        if ($account_model->create() === false) {
            return $this->error('save to db failed');
        }

        // op log
        $this->opLog("[新增wfc用户] 用户名: $account 区服信息: $server_info");

        return $this->success(array(
            'success' => true,
        ));
    }

    public function removeUserAction()
    {
        $this->view->disable();

        // check auth
        if ($this->hasAuth(AccountType::ADMIN) == false) {
            return $this->error('not allowed');
        }

        // get params
        $account = $this->request->get('account');
        if ($account === null) {
            return $this->error('`account` is required');
        }

        $account_model = WfcAccountModel::findFirstByAccount($account);
        if ($account_model === false) {
            return $this->error('`account` is invalid');
        }

        $account_model->delete();

        // op log
        $this->opLog("[删除用户] 用户名: $account");

        return $this->success(array(
            'success' => true,
        ));
    }

    public function changeRoundWinTimesAction()
    {
        $this->view->disable();

        // check auth
        if ($this->hasAuth(AccountType::ADMIN) == false) {
            return $this->error('not allowed');
        }
        // get params
        $account = $this->request->get('account');
        if ($account === null) {
            return $this->error('`account` is required');
        }
        $round_win_times = $this->request->get('round_win_times');
        if ($round_win_times === null) {
            return $this->error('`round_win_times` is required');
        }
        $is_out = $this->request->get('is_out');
        if ($is_out === null) {
            return $this->error('`is_out`  is required');
        }

        $account_model = WfcAccountModel::findFirstByAccount($account);
        if ($account_model === false) {
            return $this->error('`account` is invalid');
        }

        $account_model->round_win_times = $round_win_times;
        $account_model->is_out = $is_out;
        $account_model->update();

        // op log
        $this->opLog("[修改胜利轮次] 用户名: $account [轮次]: %round_win_times, [是否被淘汰]: $is_out");

        return $this->success(array(
            'success' => true,
        ));
    }

    public function commitUserListAction()
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
        $is_on = $this->request->get('is_on');
        if ($is_on === null) {
            return $this->error('`is_on` is required');
        }
        $session = $this->request->get('session');
        if ($session === null) {
            return $this->error('`session` is required');
        }
        // check server id
        $server_model = $this->getVisableServerModel($server_id);
        if ($server_model === false) {
            return $this->error('`server_id` is invalid');
        }

        $user_list = WfcAccountModel::find(array(
            'columns' => '[id], [account], [server_info], [round_win_times], [is_out]',
            'order' => 'id',
            ))->toArray();
        $ret = $this->slaveServerRequest(
            $server_model->addr, $server_model->secret_key,
            '/commit_wfc_user_list.php',array('user_list' => serialize($user_list),
            'session' => $session, 'is_on' => $is_on)); 
        if ($ret === false) {
            return $this->error('request slave server failed');
        }

        if (isset($ret['error_code'])) {
            return $this->success($ret);
        }

        return $this->success($ret);
    }
}
