<?php

final class PlayerLogController extends ControllerBase
{
    public function resItemLogAction()
    {
        $this->fetchPlayerManagementCache();
    }

    public function actionLogAction()
    {
        $this->fetchPlayerManagementCache();
    }

    public function getResItemLogAction()
    {
        $this->view->disable();

        // check auth
        if ($this->hasAuth(AccountType::GM) == false) {
            return $this->error('not allowed');
        }

        // get params
        $server_id = $this->request->get('server_id');
        if ($server_id === null) {
            return $this->error('`server_id` is required');
        }
        $player_id = $this->request->get('player_id');
        if ($player_id === null) {
            return $this->error('`player_id` is required');
        }
        $query_date = $this->request->get('query_date');
        if ($query_date === null) {
            return $this->error('`query_date` is required');
        }

        // check server id
        $server_model = $this->getVisableServerModel($server_id);
        if ($server_model === false) {
            return $this->error('`server_id` is invalid');
        }

        $ret = $this->slaveServerRequest(
            $server_model->addr, $server_model->secret_key,
            '/res_item_log.php', array(
                'player_id' => $player_id,
                'query_date' => $query_date,
            ));
        if ($ret === false) {
            return $this->error('request slave server failed');
        }

        if (isset($ret['error_code'])) {
            return $this->success($ret);
        }

        $log_list = array();
        foreach ($ret as $log_string) {
            $parts = explode(',', $log_string);
            $log_type = $parts[0];
            $timestamp = DataFormatter::timestamp($parts[1]);
            $way = DataFormatter::wayType($parts[2]);
            $way_desc = $parts[3];

            if ($log_type === 'RES') {
                $log_type = 'Resources';
                $res_item_id = $parts[4];
                $res_item_name = DataFormatter::resourceId($res_item_id);
                $change_value = $parts[5];
                $new_value = $parts[6];

            } else if ($log_type === 'ITEM') {
                $log_type = 'Props';
                $res_item_id = $parts[4];
                $res_item_name = DataFormatter::itemId($res_item_id);
                $change_value = $parts[5];
                $new_value = $parts[6];

            } else if ($log_type === 'JEWELRY') {
                $log_type = 'Jewelry';
                $way_desc = $parts[4];
                $res_item_id = $parts[5];
                $res_item_name = DataFormatter::itemId($res_item_id);
                $change_value = $parts[6];
                $new_value = '-';

            } else if ($log_type === 'FASHION') {
                $log_type = 'Fashion';
                $res_item_id = $parts[4];
                $res_item_name = DataFormatter::itemId($res_item_id);
                $change_value = $parts[5];
                $new_value = $parts[6];
                if ($new_value > 0) {
                    $new_value = DataFormatter::timestamp($new_value);
                }

            } else if ($log_type === 'ITEMOVERFLOW') {
                $log_type = 'overflow';
                $res_item_id = $parts[4];
                $res_item_name = DataFormatter::itemId($res_item_id);
                $change_value = $parts[5];
                $new_value = '-';

            } else if ($log_type === 'FIGHT_SOUL') {
                $log_type = 'Fight_soul';
                $way_desc = $parts[4];
                $res_item_id = $parts[5];
                $res_item_name = DataFormatter::itemId($res_item_id);
                $change_value = $parts[6];
                $new_value = '-';
            } else if ($log_type === 'TOPSTONE') {
                $log_type = 'Topstone';
                $way_desc = $parts[4];
                $res_item_id = $parts[5];
                $res_item_name = DataFormatter::itemId($res_item_id);
                $change_value = $parts[6];
                $new_value = '-';
            }


            $log = array(
                'log_type' => $log_type,
                'timestamp' => $timestamp,
                'way' => $way,
                'way_desc' => $way_desc,
                'res_item_id' => $res_item_id,
                'res_item_name' => $res_item_name,
                'change_value' => $change_value,
                'new_value' => $new_value,
            );

            array_push($log_list, $log);
        }

        return $this->success(array(
            'log_list' => $log_list,
        ));
    }

    public function getActionLogAction()
    {
        $this->view->disable();

        // check auth
        if ($this->hasAuth(AccountType::GM) == false) {
            return $this->error('not allowed');
        }

        // get params
        $server_id = $this->request->get('server_id');
        if ($server_id === null) {
            return $this->error('`server_id` is required');
        }
        $player_id = $this->request->get('player_id');
        if ($player_id === null) {
            return $this->error('`player_id` is required');
        }
        $query_date = $this->request->get('query_date');
        if ($query_date === null) {
            return $this->error('`query_date` is required');
        }

        // check server id
        $server_model = $this->getVisableServerModel($server_id);
        if ($server_model === false) {
            return $this->error('`server_id` is invalid');
        }

        $ret = $this->slaveServerRequest(
            $server_model->addr, $server_model->secret_key,
            '/action_log.php', array(
                'player_id' => $player_id,
                'query_date' => $query_date,
            ));
        if ($ret === false) {
            return $this->error('request slave server failed');
        }

        if (isset($ret['error_code'])) {
            return $this->success($ret);
        }

        $log_list = array();
        foreach ($ret as $log_string) {
            $parts = explode(',', $log_string);
            $log_type = $parts[0];
            $timestamp = DataFormatter::timestamp($parts[1]);
            $log_info = $this->formatActionLogInfo($log_type, $parts);

            $log = array(
                'log_type' => $log_type,
                'timestamp' => $timestamp,
                'log_info' => $log_info,
            );

            array_push($log_list, $log);
        }

        return $this->success(array(
            'log_list' => $log_list,
        ));
    }

    private function getBuddyInfo($log_parts, $start_index)
    {
        $buddy_info = '';
        for ($i = $start_index; $i < count($log_parts); ++$i) {
            $buddy_info_parts = explode('&', $log_parts[$i]);
            if (count($buddy_info_parts) > 7) {
                $buddy_info .= '<br/>'.
                    'Buddy_name: '.DataFormatter::buddyId($buddy_info_parts[0]).' '.
                    'Level: '.$buddy_info_parts[1].' '.
                    'Normal attack: '.$buddy_info_parts[2].' '.
                    'Skill attack: '.$buddy_info_parts[3].' '.
                    'General defense: '.$buddy_info_parts[4].' '.
                    'Skill defense: '.$buddy_info_parts[5].' '.
                    'Blood volume: '.$buddy_info_parts[6].' '.
                    'Combat effectiveness: '.$buddy_info_parts[7];
            }
        }

        return $buddy_info;
    }

    private function getSkillInfo($log_parts, $start_index)
    {
        $skills = array();
        $skill_info = '';

        // sort skill
        for ($i = $start_index; $i < count($log_parts); ++$i) {
            $skill_info_parts = explode('&', $log_parts[$i]);
            $skill_id = $skill_info_parts[0];
            $skill_count = $skill_info_parts[1];
            $skills[$skill_id] = $skill_count;
        }
        ksort($skills);
        // get skill info
        foreach ($skills as $skill_id => $skill_count) {
            $skill_info .= ' '.
                DataFormatter::castSkillId($skill_id).": ".
                $skill_count;
        }

        return $skill_info;
    }

    private function getSkillLevelInfo($log_parts, $start_index)
    {
        $skills = array();
        $skill_info = '';

        // sort skill
        for ($i = $start_index; $i < count($log_parts); ++$i) {
            $skill_info_parts = explode('&', $log_parts[$i]);
            $skill_id = $skill_info_parts[0];
            $skill_level = $skill_info_parts[1];
            $skill_info .= ' Skill:'.
                $skill_id.',Level: '.
                $skill_level.' ';
        }

        return $skill_info;
    }

    private function formatActionLogInfo(&$log_type, $log_parts)
    {
        if ($log_type === 'LOGIN') {
            $log_type = 'LOGIN';
            return 'Build time: '.DataFormatter::timestamp($log_parts[2]).' '.
                   'account number: '.$log_parts[3].' '.
                   'player_name: '.$log_parts[4].' '.
                   'VIP Level: '.$log_parts[5].' '.
                   'player_level: '.$log_parts[6].' '.
                   'player_experience: '.$log_parts[7].' '.
                   'buddy_count: '.$log_parts[8].' '.
                   'Official rank: '.$log_parts[9].' '.
                   'Official experience: '.$log_parts[10].' '.
                   'Segmentation points: '.$log_parts[11];
        } else if ($log_type === 'IP' || $log_type === 'LOGINIP') {
            $log_type = 'LOGIN IP';
            return 'account number: '.$log_parts[2].' '.
                   'IP: '.$log_parts[3];

        } else if ($log_type === 'LOGOUT') {
            $log_type = 'LOGOUT';
            return 'account number: '.$log_parts[2].' '.
                   'player_name: '.$log_parts[3].' '.
                   'VIP Level: '.$log_parts[4].' '.
                   'player_level: '.$log_parts[5].' '.
                   'player_experience: '.$log_parts[6].' '.
                   'buddy_count: '.$log_parts[7].' '.
                   'Official rank: '.$log_parts[8].' '.
                   'Official experience: '.$log_parts[9].' '.
                   'Segmentation points: '.$log_parts[10];

        } else if ($log_type === 'CREATEROLE') {
            $log_type = 'Creating a Role';
            return 'account number: '.$log_parts[2].' '.
                   'player_name: '.$log_parts[3].' '.
                   'VIP Level: '.$log_parts[4].' '.
                   'player_level: '.$log_parts[5].' '.
                   'player_experience: '.$log_parts[6].' '.
                   'buddy_count: '.$log_parts[7].' '.
                   'Official rank: '.$log_parts[8].' '.
                   'Official experience: '.$log_parts[9].' '.
                   'Segmentation points: '.$log_parts[10];

        } else if ($log_type === 'BUDDY') {
            $log_type = 'BUDDY';
            return 'position: '.$log_parts[2].' '.
                   'buddy_name: '.DataFormatter::buddyId($log_parts[3]).' '.
                   'level: '.$log_parts[4].' '.
                   'quality: '.$log_parts[5].' '.
                   'satr_count: '.$log_parts[6].' '.
                   'breakthrough: '.$log_parts[7].' '.
                   'Awakening: '.$log_parts[8].' '.
                   $this->getSkillLevelInfo($log_parts, 9);

        } else if ($log_type === 'ONLINE') {
            $log_type = 'ONLINE';
            return 'account number: '.$log_parts[2].' '.
                   'player_name: '.$log_parts[3].' '.
                   'Daily accumulated online time: '.(int)($log_parts[4] / 60).'(m) '.
                   'Weekly cumulative online time: '.(int)($log_parts[5] / 60).'(m) '.
                   'Accumulated online time: '.(int)($log_parts[6] / 60).'(m)';

        } else if ($log_type === 'COPY') {
            $log_type = 'Single copy';
            return 'account number: '.$log_parts[2].' '.
                   'player_name: '.$log_parts[3].' '.
                   'copy_ID: '.$log_parts[4].' '.
                   'Copy difficulty: '.$log_parts[5].' '.
                   'time consuming: '.$log_parts[6].'(s) '.
                   'Number of resurrection: '.$log_parts[7].' '.
                   'Whether to win: '.$log_parts[8].' '.
                   'star_count: '.$log_parts[9].' '.
                   'The generals were killed: '.$log_parts[10].
                   $this->getBuddyInfo($log_parts, 11).
                   'Whether to use the accelerated plug: '.$log_parts[count($log_parts)-1];

        } else if ($log_type === 'DYNAMIC') {
            $log_type = 'Multiple copies';
            return 'account number: '.$log_parts[2].' '.
                   'player_name: '.$log_parts[3].' '.
                   'copy_ID: '.$log_parts[4].' '.
                   'Copy difficulty: '.$log_parts[5].' '.
                   'time consuming: '.$log_parts[6].'(server) '.
                   'Number of resurrection: '.$log_parts[7].' '.
                   'Whether to win: '.$log_parts[8].' '.
                   'Types of: '.$log_parts[9].' '.
                   'The generals were killed: '.$log_parts[10].
                   $this->getBuddyInfo($log_parts, 11).
                   'Whether to use the accelerated plug: '.$log_parts[count($log_parts)-1];

        } else if ($log_type === 'CASTSKILL') {
            $log_type = 'Use skills';
            return 'buddy_name: '.DataFormatter::buddyId($log_parts[2]).' '.
                   $this->getSkillInfo($log_parts, 3);

        } else if ($log_type === 'BATTLECOMMON') {
            $log_type = 'Use skills';
            return $this->getSkillInfo($log_parts, 2);
        } else if ($log_type === 'MASTEREQUIP') {
            $log_type = 'Master equipment';
            return 'Equipment_id: '.$log_parts[2].' '.
                   'Enhanced level: '.$log_parts[3].' '.
                   'Equipment level: '.$log_parts[4].' '.
                   'Gem 1: '.$log_parts[5].' '.
                   'Gem 2: '.$log_parts[6].' '.
                   'star_count: '.$log_parts[7];
        } else if ($log_type === 'STORE') {
            $log_type = 'Store to buy';
            return 'Store_ID: '.$log_parts[2].' '.
                   'Store lattice: '.$log_parts[3].' '.
                   'Purchase quantity: '.$log_parts[4].' '.
                   'article_ID: '.$log_parts[5].' '.
                   'number of the stuffs: '.$log_parts[6];
        } else if ($log_type === 'EXERCISESKILL') {
            $log_type = 'Army training skills';
            return $this->getSkillLevelInfo($log_parts, 3);
        }
    }
}
