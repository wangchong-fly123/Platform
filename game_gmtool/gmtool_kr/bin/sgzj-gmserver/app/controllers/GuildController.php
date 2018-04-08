<?php

final class GuildController extends ControllerBase
{
    public function guildRankAction()
    {
    }
    
    public function getGuildRankAction()
    {
        $this->view->disable();

        // check auth
        if ($this->hasAuth(AccountType::ADVANCED_GM) == false) {
            return $this->error('not allowed');
        }

        // get params
        $server_id = $this->request->get('server_id');
        if ($server_id === null) {
            return $this->error('`server_id` is required');
        }
        $rank_type = $this->request->get('rank_type');
        if ($rank_type === null) {
            return $this->error('`rank_type` is required');
        }

        // check server id
        $server_model = $this->getVisableServerModel($server_id);
        if ($server_model === false) {
            return $this->error('`server_id` is invalid');
        }

        $ret = $this->slaveServerRequest(
            $server_model->addr, $server_model->secret_key,
            '/guild_rank.php', array(
                'rank_type' => $rank_type,
            ));
        if ($ret === false) {
            return $this->error('request slave server failed');
        }

        if (isset($ret['error_code'])) {
            return $this->success($ret);
        }

        foreach ($ret as &$row) {
            $row['create_time'] = DataFormatter::timestamp(
                $row['create_time']);
        }

        return $this->success(array(
            'rank_list' => $ret,
        ));
    }
}
