<?php

final class MarketController extends ControllerBase
{
    public function indexAction()
    {
    }

    public function getMarketListAction()
    {
        $this->view->disable();

        // check auth
        if ($this->hasAuth(AccountType::SUPER_GM) == false) {
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
            '/market_list.php');
        if ($ret === false) {
            return $this->error('request slave server failed');
        }

        return $this->success($ret);
    }

    public function refreshMarketListAction()
    {
        $this->view->disable();

        // check auth
        if ($this->hasAuth(AccountType::SUPER_GM) == false) {
            return $this->error('not allowed');
        }

        // get params
        $server_id = $this->request->getPost('server_id');
        if ($server_id === null) {
            return $this->error('`server_id` is required');
        }
        $market_info = $this->request->getPost('market_info');
        if ($market_info === null) {
            return $this->error('`market_info` is required');
        }

        // check server id
        $server_model = $this->getVisableServerModel($server_id);
        if ($server_model === false) {
            return $this->error('`server_id` is invalid');
        }

        $ret = $this->slaveServerRequest(
            $server_model->addr, $server_model->secret_key,
            '/refresh_market.php', array(
                'market_info' => $market_info,
            ), 'post');
        if ($ret === false) {
            return $this->error('request slave server failed');
        }

        // op log
        $server_desc = $server_model->desc;
        $market_info_fmt = preg_replace('/^\[/', '', $market_info);
        $market_info_fmt = preg_replace('/\]$/', '', $market_info_fmt);
        $market_info_fmt = preg_replace('/},/', '}</br>', $market_info_fmt);
        $this->opLog("[刷新商城道具] 服务器: $server_desc ".
                     "道具列表:</br>$market_info_fmt");

        return $this->success($ret);
    }
}
