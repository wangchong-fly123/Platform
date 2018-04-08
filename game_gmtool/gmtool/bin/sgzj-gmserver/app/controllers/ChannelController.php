<?php
final class ChannelController extends ControllerBase
{
    public function listAction()
    {
        $this->view->setVar(
            'display_add_channel_form_super_admin_option',
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

    public function getChannelListAction()
    {
        $this->view->disable();

        // check auth
        if ($this->hasAuth(AccountType::ADMIN) == false) {
            return $this->error('not allowed');
        }

        return $this->success(ChannelModel::find(array(
            'columns' => '[id], [desc], [platform_id], [state]',
            'order' => 'id, platform_id',
        ))->toArray());
    }

    public function addChannelAction()
    {
        $this->view->disable();

        // check auth
        if ($this->hasAuth(AccountType::ADMIN) == false) {
            return $this->error('not allowed');
        }

        // get params
        $id = $this->request->get('id');
        if ($id === null) {
            return $this->error('`id` is required');
        }
        $desc = $this->request->get('desc');
        if ($desc === null) {
            return $this->error('`desc` is required');
        }
        $platform_id = $this->request->get('platform_id');
        if ($platform_id === null) {
            return $this->error('`platform_id` is required');
        }

        if (preg_match('/^\d{1,6}$/', $id) !== 1) {
            return $this->error('`id` is invalid');
        }
        if (preg_match('/^\d{1,2}$/', $platform_id) !== 1) {
            return $this->error('`platform_id` is invalid');
        }

        $channel_model = new ChannelModel();
        $channel_model->id = $id;
        $channel_model->desc = $desc;
        $channel_model->platform_id = $platform_id;
        $channel_model->state = 1;
        if ($channel_model->create() === false) {
            return $this->error('save to db failed');
        }

        // op log
        $this->opLog("[新增渠道] 渠道号: $id 渠道名: $desc ".
                     "所属平台: $platform_id");

        return $this->success(array(
            'success' => true,
        ));
    }

    public function removeChannelAction()
    {
        $this->view->disable();

        // check auth
        if ($this->hasAuth(AccountType::ADMIN) == false) {
            return $this->error('not allowed');
        }

        // get params
        $id = $this->request->get('id');
        if ($id === null) {
            return $this->error('`id` is required');
        }

        $channel_model = ChannelModel::findFirstById($id);
        if ($channel_model === false) {
            return $this->error('`id` is invalid');
        }

        $channel_model->delete();

        // op log
        $this->opLog("[删除渠道] 渠道名: $id");

        return $this->success(array(
            'success' => true,
        ));
    }
    public function disableChannelAction()
    {
        $this->view->disable();

        // check auth
        if ($this->hasAuth(AccountType::ADMIN) == false) {
            return $this->error('not allowed');
        }

        // get params
        $id = $this->request->get('id');
        if ($id === null) {
            return $this->error('`id` is required');
        }

        $channel_model = ChannelModel::findFirstById($id);
        if ($channel_model === false) {
            return $this->error('`id` is invalid');
        }

	$channel_model->state = 0;	
	$channel_model->update();
        // op log
        $this->opLog("[禁用渠道] 渠道名: $id");
        $this->notifyDisabledChannelToSlaveServer();
        return $this->success(array(
            'success' => true,
        ));
    }
    public function enableChannelAction()
    {
        $this->view->disable();

        // check auth
        if ($this->hasAuth(AccountType::ADMIN) == false) {
            return $this->error('not allowed');
        }

        // get params
        $id = $this->request->get('id');
        if ($id === null) {
            return $this->error('`id` is required');
        }

        $channel_model = ChannelModel::findFirstById($id);
        if ($channel_model === false) {
            return $this->error('`id` is invalid');
        }

	$channel_model->state = 1;	
	$channel_model->update();
        // op log
        $this->opLog("[启用渠道] 渠道名: $id");

      $this->notifyEnabledChannelToSlaveServer($channel_model->id, $channel_model->platform_id);
        return $this->success(array(
            'success' => true,
        ));
    }
    public function notifyDisabledChannelToSlaveServer()
    {
        
        $disable_channel_list = ChannelModel::find(array(
            'conditions' => 'state = :state:',
            'bind' => array(
                'state' =>0,
            ),
        ));
	$platform_disable_channel_list = array();
        foreach ($disable_channel_list as $disable_channel) {
            if (!isset($platform_disable_channel_list[$disable_channel->platform_id])) {
                $platform_disable_channel_list[$disable_channel->platform_id] = array();
            }
        }
        foreach ($disable_channel_list as $disable_channel) {
            array_push($platform_disable_channel_list[$disable_channel->platform_id], $disable_channel->id);
        }
	
        $request_list = array();
       foreach ($platform_disable_channel_list as $platform =>
             $disable_channel) { 
             $server_model_list = ServerModel::find(array(
                 'conditions' => 'platform_id = :platform_id:',
                 'bind' => array(
                     'platform_id' => $platform),

             ));
             	
            foreach ($server_model_list as $server_model) {
                array_push($request_list, array(
                    'addr' => $server_model->addr,
                    'secret_key' => $server_model->secret_key,
                    'uri' => '/disable_channel_list.php',
                    'params' => array('disable_channel_list' => implode(',', $disable_channel))
               ));
            }
            $ret_list = $this->multiSlaveServerRequest($request_list);
       }
    }
    public function notifyEnabledChannelToSlaveServer($channel_id, $platform_id)
    {
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
               'uri' => '/disable_channel_list.php',
               'params' => array(
                               'disable_channel_list' => "$channel_id",
                               'enable' => 1,
                ),
               ));
	    $this->opLog("server addr:$server_model->addr");
       }
      var_dump($channel_id);
      var_dump($platform_id);
      $ret_list = $this->multiSlaveServerRequest($request_list);
    }
}
