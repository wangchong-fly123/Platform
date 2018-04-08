<?php

final class SpreadController extends ControllerBase
{
    public function listAction()
    {
        $this->view->setVar(
            'display_add_spread_form_super_admin_option',
            $this->hasAuth(AccountType::SUPER_ADMIN));
    }

    public function syncSpreadToGame()
    {
        $ret = SpreadModel::find(array(
            'columns' => '[url], [desc]',
        ))->toArray();

        if (count($ret) == 0) {
            return false;
        }
        
        $request_list = array();
        $server_model_list = $this->getVisableServerModelList();
        foreach ($server_model_list as $server_model) {
            array_push($request_list, array(
                'addr' => $server_model->addr,
                'secret_key' => $server_model->secret_key,
                'uri' => '/update_spread.php',
                'params' => array(
                    'url_list' => serialize($ret),
                ),
            ));
        }
        $ret_list = $this->multiSlaveServerRequest($request_list);
        foreach ($ret_list as $ret) {
        }
        return true;
    }

    public function getSpreadSuggestAction()
    {
        $this->view->disable();

        // check auth
        if ($this->hasAuth(AccountType::ADMIN) == false) {
            return $this->error('not allowed');
        }

        $ret = SpreadModel::find(array(
            'columns' => '[url], [desc]',
        ))->toArray();
        array_unshift($ret, array(
            'url' => 'ALL',
            'desc' => '所有平台',
        ));

        return $this->success($ret);
    }

    public function getSpreadListAction()
    {
        $this->view->disable();

        // check auth
        if ($this->hasAuth(AccountType::ADMIN) == false) {
            return $this->error('not allowed');
        }

        return $this->success(SpreadModel::find(array(
            'columns' => '[url], [desc]',
            'order' => 'url',
        ))->toArray());
    }

    public function addSpreadAction()
    {
        $this->view->disable();

        // check auth
        if ($this->hasAuth(AccountType::ADMIN) == false) {
            return $this->error('not allowed');
        }

        // get params
        $url = $this->request->get('url');
        if ($url === null) {
            return $this->error('`url` is required');
        }
        $desc = $this->request->get('desc');
        if ($desc === null) {
            return $this->error('`desc` is required');
        }

        $spread = SpreadModel::findFirstByUrl($url);
        if ($spread != false) {
            return $this->error('`url` is invalid');
        }

        $ret = SpreadModel::find(array(
            'columns' => '[url], [desc]',
        ))->toArray();
        if (count($ret) >= 10) {
            return $this->error('url max num is 10');
        }

        $spread_model = new SpreadModel();
        $spread_model->url = $url;
        $spread_model->desc = $desc;
        
        if ($spread_model->create() === false) {
            return $this->error('save to db failed');
        }

        // op log
        $this->opLog("[新增推广] 短链: $url 描述: $desc ");
        
        $this->syncSpreadToGame();

        return $this->success(array(
            'success' => true,
        ));
    }

    public function removeSpreadAction()
    {
        $this->view->disable();

        // check auth
        if ($this->hasAuth(AccountType::ADMIN) == false) {
            return $this->error('not allowed');
        }

        // get params
        $url = $this->request->get('url');
        if ($url === null) {
            return $this->error('`url` is required');
        }

        $spread_model = SpreadModel::findFirstByUrl($url);
        if ($spread_model === false) {
            return $this->error('`url` is invalid');
        }

        $spread_model->delete();

        // op log
        $this->opLog("[删除推广] 推广短链url: $url");

        $this->syncSpreadToGame();

        return $this->success(array(
            'success' => true,
        ));
    }

}
