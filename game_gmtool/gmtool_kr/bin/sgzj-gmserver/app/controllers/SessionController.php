<?php

use \Phalcon\Mvc\Controller;

final class SessionController extends ControllerBase
{
    public function initialize()
    {
        // do not use default settings
    }

    public function loginAction()
    {
    }

    public function startAction()
    {
        $this->view->disable();

        if ($this->session->has('auth')) {
            return $this->success(array(
                'success' => true,
            ));
        }

        // get params
        $account = $this->request->getPost('account');
        if ($account === null) {
            return $this->error('`account` is required');
        }
        $password = $this->request->getPost('password');
        if ($password === null) {
            return $this->error('`password` is required');
        }

        $account_model = AccountModel::findFirstByAccount($account);
        if ($account_model === false) {
            return $this->error('', ErrorCode::USER_OR_PASSWORD_INVALID);
        }

        // check password
        $check_password = sha1('enjoymi'.$account.$password);
        if ($check_password != $account_model->password) {
            return $this->error('', ErrorCode::USER_OR_PASSWORD_INVALID);
        }

        // set session
        $this->setAuthSession($account_model->account,
                              $account_model->account_type,
                              $account_model->platform_id,
                              $account_model->exclude_channel,
                              $account_model->cps);

        // op log
        $client_ip = $this->request->getClientAddress();
        $this->opLog("[Login system] IP_address: $client_ip");

        return $this->success(array(
            'success' => true,
        ));
    }

    public function endAction()
    {
        $this->session->destroy();
        return $this->gotoLogin();
    }
}
