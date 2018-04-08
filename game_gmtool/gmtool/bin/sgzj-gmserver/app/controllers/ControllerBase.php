<?php

use \Phalcon\Mvc\Controller;

class ControllerBase extends Controller
{
    private $account;
    private $account_type;
    private $account_platform_id;
    private $account_exclude_channel;
    private $account_cps;

    protected function initialize()
    {
        if ($this->session->has('auth') === false) {
            if ($this->request->isAjax()) {
                return $this->gotoPage403();
            } else {
                return $this->gotoLogin();
            }
        }
        $this->view->setTemplateAfter('main');

        $this->account =
            $this->session->get('auth')['account'];
        $this->account_type =
            $this->session->get('auth')['account_type'];
        $this->account_platform_id =
            $this->session->get('auth')['account_platform_id'];
        $this->account_exclude_channel =
            $this->session->get('auth')['account_exclude_channel'];
        $this->account_cps =
            $this->session->get('auth')['account_cps'];

        // set view var
        $this->view->setVar('auth_account',
            $this->account);
        $this->view->setVar('auth_account_type',
            $this->account_type);
        $this->view->setVar('auth_account_platform_id',
            $this->account_platform_id);
        $this->view->setVar('auth_account_exclude_channel',
            $this->account_exclude_channel);
        $this->view->setVar('auth_account_cps',
            $this->account_cps);

        // menu visable
        $this->view->setVar('display_menu_user',
            $this->hasAuth(AccountType::ADMIN));
        $this->view->setVar('display_menu_platform',
            $this->hasAuth(AccountType::ADMIN));
        $this->view->setVar('display_menu_channel',
            $this->hasAuth(AccountType::ADMIN));
        $this->view->setVar('display_menu_spread',
            $this->hasAuth(AccountType::ADMIN));
        $this->view->setVar('display_menu_server',
            $this->hasAuth(AccountType::ADVANCED_GM) ||
            $this->getAccountType() == AccountType::OPERATION_STAFF);
        $this->view->setVar('display_menu_server_list',
            $this->hasAuth(AccountType::ADMIN) ||
            $this->getAccountType() == AccountType::OPERATION_STAFF);
        $this->view->setVar('display_menu_player',
            $this->hasAuth(AccountType::GM));
        $this->view->setVar('display_menu_player_account_banning',
            $this->hasAuth(AccountType::SUPER_GM));
        $this->view->setVar('display_menu_player_player_silence',
            $this->hasAuth(AccountType::SUPER_GM));
        $this->view->setVar('display_menu_player_gm_login',
            $this->hasAuth(AccountType::SUPER_GM));
        $this->view->setVar('display_menu_change_role_account',
            $this->hasAuth(AccountType::ADVANCED_GM));
        $this->view->setVar('display_menu_player_pay_transaction',
            $this->hasAuth(AccountType::SUPER_GM));
        $this->view->setVar('display_menu_player_pay_tmall_transaction',
            $this->hasAuth(AccountType::ADMIN));
        $this->view->setVar('display_menu_player_online_list',
            $this->hasAuth(AccountType::SUPER_GM));
        $this->view->setVar('display_menu_player_mail_list',
            $this->hasAuth(AccountType::SUPER_GM));
        $this->view->setVar('display_menu_player_buddy_list',
            $this->hasAuth(AccountType::SUPER_GM));
        $this->view->setVar('display_menu_player_equip_list',
            $this->hasAuth(AccountType::SUPER_GM));
        $this->view->setVar('display_menu_player_soul_list',
            $this->hasAuth(AccountType::SUPER_GM));
        $this->view->setVar('display_menu_player_rank',
            $this->hasAuth(AccountType::SUPER_GM));
        $this->view->setVar('display_menu_player_gm',
            $this->hasAuth(AccountType::ADMIN));
        $this->view->setVar('display_menu_notice',
            $this->hasAuth(AccountType::SUPER_GM));
        $this->view->setVar('display_menu_mail',
            $this->hasAuth(AccountType::SUPER_GM));
        $this->view->setVar('display_menu_market',
            $this->hasAuth(AccountType::SUPER_ADMIN));
        $this->view->setVar('display_menu_stat',
            $this->hasAuth(AccountType::ADVANCED_GM));
        $this->view->setVar('display_menu_stat_tmall',
            $this->hasAuth(AccountType::ADMIN));
        $this->view->setVar('display_menu_guild',
            $this->hasAuth(AccountType::ADVANCED_GM));
        $this->view->setVar('display_menu_guild_rank',
            $this->hasAuth(AccountType::ADVANCED_GM));
        $this->view->setVar('display_menu_guild_member',
            $this->hasAuth(AccountType::ADVANCED_GM));
        
        if ($this->account_platform_id == PlatformType::ANDROID_LY) {
            $this->view->setVar('display_menu_cps_stat',
                $this->hasAuth(AccountType::GM));
        } else {
            $this->view->setVar('display_menu_cps_stat',
                $this->hasAuth(AccountType::ADMIN));
        }
        $this->view->setVar('display_menu_wfc',
            $this->hasAuth(AccountType::ADMIN));
    }

    protected function setAuthSession(
        $account, $account_type,
        $platform_id, $exclude_channel, $cps)
    {
        $this->session->set('auth', array(
            'account' => $account,
            'account_type' => $account_type,
            'account_platform_id' => $platform_id,
            'account_exclude_channel' => $exclude_channel,
            'account_cps' => $cps,
        ));
        $this->account = $account;
        $this->account_type = $account_type;
        $this->account_platform_id = $platform_id;
        $this->account_exclude_channel = $exclude_channel;
        $this->account_cps = $cps;
    }

    protected function getAccount()
    {
        return $this->account;
    }

    protected function getAccountType()
    {
        return $this->account_type;
    }

    protected function getAccountPlatformId()
    {
        return $this->account_platform_id;
    }

    protected function getAccountExcludeChannel()
    {
        return $this->account_exclude_channel;
    }

    protected function getAccountCps()
    {
        return $this->account_cps;
    }

    protected function hasAuth($account_type)
    {
        return $this->account_type <= $account_type;
    }

    protected function forward($controller, $action='index', $params=array())
    {
        return $this->dispatcher->forward(array(
            'controller' => $controller,
            'action' => $action,
            'params' => $params
        ));
    }

    protected function error($error_message, $error_code = -1)
    {
        $this->response->setContentType('application/json');
        $this->response->setContent(json_encode(array(
            'error_code' => $error_code,
            'error_message'=> $error_message,
        )));

        return $this->response;
    }

    protected function success($response=array())
    {
        $this->response->setContentType('application/json');
        $this->response->setContent(json_encode($response));

        return $this->response;
    }

    protected function gotoIndex()
    {
        return $this->response->redirect('');
    }

    protected function gotoPage403()
    {
        return $this->response->redirect('index/page403');
    }

    protected function gotoLogin()
    {
        return $this->response->redirect('session/login');
    }

    protected function slaveServerRequest($addr, $secret_key,
                                          $uri, $params=array(),
                                          $method = 'get')
    {
        $output = Util::signedHttpRequest(
            $addr, $secret_key, $uri, $params, $method);
        if (false === $output) {
            return false;
        }
        $ret = json_decode($output, true);
        if ($ret === null) {
            error_log($output);
            return false;
        }

        return $ret;
    }

    protected function multiSlaveServerRequest($request_list)
    {
        $output_list = Util::multiSignedHttpRequest($request_list);
        $ret_list = array();

        foreach ($output_list as $output) {
            if (false === $output) {
                array_push($ret_list, false);
                continue;
            }

            $ret = json_decode($output, true);
            if ($ret === null) {
                array_push($ret_list, false);
                continue;
            }

            array_push($ret_list, $ret);
        }

        return $ret_list;
    }

    protected function fetchPlayerManagementCache()
    {
        $cache_server_id = 0;
        $cache_player_id = '';

        if ($this->session->has('player_management_cache')) {
            $cache = $this->session->get('player_management_cache');
            if (isset($cache['server_id'])) {
                $cache_server_id = $cache['server_id'];
            }
            if (isset($cache['player_id'])) {
                $cache_player_id = $cache['player_id'];
            }
        }

        // set view var
        $this->view->setVar('cache_server_id', $cache_server_id);
        $this->view->setVar('cache_player_id', $cache_player_id);
    }

    protected function opLog($log)
    {
        $op_log_model = new OpLogModel();
        $op_log_model->timestamp = time();
        $op_log_model->account = $this->getAccount();
        $op_log_model->log = $log;
        $op_log_model->save();
    }

    protected function getVisableServerModel($server_id)
    {
        $server_model = ServerModel::findFirst($server_id);
        if ($server_model === false) {
            return false;
        }
        if ($this->getAccountPlatformId() != 0 &&
            $this->getAccountPlatformId() != $server_model->platform_id) {
            return false;
        }

        return $server_model;
    }

    protected function getVisableServerModelList()
    {
        if ($this->getAccountPlatformId() == 0) {
            return ServerModel::find();
        } else {
            return ServerModel::find(array(
                'conditions' => 'platform_id = :platform_id:',
                'bind' => array(
                    'platform_id' => $this->getAccountPlatformId(),
                ),
            ));
        }
    }

    protected function getChannelDesc($channel_id)
    {
        if ('ALL' == $channel_id) {
            return $channel_id;
        }
        $channel_model = ChannelModel::findFirst($channel_id);
        if ($channel_model === false) {
            return $channel_id;
        }
        return $channel_model->desc;
    }

    protected function getSpreadDesc($url)
    {
        if ('ALL' == $url) {
            return $url;
        }
        $channel_model = SpreadModel::findFirstByUrl($url);
        if ($channel_model === false) {
            return $url;
        }
        return $channel_model->desc;
    }
}
