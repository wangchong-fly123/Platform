<?php

final class UserController extends ControllerBase
{
    public function listAction()
    {
        $this->view->setVar(
            'display_add_user_form_super_admin_option',
            $this->hasAuth(AccountType::SUPER_ADMIN));
    }

    public function opLogAction()
    {
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

        return $this->success(AccountModel::find(array(
            'columns' => '[account], [account_type], [platform_id], [exclude_channel], [cps]',
            'order' => 'account_type, account',
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
        $account_type = $this->request->get('account_type');
        if ($account_type === null) {
            return $this->error('`account_type` is required');
        }
        $platform_id = $this->request->get('platform_id');
        if ($platform_id === null) {
            return $this->error('`platform_id` is required');
        }
        $password = $this->request->get('password');
        if ($password === null) {
            return $this->error('`password` is required');
        }
        $exclude_channel = $this->request->get('exclude_channel');
        if ($exclude_channel === null) {
            $exclude_channel = '';
        }
        $cps = $this->request->get('cps');
        if ($cps === null) {
            $cps = '';
        }

        if (preg_match('/^\w{4,20}$/', $account) !== 1) {
            return $this->error('`account` is invalid');
        }
        if (preg_match('/^.{8,20}$/', $password) !== 1) {
            return $this->error('`password` is invalid');
        }
        if (preg_match('/^\d{1,2}$/', $platform_id) !== 1) {
            return $this->error('`platform_id` is invalid');
        }
        if ($account_type > AccountType::MAX ||
            $account_type <= AccountType::SUPER_ADMIN ||
            $account_type <= $this->getAccountType()) {
            return $this->error('`account_type` is invalid');
        }

        if ($account_type == AccountType::ADMIN ||
            $account_type == AccountType::OPERATION_STAFF) {
            $platform_id = 0;
        }

        $account_model = new AccountModel();
        $account_model->account = $account;
        $account_model->password = sha1('enjoymi'.$account.$password);
        $account_model->account_type = $account_type;
        $account_model->platform_id = $platform_id;
        $account_model->exclude_channel = $exclude_channel;
        $account_model->cps = $cps;
        
        if ($account_model->cps != '' && $account_type != AccountType::GM) {
            return $this->error('`account_type` is invalid');
        }

        if ($account_model->create() === false) {
            return $this->error('save to db failed');
        }

        // op log
        $this->opLog("[新增用户] 用户名: $account 类型: $account_type ".
                     "所属平台: $platform_id");

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

        $account_model = AccountModel::findFirstByAccount($account);
        if ($account_model === false) {
            return $this->error('`account` is invalid');
        }

        if ($account_model->account_type <= $this->getAccountType()) {
            return $this->error('not allowed');
        }

        $account_model->delete();

        // op log
        $this->opLog("[删除用户] 用户名: $account");

        return $this->success(array(
            'success' => true,
        ));
    }

    public function changePasswordAction()
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
        $old_password = $this->request->get('old_password');
        if ($old_password === null) {
            return $this->error('`old_password` is required');
        }
        $new_password = $this->request->get('new_password');
        if ($new_password === null) {
            return $this->error('`new_password` is required');
        }

        if (preg_match('/^.{8,20}$/', $new_password) !== 1) {
            return $this->error('`new_password` is invalid');
        }

        $account_model = AccountModel::findFirstByAccount($account);
        if ($account_model === false) {
            return $this->error('`account` is invalid');
        }

        // change self password need check old password
        if ($this->getAccount() == $account_model->account) {
            if ($account_model->password != sha1(
                    'enjoymi'.$account.$old_password)) {
                return $this->error('`old_password` is invalid');
            }
        } else {
            // change other's password need check auth
            if ($account_model->account_type <= $this->getAccountType()) {
                return $this->error('not allowed');
            }
        }

        $account_model->password = sha1('enjoymi'.$account.$new_password);
        $account_model->update();

        // op log
        $this->opLog("[修改密码] 用户名: $account");

        return $this->success(array(
            'success' => true,
        ));
    }

    public function getOpLogAction()
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
        $start_date = $this->request->get('start_date');
        if ($start_date === null) {
            return $this->error('`start_date` is required');
        }
        $end_date = $this->request->get('end_date');
        if ($end_date === null) {
            return $this->error('`end_date` is required');
        }

        $conditions = 'timestamp >= :start_ts: AND timestamp < :end_ts:';
        $bind_params = array(
            'start_ts' => Util::dateToUnixTimestamp($start_date),
            'end_ts' => Util::dateToUnixTimestamp($end_date) + 86400,
        );
        if ($account != '') {
            $conditions .= ' AND account = :account:';
            $bind_params['account'] = $account;
        }

        $ret = OpLogModel::find(array( 
            'columns' => '[timestamp], [account], [log]',
            'conditions' => $conditions,
            'bind' => $bind_params,
        ))->toArray();

        foreach ($ret as &$log_item) {
            $log_item['timestamp'] = DataFormatter::timestamp(
                $log_item['timestamp']);
        }

        return $this->success(array(
            'log_list' => $ret,
        ));
    }
}
