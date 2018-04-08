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
            'desc' => 'All platforms',
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
            'columns' => '[id], [desc], [platform_id]',
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
        if ($channel_model->create() === false) {
            return $this->error('save to db failed');
        }

        // op log
        $this->opLog("[New add channel] Channel ID: $id Channel name: $desc ".
                     "Owned platform: $platform_id");

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
        $this->opLog("[Delete the channel] Channel name: $id");

        return $this->success(array(
            'success' => true,
        ));
    }
}
