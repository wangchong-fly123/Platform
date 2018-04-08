<?php

final class SuggestController extends ControllerBase
{
    public function getPlatformSuggestAction()
    {
        $this->view->disable();

        // check auth
        if ($this->hasAuth(AccountType::GM) == false &&
            $this->getAccountType() != AccountType::OPERATION_STAFF) {
            return $this->error('not allowed');
        }

        if ($this->getAccountPlatformId() == 0) {
            $ret = PlatformModel::find(array(
                'columns' => '[id], [desc]',
            ))->toArray();
        } else {
            $ret = PlatformModel::find(array(
                'columns' => '[id], [desc]',
                'conditions' => 'id = :id:',
                'bind' => array(
                    'id' => $this->getAccountPlatformId(),
                ),
            ))->toArray();
        }

        return $this->success($ret);
    }

    public function getChannelSuggestAction()
    {
        $this->view->disable();

        // check auth
        if ($this->hasAuth(AccountType::GM) == false &&
            $this->getAccountType() != AccountType::OPERATION_STAFF) {
            return $this->error('not allowed');
        }

        if ($this->getAccountPlatformId() == 0) {
            $ret = ChannelModel::find(array(
                'columns' => '[id], [desc]',
            ))->toArray();
        } else {
            $ret = ChannelModel::find(array(
                'columns' => '[id], [desc]',
                'conditions' => 'platform_id = :platform_id:',
                'bind' => array(
                    'platform_id' => $this->getAccountPlatformId(),
                ),
            ))->toArray();

            $exclude_channel = $this->getAccountExcludeChannel();
            $exclude_array = explode(';', $exclude_channel);
            if (count($exclude_array) > 0) {
                foreach ($ret as $key=>$value) {
                    if (in_array($value['id'], $exclude_array)) {
                        unset($ret[$key]);
                    }
                }
                array_values($ret);
            }
        }

        array_unshift($ret, array(
            'id' => 'ALL',
            'desc' => '所有渠道',
        ));

        return $this->success($ret);
    }

    public function getServerSuggestAction()
    {
        $this->view->disable();

        // check auth
        if ($this->hasAuth(AccountType::GM) == false &&
            $this->getAccountType() != AccountType::OPERATION_STAFF) {
            return $this->error('not allowed');
        }

        if ($this->getAccountPlatformId() == 0) {
            $ret = ServerModel::find(array(
                'columns' => '[id], [desc]',
            ))->toArray();
        } else {
            $ret = ServerModel::find(array(
                'columns' => '[id], [desc]',
                'conditions' => 'platform_id = :platform_id:',
                'bind' => array(
                    'platform_id' => $this->getAccountPlatformId(),
                ),
            ))->toArray();
        }

        return $this->success($ret);
    }

    public function getPayProductSuggestAction()
    {
        $this->view->disable();

        // check auth
        if ($this->hasAuth(AccountType::GM) == false) {
            return $this->error('not allowed');
        }

        return $this->success(PayProductModel::find(array(
            'columns' => '[id], [desc]',
        ))->toArray());
    }

    public function getUserSuggestAction()
    {
        $this->view->disable();

        // check auth
        if ($this->hasAuth(AccountType::ADMIN) == false) {
            return $this->error('not allowed');
        }

        return $this->success(AccountModel::find(array(
            'columns' => '[account]',
        ))->toArray());
    }

    public function getSpreadSuggestAction()
    {
        $this->view->disable();

        // check auth
        if ($this->hasAuth(AccountType::GM) == false) {
            return $this->error('not allowed');
        }

        $ret = SpreadModel::find(array(
            'columns' => '[url], [desc]',
        ))->toArray();

        array_unshift($ret, array(
            'url' => 'ALL',
            'desc' => '所有推广',
        ));
        return $this->success($ret);
    }
}
