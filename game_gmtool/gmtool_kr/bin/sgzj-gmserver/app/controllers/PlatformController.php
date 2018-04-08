<?php

final class PlatformController extends ControllerBase
{
    public function listAction()
    {
        $this->view->setVar(
            'display_add_platform_form_super_admin_option',
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

    public function getPlatformListAction()
    {
        $this->view->disable();

        // check auth
        if ($this->hasAuth(AccountType::ADMIN) == false) {
            return $this->error('not allowed');
        }

        return $this->success(PlatformModel::find(array(
            'columns' => '[id], [desc]',
            'order' => 'id',
        ))->toArray());
    }

    public function addPlatformAction()
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

        $platform_model = new PlatformModel();
        $platform_model->id = $id;
        $platform_model->desc = $desc;
        if ($platform_model->create() === false) {
            return $this->error('save to db failed');
        }

        // op log
        $this->opLog("[New add platform] platform ID: $id platform name: $desc ");

        return $this->success(array(
            'success' => true,
        ));
    }

    public function removePlatformAction()
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

        $platform_model = PlatformModel::findFirstById($id);
        if ($platform_model === false) {
            return $this->error('`id` is invalid');
        }

        $platform_model->delete();

        // op log
        $this->opLog("[Remove the platform] platform name: $id");

        return $this->success(array(
            'success' => true,
        ));
    }
}
