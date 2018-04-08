<?php

final class ServerController extends ControllerBase
{
    public function listAction()
    {
    }

    public function briefInfoAction()
    {
        $this->view->setVar('display_func_list',
            $this->hasAuth(AccountType::ADMIN));
    }

    public function getServerListAction()
    {
        $this->view->disable();

        // check auth
        if ($this->hasAuth(AccountType::ADMIN) == false &&
            $this->getAccountType() != AccountType::OPERATION_STAFF) {
            return $this->error('not allowed');
        }

        return $this->success(ServerModel::find()->toArray());
    }

    public function addServerAction()
    {
        $this->view->disable();

        // check auth
        if ($this->hasAuth(AccountType::ADMIN) == false &&
            $this->getAccountType() != AccountType::OPERATION_STAFF) {
            return $this->error('not allowed');
        }

        // get params
        $platform_id = $this->request->get('platform_id');
        if ($platform_id === null) {
            return $this->error('`platform_id` is required');
        }
        $server_id = $this->request->get('server_id');
        if ($server_id === null) {
            return $this->error('`server_id` is required');
        }
        $desc = $this->request->get('desc', null, '');
        $addr = $this->request->get('addr');
        if ($addr === null) {
            return $this->error('`addr` is required');
        }
        $secret_key = $this->request->get('secret_key');
        if ($secret_key === null) {
            return $this->error('`secret_key` is required');
        }

        $server_model = new ServerModel();
        $server_model->id = (int)($platform_id * 10000 + $server_id);
        $server_model->platform_id = (int)$platform_id;
        $server_model->server_id = (int)$server_id;
        $server_model->desc = $desc;
        $server_model->addr = $addr;
        $server_model->secret_key = $secret_key;
        if ($server_model->create() === false) {
            return $this->error('save to db failed');
        }

        // op log
        $this->opLog("[新增服务器] 平台ID: $platform_id ".
                     "服务器ID: $server_id 服务器描述: $desc ".
                     "服务器地址: $addr");

        return $this->success(array(
            'success' => true,
        ));
    }

    public function updateServerAction()
    {
        $this->view->disable();

        // check auth
        if ($this->hasAuth(AccountType::ADMIN) == false &&
            $this->getAccountType() != AccountType::OPERATION_STAFF) {
            return $this->error('not allowed');
        }

        // get params
        $platform_id = $this->request->get('platform_id');
        if ($platform_id === null) {
            return $this->error('`platform_id` is required');
        }
        $server_id = $this->request->get('server_id');
        if ($server_id === null) {
            return $this->error('`server_id` is required');
        }
        $desc = $this->request->get('desc', null, '');
        $addr = $this->request->get('addr');
        if ($addr === null) {
            return $this->error('`addr` is required');
        }
        $secret_key = $this->request->get('secret_key');
        if ($secret_key === null) {
            return $this->error('`secret_key` is required');
        }

        $server_model = new ServerModel();
        $server_model->id = (int)($platform_id * 10000 + $server_id);
        $server_model->platform_id = (int)$platform_id;
        $server_model->server_id = (int)$server_id;
        $server_model->desc = $desc;
        $server_model->addr = $addr;
        $server_model->secret_key = $secret_key;
        if ($server_model->save() === false) {
            return $this->error('save to db failed');
        }

        // op log
        $this->opLog("[编辑服务器] 平台ID: $platform_id ".
                     "服务器ID: $server_id 服务器描述: $desc ".
                     "服务器地址: $addr");

        return $this->success(array(
            'success' => true,
        ));
    }

    public function removeServerAction()
    {
        $this->view->disable();

        // check auth
        if ($this->hasAuth(AccountType::ADMIN) == false &&
            $this->getAccountType() != AccountType::OPERATION_STAFF) {
            return $this->error('not allowed');
        }

        // get params
        $id = $this->request->get('id');
        if ($id === null) {
            return $this->error('`id` is required');
        }

        $server_model = ServerModel::findFirst($id);
        if ($server_model !== false) {
            $platform_id = $server_model->platform_id;
            $server_id = $server_model->server_id;
            $desc = $server_model->desc;
            // delete server
            $server_model->delete();
            // op log
            $this->opLog("[删除服务器] 平台ID: $platform_id ".
                         "服务器ID: $server_id 服务器描述: $desc");
        }

        return $this->success(array(
            'success' => true,
        ));
    }

    public function getBriefInfoAction()
    {
        $this->view->disable();

        // check auth
        if ($this->hasAuth(AccountType::ADVANCED_GM) == false &&
            $this->getAccountType() != AccountType::OPERATION_STAFF) {
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
            '/server_brief_info.php');
        if ($ret === false) {
            return $this->error('request slave server failed');
        }

        return $this->success($ret);
    }

    public function loginSwitchAction()
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
        $forbid_login = $this->request->get('forbid_login');
        if ($forbid_login === null) {
            return $this->error('`forbid_login` is required');
        }

        // check server id
        $server_model = $this->getVisableServerModel($server_id);
        if ($server_model === false) {
            return $this->error('`server_id` is invalid');
        }

        $ret = $this->slaveServerRequest(
            $server_model->addr, $server_model->secret_key,
            '/login_switch.php', array(
                'forbid_login' => $forbid_login,
            ));
        if ($ret === false) {
            return $this->error('request slave server failed');
        }

        // op log
        $server_desc = $server_model->desc;
        $this->opLog("[修改服务器登录设置] 服务器: $server_desc ".
                     " 是否关闭登录: $forbid_login");

        return $this->success($ret);
    }
}
